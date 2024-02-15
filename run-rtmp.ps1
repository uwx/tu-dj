$PREFIX='dj'
$MPD='live/streams/dj.mpd'

.\ffmpeg.exe -f flv -listen 1 -i rtmp://127.0.0.1:6970/live/app `
    -fflags +discardcorrupt `
    -c:v libvpx -b:v 2048k `
    -c:a libvorbis -b:a 128k `
    -deadline realtime `
    -f dash `
    -window_size 15 `
    -extra_window_size 15 `
    -adaptation_sets "id=0,streams=v id=1,streams=a" `
    -remove_at_exit 1 `
    -update_period 1 `
    -utc_timing_url "https://time.akamai.com/?iso" `
    -write_prft 1 `
    -dash_segment_type webm `
    -use_template 1 `
    -use_timeline 1 `
    -seg_duration 8 `
    -frag_duration 2 `
    -frag_type duration `
    -init_seg_name "$PREFIX-init-stream`$RepresentationID`$.webm" `
    -media_seg_name "$PREFIX-chunk-stream`$RepresentationID`$-`$Number%05d`$.webm" `
    "$MPD"
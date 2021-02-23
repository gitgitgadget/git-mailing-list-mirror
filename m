Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837EC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C395E64E83
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhBWVPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhBWVNu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 16:13:50 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E193FC061222
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 13:12:29 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id j24so6689251pfi.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 13:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meter.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=gyMY96TpKUcuwcQ7Ze4tbe44BsEB2DQ9dYRKDFeqp7w=;
        b=zAafKQ5xQgYFXyIf+eW9CPZll/DbYawDDSieGWfI0n9niT5IgdjZv10xEEcMTdMKdK
         w+pSRDvbSYdCYTh4NiEMa58+lk+yAf0LFUhA19yiPlDA8vLtc4hEU1bdlPKES2sGr84O
         g8VWZpZfKZ6b1WX9B6+9K5805a3JMyWe/8kXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gyMY96TpKUcuwcQ7Ze4tbe44BsEB2DQ9dYRKDFeqp7w=;
        b=g1GhsB6/M88IbaVG3IyWz0rGVSAcMjrjXmjyRw6+h3u5og0YQjeVe61maSCzck2vpL
         fJQMtEdzvgDpHPbqzLJ1Li4TwbsDl09GJ6QyVnySamVO1cpZvoLs1RNDs5Xq2011bCav
         90dT7bUsyNGgrLgxN33U6BMAlsvdO/ntAQEmNthEKeXz8P9QEMBej1lo2FY32qWOJtHG
         lrfxwtQ7TMi+0j/3OsmVckxqMmFC2a1+Y9ZqGdsY7kZtMVMwnqK2GkKe9+owmnLAO4X/
         04juB+V3odicyedX/FZn/W8NuYq7bCDUCbifNrIVqrS1326DXUOWB5MGmMurF5jN9OEk
         PsRw==
X-Gm-Message-State: AOAM532158Ig7BGn8F/e+P73ffr/jf4oqBJEUy3ZWDF1hWlfx44/3b0d
        z5J4GoPl6RT532s6J1SA4UznI4J15G+tPWfH3zpbkeCWheO5uayq
X-Google-Smtp-Source: ABdhPJwqxQXlhl/KNCc+hbMkUE/a8ELnEwBT0ACPxk2Jg9dlVlfQmlXg2GTgDZvNprY2PSERqm8OfwEW25aIyfECpZ0=
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr143355pgh.345.1614114748962;
 Tue, 23 Feb 2021 13:12:28 -0800 (PST)
MIME-Version: 1.0
From:   Kevin Burke <kevin@meter.com>
Date:   Tue, 23 Feb 2021 13:12:18 -0800
Message-ID: <CAAJ6v9AruZ3HfqB1x6CKBM=JgFj8bNwjQFUO4rzv2s=yeXfcDw@mail.gmail.com>
Subject: Crash when using libcurl with new hyper + rustls backend
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Curl added a new TLS backend that is written in Rust recently. If you
are using Mac, you can install it by running "brew install --HEAD
meterup/safe/curl", or view the specific compilation flags I passed to
curl, here: https://github.com/meterup/homebrew-safe/blob/main/Formula/curl.rb

If you are on Linux, you can use these instructions to build libcurl
with rustls: https://github.com/abetterinternet/crustls/wiki/Building-curl-with-crustls-and-Hyper

When I compile Git using this curl, I get a segfault when running "git
fetch https://go.googlesource.com/tools"

* thread #1, queue = 'com.apple.main-thread', stop reason =
EXC_BAD_ACCESS (code=1, address=0x8)
  * frame #0: 0x00000001000e2b58 git-remote-https`strbuf_grow + 16
    frame #1: 0x00000001000e3020 git-remote-https`strbuf_add + 27
    frame #2: 0x00000001000076d5 git-remote-https`fwrite_buffer + 27
    frame #3: 0x00000001002ebfba libcurl.4.dylib`Curl_hyper_stream + 594
    frame #4: 0x000000010032fdf8 libcurl.4.dylib`Curl_readwrite + 203
    frame #5: 0x0000000100319a80 libcurl.4.dylib`multi_runsingle + 2113
    frame #6: 0x00000001003191c6 libcurl.4.dylib`curl_multi_perform + 113
    frame #7: 0x00000001000094cb git-remote-https`step_active_slots + 25
    frame #8: 0x0000000100009532 git-remote-https`run_active_slot + 67
    frame #9: 0x00000001000097fd git-remote-https`run_one_slot + 41
    frame #10: 0x000000010000bb06 git-remote-https`http_request + 1630
    frame #11: 0x00000001000099b7 git-remote-https`http_request_reauth + 34
    frame #12: 0x0000000100006131 git-remote-https`discover_refs + 625
    frame #13: 0x00000001000053fc git-remote-https`cmd_main + 4484
    frame #14: 0x000000010000ce55 git-remote-https`main + 130
    frame #15: 0x00007fff699fbcc9 libdyld.dylib`start + 1
    frame #16: 0x00007fff699fbcc9 libdyld.dylib`start + 1


I had previously reported this issue to curl here, which includes a
number of useful pieces of information including the contents of each
register at the time of the crash.
https://github.com/curl/curl/issues/6619

The latest comment on that issue suggests git may not be setting curl
flags appropriately, which is why I am raising an issue here. I'm not
great at C programming and have not been able to sort out what's going
on myself, unfortunately.

Here's some more information about my git installation:

[System Info]
git version:
git version 2.30.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jan 12 22:13:05
PST 2021; root:xnu-6153.141.16~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/zsh

Hope this helps,
Kevin

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9561EC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 15:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382866AbiD3PIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbiD3PIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 11:08:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E811CB08
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 08:05:17 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ebf4b91212so111848157b3.8
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=danil-cz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vc2dtSdxbAKNayGQz4B2fQP16T/vbCXhgfVU8c+T7Bk=;
        b=qd+ivVACLZzge6YNwH09p1nQyEzYN1b1pPEQfjTjoPlbWc5Ow6TqgUgRoYrh2xpTrT
         8zNCoMsGMhTiP2DAf0hn4JPABbjaqkQlRkkKiC110RLmh/ZXmWaim1i7D/ujzfZ3kCVr
         Cby/v51ff6jeYFZ4F4TZv/gLH4f3hcCZo3WIyKXYOLNQPiVpcXb3q1tfwe0ghPK2fhGd
         275I3tCQRfiFHT+yaWeZiozXhLrb0zYJMt5RKAry16WIP6p1Kbp4zLrWXzcCkfgfjtOU
         cJZzdvCNWIJJKMUpWbc35klZv53ZjsFWxIsdH4nqnvUS3vslFcLaUt2i61ShefBPQ6ZV
         8Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vc2dtSdxbAKNayGQz4B2fQP16T/vbCXhgfVU8c+T7Bk=;
        b=mV7YY2rFiltgra3/Bk3fAOw4QqzvUkTV1ZETH6KuxqIpxCM2Vud69NxXoHgvP7/dpU
         VOjvqMTJDmoMv+SyPCNq2gTowhOVhGZYbEdPzVTsZmTVAhH/B0EvT5zgJw/au5lOrIQY
         +rLxrN9hknGoaKH1IcAuy7yOhRUD3oN9RjNzJltorJgummN+SgD1GBjJHSZT6fxsZg8M
         3Ho7itPemRPVs6elDKZhcVkxsG7A4/CthjEuRm4liBZWmxE3b08L7ih3/cZw1DkhisN1
         LMypNk7msTp6drGw4ff1Pskz3Onl0A1T6L0ET9GlEJNBlc74Pv3mge8DeSiWLr0wI8wm
         iiMA==
X-Gm-Message-State: AOAM533ShB05lldB5FxdIQ1fs2H8RZ9vlHPTu8zWG9LqcJkAVoTxFFvs
        CIduMnZ3ysBW85q7rq8VFnXUQShK3rMlRirfHPiUVj1c5nW/k5p/X70=
X-Google-Smtp-Source: ABdhPJy6B31ZsVccCzznpJHwdwno04HzEE4EKuwqdn+9Z4d62CKINbOQGtYm0PvkXSyQzuESKIiKLKon2n8w98VHaVA=
X-Received: by 2002:a05:690c:d:b0:2d0:e02a:6cda with SMTP id
 bc13-20020a05690c000d00b002d0e02a6cdamr4552536ywb.192.1651331117058; Sat, 30
 Apr 2022 08:05:17 -0700 (PDT)
MIME-Version: 1.0
From:   Danil Pristupov <danil@danil.cz>
Date:   Sat, 30 Apr 2022 17:05:06 +0200
Message-ID: <CAKdzDnk4FFPedTQ4fG1c-BZ4ST99E1ucx664r_oc-5123P6ovA@mail.gmail.com>
Subject: Merge diff always misses the `\ No newline at end of file` mark
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For files with conflicts `git diff -- filename` always returns result
without the `No newline at end of file` mark.

I was able to reproduce this with all git versions on all platforms.

Steps to reproduce (macOS, 2.32.0 (Apple Git-132)):

```
git init
echo "line1\nline2" > eol.txt
echo -n "line1\nline2" > noeol.txt
git add .
git commit -m "initial"
git branch br1
echo "line11\nline2" > eol.txt
echo -n "line11\nline2" > noeol.txt
git add .
git commit -m "line1"
git checkout br1
echo "line12\nline2" > eol.txt
echo -n "line12\nline2" > noeol.txt
git add .
git commit -m "line2"
git merge master
git diff -- eol.txt > eol.diff
git diff -- noeol.txt > noeol.diff
```

Expected behavior: `noeol.diff` should have `\ No newline at end of file` mark

Actual behavior: Both `eol.diff` and `noeol.diff` have no `\ No
newline at end of file` mark

This is my first bug report. Please let me know if I'm missing something.

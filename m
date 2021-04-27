Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F7C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D53613B2
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhD0KqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhD0Kp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:45:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09BBC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:45:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s15so69398660edd.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sp4m.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=DKzlsaZoKE7l92k8PlqyRDNvEZNB8u9Lq/Q38lji0NQ=;
        b=avTUZqQhT0mklB/5o0XV2usPL4DaqNzZsZV5HvavxDTumEY5T/Y213jqKZwzKtEe6P
         wiA+2ZU/EUsIVXSOqNUa8eNMBimP54J4Y0QY0B9k1yW96yRrtsTpCbbNWmS6inok2EuH
         MfP7S9UUPtSe17R1PJ94pssURoETKH7spkaxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DKzlsaZoKE7l92k8PlqyRDNvEZNB8u9Lq/Q38lji0NQ=;
        b=MZ4ftmJJNxAvpP+bktn9ZJPdjP8K+7pxR7knfYpabP3VMpr4twfukDmVXe0onVu3jr
         8c9V3clVXnO0WwFLikWHfjk+2Eo79XtsVvvzMwaGlJxO0FZWpF3+6oN0RzaGQRys0lRI
         JK6TBh2Fgsjq3SS2+XXPgJuXBuhf7ACqIx9i/Y6aaSWgD+bkTcmuiBrG0gsmCgNh6UwO
         ki0zkmcAqLEkgTgdX/EDDEWCTvlY0trAhL+cyyn6juokRRwfSK89yp3Eozc1E+8D5lYs
         HPpCN9ssklxWh6EoWTJq9afB//AyfJ43goOGF1egDpwdY4/SsmHU93CiNmGy2OFIIfDv
         vi+Q==
X-Gm-Message-State: AOAM533Kufym2xE+BYdXtO1/shjXUyVyOhL/caJDYzlbxPFeHwwzs4Lu
        wra/Z6riA8oCb13dluA66X7ONogSyFg6Cy4TIQH8IgIxD9mQ9yrq
X-Google-Smtp-Source: ABdhPJzjFR46tTf1vH8NAR8TDwf5c5LMRlzVYSV4x+gBs8UcgnrgZKi+shRnOUx6ejWMExCRPUKJdSKVmcAiwRxI84Y=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr3483553edd.75.1619520312198;
 Tue, 27 Apr 2021 03:45:12 -0700 (PDT)
MIME-Version: 1.0
From:   David Emett <dave@sp4m.net>
Date:   Tue, 27 Apr 2021 11:45:01 +0100
Message-ID: <CAJ-dYSOVx0egnyxJb6ZjgWvEDR=19QPgc70JQ7cXUjUPZ1XDiQ@mail.gmail.com>
Subject: Two issues with mark_reachable_objects
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I ran into an issue yesterday with a script that effectively does this:

    set -e
    git fetch origin refs/blah/blah
    git checkout FETCH_HEAD

The checkout failed a few times with a "fatal: unable to read tree" error.

I noticed that this only happened when the fetch triggered an automatic GC at
the end. After a bit of digging I discovered two separate issues:

1) It seems that FETCH_HEAD is not considered a root by mark_reachable_objects.

2) If the bitmap_git branch in mark_reachable_objects is taken, the mark_recent
   argument is ignored. This doesn't _completely_ break "git prune"'s --expire
   option, as it turns out there is another explicit mtime check in
   prune_object (prune.c). If that check passes this is not propagated to
   referenced objects though. So even if a dangling commit is recent, a prune
   can discard old objects it references.

(1) has been discussed before on this mailing list [1], but it doesn't look
like there was a conclusion.

I assume (2) is not intentional, given that "git gc --help" explicitly says
"Any object with modification time newer than the --prune date is kept, along
with everything reachable from it." Is it safe to just run the mark_recent
block after the bitmap_git block? Could add_unseen_recent_objects_to_traversal
just be called at the start of the bitmap_git block if mark_recent?

[1] https://lore.kernel.org/git/20160708025948.GA3226@x/

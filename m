Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B50C433E6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7B264EF4
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 19:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhBJTwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhBJTwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 14:52:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B476C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 11:51:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id l25so6296896eja.9
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=s0xbvbs3UeZGHfg42bl/dmA8zheNAJzkpgsdPzUnStg=;
        b=QVxnsaaGTNbAw28ub6OYgxz29Ss7UjapQuVKM2jqMIb3SGlywgjIAvl1OaAsfBD5CK
         VyD6jpgnripka8+8+Ruhidf22lyg0T6dBos9G/0tWZqBZ8rPk453hC6TBbh4nD7sXHEG
         GqflUjm+vAbIB7laeophIzd+G38P34mxN021VzpfvcWXYsKpfDhCfTWPL0N5MEW1yp+/
         6t/3Q75rpX2LzxKPNngVvZzjMX/SP7lkMaovIWshQNyTsps7NH304L9kGbYMh5QLy5j2
         g+wfABAKVpLTKB7Jcg8KwfYVheb41ToPGqPm7MdqhJAxdPdV+tqxudTKfB9JUJBnMxiT
         epAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s0xbvbs3UeZGHfg42bl/dmA8zheNAJzkpgsdPzUnStg=;
        b=l6DXu0lfFcl7p3CTo2/bQILpu/MKeyhEN8MfYC0CxF5apWjpdkW6tV9A7bSnMvU0NB
         sYKLh/XAAS0rKuamuyYN7Fjqnfcm2VQDvfYqqP9cl/DlONvxJ/SyHoXEZMsCOQBg5QsS
         fmH+XYH+Ivgnq//1spx4pvwY0jIEWXmbTy2MpdqSKRkSEDkmLqXemQT6th/koEw7jLwJ
         Q1ls//4K1V7h4zaZjopIqdCR95a9C74bfP5M0/C5dxLCQNJpZHHFzjZfvFpiX2eivyIm
         PflMS8ec2JF3Sl+fjqltWyLZO3M8K1ZbzVGFRVZLgCr5yfkGEnhawPT26zhGX2e0eBae
         bM0w==
X-Gm-Message-State: AOAM533cvpQfpJmybMK0erfFCZXFXpm07o/xHEXKsnwFRF7cWS/+8j8E
        ZuTCgLNup8miagPViGZVA5L/2TiTIsyeGFeG2Jn1KfmSyFizqA==
X-Google-Smtp-Source: ABdhPJyd0vOsdyNzoJrqjH7AX9s5TGQkRkkYtvegVML0HuW2+H6Dl8vTNK7nPhKynDaD9BhQyytInDjf08OzKa9wU8A=
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr4649614ejb.355.1612986687657;
 Wed, 10 Feb 2021 11:51:27 -0800 (PST)
MIME-Version: 1.0
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Wed, 10 Feb 2021 09:51:16 -1000
Message-ID: <CANiSa6h=S6tHUR4hY85uZ7ZcnDc2mdUzPwyBDakQAa_NP+O0YA@mail.gmail.com>
Subject: GC can lose objects pointed to only by notes?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From the "NOTES" section in `git help gc`:
"[...] it will keep [..] objects referenced by the index,
remote-tracking branches, notes saved by git notes under refs/notes/"

I had interpreted that as saying that it will keep objects pointed to
by notes saved under refs/notes. I had a repo with lots of commits
referred to only by notes. When I ran `git gc`, the commits they
pointed to were deleted (I had a backup, so no big deal). I now
understand that the documentation actually meant that "objects
referenced by the index and remote-tracking branches, as well as notes
saved by git notes under refs/notes/" are kept.

It seems that the documentation should at least be clarified. I had
read the documentation before I decided to rely on notes for keeping
my commits alive (which I now know was a mistake). I'll make sure to
add refs pointing directly to my commits instead now. I can send a
patch for the documentation unless someone else beats me to it (it's
been a while since my last patch for git, so it'll take some time for
me to get set up).

For a while, I also thought that `git gc` should be updated to also
keep objects with notes attached. However, as far as I understand, the
notes refs are never rewritten/rewound (only fast-forwarded), which
means that you would never be able to get rid of the old commits in
that case (just like you're already not able to get rid of old notes).
So I understand that you probably don't want to make that change.

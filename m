Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE41C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E4961A03
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhKQHtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhKQHtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 02:49:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19918C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:46:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m20so6939993edc.5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2TsfqXZ9ByiMaSoG7ilV4V+uF+66K6QxbPJDU0BEows=;
        b=UW4iYBQOu4UNHzgmr0oLFzPRt1iHNuxXLGyzMjElMk19Idmy0uDimar1Mk/lXVMv/j
         AuaGTi5re/9/i2HfuPtRoBI7YL4ar4WPaR6MUl1SJKvnz4WDIbhXJv71h0uWW+9mchNv
         T23Cx0RWRtJQtJbv9lJdus1JXtYcjHHERr1q8wHtJEBBCYjFGrBQDp59K5h0OTF7MUYg
         mXsVlq2LWWlHbdOjflbPMxEP8R0L0kZB1Ejd7/eEAiZ+Avwh03oLMK80ISo1kXsXEM4w
         1Kz23Iad9QqpV4eD/t5v7DDYON/jHaWXeibgPjalLch8CAIMVu2iQPANNUFRVOdkdAzc
         Fhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2TsfqXZ9ByiMaSoG7ilV4V+uF+66K6QxbPJDU0BEows=;
        b=Ljk1K+Lymf5+xs1CvBdJisbKvUWAt/Byg+yzkL2LpW7DXSeNa6PShBQjdZfxOhOXVZ
         /7wFM1gh6Vs3ejWHlkv29WBYKmu9dqMDJe61T5kwIBKmcD2Eneidwpe83GOtPVuzyDjn
         ZFP0prHzroL3BPCXEhBKl4o4gLAautSzMu2DKIYeeWYw2WPz/5RG9W+/eQvioWuDcgxD
         k+Xx09AcyJhGNZnDqRLNgdNenVwQ2nlsk8ZsU0q9ikcvVdp0P61UoFK/WN8KY3L/kfXa
         A7RuROEMK2X1FHkFmm9D2pRfaxjFCBKxctlC16SBt9Gt9tgkyGLgQHeHPpj6ZqknLwrn
         AJkA==
X-Gm-Message-State: AOAM532+YtZhJ98WXU3SKVCWW2Lqhd3ell4u3czEDiq/ohojmd35d0/D
        mkoYiEOKmRGI2sw1nLxC+CBIlclUSl4C7eA0H8ixFz7+Ves=
X-Google-Smtp-Source: ABdhPJzeZ0KgSyMndcEYQ9FbcInU54aHRx5hH5lkv/G4R4iQB5MyPK9OG9oeQsI+uMDHrFpE7r6nbnFb0pYOWci57fk=
X-Received: by 2002:a17:907:2d8c:: with SMTP id gt12mr18893707ejc.61.1637135160183;
 Tue, 16 Nov 2021 23:46:00 -0800 (PST)
MIME-Version: 1.0
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Tue, 16 Nov 2021 23:45:49 -0800
Message-ID: <CANiSa6hKPO1toFu-3sM00zj_QbeFWJFE=aEZEjYoW7wq5rPhXQ@mail.gmail.com>
Subject: Generalization of diff and merge
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Something I'm currently working on at work reminded me of an idea I
had a while ago, which I thought may be useful to the Git project.

The idea is simply that diffs and merges can be viewed as special
cases of generalized N-way diffs. This N-way diff function takes an
arbitrary number of inputs and returns a list of matching and
non-matching hunks, where the non-matching hunks have the same number
of parts as there were number of inputs. To get a diff, you pass in
two inputs and interpret the first part of non-matching hunks as the
"before" side and the second part as "after" (assuming that's the
order you passed them in, of course). Similarly, to get a normal 3-way
merge, you pass in three inputs (base, left, and right) and interpret
the parts of the non-matching hunks accordingly. See the tests in [1]
for some examples.

One advantage of doing it this way is that the merge algorithm becomes
consistent with the diff algorithm, so the user won't see conflicts
where the conflicting hunks are in different places than they would
appear in diff output. This is probably not much of a problem in
practice.

Another advantage that I'm not sure matters in the Git project is that
the generalization can help render conflicts from octopus merges.

Sorry if this is an old idea. The fact that there's `git diff
--histogram` but no `git merge --histogram` made me think it's not. Or
maybe there are simply good reasons to not do the generalization?

[1] https://github.com/martinvonz/jj/commit/987aecc749f82c55cb3481f79680552040f7cf13

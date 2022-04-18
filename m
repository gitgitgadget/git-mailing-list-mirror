Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C448DC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 11:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiDRL7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiDRL7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 07:59:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04741A07F
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 04:56:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c64so17171281edf.11
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=j8kyMBKJumYqGgn2ypw+spwWsE7rtDp9CKIFCnK5A0o=;
        b=GCJETmutqPh56DDo8kQIqNoeJnt4N9bwcBe0GbRBOtWVlR2aN8IhHCNS46xRCdZ21U
         0WPgAEI3YP4//PHgh9b2qW3EMlIV2pWAl4Jvz/7pMUXr2eecb18LQZ4Yvr0KO/VDwjy2
         CQ4yvXD2ixBQ4DRM+kyRYH6za1YwqDqpnU2N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j8kyMBKJumYqGgn2ypw+spwWsE7rtDp9CKIFCnK5A0o=;
        b=YKIqfLSV4CD9k+dgFRX2Y4ZB3EU20QT/YXEafuUw6hzXqjvytvXa+yoSLIA27m3xgi
         TSmg8cEYXJX27VfqSD8mdSEdQGbeORO07pLyrcMTX8ELLQpxb70bDg7+BxUZh7kMOgLk
         o2YDGXPpNpE9X/+U/xQNSas4eMKhfMnTK2f7bUGVOjcNzVaCQBrUMBaIvYoNSphfVhlf
         S1h/UXGjcQU/JwJWhdkRfEEJNIjdbuJAh+Go5Qi1Nt6McDGocvQ3ZJ94RJ/u+nO0Vi7s
         GSoBPbcQQnoXK52CYgmtetZKCm/j1DrC9bDzitMud2Uj1TCwUjvYSIC5POmNtmaweCI7
         j/aw==
X-Gm-Message-State: AOAM5309pHOPE6Zo9yC+f82+XnI5zM7s1GW1DNfFd+ur6uhjrtl8Q1J1
        vxl7QdmV8p8HvOfx4+prJU84JbZasDbO1GFxIb6NmBxH3dy8jgLJBAM=
X-Google-Smtp-Source: ABdhPJwH7Vik6/4kWhpkts8WQe+/pB7dO7OC7f41RWbfpRgXUiZhr0bH0uFLj9xxaSeIXUs8hLYLIwA4a2HJpaeJTFs=
X-Received: by 2002:a05:6402:22c4:b0:41d:78b1:349 with SMTP id
 dm4-20020a05640222c400b0041d78b10349mr11950507edb.365.1650283008952; Mon, 18
 Apr 2022 04:56:48 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 18 Apr 2022 13:56:38 +0200
Message-ID: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
Subject: Current state / standard advice for rebasing merges without
 information loss/re-entry?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

The discussion around Edmundo Carmona Antoranz's recent "git replay"
proposal ([1]) led me down a rabbit-hole reminding me I really don't
understand where we stand with rebasing merges, and I don't think I'm
alone.

I understand the standard advice at the moment to be something like:
---
Use a recent git client, use the '--rebase-merges' option (avoid the
--preserve-merges option if you find it), and re-resolve any textual
and/or semantic conflicts manually (possibly using rerere if you know
what you're doing).
---
Is this correct?

This current state/advice seems... suboptimal, at best, because it
ignores any information encoded in the original merge commit, as
clearly documented in the help. It will often result in you having to
resolve conflicts that you already resolved, *where nothing relevant
to that merge/commit has changed in your rebase*. If you have rerere,
and you know what you are doing, and you were the one that performed
the merge, in this repo, then maybe you're ok; similarly if it's a
clean merge of course.

Elijah Newren describes this problem/opportunity quite carefully in
[2], and mentions a bunch of WIP that I have a hard time getting my
head around.

Similarly, Sergey Organov refers to a thread/discussion four years ago
[3], largely involving a debate around two implementations (his and
that of Phillip Wood?) that are largely theoretically-equivalent (in a
majority of cases), with a lovely explanation of the theory behind the
proposal by Igor Djordjevic / Buga [4], but that discussion appears to
have dried up; I can't tell whether anything came of it, even if only
a manually-usable "rebase a merge" script.

Finally, Martin von Zweigbergk mentions his git-like VCS [5] which
stores conflict data in some kinds of commit as part of a general
"working state is always committable and auto-committed"
state-management strategy; I may be misunderstanding something, but I
*think* the resulting conflict-resolution information ends up being
reusable in a manner theoretically equivalent to the strategy
described by Buga as referenced above.

These kinds of discussions frequently seem to feature git experts
saying "I have a script for my version of this problem" (Elijah,
Junio, Johannes Schindelin, ...), or even "I have a VCS for this
problem" :), but I seem to be too stupid or impatient to dig
through/understand whether or when these things will work for a
regular joe and how to use them.

The temptation, obviously(?), is to write a "rebase a merge" script to
do something like Sergey Organov's V2 proposal referenced above... but
it feels like I'd be spending a bunch of time and ultimately just
making things worse for the community, rather than better - helping
myself based on my (very limited, but still above average)
understanding of merge mechanics, in a way that leaves the general
public message / status just as unsatisfactory/unhelpful.

Does anyone have an existing simpler answer? Ideally I'm looking for
something like:
---
* When you have a merge in your history, and you are rebasing, follow
steps XXXXXX, involving this publicly available gist, or contrib
script, or experimental flag, and it will probably do what you want.
If there is a (new) conflict when rebasing the merge commit, you can
expect conflicts to be presented as YYYYY, because rebasing a merge in
this "informed" way can fundamentally involve multiple different
steps/phases of conflict resolution - rebase conflicts vs merge
conflicts.
* Something like this will likely be introduced as a new rebase option
in a future release, something like "--reapply-merges", or
"--rebase-merges-better", because it will always require the user to
understand that the three-way conflicts presented as part of such an
"informed" merge rebase are subtly different to regular rebase or
merge conflicts.
---

Is it possible to get that sort of simplistic message for this complex topic?

My apologies if this request is a duplicate - obviously a pointer to
some sort of existing summary would be perfect.

Thanks,
Tao

[1]: https://lore.kernel.org/git/20220413164336.101390-1-eantoranz@gmail.com/
[2]: https://lore.kernel.org/git/CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com/
[3]: https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/
[4]: https://public-inbox.org/git/a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com/
[5]: https://github.com/martinvonz/jj

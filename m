Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409BCC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 12:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjB0MNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 07:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjB0MNS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 07:13:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE87DA5
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 04:13:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f13so24869070edz.6
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 04:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dejXQ1NIx6BQS1UnehJkg3U00OTvv3o8iBL7+vt08c8=;
        b=LPiXzPLigtZP3OOaFM6gvE3mwVXMmmWElQ4TMJFHJAjqvSpWXPhmrt+CBMBfeZLsK+
         GFJCbYjgQiVffhgVxu9/yPk18C4/YSNnKI0rx1w+kQ5wXO9A7EOeXG2n0eQdEvHCnq+Q
         CfnbW+nlBIUXrokrQMxWeKIGotIIHMCdeVjdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dejXQ1NIx6BQS1UnehJkg3U00OTvv3o8iBL7+vt08c8=;
        b=Q++G3MWkidy/zqB4E0jzLpI6eKGfkMYlUX+Sfp98ADoROuOA8obHZbAKHGib2NcRYk
         DWjvX83styfudFTlXR0C3QMFNu64d8q3iFm3la8fDjHcRl1TaufV0T7Xsrtd9Oug9bJF
         jJ/FKjJlqYlVSYGNfKJu7W6dNXDNSJI2nwh/msDBQQunyn8o7jAvj3SD4mb2pIz3VFYs
         JOop4YWlgjSIzPsizOh/A0iSjZOrXEPEGR8WG+Rrluwpy+UobgA0htSgwkEDbc6R7MGp
         c9isbE/V3uPBYTqGsIapoh1N2yyAaJ4FIJKo/lsVGuU7jkovcwHoFyltCCcaxDL5PQ5c
         afWw==
X-Gm-Message-State: AO0yUKXQgosBJFGyUkopT2T8X6rNgPEqAhg3zHTKHPIkMVyhEL7dd+Y1
        WN00gyUI1Ku+pbvtpavWn+752eT72JChy73uYUI/HvFxr9LWmu5XoeM=
X-Google-Smtp-Source: AK7set+1AAXuJ2PZr0GC+PKBw11ur/LJfVlRnhcC714DD4DfV0qBlNXGXnK9maS9+49nV6Yn/tnZ2VKdC/HHwtyxPp4=
X-Received: by 2002:a17:906:80d7:b0:877:747d:f121 with SMTP id
 a23-20020a17090680d700b00877747df121mr15035699ejx.9.1677499986621; Mon, 27
 Feb 2023 04:13:06 -0800 (PST)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 27 Feb 2023 13:12:55 +0100
Message-ID: <CAPMMpohyoaH92B9f46hwdX2S5WOYeRB2yMSKW-4UCrHe29SAZQ@mail.gmail.com>
Subject: Change branch in the middle of a merge
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

In the past couple of years I've had a few instances of myself or
others starting a merge on a particular branch, resolving a bunch of
conflicts, realizing "this isn't ready for this branch yet", and
wanting to commit the resulting resolved index state *and merge
metadata* to a new local branch.

The "obvious" thing to do, like any other time you find you have some
work you want to commit to a new branch instead of the one you were
working on, is something like "git checkout -b lets-test-this-thing",
followed by "git commit".

If you do that, you will probably *eventually* realize you didn't
achieve your objective; the merge metadata disappeared when you
created a new branch. The index is as you wanted it, and after you
commit the committed tree is as you wanted it (so your testing can
proceed), but in the commit dialog you don't get the expected merge
message prepopulated, and after you commit you don't see the expected
second parent in the commit metadata - it's not a merge.

As as an interested adventurous user, you might then search for
something like "change branch in the middle of a merge" in google, and
discover torek's great stackoverflow answer
https://stackoverflow.com/a/45341429/74296 where he explains one thing
you could/should do differently, once you understand this git
behavior. Basically, *don't* switch to a new branch at that point.
Instead, you could/should commit to the "wrong" branch locally, then
create your testing branch from there, then reset your original
branch, and thus you get where you wanted to be, with the original
branch unchanged and a new branch containing the merge.

If you're even more adventurous you can find other ways to do this, of
course, like switching to *another* new branch, committing there, then
switching to the intended merge-testing branch, preparing a merge
state with "-s ours --no-commit", and restoring the desired tree with
"git restore" (to then commit normally in the branch where you wanted
to).

If you are trying to provide *simple*, reliable instructions that
don't require any depth of understanding of git nor any
potentially-risky commands/habits, then you might instead just say
"always *start* your (risky) merges on new temporary branches, instead
of doing them on the branch where you eventually want them after the
testing".

All three of these strategies are quite awful things to have to teach users.

At first I hoped that "git switch" might have fixed this - and in a
limited sense it has, in that instead of *silently discarding* the
merge state/metadata, it refuses with "fatal: cannot switch branch
while merging".

I've briefly searched for discussion of this topic on this list in the
last couple of years, but not found any.

I'd like to understand whether this behavior, the fact that you can't
easily/straightforwardly/intuitively complete a merge onto a new
branch (with the exact same "first parent" commit of course), is
intentional for some reason that I am failing to grasp, or just a
missing feature.

It makes complete sense, of course, that switching to a *different
commit* than the one you were on when you started the merge, should be
illegal... but why would switching to the *same* commit be either
illegal (git switch behavior) or destructive (git checkout behavior),
as opposed to just letting you get on with it, as it does with other
in-progress local working tree states?

Assuming that I'm not missing anything, I'd like to propose a path
forward something like this:

* Change "git switch" to just allow switching in the middle of a
merge, when the destination commit is the same as the previous commit,
without affecting the merge state/metadata. It is still experimental,
after all, so as long as we agree this is sane and helpful behavior,
the change should be welcome?
* Add a config option to "git checkout" to have it behave the same way
in this regard
* Add a hint to "git checkout", which kicks in when you are destroying
a merge state in this way, helping you see:
** That the merge state just disappeared
** That using "git switch" instead would have prevented this issue
** That there is also a config option to "git checkout" that would
have prevented this
** How to recover the lost merge state in this instance
* (update corresponding documentation)

The "How to recover the lost merge state" bit is non-trivial, the best
I can come up with is... nasty, but at least looks like it should work
across all the common shells I know of:
```
git switch -c temporary-merge-branch-<INITIAL-SHA>
git commit -m "temporary commit of merge result"
git checkout <THE-BRANCH-YOU-CHECKED-OUT>
git merge -s ours <THE-BRANCH-THAT-HAD-BEEN-MERGED> --no-commit
git restore --worktree --staged --source
temporary-merge-branch-<INITIAL-SHA> -- .
```

If the behavior change to "git switch" is not acceptable, then a
parameter, hint, and config option could be added so you can move
forward from the current switch failure with the new behavior.

If the proposed behavior is for some reason utterly impossible to
achieve, then I suppose a hint providing the above "here is now you
get to where you probably wanted to be" procedure would be an
absolute-no-brainer change that I could make.

Please let me know if I'm missing any history, concerns, etc. I
haven't looked at the code to determine whether this is a direction
I'd be comfortable trying to deliver on myself, but I'd like some
understanding of whether it's a reasonable direction to be pursuing at
all, before I try.

Thanks,
Tao

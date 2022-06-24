Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70734C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 11:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiFXLYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 07:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFXLYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 07:24:14 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126D7A6F3
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 04:24:12 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id b81so1089651vkf.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 04:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoluYYe0lSOfOyy6EeU35wAQ9QIOkySA34x8+7ve/1Y=;
        b=MLTmogb/gN26NOBc6KYFFEOW34D6TPXHrXci6Y/xrDG1M92dxvbDKOI4MBK8Mgt4AU
         ntkaT/DZJwcx7wmf20nBtBbzq4tOYC0rCyLiBpAXEaG28z+INXiXTpw5cQmqhnghcC6B
         b8PzmE3/dCQA5ZPsT3rH280ikuf6fAL7PLNkqxn/soJ7HPnqNu4hcslsZhve0/zGxGCI
         ND5dei1u436/FE/UHaU4C+ID3yN8Ews0Ckb0WSsIGEzWaafta/DBUR9+0g0FGxo1u43I
         KP/sRcrDW8B7SR+hWF4ixES7hNTB44ONWAGDgfQwRR/gIKtVsOAjCdcU3zea2OGr3apr
         xsGQ==
X-Gm-Message-State: AJIora+6qfC7C6igVN3dkw1Kd9sFFsyw9kCypTC94qy3y7t47RzeaVCB
        HXbM713Cc73Tv0JgaXwdWW3oHn5T0yb9jx0HFhn7J/Gy
X-Google-Smtp-Source: AGRyM1uwpD3/E9pB8RIfY2599AcZGUWnivL6JiCt/BXM9SuB50re19uQotFkoYE6MKOp65ShRslecc33ahGW5DTtXrQ=
X-Received: by 2002:a05:6122:14a6:b0:36c:3462:c77b with SMTP id
 c6-20020a05612214a600b0036c3462c77bmr12474274vkq.36.1656069851737; Fri, 24
 Jun 2022 04:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220621142618.239b02cd@bigbox.attlocal.net>
In-Reply-To: <20220621142618.239b02cd@bigbox.attlocal.net>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 24 Jun 2022 13:23:34 +0200
Message-ID: <CA+JQ7M9jBSB8tdpz85imER4SF1yhn3jes8ThnzkA_O9+mus1Ng@mail.gmail.com>
Subject: Re: stashing only unstaged changes?
To:     Tim Chase <git@tim.thechases.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My $0.02

On Tue, Jun 21, 2022 at 9:57 PM Tim Chase <git@tim.thechases.com> wrote:
>
> I recently had composed a commit with some `git add -p` leaving some
> portions unstaged. I wanted to stash the unstaged changes to make
> sure that the staged code ran as expected, so I did  a `git stash`
> only to find that it unstaged my staged changes and stashed
> *everything*.

What you wanted to do was
  git stash --keep-index
which creates a stash with the staged and unstaged changes but leaves
the staged ones in the working tree.

If you forget to do this, what you do is try
  git stash pop --index
and then
  git stash --keep-index

> Using `git stash --saved` does the opposite of what I want (stashing
> the index, not the difference between the index and the working-copy)

I'm unaware of a --saved option

My understanding (which may be incorrect) is that a shash is always of
the staged/unstaged changes and there's no way to stash only one or
the other in a single stash operation.

> So I carefully re-`git add -p`'ed everything and tried `git stash
> --keep-index` which sounded promising (my index remained the same),
> but popping my stash ended up causing conflicts because it had
> stashed the diff of HEAD..working-copy, not INDEX..working-copy.  A
> `git stash show -p` confirmed that the stash included things that I
> had already staged.

Such conflicts are usually trivially be resolved by taking "theirs"
I have a helper script that does this and it's basically
  git ls-files --unmerged -z |\
    xargs -0 sed -i -e '/^<\{7\}/,/^=\{7\}/d' --e '/^>\{7\}/d' &&
    git ls-files --unmerged -z | xargs -0 git add --
though, unfortunately, it also stages the content as a part of marking
resolution.

> So I carefully re-`git add -p`ed everything yet again, but then got
> stuck trying to convince `stash` to save a snapshot of only the diff
> in my working directory.

A stash is always both staged and unstaged changes of the files.

To stash only staged you may do
  git stash --keep-index
  git stash
The first stash will include staged/unstaged and the second only staged

To create a stash of only unstaged
  git commit -m tmp # create temporary commit w staged
  git stash # stash unstaged
  git reset HEAD~ &&  git stash # stash the previous staged as
unstaged (optionally git add  in the middle)
  git stash apply/pop stash@{1} # get the "unstaged" stash
As you noted such a stash is still based on a tree that may have
contained staged changes (ORIG_HEAD).
Ie. if you staged line 1 but not 2-3 the "unstaged" stash will also
contain line 1
This is doesn't happen if the staged/unstaged contain different files

> To work around it, I did a `git diff >
> temp.patch` to obtain the stuff I'd wanted to stash, a `git reset
> --staged` to clear out those changes, ran my code to verify
> (eventually committing it), and then applied the `temp.patch` back on
> top of my changes. It worked, but felt convoluted.

That's basically what you have to do if you only want certain changes.
(and also what --patch does under the hood)

> I did see the `git stash -p` option, to manually choose the inverse
> bits, but for what I was doing, it was more sensible to `git add -p`
> and try to stash the rest.

git stash --patch is MUCH slower than git add -p, so I personally never use it.
In my workflow I find it better to either
  git add -p
and then
  git stash --keep-index
or creating regular temporary commits, and fiddling with those,
perhaps using rebase and friends.

> So is there some option I've missed to tell `git stash` to stash only
> the delta between the uncommitted-index and the working-copy?

No, there is none.

In my experience, using regular
add/commit/reset/branch/checkout/rebase is superior to using the stash
for separating changes into discrete commits.

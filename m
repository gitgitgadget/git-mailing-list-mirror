Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F9C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 17:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378567AbhLDRhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 12:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345154AbhLDRhy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 12:37:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D10C061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 09:34:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so24436341edb.8
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48xwTlHf1hDB8N8fl/fjVcHMDB0lNvOwawsPB4oRS7A=;
        b=m8CWO+A6ujYCpQYSAapsU8Nxp+LM+TXi4oS3oqkk1n0DiGpNLbPwcLo3T42tG2mbL1
         uav31t9Nb+NalqNP/gcRtM8gCjopaF1U2uAENXQXlBp/6cHKpaeibO3ZxW9xth5tPmBn
         X6px3nDwajQPek/Czz3l6pQhnmbAHIQwrakKu3Ee85Rwsys/2ypZyzDQ0/8kXiGFbY31
         87KpwNlna4uwRroMWz4siGP4eNnz1Qrufe+vIDc7MjIF5jW2/mNM5JJ+Zi1g4ro0pQj9
         0vgghzjGRJsMIqW0+ABPhBvcFx4o7LnQkhq0vCC+uXEF3YTqdcdVVPaLcKOo4O2I5Ezl
         HxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48xwTlHf1hDB8N8fl/fjVcHMDB0lNvOwawsPB4oRS7A=;
        b=IxBPuuOt+qG44E6tq4B+rietnW6d+dHUIwH2/DVXn5cHY4F/CMw0EuO4aHBD86WkdV
         4lVvFqq9NtpixNuCLoEFuTYgLHJikOhB0x9aORs7odud+zeKvLWMEUC0cHmvTrpgNXp/
         xi9eeCqeJ2V5YhwTvnuYd3LKO0mcxsCyJIVDFvubZknCrZYvUB3UQ2oKPtroUB+azO+9
         PexCB+lIUzAEd6cr6ldTkit3CW4wo+GtSRzAgiw4knhDSBYRpa8UNdwaggMkMav3T7ja
         wgsT25YE0TOydUMAiqs7Faxz5pdL/6dwa7CaYbzYTjPvuR9+KMLvdczYYAV2ECzajgMm
         Pb/g==
X-Gm-Message-State: AOAM533TYlq/K6YWUdbbOD3tawE4WPFjPd3hWZppu/YeqCLAn0D+NE7+
        PqoTkcm80JlmTZWOQYEr0FMR3rWWtvGzof0YmLZZzOxivq4=
X-Google-Smtp-Source: ABdhPJxtE5+uIqyxVZqQu5TSNOwc9x7WLM+k3kjgVJ4ZTYT1ocUDvPuMsphmi7wperfwRloVyb7nXnHHQwd2HP7SXCY=
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr37811358edx.279.1638639267266;
 Sat, 04 Dec 2021 09:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20211202030458.GA48278@newk>
In-Reply-To: <20211202030458.GA48278@newk>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Dec 2021 09:34:15 -0800
Message-ID: <CABPp-BErrT9pHMz-G+E1fQTPueaySFWXf69UQ+yJ_H1RTU9LNQ@mail.gmail.com>
Subject: Re: Potential bug with octopus merges and symlinks
To:     Michael McClimon <michael@mcclimon.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 4, 2021 at 5:47 AM Michael McClimon <michael@mcclimon.org> wrote:
>
> I am having a problem with octopus merges when symbolic links are involved.
> I'm not completely convinced this is a bug in git, but I'm also not convinced
> that it's _not_. (If it's not, my apologies; I often find it very hard to
> track down the answers to complicated git questions on the internet.)
>
> There is a minimal reproducer available at
> https://github.com/mmcclimon/git-merge-problem-demo. Fetch all the branches
> there. The main branch contains a directory (dir1) with a single file
> (file.txt), plus a symlink (dir2), which links to dir1. branch1 replaces this
> symlink with a copy of the files that were linked to. (This was accomplished
> with: rm dir2; cp -r dir1 dir2.) branch2 and branch3 do not touch this
> directory at all.
>
> Merging these three branches fails:
>
> $ git merge branch1 branch2 branch3
> Fast-forwarding to: branch1
> Trying simple merge with branch2
> Simple merge did not work, trying automatic merge.
> Trying simple merge with branch3
> error: Entry 'dir2/file.txt' not uptodate. Cannot merge.
> Merge with strategy octopus failed.
>
> The order here matters! Here is every permutation (1 here is the symlink
> change) to git merge; only the first two fail, all the others work.
>
> 1 2 3   FAIL
> 1 3 2   FAIL
> 2 1 3   PASS
> 2 3 1   PASS
> 3 1 2   PASS
> 3 2 1   PASS
> 1 2     PASS
> 2 1     PASS
> 2 3     PASS
> 3 2     PASS
> 1 3     PASS
> 3 1     PASS
>
> I tracked this down as best I could (I am not a C programmer), by adding
> `set -x` to my copy of git-octopus-merge.sh. I determined that the line is
> failing is toward the very bottom of the main loop there:
>     git read-tree -u -m --aggressive  $common $MRT $SHA1
>
> I had a read of the index-format.txt and then the git read-tree docs, and I
> confess that I don't _totally_ follow the latter. But, I wonder if maybe
> --aggressive is perhaps not aggressive enough if the parts of the index that
> store symbolic link data aren't taken into account, when it's changed between
> two versions and the blobs involved aren't actually different.
>
> I recognize that replacing a symlink with real files under the same name is a
> weird thing to do, but this is a pared-down example of a thing that happens
> occasionally at $work, where we regularly octopus-merge 15+ heads into
> development branches. I would also be happy to know, if this isn't a bug, if
> there's some other workaround! The only way I know to fix this case is to
> merge the symlink change, then rebase all in-flight branches against it. That
> is often extremely time-consuming and tedious, though, and requires a human to
> be involved (all the other merging is done by CI.)

Yeah, I'm not too surprised that there are cases like this that trip up
read-tree and octopus.  There might be a fix in unpack-trees.c, but
it'd take some digging to verify if that's true or it's just a design
limitation.

However, I can give you a workaround, based on my nebulous ideas for
making an octopus-based-on-ort strategy (oort?).  Basically, just do a
sequence of individual merges with ort (which since v2.34 is the default
non-octopus merge strategy), then take the resulting tree and recraft it
into an octopus merge.  So, something like this:

  git merge --no-ff --no-edit branch1
  git merge --no-ff --no-edit branch2
  git merge --no-ff --no-edit branch3

  NEW_TREE=$(git write-tree)

  NEW_COMMIT=$(git commit-tree $NEW_TREE \
                   -p HEAD~3 -p HEAD~2^2 -p HEAD~1^2 -p HEAD^2 \
                   -m "Merge branches 'branch1', 'branch2', and 'branch3'")

  git reset $NEW_COMMIT

Which at least works with the git-merge-problem-demo repository example
you provided.

Note that the reason for the flags above are:
  --no-ff: ensure merge commits are created, so our -p flags to
           commit-tree are correct
  --no-edit: we'll later replace all the commit messages anyway

Also, if you're using an older version of git, the recursive strategy
would be fine too for the steps above; the main advantage of ort would
be that the intermediate steps could be done in memory if this were
implemented as a real builtin merge strategy rather than just a sequence
of shell commands.  The in-memory advantage might be good enough reason
to take this nebulous idea of mine and create the 'oort' strategy at
some point in the future, but for now the sequence of shell commands
should give you what you need.


Hope that helps,
Elijah

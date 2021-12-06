Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BB3C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhLFRHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbhLFQ4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:56:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3EC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:53:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so45607249edc.6
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aUFHjMNy92B67OpS4WTcFtf71cCqoDmJC1nQQd29+0=;
        b=beWQ5ayO953/xoiERiePR8ogHJrd0vS3mvlkMe+zBgnecxtt5mwaxi993BqyAP34y5
         oN+/xcyYSlquqjWQ2C9/NIsEhX3Dbq0R5Jit2LfDnXMSbQnvUXxgTnLabd9I97P1NJ4C
         gtQYWR3UZvfgW26BOeQ4k2YYtR9j2xpbJLGAfbtsfu89jaKIudm2oeS7nOojxmFCgYV7
         WSBqpDXHpByiVXe3IPPSskdXepZLy0fg7Zk+C9L9hMYII5RJ+NqfXcmYc7cB6Ehp0q2j
         SVEEMk4OEG219JtsegHvNQ9Z30eU05zLdfmcAW/Upb7wOnsv+NhhLHH6eYIhu/6jG7Xp
         iWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aUFHjMNy92B67OpS4WTcFtf71cCqoDmJC1nQQd29+0=;
        b=ra+bwIPa90H5u6qbS5IRPSb52kAAkjJnBtmzskSJ/2c0SoVL9LG23facS6sUnRdHCE
         zzbmFekjqJeUQObA55n/BuR/BnQLSRSsYm21p2ImyH65MDhZNDMZ5D67HNDGSHkM8jZw
         iUlXprkFpkrIRIsVxaBXjw9qUDcFVZmxjw085JQ6uBGcfT+q68V6MPYqQ2V8gXQcdY0K
         7yCp3cmATKb0W4m4HDcQC2cV7C5dLSGMAg/sJiHfiwTxizeG4RidWYKK7Te0G09cmADo
         mWUSblwxx7v3h4/djSQ7e/p6zXHglrWlpfpf8sQBLtMM+MKjxMAF9zo2KPVFn2UPgRb5
         2qZw==
X-Gm-Message-State: AOAM530gV4/TbCus1ne1N34HZYwBzFbcRsUuIX5zbMaJVgMg8BKXjFTR
        V65dj7yn0V3RV7uEcCheKV37MsYJ+wG3ZJAPS/3afiOWUBg=
X-Google-Smtp-Source: ABdhPJyjkW8WW9UeGS0z8QIbRQ0kCLW9tA1DwzbWHMKn3IIMfp7BElN+DHmaP29X/LncmXgbpCblyKdw13t07ZoMdRw=
X-Received: by 2002:a05:6402:1808:: with SMTP id g8mr324546edy.248.1638809604702;
 Mon, 06 Dec 2021 08:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20211202030458.GA48278@newk>
In-Reply-To: <20211202030458.GA48278@newk>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Mon, 6 Dec 2021 08:53:12 -0800
Message-ID: <CANiSa6jVp5EV73NxchFhHfZxxetdybhZ6r2qXE8O22e8rgpgVg@mail.gmail.com>
Subject: Re: Potential bug with octopus merges and symlinks
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 4, 2021 at 5:20 AM Michael McClimon <michael@mcclimon.org> wrote:
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

I'm not a Git contributor (since ~10 years ago) but I was curious and
tried your repro myself. Thanks for the very simple instructions.
Maybe it's useful to see what the error is when you use the octopus
strategy to merge only two commits:

```
$ git checkout origin/branch1
$ git merge -s octopus origin/branch2
Trying really trivial in-index merge...
error: Merge requires file-level merging
Nope.
Merge with strategy octopus failed.
```

That "Merge requires file-level merging" is surprising but maybe the
"really trivial" is the explanation :) My *guess* is the answer is
that the octopus strategy is really old and should be rewritten using
the new "ort" strategy (or maybe be integrated into it). I'm afraid I
can't think of a workaround for you (other than trying different
permutations until it works).

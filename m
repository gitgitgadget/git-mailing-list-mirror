Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B05C38BF9
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442A121744
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgBXW11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:27:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40890 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgBXW11 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 17:27:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so12318761wru.7
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 14:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1S86DWZ2MynkSrDs1nwMWGVqtun8tCeIgacSF9XFqUQ=;
        b=BcG2Ch1r88MbDXlerf/KQb0akH000M7umH3M0q37CeB0STeY4ru1F4NMaNlcOkmHVz
         QZLzjfKoaZkHtCEriYd/ekgO7S1GApCUplOTpnxj3Sdpq7aMGnRS4PzLcKErSTAZQOjk
         VkwfPMZC3WZCn1IlYN4zs1jQbNvMGTUmf590gEaVFKZcup5ldNs/9aq7EkNQc/chNjO4
         BMDVhBLnE+KQAE/oKmaaWNTW7vMDZGcjJRaJPNJvQUcYVdemgtjk9B0jhCTgCIvChbco
         kGynV0dv5+DKH9oCS4gJqaHMOm/K3a7CVNe0ihaIDSeVd4s1+20xW3ooMH3mczgm1XF2
         OQSA==
X-Gm-Message-State: APjAAAXSab4u6Kr0H3oQRzLyiHMuRGFbKG9rV+Kt8ofSls1DZAIJGgKE
        dpNAfy0K9TWStdNDs1smk9IKn7sA1kUNOpsOKqY=
X-Google-Smtp-Source: APXvYqzYLarr7vFPOTymWSUrl1awezPLDLJyCI29b5atcTXyyc8HqPnLJ2WC3aCJze1OOrgPiE3hC+cW6DOXD0jCEdg=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr72482427wrr.226.1582583245161;
 Mon, 24 Feb 2020 14:27:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
 <pull.535.v3.git.1582484231.gitgitgadget@gmail.com> <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com>
 <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com>
 <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com> <nycvar.QRO.7.76.6.2002241942120.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2002241942120.46@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 24 Feb 2020 17:27:14 -0500
Message-ID: <CAPig+cR9wwcbnuFmVuoDr6OSq29ZCSt6Kr5KtG3HPsDgM5mGSA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] get_main_worktree(): allow it to be called in the
 Git directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 1:58 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > On Mon, Feb 24, 2020 at 7:12 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > This change makes the code unnecessarily confusing and effectively
> > > turns the final line into dead code. I would much rather see the three
> > > cases spelled out explicitly, perhaps like this:
> > >
> > >     if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git dir */
> > >         !strbuf_strip_suffix(&worktree_path, "/.git/")) /* in worktree */
> > >             strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo */
>
> I would be really cautious about that.
>
> To me, the originally proposed change says: strip `/.`, if any. Then,
> strip `/.git`, and if successful, strip another `/.`, if any.

That's not at all what the original said, which is reproduced here:

    if (!strbuf_strip_suffix(&worktree_path, "/.git"))
        strbuf_strip_suffix(&worktree_path, "/.");

It says "try stripping '/.git'; if that fails, try stripping '/.'".
That is, it recognizes and handles two distinct cases: (1) the path to
the .git directory of a non-bare repository, which always ends with
"/.git", and (2) the path to a bare git repository, which always ends
with "/.". So, the original code wasn't doing any sort of incremental
stripping of suffixes; it was just handling two known distinct cases.

Perhaps you missed the '!' in the conditional?

> That reads pretty fine to me. It makes sense.

To me, it doesn't make sense to update the code as done by the patch
since that just muddies the issue by making it seem as if
get_git_common_dir() is indeterminately tacking on various suffixes
rather than giving us deterministic results.

> Above-mentioned proposal, however, puts quite a few twists into my brain,
> as is a "if neither X nor Y then Z", and I find the code comments outright
> confusing.

It's just three distinct cases my proposed code is handling; there are
no twists.

> The scenario in which we found the buggy behavior involved calling
> `find_shared_symref()`. I imagine that we could use `git branch -D` inside
> the `.git` directory for the new regression test.
>
> But yes, in my testing, `git worktree list` and `git -C .git worktree
> list` do show a different top-level directory (the latter shows an
> incorrect one). Such a test case would find a splendid home in t2402.

I don't have strong feelings about how it is tested, but would like to
see some sort of test proving that it works as expected following this
change.

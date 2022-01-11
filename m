Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDDC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 22:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbiAKWFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbiAKWE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 17:04:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BFDC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 14:04:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t24so1874635edi.8
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 14:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=To5LM/auYFta9tpRHrRAuZ0OMggZepsBH/HznBCSe/E=;
        b=EOur0ra/wVHHucjCBP2DL4CdrOiPvehj46FQ3/rr+ggVrqgYq8JaTm/L1jYR3KebD3
         uh/sKQhvKwRnH3YeyjbhgvHMPmXETuJbw7ytSLVYhKs15ECvJbfmnYr/ACgaTarJjZR8
         MyZq1PWv953eEfOOlq3KMX3SHq7EV8tPLGJgb20mCu8rGlxczsIKyDr+xZsbGhaR8tVJ
         xFU12cUDqRM08BM6OrfupbhPAuu98T/DRvGvc++V29GPGUaX8Gmu9LPRBFttjLwh9TyY
         5IB+XmziUnoU934V2wbxe+MBBjNxYlQJI3dazd2HaJtSJQOwYI59e1EHiilnbES/hoyp
         kTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=To5LM/auYFta9tpRHrRAuZ0OMggZepsBH/HznBCSe/E=;
        b=2sQrbKST2ze9R/i4rTFNZxUpzT/DwIW/ntTlti35sDGb4DLFYRL3aNSw947JsvjVPL
         LC7sNwOipOCkBl5719cNlgqT7HGFW4fevczsCI+eNn7DvmOfnuSzh16U1H1Mq4MmblFC
         1Q/D8hIjVYmUS7jzGPqpEwEL/np+qwF3R1X/G1EnPls5M3ceSJTX1eXoTyvLi6dn5fuQ
         X9jga0pXj6Rf5j3HBQPMJE39DWlpXXxMHcjN8YzV4dP6e+IXgP/aAtcEzC+vviYQ0pcg
         0N2TaYbWgOvLercC8CKkHaEUdAGpgpeK3XLyg3dSdY1xB+MO4toECg3mGyB8DFsDevOO
         ZFvQ==
X-Gm-Message-State: AOAM533k8VL33KswbChI62cSWUhUB3423e9owRDjTiazAlQPBUVCnbY2
        /By3zsCCxVMYxHPG+astQ0SO04PqFbEbj7m+IOg=
X-Google-Smtp-Source: ABdhPJxfF8rndvWI81T8SMrXXf/XOzmISyjrak+3VqO4VpX57X/84FaShWeKze7tw+zCfvwXgSuimHFuHBawY87UyEk=
X-Received: by 2002:a17:907:3f1b:: with SMTP id hq27mr2555590ejc.613.1641938697061;
 Tue, 11 Jan 2022 14:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20220109045732.2497526-1-newren@gmail.com> <20220109045732.2497526-6-newren@gmail.com>
 <950da537-941f-dfb4-460a-1aa4c68e0750@github.com>
In-Reply-To: <950da537-941f-dfb4-460a-1aa4c68e0750@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Jan 2022 14:04:45 -0800
Message-ID: <CABPp-BHEuLB9u1ggDUsTZ_85S52XScM4znM7dnrQQ1iKnXxmhw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] Accelerate ensure_skip_worktree_means_skip_worktree
 by caching
To:     Victoria Dye <vdye@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 10:30 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > Rather than lstat()'ing every SKIP_WORKTREE path, take advantage of the
> > fact that entire directories will often be missing, especially for cone
> > mode and even more so ever since commit 55dfcf9591 ("sparse-checkout:
> > clear tracked sparse dirs", 2021-09-08).  If we have already determined
> > that the parent directory of a file (or any other previous ancestor)
> > does not exist, then we already know the file cannot exist and do not
> > need to lstat() it separately.
> >
> > Granted, the cost of ensure_skip_worktree_means_skip_worktree() might
> > be considered a bit high for non-cone mode since it might now lstat()
> > every SKIP_WORKTREE path when the index is loaded (an O(N) cost, with
> > N the number of SKIP_WORKTREE paths), but non-cone mode users already
> > have to deal with the O(N*M) cost (with N=the number of tracked files
> > and M=the number of sparsity patterns), so this should be reasonable.
> >
>
> Did you write/run any performance tests to see how this optimization changed
> the execution time? If not, running the `p2000` performance tests against
> the patch series base, [3/5], and [5/5] would provide some really helpful
> insight into the cost of `ensure_skip_worktree_means_skip_worktree`, then
> how much this optimization improves it.

I haven't[1].  You bring up a very good point; I'll add it for the next round.

[1] Long, probably irrelevant story about why: My original patches
were actually going to go further and just remove the
present-despite-SKIP_WORKTREE files in _all_ cases, sparse-checkout or
not. It had not occurred to me while writing the patches to make it
specific to sparse-checkouts.  Because of that, I figured it was
better to get feedback on if the idea was acceptable and spent a lot
more time concentrating on making the case.  Then I realized near the
end that folks who don't use sparse-checkout or SKIP_WORKTREE might be
annoyed at the overhead also being added for them, for a feature
they'll never even use.  I decided to back off a bit, and make it
sparse-checkout specific.  Then I realized that backing off might just
keep all users happy anyway (the folks who intentionally use
present-despite-SKIP_WORKTREE paths, despite their many warts, can
keep doings so) and edited a lot of my commit messages, docs, and
cover letter.  And by then it was late Saturday night and I had
promised to send out my series on Friday.  Since I had already marked
my cover letter as RFC anyway, I just decided to temporarily punt on
getting performance numbers...

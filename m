Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B81C433E1
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0D320734
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgFAUyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:54:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38468 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAUyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 16:54:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id f185so897344wmf.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 13:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnX0YjgvRlV7iqDsIQ4XF0UmnpwxDP//wzhlHdOX2LM=;
        b=LjZKGCx9eBmArwNYeqkbJL8dcMck1fXoTv9OcKlzIoED7LXsmoWkYdMXoUrPLNV7i4
         sARkJuGZf3094SgNjP5oB4WUYHFXjh9WFOll6Pjx1ehgTKkhGurA94hRbULJR+Z2JQc4
         disDm4CoBLu8L6jZMJqbnZJ0N5KcOwA7KQAthE3IE0vUUnPQEtAeZ8EdW34yrnSulO6X
         ufXadoHdzZ7hvlmAeUVALtybcO38NB9QoURRQV+JQyxYpX2DUw56jmga5UWwmnKli2jQ
         w9dhM7RhGytVRURbFr+FCX6BBycpn/ZHGlEDkRCySNZkrv5RE0UZTtyfUnaQc9PS8ZlG
         G/hw==
X-Gm-Message-State: AOAM533nm2tpxA72fDt7d9xV1QqZGcN510ABX5b0V/pSISw+ukHaJoUo
        gGW//ylsy+NszfqTYhOuHoIKClaNbmXJYfUO2vSe7X9j
X-Google-Smtp-Source: ABdhPJy8v7UJwPDvpAKhhp1nU2XETH3aJNM6kvoJYZPP+d7vrujyJ75LJopkJdqfhbxYzfDmMxjaOpRmo/swv8pNYD0=
X-Received: by 2002:a1c:bad7:: with SMTP id k206mr976135wmf.11.1591044841489;
 Mon, 01 Jun 2020 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <54a3a798-0387-64df-be20-af69db124042@UhdeJc.com>
 <20200601044511.GA2529317@coredump.intra.peff.net> <cfc79aec-ec85-dbec-e37b-6b7035b4c5a4@UhdeJc.com>
 <20200601165408.GA2536619@coredump.intra.peff.net> <20200601202218.GA2763518@coredump.intra.peff.net>
In-Reply-To: <20200601202218.GA2763518@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Jun 2020 16:53:50 -0400
Message-ID: <CAPig+cRyrEHNxY+Y-_E6e4DZB-sAiVdSB2T53bKP6UJOx_DJDA@mail.gmail.com>
Subject: Re: [PATCH] diff: discard blob data from stat-unmatched pairs
To:     Jeff King <peff@peff.net>
Cc:     Jan Christoph Uhde <Jan@uhdejc.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 1, 2020 at 4:22 PM Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] diff: discard blob data from stat-unmatched pairs
>
> When performing a tree-level diff against the working tree, we may find
> that our index stat information is dirty, so we queue a filepair to be
> examined later. If the actual content hasn't changed, we call this a
> stat-unmatch; the stat information was out of date, but there's no
> actual diff.  Normally diffcore_std() would detect and remove these
> identical filepairs via diffcore_skip_stat_unmatch().  However, when
> "--quiet" is used, we want to stop the diff as soon as we see any
> changes, so we check for stat-unmatches immediately in diff_change().
>
> That check may require us to actually load the file contents into the
> pair of diff_filespecs. If we find that the pair isn't a stat-unmatch,
> then no big deal; we'd likely load the contents later anyway to generate
> a patch, do rename detection, etc, so we want to hold on to it. But if
> it a stat-unmatch, then we have no more use for that data; the whole

s/it/& is/

> point is that we're going discard the pair. However, we never free the
> allocated diff_filespec data.
>
> In most cases, keeping that data isn't a problem. We don't expect a lot
> of stat-unmatch entries, and since we're using --quiet, we'd quit as
> soon as we saw such a real change anyway. However, there are extreme
> cases where it makes a big difference:
>
>   1. We'd generally mmap() the working tree half of the pair. And since
>      the OS may limit the total number of maps, we can run afoul of this
>      in large repositories. E.g.:
>
>        $ cd linux
>        $ git ls-files | wc -l
>        67959
>        $ sysctl vm.max_map_count
>        vm.max_map_count = 65530
>        $ git ls-files | xargs touch ;# everything is stat-dirty!
>        $ git diff --quiet
>        fatal: mmap failed: Cannot allocate memory
>
>      It should be unusual to have so many files stat-dirty, but it's
>      possible if you've just run a script like "sed -i" or similar.
>
>      After this patch, the above correctly exits with code 0.
>
>   2. Even if you don't hit mmap limits, the index half of the pair will
>      have been pulled from the object database into heap memory. Again
>      in a clone of linux.git, running:
>
>        $ git ls-files | head -n 10000 | xargs touch
>        $ git diff --quiet
>
>      peaks at 145MB heap before this patch, and 94MB after.
>
> This patch solves the problem by freeing any diff_filespec data we
> picked up during the "--quiet" stat-unmatch check in diff_changes.
> Nobody is going to need that data later, so there's no point holding on
> to it. There are a few things to note:
>
>   - we could skip queueing the pair entirely, which could in theory save
>     a little work. But there's not much to save, as we need a
>     diff_filepair to feed to diff_filespec_check_stat_unmatch() anyway.
>     And since we cache the result of the stat-unmatch checks, a later
>     call to diffcore_skip_stat_unmatch() call will quickly skip over
>     them. The diffcore code also counts up the number of stat-unmatched
>     pairs as it removes them. It's doubtful any callers would care about
>     that in combination with --quiet, but we'd have to reimplement the
>     logic here to be on the safe side. So it's not really worth the
>     trouble.
>
>   - I didn't write a test, because we always produce the correct output
>     unless we run up against system mmap limits, which are both
>     unportable and expensive to test against. Measuring peak heap
>     would be interesting, but our perf suite isn't yet capable of that.
>
>   - note that diff without "--quiet" does not suffer from the same
>     problem. In diffcore_skip_stat_unmatch(), we detect the stat-unmatch
>     entries and drop them immediately, so we're not carrying their data
>     around.
>
>   - you _can_ still trigger the mmap limit problem if you truly have
>     that many files with actual changes. But it's rather unlikely. The
>     stat-unmatch check avoids loading the file contents if the sizes
>     don't match, so you'd need a pretty trivial change in every single
>     file. Likewise, inexact rename detection might load the data for
>     many files all at once. But you'd need not just 64k changes, but
>     that many deletions and additions. The most likely candidate is
>     perhaps break-detection, which would load the data for all pairs and
>     keep it around for the content-level diff. But again, you'd need 64k
>     actually changed files in the first place.
>
>     So it's still possible to trigger this case, but it seems like "I
>     accidentally made all my files stat-dirty" is the most likely case
>     in the real world.
>
> Reported-by: Jan Christoph Uhde <Jan@UhdeJc.com>
> Signed-off-by: Jeff King <peff@peff.net>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EA6C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D870F61373
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 07:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhHYHs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbhHYHsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 03:48:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E4C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rny4otAClFB7nqlI74mHkS850iRhuecvG0FVhup8pjM=;
        t=1629877689; x=1631087289; b=JOHnidwSmZ+C9+l6+GAJ9D8nJ8iI7PGdLe0wj8ZMlphA2Ii
        UdEibpUytIag2gd/VGV/PPGWqI+GtqK8G8qYk1z44m9ObHDbL4LeW9MhrGITXZ6h3PRHvs21w9ewm
        lCGH1fj1acOR3M2+XPy4xLjaLgg+cgK0XanK8NpKuQfZa2pJZNJiO//1f65ij4JrmGrfyYun6Tz4U
        UG1clQ0BLSOSA/xD3YltmepS0D/lJIJ+Hnf9kYesymWM+wE6KAXzcsFlz+PJl2se/Ha0BdqcEy5zB
        3K422qWqu/0tTZdE/veFFPYfLuPukHQEgd/WbcPPLZbhQpBnMfnIIbdTAbg/DkKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIndj-00Fd0l-CK; Wed, 25 Aug 2021 09:48:03 +0200
Message-ID: <d66f040e663f935c5407fdecad43a4c3d8e57105.camel@sipsolutions.net>
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Date:   Wed, 25 Aug 2021 09:48:02 +0200
In-Reply-To: <YSXy73lWKteiuY6s@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
         <cover.1629821743.git.me@ttaylorr.com>
         <YSWOtNoxirDdmBXG@coredump.intra.peff.net> <YSWmhMID1hGs7Yp1@nand.local>
         <YSXy73lWKteiuY6s@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2021-08-25 at 03:36 -0400, Jeff King wrote:
> On Tue, Aug 24, 2021 at 10:10:12PM -0400, Taylor Blau wrote:
> 
> > > It's not clear to me that we have a resolution on whether calling "cd ..
> > > && git multi-pack-index write --object-dir repo.git" is supposed to
> > > work.
> > 
> > My recommendation would be to do the following things, all in a reroll
> > of this series:
> > 
> >   - Fix the bug by which we would delete a .rev or .bitmap file out of a
> >     different object store than we were working in (when the caller
> >     passes `--object-dir`).

That was what my patch did, afaict.

> >   - Disallow running `git multi-pack-index` outside of a Git repository.
> > 
> >   - Restrict `--object-dir` to only work with alternates of the
> >     repository in the current working directory.
> > 
> > To me, that seems like both the least-surprising behavior, and what
> > would lend itself to the easiest implementation. I would probably argue
> > that the existing behavior (where `--object-dir` would work against
> > arbitrary repositories) is a bug, and shouldn't continue to be
> > supported.
> 
> All of those seem reasonable to me, and are what I would suggest if we
> were starting from scratch. My only hesitation is whether people are
> using the weird behavior of --object-dir in the wild (e.g., are bup
> folks relying on it).
> 
> Johannes, is this something you're using _now_, and it works, or
> something you hoped to use in the future?

I was "hoping" to use

	git multi-pack-index --object-dir=... write

but never

	$ git multi-pack-index write --object-dir=...

which almost seems like it really is more like

	$ git -C ... multi-pack-index write

anyway, because you specify a repo? At least per the above example, I
never tried.


As I started playing with that again (I had done before, and it worked)
I noticed the segfault, hence my previous patch.


However, what I was thinking of doing is more outlined in this thread:
https://lore.kernel.org/git/20210820195558.44275-1-johannes@sipsolutions.net/


And essentially, as I described later in
https://lore.kernel.org/git/dbb24573efc3dd945acd8acdfd9fe627ad7cbcd2.camel@sipsolutions.net/

I have two only vaguely overlapping use cases.

One of them doesn't need "--object-dir", and the other requires that
[RFC PATCH] to be applied as well, which would basically let me use only
the small subset of git that is "git multi-pack-index" as machinery to
*just* do indexing, *without* really ever having a real "repository"
that git could otherwise operate on and worry about the actual objects
etc.

I might resend that with the code style issues fixed, but the objects
seemed more fundamental.

> But what I'm wondering is whether using --object-dir from outside a repo
> entirely is actually something that even works. I.e., would we be
> disabling a behavior that was not intended, but does happen to work? Or
> are we closing off a possibly buggy and half-working part of the system?

Well, it does work now, modulo the segfault, but that is actually a very
recent addition, I'd tried this before :)

johannes


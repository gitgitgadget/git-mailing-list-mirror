Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62904C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD1B2070B
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD0U6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:58:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:41440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726420AbgD0U6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 16:58:10 -0400
Received: (qmail 16158 invoked by uid 109); 27 Apr 2020 20:58:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 20:58:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27820 invoked by uid 111); 27 Apr 2020 21:09:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 17:09:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 16:58:08 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v2 4/4] commit-graph.c: ensure graph layers respect
 core.sharedRepository
Message-ID: <20200427205808.GA1732530@coredump.intra.peff.net>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
 <f83437f130812d172167d335ba2d13b1545a9f58.1588004647.git.me@ttaylorr.com>
 <20200427172111.GA58509@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200427172111.GA58509@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 11:21:11AM -0600, Taylor Blau wrote:

> On Mon, Apr 27, 2020 at 10:28:05AM -0600, Taylor Blau wrote:
> > Non-layered commit-graphs use 'adjust_shared_perm' to make the
> > commit-graph file readable (or not) to a combination of the user, group,
> > and others.
> >
> > Call 'adjust_shared_perm' for split-graph layers to make sure that these
> > also respect 'core.sharedRepository'. The 'commit-graph-chain' file
> > already respects this configuration since it uses
> > 'hold_lock_file_for_update' (which calls 'adjust_shared_perm' eventually
> > in 'create_tempfile_mode').
> 
> It occurs to me that we might want to apply the same treatment to
> 'commit-graph-chain's, too.

Yeah, perhaps. I think we've been fairly inconsistent about modes here.

Really, just about _everything_ in .git is meant to be immutable,
because we generally use rename() to update files atomically. And
there's no reason anybody should ever be opening them for writing.

I think we started with dropping the write-bit on loose and packed
object files because those are extra-precious (even if everything else
were corrupted, your history, etc, is all still there). And certainly
you can't update them without invalidating their checksum trailers
anyway.

So I think there's really three levels that could make sense:

  1. Many files in .git should lose their write bits, because Git will
     never update them except through rename. This makes things safer
     against accidental changes, but more annoying when you do want to
     edit by hand. Probably .git/config should likely be exempted, as
     we'd encourage people to hand-edit even if it's not atomic. But
     having to chmod before hand-editing a packed-refs file while
     debugging is not a huge burden.

  2. Any file written via hashfd() should be marked immutable. It cannot
     be edited without rewriting the whole contents and updating the
     trailer anyway. That would imply that commit-graph and chain files
     should be immutable, but the commit-graph-chain file should not.

  3. Everything except actual object files should retain their write
     bit. It's a minor annoyance when touching the repo by hand (e.g.,
     "rm" is sometimes pickier even about deletion), and it's not like
     there's a rash of people accidentally overwriting their refs/
     files (they're just as likely to screw themselves by deleting
     them).

I admit I don't overly care much between the three. And your patches
look fine to me, as they're just making the commit-graph code consistent
with itself (and that inconsistency is wrong under any of the mental
models above ;) ).

The exception is the final patch, which is an actual bug-fix for people
using core.sharedRepository. I suspect the feature is used infrequently
enough that nobody noticed.

-Peff

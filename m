Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CC820899
	for <e@80x24.org>; Tue, 15 Aug 2017 03:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbdHODyg (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 23:54:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:39018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753070AbdHODyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 23:54:35 -0400
Received: (qmail 12485 invoked by uid 109); 15 Aug 2017 03:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 03:54:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8270 invoked by uid 111); 15 Aug 2017 03:54:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 23:54:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 23:54:33 -0400
Date:   Mon, 14 Aug 2017 23:54:33 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     'Howard Chu' <hyc@symas.com>,
        "spearce@spearce.org" <spearce@spearce.org>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "ben.alex@acegi.com.au" <ben.alex@acegi.com.au>,
        "dborowitz@google.com" <dborowitz@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "mhagger@alum.mit.edu" <mhagger@alum.mit.edu>,
        "sbeller@google.com" <sbeller@google.com>,
        "stoffe@gmail.com" <stoffe@gmail.com>
Subject: Re: reftable [v5]: new ref storage format
Message-ID: <20170815035432.kyrrqoagoxouwyln@sigill.intra.peff.net>
References: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
 <ee8f70bd-6f9e-3fb6-67be-ba26b6d5bf16@symas.com>
 <576a2361-1a3d-4bb2-1d31-f095f9e3c708@symas.com>
 <4c1c1fc9904f4678823b6c3054c02b4d@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c1c1fc9904f4678823b6c3054c02b4d@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 04:05:05PM +0000, David Turner wrote:

> > All that aside, we could simply add an EXCLUSIVE open-flag to LMDB, and
> > prevent multiple processes from using the DB concurrently. In that case,
> > maintaining coherence with other NFS clients is a non-issue. It strikes me that git
> > doesn't require concurrent multi-process access anyway, and any particular
> > process would only use the DB for a short time before closing it and going away.
> 
> Git, in general, does require concurrent multi-process access, depending on what 
> that means.
> 
> For example, a post-receive hook might call some git command which opens the 
> ref database.  This means that git receive-pack would have to close and 
> re-open the ref database.  More generally, a fair number of git commands are
> implemented in terms of other git commands, and might need the same treatment.
> We could, in general, close and re-open the database around fork/exec, but I am
> not sure that this solves the general problem -- by mere happenstance, one might
> be e.g. pushing in one terminal while running git checkout in another.  This is 
> especially true with git worktrees, which share one ref database across multiple
> working directories.

Yeah, I'd agree that git's multi-process way of working would probably
cause some headaches if there were a broad lock.

I had the impression that Howard meant we would lock for _read_
operations, too. If so, I think that's probably going to cause a
noticeable performance problem for servers.  A repository which is
serving fetches to a lot of clients (even if some of those are noops)
has to send the current ref state out to each client. I don't think we'd
want to add a serial bottleneck to that portion of each process, which
can otherwise happen totally in parallel.

Serializing writes is probably not so big a deal as long as it is kept
to the portion where the process is actively writing out values. And as
long as there's a reasonable backoff/retry protocol; right now we don't
generally bother retrying ref locks because they're taken individually,
so racing on a lock almost certainly[1] means that you've lost the
sha1-lease and need to restart the larger operation.

-Peff

[1] Actually, we've found this isn't always true. Things like ref
    packing require taking locks for correctness, which means they can
    interfere with actual ref updates. That's yet another thing it would
    be nice to get rid of when moving away from the loose/packed
    storage.

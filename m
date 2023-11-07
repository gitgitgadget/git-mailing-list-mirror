Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6BD211C
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D0114
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 20:02:01 -0800 (PST)
Received: (qmail 27517 invoked by uid 109); 7 Nov 2023 04:02:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Nov 2023 04:02:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11287 invoked by uid 111); 7 Nov 2023 04:02:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 23:02:04 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 23:02:00 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] list-objects: drop --unpacked non-commit objects
 from results
Message-ID: <20231107040200.GC873619@coredump.intra.peff.net>
References: <cover.1699311386.git.me@ttaylorr.com>
 <d3992c98aaa54c3635c249a15d919aa1177324d8.1699311386.git.me@ttaylorr.com>
 <xmqq7cmub8wm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cmub8wm.fsf@gitster.g>

On Tue, Nov 07, 2023 at 11:21:29AM +0900, Junio C Hamano wrote:

> > In git-rev-list(1), we describe the `--unpacked` option as:
> >
> >     Only useful with `--objects`; print the object IDs that are not in
> >     packs.
> >
> > This is true of commits, which we discard via get_commit_action(), but
> > not of the objects they reach. So if we ask for an --objects traversal
> > with --unpacked, we may get arbitrarily many objects which are indeed
> > packed.
> 
> Strictly speaking, as long as all the objects that are not in packs
> are shown, "print the object IDs that are not in packs" is satisfied.
> With this fix, perhaps we would want to tighten the explanation a
> little bit while we are at it.  Perhaps
> 
> 	print the object names but exclude those that are in packs
> 
> or something along that line?

I think using the word "exclude" is a good idea, as it makes it clear
that we are omitting objects that otherwise would be traversed (as
opposed to just showing unpacked objects, reachable or not).

But I wanted to point out one other subtlety here. The existing code
(before this patch) checks for already-packed commits, and avoids adding
them to the traversal. The problem this patch is fixing is that we may
see objects they point to via other non-packed commits. But the opposite
problem exists, too: we have unpacked objects that are reachable from
those packed commits.

It's probably reasonably rare, since we _tend_ to make packs by rolling
up reachable chunks of history. But that's not a guarantee. One way I
can think of for it to happen in practice is that somebody pushes (or
fetches) a thin pack with commit C as a delta against an unpacked C'. In
that case "index-pack --fix-thin" will create a duplicate of C' in the
new pack, but its trees and blobs may remain unpacked.

I think with the patch in this series we could actually drop that "do
not traverse commits that are unpacked" line of code, and end up "more
correct". But I suspect performance of an incremental "git repack -d"
would suffer. This is kind of analagous to the "we do not traverse every
UNINTERESTING commit just to mark its trees/blobs as UNINTERESTING"
optimization. We know that it is not a true set difference, but it is OK
in practice and it buys us a lot of performance. And just like that
case, bitmaps do let us cheaply compute the true set difference. ;)

-Peff

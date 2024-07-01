Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021CBA34
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858509; cv=none; b=pFZLCw8+SOXhSy9cxNF5c3yqN9c2+x7EZFSf3d8odltidIWAm3XmlW6zVDj56oFBhh2NK4wUTFYJ+TAkATkPzN3b7goNLJBplWrJEjOOP0BrBex9g9xJk3XRpJltRPAd3JrDBwzbrFDHKPKjR5NqM4jMOx46SHsjOV7KuvNYlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858509; c=relaxed/simple;
	bh=oA6fHrqCJqwJsSygybMPTYf8HFQpjCQvNt+hpEiu918=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIxWSQ5e3H54jeI+2ZpMIk623obPmEzrHYJ+d9hwRMVLC4Z7ZRP5dN6z8XONrH5Oj/zNpHmde0f+YOObsbVrzcThWqmhvYAmvJd4/NftCIpACpEnS2TYFq/MSW6JbU5ms4dw9RahEHp6yw22H57rAQb0n5lvevX4UTGAZXStgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25510 invoked by uid 109); 1 Jul 2024 18:28:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 18:28:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14890 invoked by uid 111); 1 Jul 2024 18:28:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 14:28:24 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 14:28:24 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Julia Evans <julia@jvns.ca>, git@vger.kernel.org
Subject: Re: Confusing treatment of "head" in worktree on case-insensitive FS
Message-ID: <20240701182824.GE3199@coredump.intra.peff.net>
References: <A72DCB1B-8D81-4DD7-93AD-BF37E88E9D63@jvns.ca>
 <20240701033145.GB610406@coredump.intra.peff.net>
 <bfa964a5-c366-47c7-a325-44fa4687432a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfa964a5-c366-47c7-a325-44fa4687432a@gmail.com>

On Mon, Jul 01, 2024 at 02:17:21PM +0100, Phillip Wood wrote:

> On 01/07/2024 04:31, Jeff King wrote:
> > On Sat, Jun 29, 2024 at 10:39:29AM -0400, Julia Evans wrote:
> > > $ git init
> > > $ git commit --allow-empty -m'test'
> > > $ git worktree add /tmp/myworktree
> > > $ cd /tmp/myworktree
> > > $ git commit --allow-empty -m'test'
> > > $ git rev-parse head
> > > adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
> > > $ git rev-parse hEAd
> > > adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
> > > $ git rev-parse HEAD
> > > fbb28196d08d74aa61f65e5cee3cb11cc24c338a
> > 
> > I admit this is an unexpected case, as I'd expect both on-disk files to
> > be spelled "HEAD". I didn't dig into the details, though, so it's
> > possible there's something we could be doing differently or better. But
> > I do think it's mostly the tip of the iceberg for case-insensitivity
> > issues with refs.
> 
> I think what's happening is that the checks in is_current_worktree_ref() are
> case sensitive so "head" is not treated as local to the current worktree and
> ends up being resolved in the main worktree. I guess we could make those
> checks case-insensitive but as you say it'd only be dealing the tip of the
> iceberg.

Ah, right, that makes perfect sense (well, why it happens that way, not
from the perspective of a user :) ).

So one thing we could do (but I am not sure is wise) is for those checks
to become case-insensitive for a case-insensitive ref store. And then at
least if you use consistent case when writing refs, you should get
reasonable behavior (whereas if you make "hEaD" and "HEAD" yourself, all
bets are off). But I'd worry about opening up even more weird corner
cases. And you can already avoid this problem (I think) by using the
case-sensitive spelling "HEAD" on lookups.

> On a related note do MacOs and Windows do any unicode normalization when
> looking up filenames? If so then that's probably another can of worms for
> filesystem based refs.

At least macOS does. That's why we have all of the precompose-unicode
code, which tries to normalize arguments to match what the OS will do.
In theory we could do something like that for case normalizing, but I
don't think it's nearly as simple.

For a read, normalizing "head" to "HEAD" on a case-insensitive
filesystem is OK, since the OS will return the same set for each group.

But writing is harder. The unicode normalization in the filesystem is
not "preserving". So if I pass in a decomposed string, the filesystem is
going to silently convert it to the precomposed form anyway. But case is
usually preserving. So if I write "hEaD", I'll get that in the
filesystem, and not actually "HEAD". I dunno. Maybe it would be OK if we
did that only for root refs which would otherwise be forbidden. But it
really feels like opening up a can of complexity worms and corner cases.

-Peff

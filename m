Received: from dcvr.yhbt.net (public-inbox.org [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8571B4F1F
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322037; cv=none; b=lGTKdHYBHkfX2JMEwQhpzFwNmTL0e4PJeqZz3yNc9LKu9FEwENdltcD9krn3lZ61yp7xgcXD7r/rTYzm1YQ+6NRz7b52PxHK1hX1JtoSnp36GHtj2Fibb5bfJfaMPHclqU/SSvpX2yK2OK+NL1V+BeIpm34UAVCEl746fx4f8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322037; c=relaxed/simple;
	bh=FC+DllNIGeaviSw+PU1QOptGDriT22MBfam2QosVnYg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9eXUrFlfCSLPHRjectJPKKSXGnLiyHStUtYsh24oz0iAQD3KfSAqOSdd+WNMEinTGX8I59LOR5oBJHXjJuUkzb2Z58aZGnfCOqeTKTcQaIpMSgx94oBnEXGo8hZnGcVDcR5LulSjhvsFHC+K1HingAFoEHAQpo+RAOOKrPhv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=Rw9Jqkb2; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="Rw9Jqkb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1756321697;
	bh=FC+DllNIGeaviSw+PU1QOptGDriT22MBfam2QosVnYg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Rw9Jqkb2nMGZ7dln4ZXfxfS9ZOarAFSBFqBBGUoh7w5fGCMpzKOlk8LDA0RLowwKG
	 m1nXFIPV7H2gRUm9c1q95aEy9irmZsjoQorDfp57yMtjuV0OP29JvfwgHeA/hB6jhf
	 AATA4mTTxmtIrSFxm6RKfkbkitODIlyLHYTQZ/lM=
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CB81F646;
	Wed, 27 Aug 2025 19:08:17 +0000 (UTC)
Date: Wed, 27 Aug 2025 19:08:16 +0000
From: Eric Wong <e@80x24.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing =?utf-8?Q?SHA-1_?= =?utf-8?B?4oaU?= SHA-256
 mappings in compatibility mode
Message-ID: <20250827190817.M36986@dcvr>
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> TL;DR: We need a different datastore than a flat file for storing
> mappings between SHA-1 and SHA-256 in compatibility mode.  Advice and
> opinions sought.

<snip>

> Our approach for mapping object IDs between algorithms uses data in pack
> index v3 (outlined in the transition document), plus a flat file called
> `loose-object-idx` for loose objects.  However, we didn't anticipate
> that we'd need to handle mappings long-term for data that is neither a
> loose object nor a packed object.
> 
> For instance, with shallow clones, we must store a mapping for the
> shallows the server has sent us[1], since we lack the history to convert
> objects otherwise.  Similarly, if there are submodules or we're using a
> partial clone, we must store those mappings as well, since we cannot
> convert trees without them.  We can store them in the
> `loose-object-idx`, but since it's not sorted or easily searchable, it's
> going to perform really terribly when we store enough of them.  Right
> now, we read the entire file into two hashmaps (one in each direction)
> and we sometimes need to re-read it when other processes add items, so
> it won't take much to make it be slow and take a lot of memory.

This really seems ideal for SQLite, which has come a long way
since 2005 when git started.

I really wish git would've relied on more on existing formats
(e.g. LMDB refs) rather than introducing more one-off data
formats that require more cognitive overhead to document and
learn[1], especially when SQLite is extremely portable and works
on tiny devices.

> For these reasons, I think we need a different datastore for this and
> I'd like to solicit opinions on what that should look like.  Here are
> some things that come to mind:
> 
> * The format should be fast to read and relatively fast to write.
> * We need to efficiently read and map objects in both directions.  This
>   is required for many reasons, including efficient fetches and pushes.

SQLite seems to do these well, in my experience.  It's not the
fastest possible data store, but it's no slouch, either.

> * We still require an in-memory store because we stuff entries in their
>   without writing them during pack indexing and other operations, but
>   that doesn't mean we need to load data from the data files into the
>   in-memory structure (in fact, we probably should try to avoid it).

SQLite supports in-memory DBs, and also mmap.  I always prefer
to always put larger structures on TMPDIR and rely on page
cache; because sometimes code ends up running on machines with
too little memory/swap (but git has never been great w.r.t.
memory use :<).

> * We want to be able to write small updates to the data without having
>   to re-write the entire thing (e.g., `git add`).  We often know that
>   we'll be writing a whole batch at once, such as with shallows or
>   submodules from a clone or fetch, so many places in the code will be
>   able to start a batch and then write, but we shouldn't assume that
>   will always be the case.  (In other words, we will write more
>   frequently than we do packs or indexes.)

Transactions and atomicity are included, of course.

> * It would be helpful if we can determine the type of object being
>   stored.  For instance, if we've stored an object mapping because of a
>   shallow, `git gc` could remove that mapping if the shallows have been
>   updated and the mapping is no longer useful.

Column names should be enough.

> * We should try not to assume only two hash algorithms.  Pack index v3
>   allows for effectively an arbitrary number and while much of the
>   compatibility code assumes one main and one compatibility algorithm,
>   we should try to minimize that if possible.[2]

I haven't used it much, but ALTER TABLE should work well nowadays
for adding (maybe not removing) columns.

> * Being able to mmap it would be convenient, so if we can make it
>   relatively small, that's nice.

mmap is possible, but default builds of SQLite defaults to a
relatively small mmap limit (2G?).  I don't know why and never
bothered to deal sign up for their Fossil (JS required :<, last
I checked) to ask about the small default limit.


I don't like SQLite's approach to rejecting outside
contributions; but otherwise it's served me well with various
bits of Perl code for the last 15 years or so.  Yeah, the SQLite
developer doesn't have the highest opinion of git, but we
shouldn't let that affect our decision making.


[1] Fwiw, I enjoyed working on git a lot more when it used more
    high-level scripting glue.  I'm disappointed in the overall
    movement towards AOT languages (C, now Rust) due to large
    toolchains, slow builds + linkers.  Hacking was much more
    discoverable when I could just edit installed scripts like
    config files and not have to deal with builds at all :>

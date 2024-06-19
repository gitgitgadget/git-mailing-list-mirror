Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887614D702
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803332; cv=none; b=arg166ZrJ7DLXYfgTubZVDwQM4ORD7GKa5R2xWJFGcs1wdJymWn+Qh7XxF3BrdVGRU85FcnkZwjJJK8yz8FJEOBnMKwKhCRkfuL7VlL3cw/n69htlMYkgC/7yNb3mxTTXpZr8DW+2utnkZ5CagsZTfnoya80Axzvq/RY+wwt/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803332; c=relaxed/simple;
	bh=WijoBSplKsR6IsYZyr3243SNZNdkPIMQgZl8PJnqa+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/rR0OJ4ogwg9/gQLN71q/J/+A47T4USkA1x42zZZjgcX6LkjRULJE/Mca79SqMmk9hwCYCmhIfYOH2xtToqGE3Q6xCOJMCXbN530GOEoqiYr88o6B8HArnvFzNX3C4sADWISETv7rN+/HxRGFVEQt7d582THMfGbAAhXuIYlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9254 invoked by uid 109); 19 Jun 2024 13:22:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 13:22:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21323 invoked by uid 111); 19 Jun 2024 13:22:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 09:22:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 09:22:08 -0400
From: Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@nexedi.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Tan <jonathantanmy@google.com>,
	Alain Takoudjou <alain.takoudjou@nexedi.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>
Subject: Re: [PATCH] fetch-pack: fix segfault when fscking without --lock-pack
Message-ID: <20240619132208.GA895873@coredump.intra.peff.net>
References: <20240606133605.602276-1-kirr@nexedi.com>
 <ZnJpJyLPAKlu82s8@deca.navytux.spb.ru>
 <20240619130256.GA228005@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619130256.GA228005@coredump.intra.peff.net>

On Wed, Jun 19, 2024 at 09:02:56AM -0400, Jeff King wrote:

> I think it's a bug that fetch.unpackLimit causes index-pack to create a
> lockfile at all, but there's a more direct way to trigger the issue,
> which I've used in the patch below. I'll follow up with more details in
> a reply to the patch.

Your original test used transfer.unpackLimit. By itself that should just
cause us to avoid calling unpack-objects, keeping the pack we got, but
_not_ creating a .keep file. Likewise, if you pass one "-k" to
fetch-pack, it should just keep the pack but without a .keep file
(that's what the double "-k -k" does).

But both of these do trigger a .keep file, which seems wrong to me. The
caller has no idea that the .keep file was created, so it won't clean it
up, and the pack will be in limbo forever.

I tried bisecting and came up with fa74052922 (Always obtain fetch-pack
arguments from struct fetch_pack_args, 2007-09-19). Given the length of
time it's been this way, that makes me a little afraid to touch it. ;)
But I think in practice it is not really triggered because of what I
wrote earlier:

> Nobody noticed the bug for so long because the transport code used by
> "git fetch" always passes in a pack_lockfiles pointer, and remote-curl
> (the main user of the fetch-pack plumbing command) always passes
> --lock-pack.

That is, we're always asking for a lock-file anyway.

But it could affect external users of the fetch-pack plumbing. I.e., the
very command that produced the segfault for you is probably leaving an
unexpected .keep file in place.

> So it's possible to ask index-pack to create the lock-file (using "-k
> -k") but not ask to record it (by avoiding "--lock-pack"). This worked
> fine until 5476e1efde (fetch-pack: print and use dangling .gitmodules,
> 2021-02-22), but now it causes a segfault.
> 
> Before that commit, if pack_lockfiles was NULL, we wouldn't bother
> reading the output from index-pack at all. But since that commit,
> index-pack may produce extra output if we asked it to fsck. So even if
> nobody cares about the lockfile path, we still need to read it to skip
> to the output we do care about.

There's another interesting fallout from 5476e1efde that I noticed here.
Before that commit, if you did not pass --lock-pack to fetch-pack, then
we would never bother reading stdout from index-pack, and it would go to
the caller's stdout! So doing:

  git fetch-pack -k -k repo HEAD

would produce:

  keep	3282886e55735beb9a08b048394284b03bef8488

or similar on stdout. Which makes me wonder if some callers depend on
that. Or if it is simply a bug, since it would be intermingled with
fetch-pack's actual output. We still produce that output today, but if
you use fetch.fsckObjects, then we eat it while looking for the other
fsck-related output.

-Peff

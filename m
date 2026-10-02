Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547646E01C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982820; cv=none; b=WQZQZyVINbyVwNXxuKB8vJif1HLpJzd892OB3U0bIor0GZV+21s9ThtqEM+3kRDqIj25/kZNe/Oe/74tEWi2FuPkdz3XCAk8lAT48t3uzhlugS2cBAqF1991tpMIBWDJhB2+Z4vrGphkMFL95PYHUXfeWA7rf89DB5wtzry00cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982820; c=relaxed/simple;
	bh=+6Pkt9Y/YE9P7sq8jACpDx269+Qdtww33lujmypzTq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA8oXg6Jgqkoe7TDrjvfWw4J9WjWzFcrNw42OINvygbNXMQVXRjbcKJFT+j+/9c1zeigyjKAFuaMZvhgrrFNAjJvomta4j23wam/T53dWZTu5CNH2ycXV6jvvjPSILIdPDtkYB3awsCiNkVxS7QphSVBcQj6tpa1z+P8vjUlHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J+PW1tkP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J+PW1tkP"
Received: (qmail 16790 invoked by uid 106); 2 Oct 2026 23:13:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+6Pkt9Y/YE9P7sq8jACpDx269+Qdtww33lujmypzTq4=; b=J+PW1tkPn75xa9aCIycySaKcdlJFhXTvnhzHA1ermr2fWiup9jaUa3PcecQxE+ponNHPK9Q3EjSNdzIlBX3+y+0exanGnMc18+8ljXY3kVFv+pDX+Eej2Bc/U2RH08hB9cyk/gC3B2svl+mHX32+wIOUdHwwdLmJxeRncNudDGugxzOeezXKU23jxmooxbbRm9op6s7Niqw/CaYfUJREp2VajZdGKNwxqEUFW03eCUSbb0DaxGOnzG+qIX8mDxJYcPVAZcVw86/rI5iA3GDJnMacS+MugM5fdY851A32xpSBNnuw0sTxpINUTroWWovtjwl5i9yS4dyde2XaYGSiWQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 23:13:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49178 invoked by uid 111); 2 Oct 2026 23:13:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 19:13:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 19:13:36 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 2/8] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <20261002231336.GB834759@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <940953e5c407046ac6789367f3341dc8ea73d07a.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <940953e5c407046ac6789367f3341dc8ea73d07a.1790827875.git.me@ttaylorr.com>

On Wed, Sep 30, 2026 at 11:11:39PM -0500, Taylor Blau wrote:

> @@ -4151,6 +4158,34 @@ static void read_stdin_packs(struct repository *repo,
>  			     show_object_pack_hint,
>  			     &mode);
>  
> +	/*
> +	 * Trees and tags need closure even when no commit reaches them.
> +	 * Defer adding these roots to revs.pending until the first walk
> +	 * finishes. Otherwise a subtree may be visited and marked SEEN
> +	 * before its commit's root tree, using "a" instead of "sub/a"
> +	 * for a blob's namehash and delta attributes.
> +	 *
> +	 * Tags may introduce more commits in the second walk, so this
> +	 * does not *always* guarantee that trees are always visited
> +	 * with their full paths.
> +	 */

I think one of the things that confused me reading the original patch
(but is still present here) is that this comment is in read_stdin_packs,
when we're actually doing the walks. So "defer adding these roots" feels
quite late. We already did that deferring long before in
add_object_entry_from_pack() and add_loose_object(), when we called
oidset_insert() instead of add_pending().

So it would have made more sense to me to comment it there. Of course
that is hard when there are two such places.

I dunno.

> +	oidset_iter_init(&ctx.extra_roots, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		struct object *obj = lookup_object(repo, oid);
> +
> +		if (!obj || !(obj->flags & SEEN))
> +			add_pending_oid(&revs, NULL, oid, 0);
> +	}
> +	if (revs.pending.nr) {
> +		if (prepare_revision_walk(&revs))
> +			die(_("revision walk setup failed"));
> +		traverse_commit_list(&revs,
> +				     show_commit_pack_hint,
> +				     show_object_pack_hint,
> +				     &mode);
> +	}
> +	oidset_clear(&ctx.extra_roots);
> +
>  	release_revisions(&revs);

BTW, is it safe to prepare_revision_walk() twice on the same rev_info? I
could believe it works, but I could also believe that there are hidden
corner cases, as I don't think it was ever really intended to work this
way.

Maybe OK for the vanilla set of options we are using here (as opposed to
taking arbitrary options from the user). The rev_info is created locally
in this function, though, so I guess if we wanted to be double-plus sure
we could release and reinit the struct.

-Peff

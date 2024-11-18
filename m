Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9752F30
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921466; cv=none; b=Aj2tgRo/m4z0GaeCaPBUvwjWBQTJery/h5D0jrqmoamyx+ir3pQ9Kt6uvdhXvTABnaC6L+zwoYPz740unYCeZR9Cz1PAJIO3kLT7y4+xYi2uNtMUc0fIVbWssEcnR89QmG33Xw9ywiklkjigJcyBGAxokROcmklUjNcgWa/caJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921466; c=relaxed/simple;
	bh=SEeYYHjq/ZwM2Z7cgei0CqOrx6TwYGgfMITtFPeFav4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKhZu1i+LfVUidw3t3XIhxYdGL1MoM3TOsL/l3baScxJCrxMKc0v8ocRIk+3TXjFv1IGRei9gNYsC0QpMkTj7PRpAnjbGoz6Db0QBHVeXBCwYRxV3AyLdzbLK7JwyN0GJn52cg8bxRpeYMKuWn85OdNv3w0YMPkBZlkU89dQkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QQl4E1x+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QQl4E1x+"
Received: (qmail 22117 invoked by uid 109); 18 Nov 2024 09:17:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SEeYYHjq/ZwM2Z7cgei0CqOrx6TwYGgfMITtFPeFav4=; b=QQl4E1x+8v8I9KS8mU7u5fSZtaObDhWyrEUqA18JcgOYBVkXKSXkNF3umyL6hTUCKASvEWG0q7UDUA8z3nm/QlN5ili2quoWH0HVK60qAez74N+D2Y+rmRVKzJDAcYg+tv/OZmkkOyizfh4y2PQ5xhV9PcJf1Ub3qL8/AEOZ/OQ7FnCO3q874fj3MmXOcsgzs2WrbkMcu1kKifkiLZtg/Dsu24TvmyN7gGwfRBxi4r15AIzb+MoF4H5ad6vfS7gPTLu36oKg19Dqibd3YHVFLfNatJI7YvXNFJoWYioLm912kgS+IR96Twh+fn2NyTdk/d+LfHWT84/qtanEdxIW/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:17:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17950 invoked by uid 111); 18 Nov 2024 09:17:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:17:47 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:17:42 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sam James <sam@gentoo.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/5] object-file: move empty_tree struct into
 find_cached_object()
Message-ID: <20241118091742.GB3984843@coredump.intra.peff.net>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
 <20241117090842.GC3409496@coredump.intra.peff.net>
 <ZzrvciXuOfw_V6ox@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzrvciXuOfw_V6ox@pks.im>

On Mon, Nov 18, 2024 at 08:40:34AM +0100, Patrick Steinhardt wrote:

> >  static struct cached_object *find_cached_object(const struct object_id *oid)
> >  {
> > +	static struct cached_object empty_tree = {
> > +		/* no oid needed; we'll look it up manually based on the_hash_algo */
> > +		.type = OBJ_TREE,
> > +		.buf = "",
> > +	};
> >  	int i;
> >  	struct cached_object *co = cached_objects;
> 
> I was wondering whether we want to also mark this as `const` so that no
> caller ever gets the idea of modifying the struct. Something like the
> below patch (which applies on "master", so it of course would have to
> adapt to your changes).

This seems like a fairly unlikely bug to me, just because it would be
weird for somebody to want to write to the response (whereas the other
future-proofing was against somebody reading a private-ish value).
Still, I agree that "const" is the right thing, and it's not hard to add
it in to my series.

> diff --git a/object-file.c b/object-file.c
> index b1a3463852..f15a3f6a5f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -321,7 +321,7 @@ static struct cached_object {
>  } *cached_objects;
>  static int cached_object_nr, cached_object_alloc;
>  
> -static struct cached_object empty_tree = {
> +static const struct cached_object empty_tree = {
>  	.oid = {
>  		.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
>  	},

This hunk is technically not needed since we can implicitly cast from
non-const to const when returning. I included it, though, along with
making the iteration pointer in find_cached_object() const since that
better represents the intent.

-Peff

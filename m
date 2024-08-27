Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1EF17ADFC
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790247; cv=none; b=jQcW/OQtW5N8nLNq3QR5l8RyqbF9sy1v3feoq3I3w3kGJaLG6djo2+rQuRLAZAYcnbBICKfqpc9/PnIsnWN9hK613Bedg2S9g7BFYWvAqrd1cbiSf0XSDVcZpUP/RT7uLH8byIZBS1vqZKnbDsAkl4JpH+ygghahnDv3TGMsBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790247; c=relaxed/simple;
	bh=QP2/6YS9F6qXPeyW9WiIehAtQDUHIeEoxPLpsf46swI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HckpDvOUqfRAlCF6olw+5+uFsy/ryGTxqY7nnaeqPoIHOv80VjCcPfq8dPl46tlLFibKY4z+DJ5LVsbIvg+SphiggocXyQGaIADhg5/UuJo0PxPW/0dCu0I1ls0GMLq8DLMf0Lxu7/In0dQM/is0JaX7BJT3RkFkKKcAZqpshvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=JXTD02OI; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="JXTD02OI"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944661F47A;
	Tue, 27 Aug 2024 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724790239;
	bh=QP2/6YS9F6qXPeyW9WiIehAtQDUHIeEoxPLpsf46swI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXTD02OIy7rPxrifj5sBSX0aJf3rS7EBjwRotEGUNjQrBaRle0n6QDFSKI8osvRqD
	 ETBNg2Y6YQWXPT3qVwy/c1F0k5H1PFhLpSvYg61XHGQ/ZoNF2v1gy3etW7iX+qz9dY
	 cmbd6TmTHR1/aWoHPpa8ouF/Kb+7Sr5z0hEZHKo0=
Date: Tue, 27 Aug 2024 20:23:59 +0000
From: Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 02/10] packfile: allow content-limit for cat-file
Message-ID: <20240827202359.M464972@dcvr>
References: <20240823224630.1180772-1-e@80x24.org>
 <20240823224630.1180772-3-e@80x24.org>
 <xmqqcylvky69.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcylvky69.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > From: Jeff King <peff@peff.net>
> >
> > Avoid unnecessary round trips to the object store to speed
> > up cat-file contents retrievals.  The majority of packed objects
> > don't benefit from the streaming interface at all and we end up
> > having to load them in core anyways to satisfy our streaming
> > API.
> 
> What I found missing from the description is something like ...
> 
>     The new trick used is to teach oid_object_info_extended() that a
>     non-NULL oi->contentp that means "grab the contents of the objects
>     here" can be told to refrain from grabbing an object that is too
>     large.

OK.

> > diff --git a/object-file.c b/object-file.c
> > index 065103be3e..1cc29c3c58 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1492,6 +1492,12 @@ static int loose_object_info(struct repository *r,
> >  
> >  		if (!oi->contentp)
> >  			break;
> > +		if (oi->content_limit && *oi->sizep > oi->content_limit) {
> 
> I cannot convince myself enough to say "content limit" is a great
> name.  It invites "limited by what?  text files are allowed but
> images are not?".

Hmm... naming is a most difficult problem :<

->slurp_max?  It could be ->content_slurp_max, but I think
that's too long...

Would welcome other suggestions...

> > diff --git a/object-store-ll.h b/object-store-ll.h
> > index c5f2bb2fc2..b71a15f590 100644
> > --- a/object-store-ll.h
> > +++ b/object-store-ll.h
> > @@ -289,6 +289,7 @@ struct object_info {
> >  	struct object_id *delta_base_oid;
> >  	struct strbuf *type_name;
> >  	void **contentp;
> > +	size_t content_limit;
> >  
> >  	/* Response */
> >  	enum {
> > diff --git a/packfile.c b/packfile.c
> > index 4028763947..c12a0515b3 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -1529,7 +1529,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  	 * We always get the representation type, but only convert it to
> >  	 * a "real" type later if the caller is interested.
> >  	 */
> > -	if (oi->contentp) {
> > +	if (oi->contentp && !oi->content_limit) {
> >  		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
> >  						      &type);
> >  		if (!*oi->contentp)
> > @@ -1555,6 +1555,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  				*oi->sizep = size;
> >  			}
> >  		}
> > +
> > +		if (oi->contentp) {
> > +			if (oi->sizep && *oi->sizep < oi->content_limit) {
> 
> It happens that with the current code structure, at this point,
> oi->content_limit is _always_ non-zero.  But it felt somewhat
> fragile to rely on it, and I would have appreciated if this was
> written with an explicit check for oi->content_limit, just like how
> it is done in loose_object_info() function.

Right.  I actually think something like:

		assert(oi->content_limit); /* see `if' above */
		if (oi->sizep && *oi->sizep < oi->content_limit) {

is good for documentation purposes since this is in the `else'
branch of the `if (oi->contentp && !oi->content_limit) {' condition.

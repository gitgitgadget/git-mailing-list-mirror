Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECF628
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980921; cv=none; b=DjoNwljgfjgO91euetLPfBdugLhLul9VvVyaG3ZaCDaXW2BPrpgwSy9Sy4t7wqGXXZ44EE7PzxJ4KBG+B5tT+uYObn8sNSu/pi/rdbOuOsqCAnxtb8yplcoqUI5zELp4J0QD2vFekiuZ+EH42WTFQaxN0EWU++5p3rdZdAAtMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980921; c=relaxed/simple;
	bh=fkCCzUde4f4XMJzxuPQNt5hg+xZ6EKLcXgcKQ9po6p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUh8Fs6iISFZEmzBSd+yNbqIm4a3a+Ish2oFVr42PbUuoAZDu0VSXhYirw/QUHHUchdv25hvpx/lR09xoXP/vUDB9RxjLAA5X+jcJqNk3TjmvkzkjfNY8FcX6aSmtJILTgH+K4ixG/i6pypIcg4gDZcoNQkqnQ8xoeynRXq5/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=RPaRzW7P; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="RPaRzW7P"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247681F572;
	Fri, 26 Jul 2024 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721980919;
	bh=fkCCzUde4f4XMJzxuPQNt5hg+xZ6EKLcXgcKQ9po6p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPaRzW7P3Ue5RBt6MiHH91FJZWxBfb1jRSYAPiNuYGdctV97tMm4QbmzlUS8FFn5v
	 Avyi62u0WnxSqNtv5R9DkBiQStEYXDKhQiruMz6gfTFp8DuMF5X2DOzqWQ/Ay73ugW
	 XegLz3WF5xFa9c7mIHb/F68I56L1RSUMVxTcg04M=
Date: Fri, 26 Jul 2024 08:01:58 +0000
From: Eric Wong <e@80x24.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 06/10] packfile: packed_object_info avoids
 packed_to_object_type
Message-ID: <20240726080159.M14165@dcvr>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-7-e@80x24.org>
 <ZqC89ArZWgaZWY7a@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqC89ArZWgaZWY7a@tanuki>

Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Jul 15, 2024 at 12:35:15AM +0000, Eric Wong wrote:
> > For calls the delta base cache, packed_to_object_type calls
> > can be omitted.  This prepares us to bypass content_limit for
> > non-blob types in the following commit.
> > 
> > Signed-off-by: Eric Wong <e@80x24.org>
> > ---
> >  packfile.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/packfile.c b/packfile.c
> > index b2660e14f9..c2ba6ab203 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -1522,7 +1522,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  {
> >  	struct pack_window *w_curs = NULL;
> >  	off_t curpos = obj_offset;
> > -	enum object_type type;
> > +	enum object_type type, final_type = OBJ_BAD;
> >  	struct delta_base_cache_entry *ent;
> 
> I think it might help this patch to move `type` to the scopes where it's
> used to demonstrate that all code paths set `final_type` as expected.

The condition at the end of packed_object_info() requires the original
`type' to keep its top-level scope:

        if (oi->delta_base_oid) {
                if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {

But yeah, the whole function is huge and remains a bit convoluted.
Inlining cache_or_unpack_entry in 4/10 helped some, I think.

> >  	/*
> > @@ -1534,7 +1534,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  	ent = get_delta_base_cache_entry(p, obj_offset);
> >  	if (ent) {
> >  		oi->whence = OI_DBCACHED;
> > -		type = ent->type;
> > +		final_type = type = ent->type;
> >  		if (oi->sizep)
> >  			*oi->sizep = ent->size;
> >  		if (oi->contentp) {
> > @@ -1552,6 +1552,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  	} else if (oi->contentp && !oi->content_limit) {
> >  		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
> >  						oi->sizep);
> > +		final_type = type;
> >  		if (!*oi->contentp)
> >  			type = OBJ_BAD;
> >  	} else {
> > @@ -1581,6 +1582,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  			if (oi->sizep && *oi->sizep <= oi->content_limit) {
> >  				*oi->contentp = unpack_entry(r, p, obj_offset,
> >  							&type, oi->sizep);
> > +				final_type = type;
> >  				if (!*oi->contentp)
> >  					type = OBJ_BAD;
> >  			} else {
> > @@ -1602,17 +1604,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  	}
> >  
> >  	if (oi->typep || oi->type_name) {
> > -		enum object_type ptot;
> > -		ptot = packed_to_object_type(r, p, obj_offset,
> > -					     type, &w_curs, curpos);
> > +		if (final_type < 0)
> > +			final_type = packed_to_object_type(r, p, obj_offset,
> > +						     type, &w_curs, curpos);
> 
> So this is the actual change we're interested in, right? Instead of
> unconditionally calling `packed_to_object_type()`, we skip that call in
> case we know that we have already figured out the correct object type.
> 
> Wouldn't it be easier to manage this with a single `type` variable,
> only, and then conditionally call `packed_to_object_type()` only in the
> cases where `type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA`? Not sure
> whether that would be all that useful though given that the function
> already knows to exit without doing anything in case the type is already
> properly resolved. So maybe the next patch will enlighten me.

As I mentioned above, I think the `type' var remains necessary.

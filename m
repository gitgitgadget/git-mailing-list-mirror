Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2A18D64D
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692195; cv=none; b=dPeApePiuKws/wdUg8Xu+ID2iSiyhtQ+S/+ZNJw42KawWOeFyxmUkJeaVSd90QtvtbGGNnNLINm7RCQmakZkB5cRJYbTm4Op+lS+kQ0TqXFIRZxjCmQ+LHawMecQoaJ6UrCcQYANIgGil+QF/c9CBmj0xPf9laBhFTBzg6gA1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692195; c=relaxed/simple;
	bh=nhrgqXO9CCF6q348JgNc+mcigoDhdoehtENI56yc4G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uAiYJypTAPsM/p++tZuejiyFeNxzsi/gVdDnYe+iUE9UknMEDvKv+ai6bPuEh/CbWEyhAZGvgGe4dwPFcE8J5tgj7gaz7cOEnBbf38Amb4ePKHCDNh1CQp30aipMrEvCV4NI3Cb7JE9IOnfag7MW7L2eLs8TQDZubsaukWikrto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kpxLTC7J; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kpxLTC7J"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D34027BAB;
	Mon, 26 Aug 2024 13:09:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nhrgqXO9CCF6q348JgNc+mcigoDhdoehtENI56
	yc4G8=; b=kpxLTC7Jwj+3mdT6VyU3n9SjgiJ1BoUWky2SHncQAMM8lJa14BuGiv
	pFrWokTKu+yPRY/xDFsj9X8FB5+xXE0/ppAwGMe/Xi+J5cvKgVxgTW/hOUWBvAAL
	ZX5ZL5bVSc5GYxHa5qUokI9XWLnhg2cpyJNwqwXK4DZKSA7tPYObo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4320A27BAA;
	Mon, 26 Aug 2024 13:09:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B77ED27BA6;
	Mon, 26 Aug 2024 13:09:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 04/10] packfile: inline cache_or_unpack_entry
In-Reply-To: <20240823224630.1180772-5-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:24 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-5-e@80x24.org>
Date: Mon, 26 Aug 2024 10:09:48 -0700
Message-ID: <xmqqjzg3ky77.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00AF17B6-63CE-11EF-9B3F-BF444491E1BC-77302942!pb-smtp20.pobox.com

Eric Wong <e@80x24.org> writes:

> We need to check delta_base_cache anyways to fill in the
> `whence' field in `struct object_info'.  Inlining (and getting
> rid of) cache_or_unpack_entry() makes it easier to only do the
> hashmap lookup once and avoid a redundant lookup later on.
>
> This code reorganization will also make an optimization to
> use the cache entry directly easier to implement in the next
> commit.

"cache entry" -> "cached entry"; we tend to use "cache entry"
exclusively to mean an entry in the in-core index structure,
and not the cached objects held in the object layer.

>  {
>  	struct pack_window *w_curs = NULL;
> -	unsigned long size;
>  	off_t curpos = obj_offset;
>  	enum object_type type;
> +	struct delta_base_cache_entry *ent;
>  
>  	/*
>  	 * We always get the representation type, but only convert it to
>  	 * a "real" type later if the caller is interested.
>  	 */
> -	if (oi->contentp && !oi->content_limit) {
> -		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
> -						      &type);
> +	oi->whence = OI_PACKED;
> +	ent = get_delta_base_cache_entry(p, obj_offset);
> +	if (ent) {
> +		oi->whence = OI_DBCACHED;

OK.  This is very straight-forward.  It is packed but if we grabbed
it from the delta-base-cache, that is the only case we know it is
dbcached.

> +		type = ent->type;
> +		if (oi->sizep)
> +			*oi->sizep = ent->size;
> +		if (oi->contentp) {
> +			if (!oi->content_limit ||
> +					ent->size <= oi->content_limit)
> +				*oi->contentp = xmemdupz(ent->data, ent->size);
> +			else
> +				*oi->contentp = NULL; /* caller must stream */

This assignment of NULL is more explicit than the original; is it
because the original assumed that *(oi->contentp) is initialized to
NULL if oi->contentp asks us to give the contents?

> +	} else if (oi->contentp && !oi->content_limit) {
> +		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
> +						oi->sizep);
>  		if (!*oi->contentp)
>  			type = OBJ_BAD;

Nice.  The code structure is still easy to follow, even though the
if/else cascade here are organized differently with more cases (used
to be "are we peeking the contents, or not?"---now it is "do this if
we can grab from the delta base cache, do one of these other things
if we have go to the packfile").


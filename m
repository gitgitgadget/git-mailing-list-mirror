Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCF198E61
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692229; cv=none; b=XMZHrT8d70BHy/MqThrDjq3o46Mq7ihQSLcUNOh164QdNpfbVsMimx71b2q+ENcZOBlJ71x9/A/l6kUOHgMr9eHf6jlZqEQvYDqrxU/LcpRXhpo/q3W7ZxRBNnJBtbsfc/1SbufxsMnLcoi0WhKz4Hc2j8wmFls/J1uljmN15pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692229; c=relaxed/simple;
	bh=eTvZ1x3yU0BeAcHdwprlxt0jUxKpALm3RcuHAeBTyfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l3NkseGZuKv3zTjaf6XiTt/2k4XESTFDjIKvP2Ilpv6Dk+MaTJ350ejtQJ2toY8M0InCo6M2l8E4tBIq9PHLk7G2yGCbvQ8JECCLtMQJCvO7zcfUr1MwJo2aiOhHJ7QVlSGvE2NYXmMhlL51nvIn8f541SqY/ycOyzO39Q5YS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S0QtBPOX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S0QtBPOX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 90FE127BBD;
	Mon, 26 Aug 2024 13:10:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eTvZ1x3yU0BeAcHdwprlxt0jUxKpALm3RcuHAe
	BTyfk=; b=S0QtBPOX9sBjvUfsyTqehXK81t3DS/bs8nIrnNyyJfRiC6h7MnFQq4
	ykMX/CfRVSwItXBTVkY/twJr6vW5h0hPb5525h1Ss9K2PZWOwP25EbpEWTlANKIL
	T5cdcoJoneV4iZXXUVzEp8aqAl0Xz2O5EEdU/TPSRZjLa3IEpIQ3Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 885D127BBC;
	Mon, 26 Aug 2024 13:10:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19A6D27BB6;
	Mon, 26 Aug 2024 13:10:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 02/10] packfile: allow content-limit for cat-file
In-Reply-To: <20240823224630.1180772-3-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:22 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-3-e@80x24.org>
Date: Mon, 26 Aug 2024 10:10:22 -0700
Message-ID: <xmqqcylvky69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1528C3AE-63CE-11EF-8821-BF444491E1BC-77302942!pb-smtp20.pobox.com

Eric Wong <e@80x24.org> writes:

> From: Jeff King <peff@peff.net>
>
> Avoid unnecessary round trips to the object store to speed
> up cat-file contents retrievals.  The majority of packed objects
> don't benefit from the streaming interface at all and we end up
> having to load them in core anyways to satisfy our streaming
> API.

What I found missing from the description is something like ...

    The new trick used is to teach oid_object_info_extended() that a
    non-NULL oi->contentp that means "grab the contents of the objects
    here" can be told to refrain from grabbing an object that is too
    large.

> diff --git a/object-file.c b/object-file.c
> index 065103be3e..1cc29c3c58 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1492,6 +1492,12 @@ static int loose_object_info(struct repository *r,
>  
>  		if (!oi->contentp)
>  			break;
> +		if (oi->content_limit && *oi->sizep > oi->content_limit) {

I cannot convince myself enough to say "content limit" is a great
name.  It invites "limited by what?  text files are allowed but
images are not?".

> diff --git a/object-store-ll.h b/object-store-ll.h
> index c5f2bb2fc2..b71a15f590 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -289,6 +289,7 @@ struct object_info {
>  	struct object_id *delta_base_oid;
>  	struct strbuf *type_name;
>  	void **contentp;
> +	size_t content_limit;
>  
>  	/* Response */
>  	enum {
> diff --git a/packfile.c b/packfile.c
> index 4028763947..c12a0515b3 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1529,7 +1529,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  	 * We always get the representation type, but only convert it to
>  	 * a "real" type later if the caller is interested.
>  	 */
> -	if (oi->contentp) {
> +	if (oi->contentp && !oi->content_limit) {
>  		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
>  						      &type);
>  		if (!*oi->contentp)
> @@ -1555,6 +1555,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  				*oi->sizep = size;
>  			}
>  		}
> +
> +		if (oi->contentp) {
> +			if (oi->sizep && *oi->sizep < oi->content_limit) {

It happens that with the current code structure, at this point,
oi->content_limit is _always_ non-zero.  But it felt somewhat
fragile to rely on it, and I would have appreciated if this was
written with an explicit check for oi->content_limit, just like how
it is done in loose_object_info() function.

Other than that, looking very good.

Thanks.


> +				*oi->contentp = cache_or_unpack_entry(r, p, obj_offset,
> +								      oi->sizep, &type);
> +				if (!*oi->contentp)
> +					type = OBJ_BAD;
> +			} else {
> +				*oi->contentp = NULL;
> +			}
> +		}
>  	}
>  
>  	if (oi->disk_sizep) {

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2E13E41D
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709060; cv=none; b=mtE4wqu48baSorIb+ERNwGkJpc/yM1IgnCB5W8B9kyvVtAUtxlyqnAK49v76jk0+rwzbDsqfh2sC8MGZQcNZkcU9/8hM19RU0xo906r4Myjyh1U+9ITQbGlD1pqskQ0EqBdssaWDH9MgNJEjen0K3HAW1sWvmgIwwhLxyUn0vjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709060; c=relaxed/simple;
	bh=WrAmMjqbF8iSO9UFUiWUrox7aMockSw5v1nmqJz6v1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VjzxnkN91vyF053HWqZMWt4+gm+OkMgdlEX1x6HLhjqILXlBKsuMuSr7BhDe4gIbzyaAO5o/iQcemHkcvkpEZgoluJncBGF4KHNHRKMP8zUgchquTuFIcQD51K3L5zm8+1/L6Vc7KQjHKbVp+2Cz0uYhoCXgtcFUxTDOALfQcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=skpDZYZ4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="skpDZYZ4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AEB2B3B2A6;
	Mon, 26 Aug 2024 17:50:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WrAmMjqbF8iSO9UFUiWUrox7aMockSw5v1nmqJ
	z6v1c=; b=skpDZYZ4db5jttDfTzSkRmaMGTP8EIHo6cv/RucVsv+JOHYppr3SXH
	rADzidAlM/z216baKI6GMMj+Rn+Yb1vnF1pxiWoQdOsdI9auRq9mrGud2uFPDS1w
	V9Dh37zPEmv5t33F0k7wp9Ons91sSs77KdBfW86tkTUEgjQf+9TmU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5F613B2A5;
	Mon, 26 Aug 2024 17:50:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1127F3B2A4;
	Mon, 26 Aug 2024 17:50:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 06/10] packfile: packed_object_info avoids
 packed_to_object_type
In-Reply-To: <20240823224630.1180772-7-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:26 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-7-e@80x24.org>
Date: Mon, 26 Aug 2024 14:50:55 -0700
Message-ID: <xmqq7cc3gdhc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4663B4E8-63F5-11EF-BF16-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Wong <e@80x24.org> writes:

> Subject: Re: [PATCH v2 06/10] packfile: packed_object_info avoids packed_to_object_type

I was confused if "avoids" is talking about the status quo, avoiding
is the bad thing, and this patch is about fixing that so that it
would not avoid.  That is not what this does.

    Subject: packfile: skip packed_to_object_type call in packed_object_info

or something, perhaps?

> For entries in the delta base cache, packed_to_object_type calls
> can be omitted.

"... because an entry in delta base cache knows what the final type
of the object is"?

I had "what the code should do in the error cases" question in a few
places.  Please describe (and justify if needed) the choice of
behaviour in the proposed log message.

> @@ -1538,7 +1538,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  	ent = get_delta_base_cache_entry(p, obj_offset);
>  	if (ent) {
>  		oi->whence = OI_DBCACHED;
> -		type = ent->type;
> +		final_type = type = ent->type;
>  		if (oi->sizep)
>  			*oi->sizep = ent->size;
>  		if (oi->contentp) {

OK.

> @@ -1556,6 +1556,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  	} else if (oi->contentp && !oi->content_limit) {
>  		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
>  						oi->sizep);
> +		final_type = type;
>  		if (!*oi->contentp)
>  			type = OBJ_BAD;

Do we want to still yield the "type" not "OBJ_BAD" in final_type in
this case?

> @@ -1585,6 +1586,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  			if (oi->sizep && *oi->sizep <= oi->content_limit) {
>  				*oi->contentp = unpack_entry(r, p, obj_offset,
>  							&type, oi->sizep);
> +				final_type = type;
>  				if (!*oi->contentp)
>  					type = OBJ_BAD;

Ditto.

> @@ -1606,17 +1608,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  	}
>  
>  	if (oi->typep || oi->type_name) {
> -		enum object_type ptot;
> -		ptot = packed_to_object_type(r, p, obj_offset,
> -					     type, &w_curs, curpos);
> +		if (final_type < 0)
> +			final_type = packed_to_object_type(r, p, obj_offset,
> +						     type, &w_curs, curpos);
>  		if (oi->typep)
> -			*oi->typep = ptot;
> +			*oi->typep = final_type;
>  		if (oi->type_name) {
> -			const char *tn = type_name(ptot);
> +			const char *tn = type_name(final_type);
>  			if (tn)
>  				strbuf_addstr(oi->type_name, tn);
>  		}
> -		if (ptot < 0) {
> +		if (final_type < 0) {
>  			type = OBJ_BAD;
>  			goto out;
>  		}

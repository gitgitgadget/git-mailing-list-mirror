Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F05142631
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263665; cv=none; b=H6pmPLpyVsdS/tb1CvY7hHO0JjkARzCDN0GY3wIX+Awz+GVWh98FHVyc3p0zemxIPUW9llSbNTXo8je6aZBG6/6UrV6lt1mu2P8AFzg6XhK8MaZTh+Q9eUuWp4uAxH+FCO/6KvODx3dHEZ8ufNXMRdvMi7J1oJqXSoxPLf0AFBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263665; c=relaxed/simple;
	bh=9daN2ZfIWEIT5e3v4/r3G57/fQuhwbAi1Qihn7e3cUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qiyfwfRkRbGd7CUXn0+HLJZlkEySUnJPKe7/YVT4LD5CUwwZkNsVzTsmPSbCpi12o+OAjiTHSldOa2wTOUTST5+6TGSeD0viErNx/T1awgS/VTh6Q2QsuGiLSG4ZJ8Yh+v67K6XVdxg0NhRLf2/moq6cFRR6f9vfihEzKteAYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dg2aoNDR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dg2aoNDR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2217236816;
	Wed, 21 Aug 2024 14:07:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9daN2ZfIWEIT5e3v4/r3G57/fQuhwbAi1Qihn7
	e3cUA=; b=Dg2aoNDR9OCznnxeVcfuzDQG+r5tgCVkv+jnhAmmlxSnW7kB2owzHo
	mrHQI+Z840kQvGJoFof8v7xrnEDcGpyRAFqtyGD+xhkV5QdkOk4n3MOAqiYTWJHV
	PQz0DBpQf7TN4ttK7fOOoIs9QDUKgOjjnnBEg2lOiGQaUlNwvv+Qo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A40C36815;
	Wed, 21 Aug 2024 14:07:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9799836814;
	Wed, 21 Aug 2024 14:07:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/20] transport: fix leaking arguments when fetching
 from bundle
In-Reply-To: <b72f7d1ee394291a018061c91222ea17a99c2e53.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:59 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<b72f7d1ee394291a018061c91222ea17a99c2e53.1724159575.git.ps@pks.im>
Date: Wed, 21 Aug 2024 11:07:39 -0700
Message-ID: <xmqqseuxyck4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 416B2FD6-5FE8-11EF-98D6-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In `fetch_refs_from_bundle()` we assemble a vector of arguments to pass
> to `unbundle()`, but never free it. Fix this leak.
>
> This memory leak gets hit in t5510, but fixing it isn't sufficient to
> make the whole test suite pass.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport.c b/transport.c
> index f0672fdc505..da639d3bff0 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -189,6 +189,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  		       &extra_index_pack_args,
>  		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
>  	transport->hash_algo = data->header.hash_algo;
> +
> +	strvec_clear(&extra_index_pack_args);
>  	return ret;
>  }

Hmph.  unbundle() has this:

	if (extra_index_pack_args) {
		strvec_pushv(&ip.args, extra_index_pack_args->v);
		strvec_clear(extra_index_pack_args);
	}

so while I think this patch would not hurt at all, do we need this
patch?

The other caller of unbundle() that passes the extra_index_pack_args
is cmd_bundle_unbundle() and it does not do anything after it is
done.

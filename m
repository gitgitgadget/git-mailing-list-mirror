Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E9F9C7
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ah/X9MME"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D70C1CDF78;
	Thu, 28 Dec 2023 12:25:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FoEN8jLFXoxp+HdHUqXrjO8DttyJHshzxaDrmM
	/bU64=; b=ah/X9MMERm0Cb8sKjgu/Lt1gNrneAiKLGrLFJq7uAbJfWBxcDF+MfI
	S41RyymDappMt8DUR4wn5NeHdSriBS8SJDSuGXhD+G4vFqOXA0jD2QAU6rQh/fri
	V0v18RedmdZGZMmA0fcdbVRiB37v0THmplxYFPjXNgTn+3RQkzv34=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84B321CDF77;
	Thu, 28 Dec 2023 12:25:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB97F1CDF75;
	Thu, 28 Dec 2023 12:25:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/12] refs: refactor logic to look up storage backends
In-Reply-To: <12329b99b753f79fe93fe017e71b08227d213c1e.1703753910.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 28 Dec 2023 10:57:35 +0100")
References: <cover.1703067989.git.ps@pks.im> <cover.1703753910.git.ps@pks.im>
	<12329b99b753f79fe93fe017e71b08227d213c1e.1703753910.git.ps@pks.im>
Date: Thu, 28 Dec 2023 09:25:55 -0800
Message-ID: <xmqqjzoygrx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 293890A4-A5A6-11EE-8437-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In order to look up ref storage backends, we're currently using a linked
> list of backends, where each backend is expected to set up its `next`
> pointer to the next ref storage backend. This is kind of a weird setup
> as backends need to be aware of other backends without much of a reason.
>
> Refactor the code so that the array of backends is centrally defined in
> "refs.c", where each backend is now identified by an integer constant.
> Expose functions to translate from those integer constants to the name
> and vice versa, which will be required by subsequent patches.

A small question.  Does this have to be "int", or is "unsigned" (or
even an enum, rewrittenfrom the "REF_STORAGE_FORMAT_*" family of CPP
macro constants) good enough?  I am only wondering what happens when
you clal find_ref_storage_backend() with a negative index.

For that matter, how REF_STORAGE_FORMAT_UNKNOWN (whose value is 0)
is handled by the function also gets curious.  The caller may have
to find that the backend hasn't been specified by receiving an
element in the refs_backends[] array that corresponds to it, but the
error behaviour of this function is also to return NULL, so it has
to be prepared to handle both cases?

> +static const struct ref_storage_be *refs_backends[] = {
> +	[REF_STORAGE_FORMAT_FILES] = &refs_be_files,
> +};
> ...
> +static const struct ref_storage_be *find_ref_storage_backend(int ref_storage_format)
>  {
> +	if (ref_storage_format < ARRAY_SIZE(refs_backends))
> +		return refs_backends[ref_storage_format];
>  	return NULL;
>  }

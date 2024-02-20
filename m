Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3C33F1
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708388064; cv=none; b=cnwhFgaC1vpQWF/nmnQm2tVf5QXZBOf25Zx3y9yiEdjbGJJrfK4Nbjlvf8Y+OIwTM1SgpecynjHOECeM5ybdWAftEEpW7Mh8/H0MP99R7jD90b2amyQTmb6Im5qu8KoJUsMvZsHYxKR5VDEWrkk/0wj/DxdiMyuABDf4Dl8mSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708388064; c=relaxed/simple;
	bh=6hpmyGzFiLYKhPkc4Oc1eidWDZw5CRaenqKmIAELc1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lvps4P1Xt0mGgDYGETyf3K8Nzu4SSYd6jz411iCAwursih1cr6+582mWaMPBYnfZMYy9Lo/g4dvFlSOXQJmgvB7BFvmKJ0ty7N7lvUMonoZn9R6ZZ3xjcXfRuG6d/gZrNpMNjtyOE6COvpVoR2cFuP/7zp6qF+kpJaLt0KtFM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aqyWUjTs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aqyWUjTs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A55B026AD5;
	Mon, 19 Feb 2024 19:14:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6hpmyGzFiLYKhPkc4Oc1eidWDZw5CRaenqKmIA
	ELc1o=; b=aqyWUjTsH0CDIb17D5VvO05XSoglGpwwa088PfvwxWp/LNBZ3uux1F
	2ORU5IoEkDz8IDh9ByTwLsa3/7L8ZEv13xzQ/jqRicwtdEns+zhapEWbX4XKDRyY
	UqZ1EfrBv+4Jjpoaaozz56HbFZK/hKvr6eapDylTtwofL7KrVtNig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9134826AD4;
	Mon, 19 Feb 2024 19:14:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2884826ACD;
	Mon, 19 Feb 2024 19:14:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] refs: drop unused params from the reflog iterator
 callback
In-Reply-To: <be512ef268b910852ff11df181d89c483ffc18ab.1708353264.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 19 Feb 2024 15:35:31 +0100")
References: <cover.1708353264.git.ps@pks.im>
	<be512ef268b910852ff11df181d89c483ffc18ab.1708353264.git.ps@pks.im>
Date: Mon, 19 Feb 2024 16:14:16 -0800
Message-ID: <xmqqplwsyotj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FD90E61E-CF84-11EE-9238-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The ref and reflog iterators share much of the same underlying code to
> iterate over the corresponding entries. This results in some weird code
> because the reflog iterator also exposes an object ID as well as a flag
> to the callback function. Neither of these fields do refer to the reflog
> though -- they refer to the corresponding ref with the same name. This
> is quite misleading. In practice at least the object ID cannot really be
> implemented in any other way as a reflog does not have a specific object
> ID in the first place. This is further stressed by the fact that none of
> the callbacks except for our test helper make use of these fields.

Interesting observation.  Of course this will make the callstack
longer by another level of indirection ...

> +struct do_for_each_reflog_help {
> +	each_reflog_fn *fn;
> +	void *cb_data;
> +};
> +
> +static int do_for_each_reflog_helper(struct repository *r UNUSED,
> +				     const char *refname,
> +				     const struct object_id *oid UNUSED,
> +				     int flags,
> +				     void *cb_data)
> +{
> +	struct do_for_each_reflog_help *hp = cb_data;
> +	return hp->fn(refname, hp->cb_data);
> +}

... but I think it would be worth it.

> +/*
> + * The signature for the callback function for the {refs_,}for_each_reflog()
> + * functions below. The memory pointed to by the refname argument is only
> + * guaranteed to be valid for the duration of a single callback invocation.
> + */
> +typedef int each_reflog_fn(const char *refname, void *cb_data);
> +
>  /*
>   * Calls the specified function for each reflog file until it returns nonzero,
>   * and returns the value. Reflog file order is unspecified.
>   */
> -int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data);
> -int for_each_reflog(each_ref_fn fn, void *cb_data);
> +int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_data);
> +int for_each_reflog(each_reflog_fn fn, void *cb_data);

Nice simplification.

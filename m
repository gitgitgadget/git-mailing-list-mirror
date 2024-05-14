Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1FB191
	for <git@vger.kernel.org>; Tue, 14 May 2024 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645786; cv=none; b=Ali96GnkNDJVzyDVUOr6FrZG8Xn3EuNglltaFS+SgpoE1i8ss61p9BfJ2b4hxkA4iaiRI7+aZxLLrEK+XVALpuoqFvlF9DQKPQaZr2tc6vHyhZmxFlxuaazrBpSZbC01DbVn3NRDzRD8dShh/7ECU0yGAcWbOz6BbGLmHuLEW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645786; c=relaxed/simple;
	bh=myzne/wAdUji925qNouLzrw7ltT+Pf/yn9MBSYZ7qgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kz3CSebJuBcumeXaOxbKGSkWZc9R4acau5cL4wVXvWLjKR9g9rUwSFpebEwbNgLUfWDIR4wR9/uJXUqXZ7zUPwgP9vpbvyftgOAMmaZTQIC2K3S0VUETtav5jysvU7h2U08sNMWZpuWKO1+uNWJohn3iGaUMQTcmvv691cBn2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lhOk+RBk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lhOk+RBk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 67650297EE;
	Mon, 13 May 2024 20:16:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=myzne/wAdUji925qNouLzrw7ltT+Pf/yn9MBSY
	Z7qgE=; b=lhOk+RBk9Max7ZAW0jc6VQDFnReTgP6Y1Si/A5TDLhrXHpy2PhzLWS
	8aLyUTot5v8S9yBjhL6PpTPnZ/iiPR7bngtms6fsGqix0djoeUNEr0woNh2VqMFb
	8g0XSN/Hyjwi2a8m6e9iHdDExrFygXChzYlme0SreMW3cSbeaPWpE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EA01297ED;
	Mon, 13 May 2024 20:16:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEE38297EC;
	Mon, 13 May 2024 20:16:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/hash-object: fix uninitialized hash function
In-Reply-To: <1e010f798ce50e51100bd46564a69ddbd31d29ea.1715582857.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 May 2024 09:15:13 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<1e010f798ce50e51100bd46564a69ddbd31d29ea.1715582857.git.ps@pks.im>
Date: Mon, 13 May 2024 17:16:21 -0700
Message-ID: <xmqqttj1b63u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 31F1F40E-1187-11EF-804F-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 82ca6d2bfd..0855f4f8aa 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -123,6 +123,13 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  	else
>  		prefix = setup_git_directory_gently(&nongit);
>  
> +	/*
> +	 * TODO: Allow the hash algorithm to be configured by the user via a
> +	 *       command line option when not using `-w`.
> +	 */
> +	if (nongit)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

This breaks t1007 when

        linux-sha256)
                export GIT_TEST_DEFAULT_HASH=sha256

is in effect.

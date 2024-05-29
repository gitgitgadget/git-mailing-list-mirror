Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738831C6B2
	for <git@vger.kernel.org>; Wed, 29 May 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001941; cv=none; b=BWkquYKgJXFsbJQVYUJSEQGxmHXEgYwbK4sz+/JVdleWGwK/lpCpQnjhXm4PEfvZ/rdbrNpnBwiO6A1i4QVK2uDEuQoUgOIX6uXF8/LNo0secGPrvdKVIi0dyZBKdBKhMhy80y4mRSi0mJ9EsTUCmO3ler5FWDEZh1SYR9FBHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001941; c=relaxed/simple;
	bh=P2rE/q32DhIOo+JVbZHiid8ysxqLgsYPRTbajv+//Ys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/PH+Hhh63XZcDsRgG4+qXr9UNLz0yQh/anLHfmO0wBwROb//zT7P6oJ8dmmoecFXiVyuT+BvE9iV5KKtr2FGwjaUYcxMOorTLenfUG4fhP6ksrPAlK8NbkpndPvaRdmL/KXBVZrK8VNP9zkpFtSVfVqoL4HHXk4XeMqltGU/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DWTrepJb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DWTrepJb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2186F3301B;
	Wed, 29 May 2024 12:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P2rE/q32DhIOo+JVbZHiid8ysxqLgsYPRTbajv
	+//Ys=; b=DWTrepJbcMfGU2ON0ysx9IEjLlVCK/c+Rv7TKKHSBKaG9wQn/zHxQl
	yzY7l+wfC2tC3piCfKK7liCA9gxWWUfJvbjuIOOI4MdgZn02g4yTqwddHMUVuL2t
	w3Wg6LHfhg1gKb3k0UNhft3WEGuyPJ2sJAnUNWYvIR/DkK6AfxRd8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 198813301A;
	Wed, 29 May 2024 12:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 800CE33019;
	Wed, 29 May 2024 12:58:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/19] global: improve const correctness when assigning
 string constants
In-Reply-To: <25c31e550fcecdda7510b259b271cd45d036f5d7.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:07 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<25c31e550fcecdda7510b259b271cd45d036f5d7.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 09:58:56 -0700
Message-ID: <xmqqzfs8y2pb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD2955E2-1DDC-11EF-891E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We're about to enable `-Wwrite-strings`, which changes the type of
> string constants to `const char[]`. Fix various sites where we assign
> such constants to non-const variables.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

This is a noisy change, and it is kind of surprising that ...

> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index a58432b9d9..dabce9b542 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -262,7 +262,8 @@ static int bisect_reset(const char *commit)
>  	return bisect_clean_state();
>  }
>  
> -static void log_commit(FILE *fp, char *fmt, const char *state,
> +static void log_commit(FILE *fp,
> +		       const char *fmt, const char *state,
>  		       struct commit *commit)
>  {
>  	struct pretty_print_context pp = {0};

... a change like this does not require any other change to the
code inside the function (e.g., by making further cascading changes
to what the function calls).

But applying this step alone and building would not give us any
constness warning/error from the compiler, so the result looks good
to the compiler, I guess?

Thanks.


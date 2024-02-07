Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029C535A5
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343385; cv=none; b=lLqf8LR20wB4gsTq70Jw3OEo+P68Jt2AM8/lL73lca2LhZjVM/AQ4TaOS38rWOz16vOWHCdDiBZdWKd3iRguU7D/LggFxPQtHH8Ha59YZUphrszUeAvcuF7psPMqidpPkqxBnj2Z2sJkZ8cYeb/6qKpIkGJt4MuhfJGWNn8LTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343385; c=relaxed/simple;
	bh=PNti276mfMCZbIBaNEves8EeOeXjqyBHM5SskWiqhEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gygWnM8AYJvIVZBTarC04CYJY0ttkqwp0at4aY6OI6frcBzFaqSbA0RDsaTHF0C7FYYEPFueHvUMEs2+G06p2AFg2DFR9gQK/Y3mfhJ6UUHnwibwqHl0YWfz/gPFclmvPMz2lgCh0XMVKjSJ42CTpLC79hGxjUzFsgX+BEJZ11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g+ZajW1T; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g+ZajW1T"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D7EF82BFD5;
	Wed,  7 Feb 2024 17:03:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PNti276mfMCZbIBaNEves8EeOeXjqyBHM5SskW
	iqhEs=; b=g+ZajW1T2+xK5IM7jOO9dTgM86NejqirQXgXvjqzEniZeEquD4ZS4y
	rudvECBOMB//LffQCiEAoZ9QPJWwDazet5jOOsbLWKTjUsi4/QCYeuIdULrMmxoF
	9X6D3KQ+zl0iHazcaTko/jxlBh5R5uaqkiOh+HqUyNlKXl8CYcfZA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CF3642BFD4;
	Wed,  7 Feb 2024 17:03:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E2BF2BFD2;
	Wed,  7 Feb 2024 17:02:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 5/7] refs: add pseudorefs array and iteration functions
In-Reply-To: <ZcEvLwp0t8-rcyGn@five231003> (Kousik Sanagavarapu's message of
	"Tue, 6 Feb 2024 00:25:43 +0530")
References: <ZcEvLwp0t8-rcyGn@five231003>
Date: Wed, 07 Feb 2024 14:02:56 -0800
Message-ID: <xmqqcyt853vz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7600AF6-C604-11EE-BE0D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Andy Koppe <andy.koppe@gmail.com> wrote:
> ...
>> +static const char *const pseudorefs[] = {
>> +	"FETCH_HEAD",
>> +	"ORIG_HEAD",
>> +	"MERGE_HEAD",
>> +	"REBASE_HEAD",
>> +	"CHERRY_PICK_HEAD",
>> +	"REVERT_HEAD",
>> +	"BISECT_HEAD",
>> +	"AUTO_MERGE",
>> +};
>> +
>>  struct ref_namespace_info ref_namespace[] = {
>>  	[NAMESPACE_HEAD] = {
>>  		.ref = "HEAD",
>> @@ -1549,6 +1564,33 @@ int head_ref(each_ref_fn fn, void *cb_data)
>>  	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
>>  }
>
> The first thing that popped up in my head was "Should we somehow use
> is_pseudoref_syntax() instead of manually listing these?" (although I
> read in this thread later that Junio was okay with the listing) but then ...
>
> I thought I saw something similar in some other thread (which entered
> the mailing list much after this patch series was submitted) ...
>
> 	https://lore.kernel.org/git/20231221170715.110565-2-karthik.188@gmail.com/T/

We are halting Karthik's topic to rethink its UI for now, but your
point stands.  We should use a unified definition of what pseudorefs
there are across the codebase for consistency, and Karthik's topic
would be a better place to do so.

Andy, let me drop this topic for now from my tree, and let's wait
until Karthik's "iterate over all refs" topic solidifies, at which
time an updated iteration (v4?)  of this topic hopefully can build
on top of it.

Thanks.

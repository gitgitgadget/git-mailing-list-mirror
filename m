Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69CECF
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626895; cv=none; b=VAG2j1bAeleG3nk7P4ujz2jNjZxO6hYZYkrv9UpCVricjHPncNhkVvrgdriKxsJBsOgvHZltzude+rratm5kmpwdbH7oMKCvwahEGS4zguQHnOepgnizFadoagSG17mgr4WubeXGf5Qg6YsOkr+eMEf7kNwsykCfnbQJGCnTz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626895; c=relaxed/simple;
	bh=xLmkLQecWjY/CT9FnlVQEB+mX4BVOwJwqhgQKgq7mHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DnmtVFuAFdLbtVpJFYlsoJOPesB+5GGma58iL33BDb3CP2qjRVUY/HoyeRh/rl+UQMIamPINmtOAFt3fRG+EOj+JfZKaJaavlpWvd1gc7yFqjUb4fc5jwh9R0eK4XqKMsSPhm2i6MadZHfXgWGirYuOxzllzKsZcZHzk8Q3p3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qk1QILXf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qk1QILXf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E1822C35B;
	Thu, 18 Jan 2024 20:14:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xLmkLQecWjY/CT9FnlVQEB+mX4BVOwJwqhgQKg
	q7mHc=; b=Qk1QILXfdidXKJMPoGgm1+j42dby5uGWuMfrv9b4ve8G6z11WjeUk3
	9WVuxHcTVOweDX8qE+S6xYDnFBkVPmITZjwMX2U6qp92FuO6ucqJhoZNU7K7bP1f
	ule6Znd3ZijziFBTEvsxbrclT6Uml8c/Abtn7eWMvvyeW7zvaWNOY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 868C82C35A;
	Thu, 18 Jan 2024 20:14:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DFEA72C359;
	Thu, 18 Jan 2024 20:14:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 09/10] trailer: move arg handling to interpret-trailers.c
In-Reply-To: <8a99d0fca21eca41d62dcd682c8b4ae545633bf7.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:25
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<8a99d0fca21eca41d62dcd682c8b4ae545633bf7.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 17:14:48 -0800
Message-ID: <xmqqo7dim8dz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 24715D44-B668-11EE-990B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/trailer.c b/trailer.c
> index e2d541372a3..0a86e0d5afa 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -66,6 +66,11 @@ static LIST_HEAD(conf_head);
>  
>  static char *separators = ":";
>  
> +const char *default_separators(void)
> +{
> +	return separators;
> +}

This allows API users to peek into the current set of separator
bytes (either the default ":" or specified by the configuration
varaible "trailer.separators"), which is an improvement over
directly exposing the "separators" variable, but in a longer term,
do we need to have some "trailer context" object that holds this
and possibly other global variables like this?

I do not demand such further abstraction in this series, but I'd
prefer to see if we all have shared vision into the future.

Thanks.

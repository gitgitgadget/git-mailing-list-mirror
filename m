Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E91E894
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060417; cv=none; b=IdSNL40PynFGwHXwq4U/KTtvu5xMKDu0Z/lHsBSA00axrnswyNAHtRohkhz2X+tlua1CEi5q52SC1pg6QHpzqlandHG/tvm+RwfWcMPJtvWvr+ev+0vcUaRmnQ5kbcshZ3+XKDTmJSdXa4S751FHBH0ygTdMxH/DgbQftJfb+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060417; c=relaxed/simple;
	bh=QljrnGy0XYOudnU9AfHOcx4lYhN7IW+D6zqknSqdNRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G029c5uCxSj8G4D8DYj4g7ZKqnIuxwY9zvp2nPb6p5sL2jGz0abPTt5yJBxx6KzgsmdkMw/Ka7xbGY5VXPdx2d+GuyBwHiO88LE3tJbZaRZth8UTI3jjOtI3EWppQG7WSA5h2ADZL7X+dYqlKFsJkLXPIQ/3Erw+PhGkBb00S/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WGufO1LM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WGufO1LM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 498C11D1D22;
	Tue, 27 Feb 2024 14:00:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QljrnGy0XYOudnU9AfHOcx4lYhN7IW+D6zqknS
	qdNRg=; b=WGufO1LMUL9sc9MbCr8wVeX6gyJPH3gtrM238C1lnJy4zyWRhdQ4rT
	gcLp2WPzhRsoOj12ppH9nu7qPHcnkD2iII2dA/XprayIdhWH5y0hkFr4sl1bWso1
	dobk6/7zXkqcdCuQk4An03v6IQQ/2bvVs0K6tg5Mwk63uRbtxzed8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F6991D1D21;
	Tue, 27 Feb 2024 14:00:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A473A1D1D20;
	Tue, 27 Feb 2024 14:00:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 2/3] builtin/receive-pack.c: change xwrite to
 write_in_full.
In-Reply-To: <20240227150934.7950-3-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Tue, 27 Feb 2024 10:09:33 -0500")
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
	<20240227150934.7950-3-randall.becker@nexbridge.ca>
Date: Tue, 27 Feb 2024 11:00:13 -0800
Message-ID: <xmqqwmqprav6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 70ADEB92-D5A2-11EE-B881-25B3960A682E-77302942!pb-smtp2.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This change is required because some platforms do not support file writes of    arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/receive-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index db65607485..4277c63d08 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -456,7 +456,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
>  	if (use_sideband)
>  		send_sideband(1, 2, msg, sz, use_sideband);
>  	else
> -		xwrite(2, msg, sz);
> +		write_in_full(2, msg, sz);
>  }

This change does make sense, as we can see a short write(2) from
xwrite() and this caller is not repeating the call to flush the
remainder after a short write.

>  
>  __attribute__((format (printf, 1, 2)))

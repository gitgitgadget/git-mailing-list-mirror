Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2C1396
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446337; cv=none; b=T0pGIz9zifL/zsVZ0QtcECcZ458/sDEgxq5kyJph7FmV4GnGhFKNpQaFAPfW5pD8ykp5MQlQQihoxFSZCU+SfG/6rvjO4JkX8n2DFgg7vwBVilqI/bT8hcZLkPyWofJZ/l3P/sGWxqq72+TXUZCoh4mv14B8ag64RrF6OuCZzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446337; c=relaxed/simple;
	bh=gE/gWSAI4LhrwJBZbqRyJG4oZfAIf+AEXVwp8M5/g58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QSL4NHLH6y7lEeC242VpHI0CZRP7nVhFAwriHk83Yo8E7FJ8E/R8Twka5ahymqhJ48iSmoTKKVdjW5rEgPSCyIRmcRt3xHnitbFaQ2Qd3t5ZediRZ6OUk1geA7l5DQJZypteG7A6CPFEQL/z7DRbHwnyTk1NO8WIq1YhyHnaD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mMtQ4x9l; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMtQ4x9l"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B968D3A29D;
	Wed, 31 Jul 2024 13:18:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gE/gWSAI4LhrwJBZbqRyJG4oZfAIf+AEXVwp8M
	5/g58=; b=mMtQ4x9lVBrcP7+sKadiV6JqwGONxBsVmQxmNrX3sem1FSrWPOCArt
	eRvCcqgzSHiqtncy7zVUv2x2DuLqdxPTpblUrted1a41hX/lxTWJacn/0Af9isS5
	CGV5kjUN5oauiqJYmLBXHe1gSZNrxnw3cyDDs9XsnFGGDnKmXmDI4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B15CF3A29C;
	Wed, 31 Jul 2024 13:18:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 278C83A29B;
	Wed, 31 Jul 2024 13:18:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] version: refactor strbuf_sanitize()
In-Reply-To: <20240731134014.2299361-2-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 31 Jul 2024 15:40:11 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-2-christian.couder@gmail.com>
Date: Wed, 31 Jul 2024 10:18:50 -0700
Message-ID: <xmqqzfpx5vk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F53F2DAC-4F60-11EF-9A7E-BAC1940A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/strbuf.c b/strbuf.c
> index 3d2189a7f6..cccfdec0e3 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1082,3 +1082,12 @@ void strbuf_strip_file_from_path(struct strbuf *sb)
>  	char *path_sep = find_last_dir_sep(sb->buf);
>  	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
>  }
> +
> +void strbuf_sanitize(struct strbuf *sb)
> +{
> +	strbuf_trim(sb);
> +	for (size_t i = 0; i < sb->len; i++) {
> +		if (sb->buf[i] <= 32 || sb->buf[i] >= 127)
> +			sb->buf[i] = '.';
> +	}
> +}

This looked a bit _too_ specific for the use of the transport layer
(which raises the question if it should even live in strbuf.[ch]).
It also made me wonder if different callers likely want to have
different variants (e.g., do not trim, only trim at the tail, squash
a run of unprintables into a single '.', use '?'  instead of '.',
etc., etc.).

It turns out that there is only *one* existing caller that gets
replaced with this "common" version, which made it a Meh to me.

Let's hope that there will be many new callers to make this step
worthwhile.

>  __attribute__((format (printf,1,2)))
>  int printf_ln(const char *fmt, ...);
>  __attribute__((format (printf,2,3)))
> diff --git a/version.c b/version.c
> index 41b718c29e..951e6dca74 100644
> --- a/version.c
> +++ b/version.c
> @@ -24,15 +24,10 @@ const char *git_user_agent_sanitized(void)
>  
>  	if (!agent) {
>  		struct strbuf buf = STRBUF_INIT;
> -		int i;
>  
>  		strbuf_addstr(&buf, git_user_agent());
> -		strbuf_trim(&buf);
> -		for (i = 0; i < buf.len; i++) {
> -			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
> -				buf.buf[i] = '.';
> -		}
> -		agent = buf.buf;
> +		strbuf_sanitize(&buf);
> +		agent = strbuf_detach(&buf, NULL);
>  	}
>  
>  	return agent;

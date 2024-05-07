Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B788F72
	for <git@vger.kernel.org>; Tue,  7 May 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102535; cv=none; b=T6CDXD7AdunCT4qCOZXHhfEe6plbxiL7z76OeuSSBF+0UwU3JcLvKkM9EVGXYwQ9UhJfw4J5ltx7EBp0mRUMirDlpm2dUpZLGrRVQPBG4/bkhd0EkyooW7i+pKeOoTUSegkSdMI4wbFQlK9wb/vjxEOK5ZBFrc5Y9mi6GYKHHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102535; c=relaxed/simple;
	bh=t/l6A62SF4KujgzVAS8F9NB6pTEbdA/zw//ZAUPp0r0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o14wnR2Coe8WPSHG49zwKjcLAaCjDn8DGQlPvQt8qXPLgGi1NkMRYP2spuyWaHXYZ6toNE1gPHo5oKgMlRuXDxo40fRGasUjk20GzWqDND8Jh6n2BmihRtMunzARrmCe1TKKcInja4r/gF/fJ8fJjFoj1z8c5muec8Bu1HFaH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ASuOkaid; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ASuOkaid"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AE8935C16;
	Tue,  7 May 2024 13:22:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t/l6A62SF4KujgzVAS8F9NB6pTEbdA/zw//ZAU
	Pp0r0=; b=ASuOkaiduF/9DyjCoEKhsM52jXuz33Y+srtfkGUolySf1fiaq9a3xY
	tWAokf0JVzcpQPRmtaefcmilmbY1Cv68nKFpnVOAYRb3ZHY9F1ml1QN8M+JpCcjK
	suOMgeP7seVXi0jgCpoSSiZUPFaRkl7ByCC4UeMzUcokZFiZfTQ9U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 727DF35C15;
	Tue,  7 May 2024 13:22:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07A6835C14;
	Tue,  7 May 2024 13:22:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v1 2/2] strbuf_getcwd() needs precompse_strbuf_if_needed()
In-Reply-To: <20240507084431.19797-1-tboegi@web.de> (tboegi@web.de's message
	of "Tue, 7 May 2024 10:44:31 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240507084431.19797-1-tboegi@web.de>
Date: Tue, 07 May 2024 10:22:02 -0700
Message-ID: <xmqqa5l1pmf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 527ED476-0C96-11EF-8745-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

tboegi@web.de writes:

> +void precompse_strbuf_if_needed(struct strbuf *sb)
> +{
> +	char *buf_prec = (char *)precompose_string_if_needed(sb->buf);
> +	if (buf_prec != sb->buf) {

Cute.  This matches with the !PRECOMPSE_UNICODE case in git-compat-util.h
where we do

    static inline const char *precompose_string_if_needed(const char *in)
    {
            return in;
    }

to make it a no-op.  I was wondering how you are avoiding an
inevitable crash from trying to free an unfreeable piece of memory,
but this should do just fine.

You'd want to fix the typo in the name of the new function, I
presume?  "precompse" -> "precompose"

> +		size_t buf_prec_len = strlen(buf_prec);
> +		free(strbuf_detach(sb, NULL));
> +		strbuf_attach(sb, buf_prec, buf_prec_len, buf_prec_len + 1);
> +	}
> +
> +}

> diff --git a/strbuf.c b/strbuf.c
> index 0d929e4e19..cefea6b75f 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -591,6 +591,7 @@ int strbuf_getcwd(struct strbuf *sb)
>  	for (;; guessed_len *= 2) {
>  		strbuf_grow(sb, guessed_len);
>  		if (getcwd(sb->buf, sb->alloc)) {
> +			precompse_strbuf_if_needed(sb);
>  			strbuf_setlen(sb, strlen(sb->buf));

The need for strbuf_setlen() stems from the use of getcwd() that may
and will place a string that is much shorter than sb->alloc, so they
logically belong together.  It will make more sense to call the
precompose _after_ arranging the members of strbuf in a consistent
state with the call to strbuf_setlen().

>  			return 0;
>  		}
> --
> 2.41.0.394.ge43f4fd0bd

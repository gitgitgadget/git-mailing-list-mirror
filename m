Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6270801
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954287; cv=none; b=JE2Tsq7U69uY6p2RqAW9I/4Txvm8SZn6ppybaqQXuvCxlVGE9cVc/wB1PNDVpjdaVhAzkLQxk0l3iqEoa7hAIQhKnuV9w5wtOrYds7rBuvU1AcyDCpOaY/RTYJO4Pyvr71JjeCopFTVNffUnpdEvKnwWUjZB+5eKKVIBC7k2F9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954287; c=relaxed/simple;
	bh=owh7UmKmMjX0LNo6fDNRbOWFsHl9M6QY7SNMLpOp3ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fYMWKU+3NlT8bxZ/O8pY5gWipN1zXKzxo5KtMa6SjQCYo22UGNKriiC6r3L8hAIsF88L1mqGPE+9QzHGBz7k/jyFnKTRu+TjG9M2FBX76mW9gQ+YIx5c33YHxBhCGvFBghhrQwpF3mOkCKTo9iSvesHcoNGcbVhCEF7NGEbkzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YY8kr1BmCz1r6mn;
	Wed, 15 Jan 2025 16:17:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YY8kr0sXyz1qqlS;
	Wed, 15 Jan 2025 16:17:56 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id d1xS3L3Vv59J; Wed, 15 Jan 2025 16:17:55 +0100 (CET)
X-Auth-Info: Vt8CsjdcFibJ9ks6KjEj9+gDkGeRTkfkDXTHJuiMccTYS6162VSGCumdl6sPeS50
Received: from igel.home (aftr-82-135-83-199.dynamic.mnet-online.de [82.135.83.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 15 Jan 2025 16:17:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 3C37F2C1C60; Wed, 15 Jan 2025 16:17:55 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] sideband: mask control characters
In-Reply-To: <f7fb7a38333cf6527345e3dbefaeb2cd8ade6429.1736878772.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 14 Jan 2025
	18:19:30 +0000")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<f7fb7a38333cf6527345e3dbefaeb2cd8ade6429.1736878772.git.gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 16:17:55 +0100
Message-ID: <87sepk14yk.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jan 14 2025, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/sideband.c b/sideband.c
> index 02805573fab..c0b1cb044a3 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -65,6 +65,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
>  		list_config_item(list, prefix, keywords[i].keyword);
>  }
>  
> +static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
> +{
> +	strbuf_grow(dest, n);
> +	for (; n && *src; src++, n--) {
> +		if (!iscntrl(*src) || *src == '\t' || *src == '\n')

The argument of iscntrl needs to be converted to unsigned char.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

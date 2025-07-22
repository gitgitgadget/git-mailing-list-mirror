Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D521ABCB
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172761; cv=none; b=N0i4u3UEZqtXQuqBD/OAoRwGVlvIwUH47y+WI4t39yFbQygdYC61arpqrr66aLwatpipE0ZIehM5NAznPSF+AVIa/EBka6WKfEiNANrk2YjqKtjgzCras/zafDAPXMJk/ZajAovDlYq2S0nMcStA0KID7OfUS/mBp9BaA1q1Wz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172761; c=relaxed/simple;
	bh=Vq5ADPGaTYx/Du2hjnLUmzaBIhCYDXUPYJBKgcLJVMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ety+xPKPFybe/okHMX4hfHa3eFrGp4MIpfj9q86f90VZYZE+8lkgh1OPdBqKjcGJBTeLbKvj4AFf8dhgSo4i8DUSQzos+qsb+lIfEr6jv/KDwYmkb++SmIZFBvzMz1KYK4IV/gHi5REW6uyDthDsfzPrMANu4yAPJg1G+hvA6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gb/DwNRl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gb/DwNRl"
Received: (qmail 26896 invoked by uid 109); 22 Jul 2025 08:25:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vq5ADPGaTYx/Du2hjnLUmzaBIhCYDXUPYJBKgcLJVMk=; b=gb/DwNRlkJiYXZWW9FG/8WyJs7YMlm0/+2PfpY4ftvR8mbuhgLti+tOxV7VRR6MTXUVg5Lb31Tb30pteZCF3SDn9j6Ru6wdYrV7mO3oYDryXEcb98rpKUBvZSZ/2siZB7uLxF5oqxBrXJvvwSpfC+VfCSm0Gn8cEMFB1IO4ERFdjy2xiBO0QeiWxMPnW/N4Cc9Q0qx28XeR221WpikZV6EJgIrsiQ/UMGVVFaFJWsz3KiMwK8bRnlrixeOrm04l/KM2mdkp8pLDH/UK587h6egtl1VgHhKJYad6/iwCY+ugA0NHKAkj9wKcaP6ut8VMjaYuat/nbjl1Qyfjrkmk6Zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 08:25:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26575 invoked by uid 111); 22 Jul 2025 08:26:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 04:26:02 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 04:25:57 -0400
From: Jeff King <peff@peff.net>
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] t/helper/test-delta: close fd if fstat() fails
 after second open()
Message-ID: <20250722082557.GC862006@coredump.intra.peff.net>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
 <20250722081219.1086866-5-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722081219.1086866-5-lhywkd22@gmail.com>

On Tue, Jul 22, 2025 at 08:12:19AM +0000, Hoyoung Lee wrote:

> When opening argv[3], if open() succeeds but fstat() fails,
> the file descriptor is not closed, resulting in a resource leak.
> This patch ensures that the descriptor is closed on failure.
> 
> Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
> ---
>  builtin/archive.c     | 3 ++-
>  t/helper/test-delta.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/archive.c b/builtin/archive.c
> index c919a39f90..951fc2e444 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -13,9 +13,10 @@ static void create_output_file(const char *output_file)
>  {
>  	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
>  	if (output_fd != 1) {
> -		if (dup2(output_fd, 1) < 0)
> +		if (dup2(output_fd, 1) < 0) {
>  			close(output_fd);
>  			die_errno(_("could not redirect output"));
> +		}
>  		else
>  			close(output_fd);
>  	}

Ah, I guess you found the problem from patch 3. But it should have been
squashed in there, not to this patch. (But as I said there, I think we
should just drop patch 3 entirely).

-Peff

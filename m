Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F61876
	for <git@vger.kernel.org>; Mon, 26 May 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241091; cv=none; b=t28i/lDMH5K1YDbLaMizYllqrIoiiQnT3hDMlfWyB3S1YZtUNPZZN6onCbBBMdfcuMy7uYZ7NFY0uvwwkC5HMLJ0DzMVxGt/0WNOHBEZUjdrDUigng5U7LkP90TjB4gn9h5YfnayehCGP2Tsdb7Q6d3jAXMu+YCRNbLKv6SAnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241091; c=relaxed/simple;
	bh=Cfv9YhGlGvUCd3NI2/uXCdPNubrbTGB5wE/JYodTApY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=eBO9ype13oc9lz4q9NOAbQ4Vn2Bn3w/dmeS/6dM8XC4aMM2BjwntfpJgs09g7hLDye6coAbUD0JcNBiE66+/Y23xBBWQk2vc7/btg6mdVTZaMD9L6PE2cbH+HecgVTTyfaysQu5WWVgnbea+60F/WjAsQTsaSqTFvWWMqsgnM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4b5Q5y4mYGz7QR4p
	for <git@vger.kernel.org>; Mon, 26 May 2025 07:57:42 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4b5Q5p3Tw5zRnlJ;
	Mon, 26 May 2025 07:57:34 +0200 (CEST)
Message-ID: <385d7189-98fa-4863-8bcf-905c76eccbc8@kdbg.org>
Date: Mon, 26 May 2025 07:57:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] userdiff: add support for R programming language
To: Rodrigo Carvalho <rodrigorsdc@gmail.com>
References: <20250525210236.116342-1-rodrigorsdc@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250525210236.116342-1-rodrigorsdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 25.05.25 um 23:02 schrieb Rodrigo Carvalho:
> The patch appends userdiff.c file in order to support R programming
> language function header. This will be useful for those who use Git
> for versioning .R files.
> 
> Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> ---
>  userdiff.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/userdiff.c b/userdiff.c
> index da75625020..d1d31ea67e 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -317,6 +317,10 @@ PATTERNS("python",
>  	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
>  	 /* -- */
> +PATTERNS("r",

Rant mode: I am not a fan of the name "R". It is so un-searchable. It
hijacks a single character for its own purpose.

I don't see a negative impact in this case, though.

> +	"^[ \t]*([a-zA-z][a-zA-Z0-9_.]*[ \t]*<-[ \t]*function.*)$",

I wonder how useful this is in practice. Unlike C or Java for example,
code can live outside of functions in R scripts. If you have a script
without any functions, there would not be any hunk headers. If you have
a script with a mix of functions and code outside of functions, the code
after a function would be attributed to the function. I'm not saying
that this is bad, but just asking if this is part of the plan.

> +	/* -- */
> +	"[a-zA-Z_][a-zA-Z0-9_.]*"),

This singles out identifiers. Every single other characters would be its
own word. I'd consider this a disimprovement. If you are not prepared to
provide worddiff patterns, I recommend to use "[^ \t]+", which roughly
amounts to the default behavior. It can be improved incrementally in
later patches.

>  PATTERNS("ruby",
>  	 "^[ \t]*((class|module|def)[ \t].*)$",
>  	 /* -- */

Please squash the test cases into this patch. Don't forget to test an
indented function, and while at it, test a function definition *nested*
in a function definition: that documents what the expected outcome is.

-- Hannes


Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0998626D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411391; cv=none; b=ORziXr5O5Ifpao2Lz1Z3H6wBoa1mtLoDrCNBTsoptCiJlcfQ046cpO+82YXJJb4WFNB6w8seHewG8TuhwmeItcSNXhhd339mFnG9x/HstcPoa9BRXOJ2jwVhTxxF+ykNHGsmCiJ1DKoATQNA9vOh4AtqxFXwp45EwMRQoAtUziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411391; c=relaxed/simple;
	bh=IScglrnEvtHZMTZqxYTxLP1OCBcpz+yfgYlevuP5Zvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bbrkVmST8/XwoW6kGfRXTKw0cXJDaT19qRA7Do4xNIkuFpfCEr0WtZ7gyOZ73ngxJHucbS1SzlkdZFbydFhjILMyjCY3/eG40Od7cF1vhc/FHnk3WVX9PCH4dEZnhKnz+rNBFHojPmiiDhdJuPZ9jftK8CoNJg4VcVAv83akaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o1tu1itX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o1tu1itX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B35E378F8;
	Mon, 29 Apr 2024 13:23:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IScglrnEvtHZMTZqxYTxLP1OCBcpz+yfgYlevu
	P5Zvs=; b=o1tu1itXAFHWkl0wiO2StHalg1tU1sQgTAm79nVjznsZNsirElnTkB
	75qkoAoD46E1UJT5w3bHI9eyBmzrgbkMIREeohCLYT2TOceQnGbaaiBWgU+su2Tl
	hcEYFGN+Vgt/yLHB4kDz7ywasjJ6nv/f2PxTFW7mAZkgPIC0/sh4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 82ADB378F7;
	Mon, 29 Apr 2024 13:23:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CA32378F5;
	Mon, 29 Apr 2024 13:23:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH 3/3] color: add support for 12-bit RGB colors
In-Reply-To: <20240429164849.78509-4-dev+git@drbeat.li> (Beat Bolli's message
	of "Mon, 29 Apr 2024 18:48:49 +0200")
References: <20240429164849.78509-1-dev+git@drbeat.li>
	<20240429164849.78509-4-dev+git@drbeat.li>
Date: Mon, 29 Apr 2024 10:23:02 -0700
Message-ID: <xmqqo79sulqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2333D68E-064D-11EF-8400-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> +static int get_hex_color(const char **inp, int width, unsigned char *out)
>  {
> +	const char *in = *inp;
>  	unsigned int val;
> -	val = (hexval(in[0]) << 4) | hexval(in[1]);
> +
> +	assert(width == 1 || width == 2);
> +	val = (hexval(in[0]) << 4) | hexval(in[width - 1]);

So this makes #111111 out of #111 and #ffffff out of #fff.  Nice.

> diff --git a/color.h b/color.h
> index bb28343be210..7ed259a35bb4 100644
> --- a/color.h
> +++ b/color.h
> @@ -112,7 +112,8 @@ int want_color_fd(int fd, int var);
>   * Translate a Git color from 'value' into a string that the terminal can
>   * interpret and store it into 'dst'. The Git color values are of the form
>   * "foreground [background] [attr]" where fore- and background can be a color
> - * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
> + * name ("red"), a RGB code (#FF0000 or #F00) or a 256-color-mode from the
> + * terminal.
>   */

Good.  Hopefully we do not have such extra 0x in our end-user facing
documentation?

> diff --git a/t/t4026-color.sh b/t/t4026-color.sh
> index 0c39bd74a613..9a6f8a4bc5bf 100755
> --- a/t/t4026-color.sh
> +++ b/t/t4026-color.sh
> @@ -96,8 +96,8 @@ test_expect_success '256 colors' '
>  	color "254 bold 255" "[1;38;5;254;48;5;255m"
>  '
>  
> -test_expect_success '24-bit colors' '
> -	color "#ff00ff black" "[38;2;255;0;255;40m"
> +test_expect_success 'RGB colors' '
> +	color "#ff00ff #0f0" "[38;2;255;0;255;48;2;0;255;0m"
>  '
>  
>  test_expect_success '"default" foreground' '
> @@ -146,7 +146,10 @@ test_expect_success 'non-hex character in RGB color' '
>  	invalid_color "#12x456" &&
>  	invalid_color "#123x56" &&
>  	invalid_color "#1234x6" &&
> -	invalid_color "#12345x"
> +	invalid_color "#12345x" &&
> +	invalid_color "#x23" &&
> +	invalid_color "#1x3" &&
> +	invalid_color "#12x"
>  '

OK, looking good.

Thanks.

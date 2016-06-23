Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391A61FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 18:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbcFWSeG (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 14:34:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751454AbcFWSeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 14:34:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BB0F264C8;
	Thu, 23 Jun 2016 14:34:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tjei6F4KoYAc6GUO2tY2/c0SA7A=; b=UNwEB+
	cLFuYNbEZPuXm+7lBtMiECE9ZULgz6BJbD9UR+0Zeox8LT8aOGyqnv1bW2WszqnD
	jYCp4/fLjrXTkatpNZOuZimafc8HAjh8crYf2cNNLN5KWJZH4mozy11Pb0hDc+Ed
	j+rNjey4twBtmuPnaEFnukvRF6cxbn5oTC64Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BkFfGDPANN9WCpADzw0C4aFBWoIsY2Cn
	jEnd2J/FRRLBCHUKv3WEgeHWQ8cv0WReQ6HZX2t6vgFoJqa1SwOdidclsyYABm75
	V5m5W+lwM34/laaSJOA7LqErP5/idDClRlkewfkeozmdz2h26/4am+hi96MozUny
	UWmhWF3fVr8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 634D7264C7;
	Thu, 23 Jun 2016 14:34:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0573264C5;
	Thu, 23 Jun 2016 14:34:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 6/7] color: support "italic" attribute
References: <20160623173048.GA19923@sigill.intra.peff.net>
	<20160623173907.GF15774@sigill.intra.peff.net>
Date:	Thu, 23 Jun 2016 11:34:00 -0700
In-Reply-To: <20160623173907.GF15774@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jun 2016 13:39:07 -0400")
Message-ID: <xmqqtwgjiwkn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F20F32C-3971-11E6-8AA3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We already support bold, underline, and similar attributes.
> Let's add italic to the mix.  According to the Wikipedia
> page on ANSI colors, this attribute is "not widely
> supported", but it does seem to work on my xterm.
> ...
> @@ -133,6 +133,7 @@ static int parse_attr(const char *name, size_t len)
>  #define ATTR(x, val, neg) { (x), strlen(x), (val), (neg) }

I see this one was from an earlier reroll that did not use sizeof(x)-1;
easy to fixup, though ;-)

>  		ATTR("bold",      1, 22),
>  		ATTR("dim",       2, 22),
> +		ATTR("italic",    3, 23),
>  		ATTR("ul",        4, 24),
>  		ATTR("blink",     5, 25),
>  		ATTR("reverse",   7, 27)
> diff --git a/color.h b/color.h
> index e24fa0b..3af01a6 100644
> --- a/color.h
> +++ b/color.h
> @@ -16,7 +16,8 @@ struct strbuf;
>   *
>   * The space for attributes is also slightly overallocated, as
>   * the negation for some attributes is the same (e.g., nobold and nodim).
> - * We also allocate space for 6 attributes (even though we have only 5).
> + *
> + * We allocate space for 6 attributes.
>   */
>  #define COLOR_MAXLEN 70
>  
> diff --git a/t/t4026-color.sh b/t/t4026-color.sh
> index 2065752..13690f7 100755
> --- a/t/t4026-color.sh
> +++ b/t/t4026-color.sh
> @@ -60,8 +60,9 @@ test_expect_success 'long color specification' '
>  
>  test_expect_success 'absurdly long color specification' '
>  	color \
> -	  "#ffffff #ffffff bold nobold dim nodim ul noul blink noblink reverse noreverse" \
> -	  "[1;2;4;5;7;22;24;25;27;38;2;255;255;255;48;2;255;255;255m"
> +	  "#ffffff #ffffff bold nobold dim nodim italic noitalic
> +	   ul noul blink noblink reverse noreverse" \
> +	  "[1;2;3;4;5;7;22;23;24;25;27;38;2;255;255;255;48;2;255;255;255m"
>  '
>  
>  test_expect_success '0-7 are aliases for basic ANSI color names' '

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Detect endianness on more platforms that don't use BYTE_ORDER
Date: Fri, 02 May 2014 09:48:58 -0700
Message-ID: <xmqqwqe4azyd.fsf@gitster.dls.corp.google.com>
References: <20140502074917.GA25198@hashpling.org>
	<1399017329-25645-1-git-send-email-cbailey32@bloomberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Fri May 02 18:49:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgGeD-00088v-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 18:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbaEBQtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 12:49:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52700 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbaEBQtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 12:49:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A471912D15;
	Fri,  2 May 2014 12:49:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=atrIFhtIw37NQ+hig4Vsi2tKREI=; b=nZklLt
	Oo+444SYk2ab09WSaFSmgOv3R4xkb/pZ+nwq//2JV/sB9DjLQ64ISMLGK8U43694
	qLVlIYr0ryL154munnunAWmmrthGVIa427O+1RUrBtfFF9A3kbh6AFVc5a/pMsyJ
	N5eNb0BIZou/RUbsbbvp4zKj/WoEi3tyE+8Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=spcaw/P+2INkwSKoweuAMNM9pPExxm/T
	cS0hhSmxsMWeIqHGTvEyCYF1jKNinjBkLdCg+KDfy07rRpqysCouHGglIHbc1oRb
	W/pheLoF72/mvUPe6pCPi8v0GT3qB0hX4Oei5wkAokWMicLGG1pGkRMECIEjpqno
	Rn0xsYJg0SU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B23812D14;
	Fri,  2 May 2014 12:49:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B042C12D12;
	Fri,  2 May 2014 12:49:01 -0400 (EDT)
In-Reply-To: <1399017329-25645-1-git-send-email-cbailey32@bloomberg.net>
	(Charles Bailey's message of "Fri, 2 May 2014 08:55:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A9E0799E-D219-11E3-A665-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247943>

Charles Bailey <cbailey32@bloomberg.net> writes:

> ---

Please sign-off your patches ;-)

This swaps the precedence of BYTE_ORDER and __BYTE_ORDER from the
original, which we may not want to.  It is easy for me to swap the
order of if/elif to restore it, so it is not a big deal, though.

Thanks.

>  compat/bswap.h | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 120c6c1..f08a9fe 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -101,19 +101,34 @@ static inline uint64_t git_bswap64(uint64_t x)
>  #undef ntohll
>  #undef htonll
>  
> -#if !defined(__BYTE_ORDER)
> -# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
> -#  define __BYTE_ORDER BYTE_ORDER
> -#  define __LITTLE_ENDIAN LITTLE_ENDIAN
> -#  define __BIG_ENDIAN BIG_ENDIAN
> +#if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
> +
> +# define GIT_BYTE_ORDER BYTE_ORDER
> +# define GIT_LITTLE_ENDIAN LITTLE_ENDIAN
> +# define GIT_BIG_ENDIAN BIG_ENDIAN
> +
> +#elif defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && defined(__BIG_ENDIAN)
> +
> +# define GIT_BYTE_ORDER __BYTE_ORDER
> +# define GIT_LITTLE_ENDIAN __LITTLE_ENDIAN
> +# define GIT_BIG_ENDIAN __BIG_ENDIAN
> +
> +#else
> +
> +# define GIT_BIG_ENDIAN 4321
> +# define GIT_LITTLE_ENDIAN 1234
> +
> +# if defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
> +#  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
> +# elif defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
> +#  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
> +# else
> +#  error "Cannot determine endianness"
>  # endif
> -#endif
>  
> -#if !defined(__BYTE_ORDER)
> -# error "Cannot determine endianness"
>  #endif
>  
> -#if __BYTE_ORDER == __BIG_ENDIAN
> +#if GIT_BYTE_ORDER == GIT_BIG_ENDIAN
>  # define ntohll(n) (n)
>  # define htonll(n) (n)
>  #else

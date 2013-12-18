From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] Make starts_with() a wrapper of skip_prefix()
Date: Wed, 18 Dec 2013 09:50:07 -0800
Message-ID: <xmqqa9fyjbg0.fsf@gitster.dls.corp.google.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
	<1387378437-20646-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 18:50:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtLGG-0000EM-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 18:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab3LRRuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 12:50:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab3LRRuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 12:50:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4925059CA6;
	Wed, 18 Dec 2013 12:50:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c9aZYS4WJP6h
	Qu/84YA9Qk6ElkI=; b=wUssnSqsUvOfSzOxwgBethttxIeezg0N0dkOV5jwrkJ3
	b2ozrvxm47+vR0V5XIn5fi0laVwmmQbLB1BErR5e98XiJhP2SjsCocgps4rDZ1kf
	H4hxmXlN26misBMYI1CVQ8kQpXZCyvzNrxsUszck+sZvUy7D/IQU7ctc7jsP8ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K/6dEb
	WJ0QRcVIZ0vcCqyRFnqk/w3WrYB+0c4001MUDKwCFkXWAIvncSHVI7jEANCe7vO1
	ysKNF+YHNzudH2ePuShbrDl7moN4P9jSH9vpc8ZTxq5iqSoyVAtMBNJHYiYHQ0bB
	ShMV/UxZ8daXUTXkaEcGav2snCrxjXzFFLjbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EDFA59CA2;
	Wed, 18 Dec 2013 12:50:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECC3059C9B;
	Wed, 18 Dec 2013 12:50:09 -0500 (EST)
In-Reply-To: <1387378437-20646-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 18
 Dec 2013 21:53:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D68E7B70-680C-11E3-A155-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239462>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> starts_with() started out as a copy of prefixcmp(). But if we don't
> care about the sorting order, the logic looks closer to
> skip_prefix(). This looks like a good thing to do.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Sure, but the implementation of skip_prefix() scans the prefix
string twice, while prefixcmp() aka starts_with() does it only once.

I'd expect a later step in this series would rectify this micro
regression in the performance, though ;-)

>  git-compat-util.h | 6 +++++-
>  strbuf.c          | 9 ---------
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b73916b..84f1078 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -350,7 +350,6 @@ extern void set_die_routine(NORETURN_PTR void (*r=
outine)(const char *err, va_lis
>  extern void set_error_routine(void (*routine)(const char *err, va_li=
st params));
>  extern void set_die_is_recursing_routine(int (*routine)(void));
> =20
> -extern int starts_with(const char *str, const char *prefix);
>  extern int prefixcmp(const char *str, const char *prefix);
>  extern int ends_with(const char *str, const char *suffix);
>  extern int suffixcmp(const char *str, const char *suffix);
> @@ -361,6 +360,11 @@ static inline const char *skip_prefix(const char=
 *str, const char *prefix)
>  	return strncmp(str, prefix, len) ? NULL : str + len;
>  }
> =20
> +static inline int starts_with(const char *str, const char *prefix)
> +{
> +	return skip_prefix(str, prefix) !=3D NULL;
> +}
> +
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
> =20
>  #ifndef PROT_READ
> diff --git a/strbuf.c b/strbuf.c
> index 83caf4a..bd4c0d8 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1,15 +1,6 @@
>  #include "cache.h"
>  #include "refs.h"
> =20
> -int starts_with(const char *str, const char *prefix)
> -{
> -	for (; ; str++, prefix++)
> -		if (!*prefix)
> -			return 1;
> -		else if (*str !=3D *prefix)
> -			return 0;
> -}
> -
>  int prefixcmp(const char *str, const char *prefix)
>  {
>  	for (; ; str++, prefix++)

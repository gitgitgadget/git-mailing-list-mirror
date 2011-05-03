From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 3/3] git-grep: Learn PCRE
Date: Tue, 03 May 2011 16:11:06 -0700
Message-ID: <7vliyngz1x.fsf@alter.siamese.dyndns.org>
References: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1304458557-25629-3-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:11:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHOkU-0004OB-Su
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 01:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab1ECXLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 19:11:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab1ECXLR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 19:11:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4BB715E84;
	Tue,  3 May 2011 19:13:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VJ4tlfP54SKi
	L/zomHLzLhtbplk=; b=Nkjq6g/+4rRNBhA0BLq2meJtGCdOP8QorTiHpFf02gOg
	sPWZRt2rvdxSLoSFy1zRHOgD6aRJBOowCnauIy0XEzWbVxyJLPU7ZPcIL+dny1ZY
	nWlhC5rU6WLmHJC2QI3jYCXLy0+BWpUWyP5LBbn+uBVLUJzi68Gi1jslG+vha0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oosAOR
	9YZHUdV1J5ThRgupD71oQk84JDf1z8elwOPmdkyi31WZ9GC4sQkNSLN88mpuwPdy
	tey5zpKs50PYTKrbGBI/Kcprxd/hTFEPfXVQWJlqzVvX1x/vEQ6A3EfrsJAonyuJ
	tIyEDBdpjl4lT518xRMxsKOhJtDTY1Xmq+NRs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A57E5E83;
	Tue,  3 May 2011 19:13:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6A865E82; Tue,  3 May 2011
 19:13:12 -0400 (EDT)
In-Reply-To: <1304458557-25629-3-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Tue, 3 May 2011
 23:35:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED04FCF2-75DA-11E0-B2DC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172700>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> This patch lacks tests.
>
> AFAIK grep.c is a part of libgit.a, so libpcre is linked with the git
> itself, which bloats it. I don't like it, especially because it makes
> 'make test' take:
>
> 	real    6m27.558s
> 	user    1m34.392s
> 	sys     2m11.029s
>
> instead of
>
> 	real    3m41.322s
> 	user    1m44.005s
> 	sys     2m32.403s
>
> on my PC.

I am not against pcre, but the performance numbers look rather yucky.

> diff --git a/grep.c b/grep.c
> index d67baf9..4f5fcbb 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -70,6 +70,30 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
>  	if (p->fixed)
>  		return;
> =20
> +	if (opt->pcre) {
> +#ifdef NO_LIBPCRE
> +		die("cannot use Perl-compatible regexes when libpcre is not compil=
ed in");
> +#else
> +		const char *error;
> +	...
> +		return;
> +#endif
> +	}
> +

Please avoid these #ifdefs in the middle of otherwise generic function.

Make the above into something like:

	if (opt->pcre) {
        	compile_pcre(p, opt);
                return;
	}

and then have an extra section entirely devoted to pcre integration tha=
t
has bunch of ...

        #ifdef NO_LIBPCRE
        static void compile_pcre_part(struct grep_pat *p, struct grep_o=
pt *opt)
        {
                die("...");
	}
        #else
        static void compile_pcre_part(struct grep_pat *p, struct grep_o=
pt *opt)
        {
                ...
	}
        #endif

=2E.. that is totally separate from the generic part of the codebase.  =
They
could even be in a separate file, if you need numerous helpers.

> @@ -320,7 +344,16 @@ void free_grep_patterns(struct grep_opt *opt)
>  		case GREP_PATTERN: /* atom */
>  		case GREP_PATTERN_HEAD:
>  		case GREP_PATTERN_BODY:
> +#ifndef NO_LIBPCRE
> +			if (p->re) {
> +				pcre_free(p->re);
> +				pcre_free(p->extra);
> +			} else {
> +				regfree(&p->regexp);
> +			}
> +#else
>  			regfree(&p->regexp);
> +#endif
>  			break;
>  		default:
>  			break;

> diff --git a/grep.h b/grep.h
> index 06621fe..cd202a9 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -1,6 +1,9 @@
>  #ifndef GREP_H
>  #define GREP_H
>  #include "color.h"
> +#ifndef NO_LIBPCRE
> +#include <pcre.h>
> +#endif /* NO_LIBPCRE */

This part might want to do something like

	#ifndef NO_LIBPCRE
        #include <pcre.h>
        #else
        typedef int pcre; /* dummy */
        typedef int pcre_extra; /* dummy */
        #endif

if it makes it easier to keep the generic part of the code and structur=
e
definition clean.

=46or example, the "free" part of your patch above then would become

	if (p->pcre_regexp)
        	free_pcre_part(p);
	else
        	regfree(&p->regexp);

with the conditional enclosed entirely within the implementation of
the free_pcre_part() helper function.

Also by doing so, the struct definition below can lose #ifndef, and can=
 become:

	 struct grep_pat {
         ...
        +	pcre *pcre_regexp;
        +	pcre_extra *pcre_extra_info;
	 ...
	 };

> @@ -33,6 +36,10 @@ struct grep_pat {
>  	size_t patternlen;
>  	enum grep_header_field field;
>  	regex_t regexp;
> +#ifndef NO_LIBPCRE
> +	pcre *re;
> +	pcre_extra *extra;
> +#endif /* NO_LIBPCRE */
>  	unsigned fixed:1;
>  	unsigned ignore_case:1;
>  	unsigned word_regexp:1;
> @@ -83,6 +90,7 @@ struct grep_opt {
>  #define GREP_BINARY_TEXT	2
>  	int binary;
>  	int extended;
> +	int pcre;
>  	int relative;
>  	int pathname;
>  	int null_following_name;

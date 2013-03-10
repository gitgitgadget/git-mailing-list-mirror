From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sat, 09 Mar 2013 23:34:05 -0800
Message-ID: <7vy5dvd7yq.fsf@alter.siamese.dyndns.org>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 08:34:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEamD-0001Jv-5m
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 08:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab3CJHeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 03:34:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab3CJHeK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Mar 2013 03:34:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 490C08296;
	Sun, 10 Mar 2013 03:34:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tx+rhfeEAtEb
	8VaLWMeiygKjMUM=; b=pkDVKus+qaeyZ8lgq6Uw1RNxOhoCxYTbajpZeaFV1xIE
	A4y6rDcXAEzXtxzLHv1kzQwoYjtV5T+O44i5ZWSG9oc+zXI5NSauWuB5N7v1rspj
	nB0p2amWBUWBx3Jef/YrR0GYNVsLq6zK2jJPkQ0lh/EIZGaWQoEF4SjTOZCVVTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sPOmwS
	hxQD5OPivErTbisMCfyGK0aKbvYyw6KejTVj6TUzcK4pC2ElUOnLL1f8yqZ/Uydl
	6LKoHNcjMfqQva4LKKu9pnE8jmIIzh0noQjuBS5BmDPjauIh2yPFwwQ+szZHkplz
	AyGo7akMWAdLvhrLUaPqGokIHDRCrf+IsFNlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3449E8294;
	Sun, 10 Mar 2013 03:34:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 348828292; Sun, 10 Mar 2013
 03:34:07 -0400 (EDT)
In-Reply-To: <1362896070-17456-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 10 Mar
 2013 13:14:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4BA9D10-8954-11E2-8E7D-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217789>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> strncmp is provided length information which could be taken advantage
> by the underlying implementation.

I may be missing something fundamental, but I somehow find the above
does not make any sense.

strcmp(a, b) has to pay attention to NUL in these strings and stop
comparison.  strncmp(a, b, n) not only has to pay the same attention
to NUL in the strings, but also needs to stop comparing at n bytes.

In what situation can the latter take advantage of that extra thing
that it needs to keep track of and operate faster, when n is the
length of shorter of the two strings?

> diff --git a/dir.c b/dir.c
> index 9960a37..46b24db 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -610,12 +610,14 @@ int match_basename(const char *basename, int ba=
senamelen,
>  		   int flags)
>  {
>  	if (prefix =3D=3D patternlen) {
> -		if (!strcmp_icase(pattern, basename))
> +		if (patternlen =3D=3D basenamelen &&
> +		    !strncmp_icase(pattern, basename, patternlen))
>  			return 1;

What happens if you replace this with

		if (patternlen =3D=3D baselen &&
                    !strcmp_icase(pattern, basename, patternlen))

and drop the other hunk and run the benchmark again?

>  	} else if (flags & EXC_FLAG_ENDSWITH) {
>  		if (patternlen - 1 <=3D basenamelen &&
> -		    !strcmp_icase(pattern + 1,
> -				  basename + basenamelen - patternlen + 1))
> +		    !strncmp_icase(pattern + 1,
> +				   basename + basenamelen - patternlen + 1,
> +				   patternlen - 1))
>  			return 1;
>  	} else {
>  		if (fnmatch_icase(pattern, basename, 0) =3D=3D 0)

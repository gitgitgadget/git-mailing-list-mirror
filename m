From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] wildmatch: advance faster in <asterisk> + <literal>
 patterns
Date: Thu, 27 Dec 2012 22:24:29 -0800
Message-ID: <7vpq1uk82q.fsf@alter.siamese.dyndns.org>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
 <1356163028-29967-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 07:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToTNI-0004rH-LE
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 07:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146Ab2L1GYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Dec 2012 01:24:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab2L1GYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Dec 2012 01:24:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A75C770B;
	Fri, 28 Dec 2012 01:24:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SA9nhmvCixBy
	84qvgqFAOE/8PTE=; b=ATkxYJlutAAgsFIe+C7rpMBIkMtmSki73RQUDIIJcMT8
	LaFS+dq+1xehtF3ZA4vp9vD/vc3nki3KDjDMXCdzmnSAnGTVTE5JMrTsVc6CnTZF
	QZ7edk1MfiOeoILGIHy4SgSRZgg0Fr77xleL6/BlMMWttfoKic2JSvLDhg08Ir4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qDjDds
	SX+DJUqIxo22Aw7dZjlWnZzMoOhHY+j7Hlma+mUPbHjDz0Z8PyFkm8115Cu1G6uE
	Wpm5DUOOJbosNkO8qEWO6XLj8/ZaiNTGME530wP46/1IF/S0buHwfSQI2TK0JHlJ
	A0oidtNFRhIshUS+v26RDu/IXX9f282RSR81A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B90C770A;
	Fri, 28 Dec 2012 01:24:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51C677709; Fri, 28 Dec 2012
 01:24:31 -0500 (EST)
In-Reply-To: <1356163028-29967-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22 Dec
 2012 14:57:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D5FC840-50B7-11E2-B08C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212235>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> compat, '*/*/*' on linux-2.6.git file list 2000 times, before:
> wildmatch 7s 985049us
> fnmatch   2s 735541us or 34.26% faster
>
> and after:
> wildmatch 4s 492549us
> fnmatch   0s 888263us or 19.77% slower
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  wildmatch.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/wildmatch.c b/wildmatch.c
> index 3794c4d..68b02e4 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -132,6 +132,27 @@ static int dowild(const uchar *p, const uchar *t=
ext, unsigned int flags)
>  			while (1) {
>  				if (t_ch =3D=3D '\0')
>  					break;
> +				/*
> +				 * Try to advance faster when an asterisk is
> +				 * followed by a literal. We know in this case
> +				 * that the the string before the literal
> +				 * must belong to "*".
> +				 */
> +				if (!is_glob_special(*p)) {

So far, we have looked at "*x" or "**x" in the pattern, p points at
'x' (not an asterisk), and we have "text" to match.  For "text" to
match this pattern, the earlier part of it that is consumed to match
the asterisk must be followed by "x".  "special" tells us if we are
allowed to treat '/' as matching the asterisk.

> +					p_ch =3D *p;
> +					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
> +						p_ch =3D tolower(p_ch);

That "x" in the example is picked up here and stored in "p_ch".
Let's skip over "text" and find that "x" in there.

> +					while ((t_ch =3D *text) !=3D '\0' &&
> +					       (!(flags & WM_PATHNAME) || t_ch !=3D '/')) {

Why do we look at (flags & WM_PATHMAME) and not "special" here?

> +						if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
> +							t_ch =3D tolower(t_ch);
> +						if (t_ch =3D=3D p_ch)
> +							break;

=46ound it.

> +						text++;
> +					}
> +					if (t_ch !=3D p_ch)
> +						return WM_NOMATCH;

If we did not find that "x", then "**x" or "*x" can never match.
OK.  And at this point "text" points at that "x" we found, and "p"
points at "x" after the asterisk in the pattern.

Looks good so far.  Thanks.

> +				}
>  				if ((matched =3D dowild(p, text,  flags)) !=3D WM_NOMATCH) {
>  					if (!special || matched !=3D WM_ABORT_TO_STARSTAR)
>  						return matched;

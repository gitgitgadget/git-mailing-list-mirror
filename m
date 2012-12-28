From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] wildmatch: support "no FNM_PATHNAME" mode
Date: Thu, 27 Dec 2012 22:24:16 -0800
Message-ID: <7vwqw2k833.fsf@alter.siamese.dyndns.org>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
 <1356163028-29967-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 07:24:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToTN8-0004mS-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 07:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898Ab2L1GYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Dec 2012 01:24:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2L1GYT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Dec 2012 01:24:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1F176F2;
	Fri, 28 Dec 2012 01:24:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=4aYGD6zQSURrtRdfNhBUmSNjt
	/s=; b=ArjHep0l4OYbcELgG9S4NbrSFP1nli88ONe+SlKqttSbJkT8ciYJqwr5P
	scoEormPdTQl6iEFFmp8EWZPVDcKyhtqDLHOCDJjnKnzNSb+T3euDfhkjZJAt7zS
	S/HfG15obPWmWVrETOgwhtrmem6oDCguXLr6GL5mdF7ThVJsIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AQE8hNgbVHXIoK7xO+D
	xFSYkSxzdUA3jCaFauFVPnT6nHuwUmtIabn5t+lIo5QeKD0rFVN5sI+z9sVD8Z5J
	wMEGEfxAzS4Vq6Zd5ijmNwG01eukIIDHQ3y2ywii7BwI47EujirhZME/x9bm6d1c
	UpBuo/xfvH+Np90uCyW5V2Q0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C740A76F1;
	Fri, 28 Dec 2012 01:24:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32B4C76EE; Fri, 28 Dec 2012
 01:24:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 358C1F38-50B7-11E2-A56D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212234>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/wildmatch.c b/wildmatch.c
> index a79f97e..4fe1d65 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -77,14 +77,17 @@ static int dowild(const uchar *p, const uchar *te=
xt, unsigned int flags)
>  			continue;
>  		case '?':
>  			/* Match anything but '/'. */
> -			if (t_ch =3D=3D '/')
> +			if ((flags & WM_PATHNAME) && t_ch =3D=3D '/')
>  				return WM_NOMATCH;
>  			continue;
>  		case '*':
>  			if (*++p =3D=3D '*') {
>  				const uchar *prev_p =3D p - 2;
>  				while (*++p =3D=3D '*') {}
> -				if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
> +				if (!(flags & WM_PATHNAME))
> +					/* without WM_PATHNAME, '*' =3D=3D '**' */
> +					special =3D 1;
> +				else if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||

Not a new issue in this patch, but here, "prev_p" points into the
pattern string, two bytes before p, which is the byte before the
"**" that we are looking at (which might be before the beginning of
the pattern).  "text" is the string we are trying to match that
pattern against.  How can these two pointers be compared to yield a
meaningful value?

>  				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
>  				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {

OK.  "**/", "**" (end of pattern), and "**\/" are handled here. =20

Do we have to worry about "**[/]" the same way, or a class never
matches the directory separator, even if it is a singleton class
that consists of '/' (which is fine by me)?  If so, is "\/" more or
less like "[/]"?

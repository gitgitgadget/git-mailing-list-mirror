From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make it possible to update git_wcwidth()
Date: Mon, 12 May 2014 10:54:41 -0700
Message-ID: <xmqq8uq6u967.fsf@gitster.dls.corp.google.com>
References: <536D4DF0.3060301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kevin@bracey.fi, peter@softwolves.pp.se
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 12 20:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjvFU-0005dq-96
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbaELSqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 14:46:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59657 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135AbaELSqt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 14:46:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C11815E80;
	Mon, 12 May 2014 14:46:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Frir7JkocdDbN3sOKMDOcDZqw
	/8=; b=OG4fJMSEsKh1gDvIep1lhW1FZwtUJxb0QHNSmfcLLN8dpqEDs9ClLNFHr
	ANB8sIP+L62LkuBf8n1WLJC8P62QqNcXK8sOz2ywt3uOa1nhzQqrwET4ulZR/XpF
	B91sMIYjX5EqO5tHcX34duTDa2S4MQpRYU4zwuU9yjC+BuKHAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GivoU8SKPdouFR+sxVH
	SFgOqfhFvFR2TKwjIg/MNEhnZcZitdE56NrFxBrAf0Dx252NXHkXZStJSLj0VLwA
	vHZ+sK+FRjDeyFcr1imAmZYK4RPeMDRyY1/TIxB2xlPARginfICNOZTTvGdPawWd
	FkKWP9XR/Y+M9pvAjmYrteuc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9137915E7C;
	Mon, 12 May 2014 14:46:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D495715E53;
	Mon, 12 May 2014 14:46:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C22F968A-DA05-11E3-9AD9-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248721>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The function git_wcwidth() returns for a given unicode code point the
> width on the display:
> -1 for control characters,
>  0 for combining or other non-visible code points
>  1 for e.g. ASCII
>  2 for double-width code points.
>
> This table had been originally been extracted for one Unicode version=
,
> probably 3.2.
>
> Make it possible to update the to a later version of Unicode:
>
> Factor out the table from utf8.c into unicode_width.h and
> add the script update_unicode.sh to update the table based on the lat=
est
> Unicode specification files.
>
> Thanks to
> Peter Krefting <peter@softwolves.pp.se> and
> Kevin Bracey <kevin@bracey.fi>
> for helping with their Unicode knowledge
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

I would say this is a good idea, but a few nitpicks.

> diff --git a/unicode_width.h b/unicode_width.h
> new file mode 100644
> index 0000000..4db7803
> --- /dev/null
> +++ b/unicode_width.h
> @@ -0,0 +1,288 @@

Please update the script (and the resulting file) to caution against
misuse/mismanagement of this file by adding a comment to at least
state:

 - This is a generated file and you are not supposed to modify it; and

 - This is to be included only once from one place in the code and
   that is why this does not use the usual #ifndef X/#define X/#endif
   double-inclusion guards.

An obvious and viable alternative to the second would be to do the
usual double-inclusion guard.  I do not have much preference either
way.

> +static const struct interval zero_width[] =3D {
> ...
> +};
> +static const struct interval double_width[] =3D {
> ...
> +};
> diff --git a/update_unicode.sh b/update_unicode.sh
> new file mode 100755
> index 0000000..000b937
> --- /dev/null
> +++ b/update_unicode.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +#See http://www.unicode.org/reports/tr44/
> +#
> +#Me Enclosing_Mark  an enclosing combining mark
> +#Mn Nonspacing_Mark a nonspacing combining mark (zero advance width)
> +#Cf Format          a format control character

Please have a SP after # in these comments to make them readable?

> +#
> +UNICODEWIDTH_H=3D../unicode_width.h
> +if ! test -d unicode; then
> +	mkdir unicode
> +fi &&

Style:

	if ! test -d unicode
        then
        	...
	fi

> +( cd unicode &&
> +	if ! test -f UnicodeData.txt; then
> +		wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
> +	fi &&
> +	if ! test -f EastAsianWidth.txt; then
> +		wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.t=
xt
> +	fi &&
> +	if ! test -d uniset; then
> +		git clone https://github.com/depp/uniset.git
> +	fi &&
> +	(
> +		cd uniset &&
> +		if ! test -x uniset; then
> +			autoreconf -i &&
> +			./configure --enable-warnings=3D-Werror CFLAGS=3D'-O0 -ggdb'

What are these "-O0 -ggdb" about?

> +		fi &&
> +		make
> +	) &&
> +	echo "static const struct interval zero_width[] =3D {" >$UNICODEWID=
TH_H &&
> +	UNICODE_DIR=3D. ./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF =
- U+00AD |
> +	grep -v plane >>$UNICODEWIDTH_H &&
> +	echo "};" >>$UNICODEWIDTH_H &&
> +	echo "static const struct interval double_width[] =3D {" >>$UNICODE=
WIDTH_H &&
> +	UNICODE_DIR=3D. ./uniset/uniset --32 eaw:F,W >>$UNICODEWIDTH_H &&
> +	echo "};" >>$UNICODEWIDTH_H
> +)
> @@ -147,7 +90,7 @@ static int git_wcwidth(ucs_char_t ch)
>  		return -1;
> =20
>  	/* binary search in table of non-spacing characters */
> -	if (bisearch(ch, combining, sizeof(combining)
> +	if (bisearch(ch, zero_width, sizeof(zero_width)
>  				/ sizeof(struct interval) - 1))

To my eyes, that line looks folded at a funny place.  I think it is
more conventional to fold after the operator, i.e.

	if (bisearch(ch, zero_width, sizeof(zero_width)	/
				sizeof(struct interval) - 1))

but

	if (bisearch(ch, zero_width,
  		     sizeof(zero_width)	/ sizeof(struct interval) - 1))

may probably be a lot more logical and readable.  Maybe it is just
me.

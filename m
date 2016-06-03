From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri, 03 Jun 2016 10:00:24 -0700
Message-ID: <xmqqlh2mp5qv.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160603110843.15434-1-pclouds@gmail.com>
	<20160603110843.15434-4-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:10:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sSX-00040Y-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbcFCRA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 13:00:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932107AbcFCRA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 13:00:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30CF12104C;
	Fri,  3 Jun 2016 13:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pHWXRki4i/rH
	mP5y02qNMs1MooE=; b=pruW3PxtJTEGECSl+y8h5as6Vw3OKHS/4T8514von7G1
	k6OInyp+mmWSliLtyiBHD5YrVUN9+Hzs2fbeUhzB0owVOKd59c6izToX9KYZbOsz
	AA/BAjTqvK7Mm8FvrUv5OBc3SM2/cTEa1ZXiVYkltGUlUQzdsFdpPNmmcrKVv94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TSAl3d
	oGxMPXz9TkNm17SmcTLRkAXXr7Lvq0xiUAeWgTSi0ZRlbzihA58eHbK0YMLj/zli
	Df/AIgXewgFTD3TW9vdXGT4ZDT49mg12sbmn+7LIf+k/9bfUH7WY3KcMV0FuaVLF
	rvWtunS0HZGCA9c7Wg5HPkaPGtPSL1NQSdgq4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27D6221049;
	Fri,  3 Jun 2016 13:00:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1DFD21048;
	Fri,  3 Jun 2016 13:00:26 -0400 (EDT)
In-Reply-To: <20160603110843.15434-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Fri, 3 Jun 2016 18:08:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB51C1F6-29AC-11E6-AB8A-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296347>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static int common_suffix_length(const char *a, const char *b)
> +{
> +	const char *pa =3D a + strlen(a);
> +	const char *pb =3D b + strlen(b);
> +	int count =3D 0;
> +
> +	while (pa > a && pb > b && pa[-1] =3D=3D pb[-1]) {
> +		pa--;
> +		pb--;
> +		count++;
> +	}
> +
> +	/* stick to '/' boundary, do not break in the middle of a word */
> +	while (count) {
> +		if (*pa =3D=3D '/' ||
> +		    (pa =3D=3D a && pb > b && pb[-1] =3D=3D '/') ||
> +		    (pb =3D=3D b && pa > a && pa[-1] =3D=3D '/'))
> +			break;
> +		pa++;
> +		pb++;
> +		count--;
> +	}
> +
> +	return count;
> +}
> +

Why do you need two loops, one going backward from the tail and then
going forward toward '/'?  Wouldn't it be sufficient to keep track
of the last slash you saw in a while scanning backwards?  I.e
something along the lines of:

	tail_a =3D a + strlen(a);
	for (pa =3D tail_a, pb =3D b + strlen(b), slash_in_a =3D NULL;
             a < pa && b < pb && pa[-1] =3D=3D pb[-1];
	     pa--, pb--) {
		if (*pa =3D=3D '/')
			slash_in_a =3D pa;
	}
	count =3D a + strlen(a) - slash_in_a;
	=09
perhaps?

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 454d896..9a7649c 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -222,11 +222,11 @@ test_expect_success 'fetch uses remote ref name=
s to describe new refs' '
>  	(
>  		cd descriptive &&
>  		git fetch o 2>actual &&
> -		grep " -> refs/crazyheads/descriptive-branch$" actual |
> +		grep " -> refs/crazyheads/.descriptive-branch$" actual |
>  		test_i18ngrep "new branch" &&
>  		grep " -> descriptive-tag$" actual |
>  		test_i18ngrep "new tag" &&
> -		grep " -> crazy$" actual |
> +		grep " -> .crazy$" actual |
>  		test_i18ngrep "new ref"
>  	) &&

These are somewhat cryptic ;-)

Other than that, the patch looks OK.

Thanks.

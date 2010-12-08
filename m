From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] get_sha1: support ref^{/regex} syntax
Date: Wed, 08 Dec 2010 14:50:57 -0800
Message-ID: <7vvd33j2um.fsf@alter.siamese.dyndns.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <1291820319-12455-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 23:51:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSrT-0002uD-2O
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606Ab0LHWvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 17:51:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab0LHWvO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 17:51:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D3DD234D;
	Wed,  8 Dec 2010 17:51:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7V8kvNizZVrOEw626oF9iibQ0
	Z4=; b=DZNyq86xNodizx45Bx8sqk9KrLDfnrNKGMuhT+c6xKlLykXO7UiKkHWPs
	nVyQqqcVdAAHCpUWjl+4kS4MIWqAcS/KmQ8J+MHcZ0AtQ+Tb8XbnMTe1Ti7N+Vjj
	zXtR7HLikBVUrSQM3BI/avBGmYMII+dOviGX2WouZT3eqG9yaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=kUwz9SGXZ8GhHF0wGK6
	JjLL4CJuRIL1usWN14R74CpF2FZncnB2Z4r/++ZAdWfaffueC7bnaVKJtlRQ8Icu
	IrKlqwXuHaaZPgDXh4SDdo92uFPYCicCiSMtzsnyKODQewbK8se4qOGfTM9KynQa
	m5jN0badKbp/7tDR1sELdphI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEA972346;
	Wed,  8 Dec 2010 17:51:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 06AE6232C; Wed,  8 Dec 2010
 17:51:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2B1D514-031D-11E0-B12A-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163232>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index f4ccdc5..00e52b0 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -562,6 +563,11 @@ static int peel_onion(const char *name, int len,=
 unsigned char *sha1)
>  		expected_type =3D OBJ_BLOB;
>  	else if (sp[0] =3D=3D '}')
>  		expected_type =3D OBJ_NONE;
> +	else if (sp[0] =3D=3D '/') {
> +		if (sp[1] =3D=3D '}')
> +			return -1;

Why?  $commit^{/} may be a no-op but I do not see a strong reason to
waste extra two lines to forbid it.

> @@ -584,11 +590,23 @@ static int peel_onion(const char *name, int len=
, unsigned char *sha1)
>  		 * barf.
>  		 */
>  		o =3D peel_to_type(name, len, o, expected_type);
> -		if (o) {
> -			hashcpy(sha1, o->sha1);
> -			return 0;
> +		if (!o)
> +			return -1;

I can see you are trying to reduce nesting of

        if (o) {
		do true thing
                return 0
	}
        return -1;

but then we should apply the same to outer "if (!expected_type) ... els=
e",
too, to unnest the "else" clause by returning from the true branch of t=
hat
"if".

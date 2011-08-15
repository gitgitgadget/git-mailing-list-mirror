From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] xdiff-interface: allow consume function to quit
 early by returning non-zero
Date: Mon, 15 Aug 2011 12:41:36 -0700
Message-ID: <7v39h2laxb.fsf@alter.siamese.dyndns.org>
References: <1313376083-24713-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 21:41:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt32j-00011V-7U
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 21:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1HOTlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Aug 2011 15:41:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab1HOTln convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2011 15:41:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 081A143D4;
	Mon, 15 Aug 2011 15:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IhyJDBhCgNSK
	dCuXt3QPR1cVqgA=; b=iU4+1C6ejJxhD1U4Nb2ORMkHCwEIW9b9ClIZyGSdf6tU
	4sMmtGVwRb+X6PvB/4ZwDAfM1vZWcg73A+/e2R8vRS5ayvRIJ0/2Fxfba+OH2gdB
	CzGe+awacQYnapcOMl1w3jClL04xuRtzcEXiZ0cV/6dV8sQweiMlqKu/eFSw8Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ufLAOI
	GA6T5ZsV4dk5h1DLROd0vEbgm5wmINJ8mGPh9K2hGRBJw2yCAwfh+S8K159aGSLU
	G5YiWyJu4jPal/EwyHHBZ+6upc3282tOzeYKkkh7BFcTYDnSjRWspbE2VFbxvpmM
	IjEAzUnlC2Rq6tt8/zSSrp2a/1P+R7y46YVEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F37B143D3;
	Mon, 15 Aug 2011 15:41:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81CE143D2; Mon, 15 Aug 2011
 15:41:40 -0400 (EDT)
In-Reply-To: <1313376083-24713-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15 Aug
 2011 09:41:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98D720CC-C776-11E0-9327-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179384>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

What is this for? No explanation?

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 0e2c169..c5684b4 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -56,7 +56,7 @@ int parse_hunk_header(char *line, int len,
>  	return -!!memcmp(cp, " @@", 3);
>  }
> =20
> -static void consume_one(void *priv_, char *s, unsigned long size)
> +static int consume_one(void *priv_, char *s, unsigned long size)
>  {
>  	struct xdiff_emit_state *priv =3D priv_;
>  	char *ep;
> @@ -64,10 +64,12 @@ static void consume_one(void *priv_, char *s, uns=
igned long size)
>  		unsigned long this_size;
>  		ep =3D memchr(s, '\n', size);
>  		this_size =3D (ep =3D=3D NULL) ? size : (ep - s + 1);
> -		priv->consume(priv->consume_callback_data, s, this_size);
> +		if (priv->consume(priv->consume_callback_data, s, this_size))
> +			return -1;
>  		size -=3D this_size;
>  		s +=3D this_size;
>  	}
> +	return 0;
>  }

Returning a negative value implies that this is an error condition. Sho=
uld
all "non-zero" returns from ->consume necessarily be considered error?

The same comment applies to the new "return -1" in the rest of the patc=
h.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/28] update-server-info: do not publish shallow clones
Date: Mon, 25 Nov 2013 12:08:01 -0800
Message-ID: <xmqqr4a4xn1a.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:08:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2S6-0003n8-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab3KYUIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 15:08:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab3KYUIJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 15:08:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2138A53D3F;
	Mon, 25 Nov 2013 15:08:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vYZwdFnFDgLf
	JdtDB5QxM5b98Gw=; b=IB14iwfSNa4Dk26okmdALrPrLfEXvQI6ObeD1zAYhfIR
	dyjXJ3Zfq5vrV74gP9zOgUqQ9VWaZwTYZdiEtgTsuPmmXO/pfI2qOCLUYYocXUE7
	pMJ3J+kDrT7iQmtRD1sXJGb2i22JenP6uHsxUV/xZ0ixdyNiXut6qrCQBc2ciyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z0M7V3
	kSQf+VNX7VKDa6L42QG0YqeoB2S95EYCb+INfu08bdJt053DfBzDAAIYc4908RjM
	PonjrxSX/YpEuNlBgSOSHivtUO3NKUEn3D9OqOZ/L0JvG9VoBWl3ONYoOHpmtB8J
	Uj564EazZqbFLCsXMiYrn5dEB/dI/O9SC9FlM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C2AF53D3E;
	Mon, 25 Nov 2013 15:08:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C7D953D39;
	Mon, 25 Nov 2013 15:08:08 -0500 (EST)
In-Reply-To: <1385351754-9954-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 25
 Nov 2013 10:55:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4D60744A-560D-11E3-A112-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238337>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Dumb commit walker does not care about .git/shallow and until someone
> steps up to make it happen, let's not publish shallow clones using
> dumb protocols.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  server-info.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

I doubt that pros-and-cons is in this patch's favor.  Without this
patch, if a fetch requests commits just on the surface in this
shallow repository, the walker would happily get the necessary
objects just fine.  If the request has to dig deeper and cross the
shallow boundary, the walker will get a failure and error out.

With this patch, both will error out.  So overall, the patch did not
make anything safer (e.g. preventing from introducing new corruption
on the recipient's end) while breaking a case where it worked just
fine, no?

Or am I missing something?  Not that dumb walkers would matter very
much these days, ...

> diff --git a/server-info.c b/server-info.c
> index 9ec744e..a8df6a5 100644
> --- a/server-info.c
> +++ b/server-info.c
> @@ -33,6 +33,10 @@ static int update_info_refs(int force)
>  	strcpy(path1 + len, "+");
> =20
>  	safe_create_leading_directories(path0);
> +	if (is_repository_shallow()) {
> +		unlink(path0);
> +		return error("info/refs not updated for shallow clone");
> +	}
>  	info_ref_fp =3D fopen(path1, "w");
>  	if (!info_ref_fp)
>  		return error("unable to update %s", path1);
> @@ -217,6 +221,11 @@ static int update_info_packs(int force)
>  	strcpy(name, infofile);
>  	strcpy(name + namelen, "+");
> =20
> +	if (is_repository_shallow()) {
> +		unlink(infofile);
> +		return error("info/packs not updated for shallow clone");
> +	}
> +
>  	init_pack_info(infofile, force);
> =20
>  	safe_create_leading_directories(name);

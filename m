From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Thu, 17 Jul 2014 11:03:16 -0700
Message-ID: <xmqqoawnq2vv.fsf@gitster.dls.corp.google.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:03:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7q1g-0002AJ-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 20:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbaGQSDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 14:03:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54172 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbaGQSDY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2014 14:03:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CACC72ADF4;
	Thu, 17 Jul 2014 14:03:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Pu+o+dZVbDHM
	HjHd7Q0W36ba5J8=; b=dXGiQmcdvNlXKoP5rnw1UQTfeUmVAw31aNCuqnKylTEN
	oO3Kohiuc4m77wjNP4zWLjmv7rmiitmn20U1Z08l9gapaDCDsTeArpbD7/5NIpin
	ip3mmaO2oFC4VRwpC3lxovmPfyKypGPLtrGuvErnQJ68s0oA5zs2ESFplKhts0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aClBog
	7MHsPDU79v0f+juSgMEX8Bs1EScQbCHiE3nxWuFhFGi8142DVYeJL9RhFG043e6Y
	AT1yfTKXEqfx5HKqRMOBR8gp3pPL6sizEJDPFrDYShYWQUTogpXwN0AN92Hiuqyb
	jKScvgEEIsNkca/Zvfs9qRCQobr8fa5SGf47w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C09292ADF3;
	Thu, 17 Jul 2014 14:03:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C20E42ADE9;
	Thu, 17 Jul 2014 14:03:17 -0400 (EDT)
In-Reply-To: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 17
 Jul 2014 19:45:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A14C9250-0DDC-11E4-BA1C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253764>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This array 'cwd' is used to store the result from getcwd() and chdir(=
)
> back. PATH_MAX is the right constant for the job. On systems with
> longer PATH_MAX (eg. 4096 on Linux), hard coding 1024 fails stuff,
> e.g. "git init". Make it static too to reduce stack usage.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.  It seems that this 1024 has been with us since the
beginning of this piece of code.  I briefly wondered if there are
strange platform that will have PATH_MAX shorter than 1024 that will
be hurt by this change, but the result in cwd[] is used to grow the
final result bufs[] that is sized based on PATH_MAX anyway, so it
will not be an issue (besides, the absurdly short one seems to be
a different macro, MAX_PATH, on Windows).

Will queue.

>  abspath.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/abspath.c b/abspath.c
> index ca33558..c0c868f 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -41,7 +41,7 @@ static const char *real_path_internal(const char *p=
ath, int die_on_error)
>  	 * here so that we can chdir() back to it at the end of the
>  	 * function:
>  	 */
> -	char cwd[1024] =3D "";
> +	static char cwd[PATH_MAX];
> =20
>  	int buf_index =3D 1;
> =20
> @@ -49,6 +49,8 @@ static const char *real_path_internal(const char *p=
ath, int die_on_error)
>  	char *last_elem =3D NULL;
>  	struct stat st;
> =20
> +	*cwd =3D '\0';
> +
>  	/* We've already done it */
>  	if (path =3D=3D buf || path =3D=3D next_buf)
>  		return path;

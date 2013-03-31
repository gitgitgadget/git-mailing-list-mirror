From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v7 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Sun, 31 Mar 2013 15:41:28 +0100
Message-ID: <20130331144128.GE2286@serenity.lan>
References: <20130331133332.GD2286@serenity.lan>
 <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
 <51584914.500@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, trast@inf.ethz.ch
To: Sebastian =?iso-8859-1?Q?G=F6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 16:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMJSZ-0002UW-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 16:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab3CaOlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 10:41:39 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:53841 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267Ab3CaOli (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 10:41:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E8DDA161E2EE;
	Sun, 31 Mar 2013 15:41:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MbOqbp+mHUcS; Sun, 31 Mar 2013 15:41:37 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4B8E0161E396;
	Sun, 31 Mar 2013 15:41:30 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51584914.500@physik.tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219627>

On Sun, Mar 31, 2013 at 04:32:52PM +0200, Sebastian G=F6tte wrote:
>=20
> Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
> ---
>  commit.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/commit.c b/commit.c
> index eb645af..eda7f90 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1027,8 +1027,8 @@ static struct {
>  	char result;
>  	const char *check;
>  } sigcheck_gpg_status[] =3D {
> -	{ 'G', "\n[GNUPG:] GOODSIG " },
> -	{ 'B', "\n[GNUPG:] BADSIG " },
> +	{ 'G', "[GNUPG:] GOODSIG " },
> +	{ 'B', "[GNUPG:] BADSIG " },
>  };
> =20
>  static void parse_gpg_output(struct signature_check *sigc)
> @@ -1036,13 +1036,20 @@ static void parse_gpg_output(struct signature=
_check *sigc)
>  	const char *buf =3D sigc->gpg_status;
>  	int i;
> =20
> +	/* Iterate over all search strings */
>  	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> -		const char *found =3D strstr(buf, sigcheck_gpg_status[i].check);
> -		const char *next;
> -		if (!found)
> -			continue;
> +		const char *found, *next;
> +
> +		if (!prefixcmp(buf, sigcheck_gpg_status[i].check + 1)) {
> +			/* At the very beginning of the buffer */

This seems wrong.  You're losing the "\n" in front of the status string=
s
above but adding a special first line check skipping the first
character.  Surely it should be one of these changes or the other, not
both?

> +			found =3D buf + strlen(sigcheck_gpg_status[i].check + 1);
> +		} else {
> +			found =3D strstr(buf, sigcheck_gpg_status[i].check);
> +			if (!found)
> + 				continue;
> +			found +=3D strlen(sigcheck_gpg_status[i].check);
> +		}
>  		sigc->result =3D sigcheck_gpg_status[i].result;
> -		found +=3D strlen(sigcheck_gpg_status[i].check);
>  		sigc->key =3D xmemdupz(found, 16);
>  		found +=3D 17;
>  		next =3D strchrnul(found, '\n');
> --=20
> 1.8.1.5

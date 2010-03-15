From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Mon, 15 Mar 2010 19:16:06 +0100
Message-ID: <4B9E7966.4060300@lsrfire.ath.cx>
References: <cover.1268664693.git.grubba@grubba.org> <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?IkhlbnJpayBHcnViYnN0csO2bSAoR3J1YmJhKSI=?= 
	<grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 15 19:16:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrEps-0003cq-TB
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965611Ab0COSQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 14:16:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:52283 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965596Ab0COSQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 14:16:10 -0400
Received: from [10.0.1.100] (p57B7CEE7.dip.t-dialin.net [87.183.206.231])
	by india601.server4you.de (Postfix) with ESMTPSA id 780042F804E;
	Mon, 15 Mar 2010 19:16:08 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142237>

Am 15.03.2010 16:30, schrieb Henrik Grubbstr=C3=B6m (Grubba):
> The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
> of source text if the terminating $ was lost. It now refuses to
> contract $Id:xxxxx$ strings spanning multiple lines.
>=20
> Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
> ---
> The behaviour implemented by the patch is in line with what other
> VCSes that implement $Id$ do.
>=20
>  convert.c             |   17 +++++++++++++++--
>  t/t0021-conversion.sh |   16 ++++++++++------
>  2 files changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index 4f8fcb7..91207ab 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -425,6 +425,7 @@ static int count_ident(const char *cp, unsigned l=
ong size)
>  				cnt++;
>  				break;
>  			}
> +			if (ch =3D=3D '\n') break;

Style:

			if (ch =3D=3D '\n')
				break;

>  		}
>  	}
>  	return cnt;
> @@ -433,7 +434,7 @@ static int count_ident(const char *cp, unsigned l=
ong size)
>  static int ident_to_git(const char *path, const char *src, size_t le=
n,
>                          struct strbuf *buf, int ident)
>  {
> -	char *dst, *dollar;
> +	char *dst, *dollar, *nl;
> =20
>  	if (!ident || !count_ident(src, len))
>  		return 0;
> @@ -455,6 +456,12 @@ static int ident_to_git(const char *path, const =
char *src, size_t len,
>  			dollar =3D memchr(src + 3, '$', len - 3);
>  			if (!dollar)
>  				break;
> +			nl =3D memchr(src + 3, '\n', len - 3);
> +			if (nl && nl < dollar) {
> +				/* Line break before the next dollar. */
> +				continue;
> +			}
> +

You only need to search up to the previously found dollar sign here:

			if (memchr(src + 3, '\n', dollar - src - 3))
				continue;

>  			memcpy(dst, "Id$", 3);
>  			dst +=3D 3;
>  			len -=3D dollar + 1 - src;
> @@ -470,7 +477,7 @@ static int ident_to_worktree(const char *path, co=
nst char *src, size_t len,
>                               struct strbuf *buf, int ident)
>  {
>  	unsigned char sha1[20];
> -	char *to_free =3D NULL, *dollar;
> +	char *to_free =3D NULL, *dollar, *nl;
>  	int cnt;
> =20
>  	if (!ident)
> @@ -514,6 +521,12 @@ static int ident_to_worktree(const char *path, c=
onst char *src, size_t len,
>  				break;
>  			}
> =20
> +			nl =3D memchr(src + 3, '\n', len - 3);
> +			if (nl && nl < dollar) {
> +				/* Line break before the next dollar. */
> +				continue;
> +			}
> +

Ditto.

Ren=C3=A9

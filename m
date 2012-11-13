From: =?UTF-8?B?IkphbiBILiBTY2jDtm5oZXJyIg==?= <schnhrr@cs.tu-berlin.de>
Subject: Re: [PATCH nd/wildmatch] Correct Git's version of isprint and isspace
Date: Tue, 13 Nov 2012 19:58:46 +0100
Message-ID: <50A29866.1070700@cs.tu-berlin.de>
References: <507E9FDE.7080706@cs.tu-berlin.de> <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	rene.scharfe@lsrfire.ath.cx
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYLhe-0001jl-P4
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab2KMS7D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 13:59:03 -0500
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:34581 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab2KMS7B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:59:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 26DE0614A
	for <git@vger.kernel.org>; Tue, 13 Nov 2012 19:58:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id khd2znm703E2 05064-16;
	Tue, 13 Nov 2012 19:58:47 +0100 (CET) 13595
Received: from [130.149.91.59] (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Tue, 13 Nov 2012 19:58:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120919 Thunderbird/10.0.7
In-Reply-To: <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209657>

Hi.

Am 13.11.2012 11:46, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> Git's ispace does not include 11 and 12. Git's isprint includes
> control space characters (10-13). According to glibc-2.14.1 on C
> locale on Linux, this is wrong. This patch fixes it.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I wrote a small C program to compare the result of all is* functions
>  that Git replaces against the libc version. These are the only ones =
that
>  differ. Which matches what Jan Sch=C3=B6nherr commented.
>=20
>  ctype.c           |  6 +++---
>  git-compat-util.h | 11 ++++++-----
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/ctype.c b/ctype.c
> index 0bfebb4..71311a3 100644
> --- a/ctype.c
> +++ b/ctype.c
> @@ -14,11 +14,11 @@ enum {
>  	P =3D GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
>  	X =3D GIT_CNTRL,
>  	U =3D GIT_PUNCT,
> -	Z =3D GIT_CNTRL | GIT_SPACE
> +	Z =3D GIT_CNTRL_SPACE
>  };
> =20
> -const unsigned char sane_ctype[256] =3D {
> -	X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,		/*   0.. 15 */
> +const unsigned int sane_ctype[256] =3D {
> +	X, X, X, X, X, X, X, X, X, Z, Z, Z, Z, Z, X, X,		/*   0.. 15 */
>  	X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,		/*  16.. 31 */
>  	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
>  	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */

An alternative to switching from 1-byte to 4-byte values (don't we have
a 2-byte datatype?), would be to free up GIT_CNTRL and simply do:

#define iscntrl(x) ((x) < 0x20)


> diff --git a/git-compat-util.h b/git-compat-util.h
> index 02f48f6..4ed3f94 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
[...]
> @@ -483,9 +483,10 @@ extern const unsigned char sane_ctype[256];
>  #define GIT_PATHSPEC_MAGIC 0x20
>  #define GIT_CNTRL 0x40
>  #define GIT_PUNCT 0x80
> -#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask=
)) !=3D 0)
> +#define GIT_SPACE 0x100
> +#define sane_istest(x,mask) ((sane_ctype[(unsigned int)(x)] & (mask)=
) !=3D 0)

That should better be left "(unsigned char)"? We might access values af=
ter the
array otherwise.

(That said, it wasn't really correct before either, when there really i=
s a
possibility that x >=3D 0x100.)

Regards
Jan

PS: It looks like my isprint() version was given precedence over your
isprint() version during the merge into next. That should also be sorte=
d out,
but I've no idea which one is actually better: two comparisons versus o=
ne
cache lookup and a bitop... (though my guess is that comparisons are ch=
eaper,
but then we should also convert isdigit()...)

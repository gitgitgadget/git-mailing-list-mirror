From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Do not decode url protocol.
Date: Thu, 24 Jun 2010 01:54:08 +0200
Message-ID: <4C229EA0.6010904@lsrfire.ath.cx>
References: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 01:54:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORZm2-0000ed-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 01:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab0FWXyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 19:54:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:35458 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0FWXyY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 19:54:24 -0400
Received: from [10.0.1.100] (p57B7CAFD.dip.t-dialin.net [87.183.202.253])
	by india601.server4you.de (Postfix) with ESMTPSA id 039C52F804A;
	Thu, 24 Jun 2010 01:54:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149557>

Am 22.06.2010 11:25, schrieb Pascal Obry:
> Same patch with fixed formatting. Sorry.
>=20
> When using the protocol git+ssh:// for example we do not want to
> decode the '+' as a space.
>=20
> This fixes a regression introduced in 9d2e942.
> ---
>  url.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/url.c b/url.c
> index cd32b92..94a42a5 100644
> --- a/url.c
> +++ b/url.c
> @@ -70,9 +70,18 @@ static int url_decode_char(const char *q)
>  static char *url_decode_internal(const char **query, const char *sto=
p_at)
>  {
>  	const char *q =3D *query;
> +	const char *first_slash;
>  	struct strbuf out;
>=20
>  	strbuf_init(&out, 16);
> +
> +	/* Skip protocol. */
> +	first_slash =3D strchr(*query, '/');
> +
> +	while (q < first_slash) {
> +		strbuf_addch(&out, *q++);
> +	}
> +
>  	do {
>  		unsigned char c =3D *q;
>=20

The protocol in an URL is followed by a colon and technically a slash
doesn't have to be part of it at all.  While in practise all URL scheme=
s
used by git have two slashes following the colon, it's just as easy to
be more correct and search for ':' instead of '/' here.

And you can use strbuf_add() instead of the while loop because you know
how many characters to copy.

Ren=E9

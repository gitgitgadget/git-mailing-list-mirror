From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] speed: reuse char instead of recreation in loop
Date: Mon, 25 May 2009 22:39:05 +0200
Message-ID: <4A1B01E9.30601@lsrfire.ath.cx>
References: <pan.2009.05.25.19.44.10@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Spura <tomspur@fedoraproject.org>
X-From: git-owner@vger.kernel.org Mon May 25 22:39:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8gxI-0003r8-9l
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 22:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZEYUjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 16:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZEYUjR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 16:39:17 -0400
Received: from india601.server4you.de ([85.25.151.105]:55007 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbZEYUjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 16:39:17 -0400
Received: from [10.0.1.101] (p57B7E11B.dip.t-dialin.net [87.183.225.27])
	by india601.server4you.de (Postfix) with ESMTPSA id 9496D2F805B;
	Mon, 25 May 2009 22:39:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <pan.2009.05.25.19.44.10@fedoraproject.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119962>

Thomas Spura schrieb:
> Move a char and a char * outside of a for loop for speed improvements

It's a good idea to include actual timings, to give the reader a better
idea what operation is sped up and by how much.

> Signed-off-by: Thomas Spura <tomspur@fedoraproject.org>
> ---
> Comments?
>=20
>  transport.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/transport.c b/transport.c
> index 17891d5..e350937 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -263,11 +263,10 @@ static int write_refs_to_temp_dir(struct strbuf=
=20
> *temp_dir,

Please turn off automatic line wrapping in your email program when
sending patches (at least for the patch part).

>  		int refspec_nr, const char **refspec)
>  {
>  	int i;
> +	unsigned char sha1[20];
> +	char *ref;
> =20
>  	for (i =3D 0; i < refspec_nr; i++) {
> -		unsigned char sha1[20];
> -		char *ref;
> -

I wouldn't expect this to significantly change the object code.
Declaring variables in as narrow a scope as possible often helps to mak=
e
the code more readable, though.  write_refs_to_temp_dir() is short
enough, so it doesn't matter in this case, though.

>  		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) !
> =3D 1)
>  			return error("Could not get ref %s", refspec[i]);
> =20
> @@ -275,8 +274,8 @@ static int write_refs_to_temp_dir(struct strbuf=20
> *temp_dir,
>  			free(ref);
>  			return -1;
>  		}
> -		free(ref);
>  	}
> +	free(ref);
>  	return 0;
>  }

This introduces a memory leak.  The string pointed to by ref is
allocated by dwim_ref() and needs to be free()'d after use, and -- more
importantly -- before ref is assigned its next value by dwim_ref().

Ren=C3=A9

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fix crash in path.c on Windows
Date: Thu, 05 Feb 2009 08:57:53 +0100
Message-ID: <498A9C01.6020602@viscovery.net>
References: <498A1E1E.8010901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:59:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUz92-00082n-3W
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbZBEH6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 02:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZBEH6E
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:58:04 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23703 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbZBEH6D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 02:58:03 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUz7S-00031V-19; Thu, 05 Feb 2009 08:57:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C42B369F; Thu,  5 Feb 2009 08:57:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <498A1E1E.8010901@lsrfire.ath.cx>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108519>

Ren=E9 Scharfe schrieb:
> 	set a=3D	getenv("a")
> 	=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	c	c
> 	/c	c:/
> 	c/	c/
> 	/c/	c:/
> 	c:c	c:c
> 	/c:c	c:c
> 	c:/c	c:/c
> 	/c:/c	c:/c
> 	c/:/c	c\;c:\
> 	/c:c/	c:c/
> 	/c/:c	/c/:c
> 	/c/:/c	c:\;c:\
> 	/c:/c/	c:/c/
> 	/c/:/c/	c:\;c:\

Bash translates leading single-letter path components to drive prefix
notation if it invokes a non-MSYS program; and it also translates ':' t=
o
';' if the value looks like a path list. Sometimes there is an ambiguit=
y
and bash guesses wrong.

> @@ -387,7 +387,7 @@ int normalize_absolute_path(char *buf, const char=
 *path)
>  	assert(path);
> =20
>  	while (*comp_start) {
> -		assert(*comp_start =3D=3D '/');
> +		assert(is_absolute_path(comp_start));
>  		while (*++comp_end && *comp_end !=3D '/')
>  			; /* nothing */
>  		comp_len =3D comp_end - comp_start;

Junio has pointed out your thinko here. Furthermore, *all* uses of '/' =
in
this loop must be replaced by is_dir_sep().

But I would really appreciate if you could unify normalize_absolute_pat=
h()
with setup.c's sanitary_path_copy() because they do almost the same thi=
ng
(and the latter already works on Windows).

> @@ -438,11 +438,20 @@ int longest_ancestor_length(const char *path, c=
onst char *prefix_list)
>  		return -1;
> =20
>  	for (colon =3D ceil =3D prefix_list; *colon; ceil =3D colon+1) {
> -		for (colon =3D ceil; *colon && *colon !=3D ':'; colon++);
> +		for (colon =3D ceil; *colon && *colon !=3D PATH_SEP; colon++);
>  		len =3D colon - ceil;
>  		if (len =3D=3D 0 || len > PATH_MAX || !is_absolute_path(ceil))
>  			continue;
>  		strlcpy(buf, ceil, len+1);
> +
> +		if (has_dos_drive_prefix(buf)) {
> +			char *p;
> +			for (p =3D buf; *p; p++) {
> +				if (*p =3D=3D '\\')
> +					*p =3D '/';
> +			}

IMNSHO this is a kind of normalization and, therefore, must be done by
normalize_absolute_path() (sanitary_path_copy() already does this).

> +		}
> +
>  		len =3D normalize_absolute_path(buf, buf);
>  		/* Strip "trailing slashes" from "/". */
>  		if (len =3D=3D 1)

-- Hannes

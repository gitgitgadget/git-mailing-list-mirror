From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] git-tar-tree: Move code for git-archive --format=tar
 to archive-tar.c
Date: Mon, 25 Sep 2006 00:19:59 +0200
Message-ID: <4517048F.9040007@lsrfire.ath.cx>
References: <4516A4BE.9090406@lsrfire.ath.cx> <7vr6y16iyk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 00:20:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRcKV-0006nS-7O
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 00:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWIXWUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 18:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWIXWUD
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 18:20:03 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44196
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751253AbWIXWUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 18:20:01 -0400
Received: from [10.0.1.3] (p508E7663.dip.t-dialin.net [80.142.118.99])
	by neapel230.server4you.de (Postfix) with ESMTP id A190115005;
	Mon, 25 Sep 2006 00:19:59 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6y16iyk.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27704>

Junio C Hamano schrieb:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> This patch doesn't change any functionality, it only moves code arou=
nd.  It
>> makes seeing the few remaining lines of git-tar-tree code easier. ;-=
)
>>
>> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>=20
> Thanks.  And here is an obvious follow-up to it.
>=20
> -- >8 --
> [PATCH] Remove upload-tar and make git-tar-tree a thin wrapper to git=
-archive

OK.

> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index aa370e3..5d2bec0 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -8,94 +8,66 @@ #include "tar.h"
>  #include "builtin.h"
>  #include "pkt-line.h"
>  #include "archive.h"

At least the last two header references aren't needed any more.

> -	if (argc =3D=3D 3) {
> -		int baselen =3D strlen(argv[2]);
> -		base =3D xmalloc(baselen + 2);
> -		memcpy(base, argv[2], baselen);
> -		base[baselen] =3D '/';
> -		base[baselen + 1] =3D '\0';
[...]
> +	case 3:
> +		/* base-path */=20
> +		basedir_arg =3D xmalloc(strlen(argv[2]) + 10);
> +		sprintf(basedir_arg, "--prefix=3D%s", argv[2]);
> +		nargv[nargc++] =3D basedir_arg;

Traditionally we always added a slash to the git-tar-tree base
parameter, forcing it to always be a base _directory_.  git-archive
in contrast to that simply adds the prefix to the paths; users have
to provide their own slash.  This is consistent with how we handle
--prefix parameters elsewhere.  It also means that the sprintf
format string here should be "--prefix=3D%s/" (and allocate one more
byte the line before).

> +	fprintf(stderr,
> +		"*** git-tar-tree is now deprecated.\n"
> +		"*** Running git-archive instead.\n***");
> +	for (i =3D 0; i < nargc; i++) {
> +		fputc(' ', stderr);
> +		sq_quote_print(stderr, nargv[i]);
> +	}
> +	fputc('\n', stderr);

Hey, scary message. ;-)  It certainly will aid the re-education of
our users, so I think it's OK.

Thanks,
Ren=E9

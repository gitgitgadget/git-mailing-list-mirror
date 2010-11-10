From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Wed, 10 Nov 2010 18:17:50 +0100
Message-ID: <vpq39r9m729.fsf@bauges.imag.fr>
References: <m3eiatfbg2.fsf@localhost.localdomain>
	<1289407021-30287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, gitster@pobox.com, peff@peff.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 18:26:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGERe-0007yw-Dx
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257Ab0KJR0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 12:26:36 -0500
Received: from mx2.imag.fr ([129.88.30.17]:40550 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab0KJR0g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 12:26:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oAAHAws7003084
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 10 Nov 2010 18:10:59 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PGEIx-0003uX-3h; Wed, 10 Nov 2010 18:17:51 +0100
In-Reply-To: <1289407021-30287-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 10
 Nov 2010 23\:37\:01 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Nov 2010 18:11:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAAHAws7003084
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1290013864.11182@AwwMUHMjdYyWykjku1dIGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161163>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Currently :path and ref:path can be used to refer to a specific objec=
t
> in index or ref respectively. "path" component is absolute path. This
> patch allows "path" to be written as "./path" or "../path", which is
> relative to user's original cwd.
>
> This does not work in commands that startup_info is NULL

Grammar: shouldn't it be "commands for which startup_info is NULL"?

> (i.e. non-builtin ones).

Does that include "git show"? That's probably the most common use-case
for the <object>:<path> syntax, perhaps worth mentionning here.

Also, what happens when it doesn't work? I guess it falls back to the
previous behavior, which tries to do a detailed diagnosis and provides
a general error message. But probably the error messages should be
reworded to include "syntax not supported by this command" or so,
'cause it's really weird for a user to be able to say HEAD:./foo in
some places and not in others.

>  The idea is old although I don't remember if anybody has made any
>  attempt to realize it: use './' and '../' to specify the given path
>  is relative, not absolute.

I gave it a try, but I was not aware of the startup_info thing, and
tried passing more arguments to get_sha1*, and you can guess I quickly
gave up ;-).

> +			if (startup_info && cp[0] =3D=3D '.' &&
> +			    (cp[1] =3D=3D '/' || (cp[1] =3D=3D '.' && cp[2] =3D=3D '/')))=
 {

Nothing performance-critical here, so I'd rather have something more
readable, like

startup_info && (!prefixcmp(cp, "./") || !prefixcmp(cp, "../"))


> +				new_path =3D prefix_path(startup_info->prefix,
> +						       strlen(startup_info->prefix),
> +						       cp);

free(cp); here?

> +				cp =3D new_path;
> +			}
> +		}

> @@ -1122,6 +1134,17 @@ int get_sha1_with_context_1(const char *name, =
unsigned char *sha1,
>  		}
>  		if (!get_sha1_1(name, cp-name, tree_sha1)) {
>  			const char *filename =3D cp+1;
> +			char *new_filename =3D NULL;
> +
> +			if (startup_info &&
> +			    filename[0] =3D=3D '.' &&
> +			    (filename[1] =3D=3D '/' ||
> +			     (filename[1] =3D=3D '.' && filename[2] =3D=3D '/'))) {
> +				new_filename =3D prefix_path(startup_info->prefix,
> +							   strlen(startup_info->prefix),
> +							   filename);

Same 2 questions as above.

Also, that would be nice is this came with a testcase :-)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

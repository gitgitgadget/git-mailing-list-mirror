From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/4] sha1_name: add get_sha1_with_context()
Date: Tue, 08 Jun 2010 19:57:58 +0200
Message-ID: <vpqiq5t5rvd.fsf@bauges.imag.fr>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
	<1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: =?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 08 19:58:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM33x-0003mG-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 19:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab0FHR6D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 13:58:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55811 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725Ab0FHR6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 13:58:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o58HoGBg000555
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Jun 2010 19:50:16 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OM33m-0006cC-V2; Tue, 08 Jun 2010 19:57:59 +0200
In-Reply-To: <1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
 (=?iso-8859-1?Q?=22Cl=E9ment?= Poulain"'s message of "Tue\,  8 Jun 2010
 15\:49\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 08 Jun 2010 19:50:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o58HoGBg000555
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148697>

This patch produces uncompilable code for me:

cc1: warnings being treated as errors
In file included from builtin.h:6,
                 from fast-import.c:147:
cache.h: In function =E2=80=98get_sha1_with_context=E2=80=99:
cache.h:748: error: implicit declaration of function =E2=80=98get_sha1_=
with_context_1=E2=80=99

=46orgot to add get_sha1_with_context_1 to cache.h?

Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> +struct object_context {
> +	unsigned char tree[20];
> +	char path[PATH_MAX];
> +	unsigned mode;
> +};
> +#define OBJECT_CONTEXT_INIT  { 0, 0, 0 }
> +

I'm not an expert in struct initializers, but after doing experiments
with GCC, this raises a warning

builtin/cat-file.c:90: error: missing braces around initializer
builtin/cat-file.c:90: error: (near initialization for =E2=80=98obj_con=
text.tree=E2=80=99)

and the behavior is to flatten the arrays contained inside the
structure. So, your OBJECT_CONTEXT_INIT initializes the 3 first bytes
of tree to 0, and leaves other fields uninitialized.

You probably want something like this instead if you want to
initialize the whole struct:

{{0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=20
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, "", 0}

> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -933,8 +933,8 @@ int interpret_branch_name(const char *name, struc=
t strbuf *buf)
>   */
>  int get_sha1(const char *name, unsigned char *sha1)
>  {
> -	unsigned unused;
> -	return get_sha1_with_mode(name, sha1, &unused);
> +	struct object_context unused;
> +	return get_sha1_with_context(name, sha1, &unused);
>  }

This changes doesn't seem harmful, but it doesn't seem useful to me
either: get_sha1_with_mode still exists, right?

>  int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsi=
gned *mode, int gently, const char *prefix)
>  {
> +	struct object_context orc;

What does orc stand for? I understand "oc" for "object context", but
I'm curious about the r ;-).

> +		orc->path[sizeof(orc->path)] =3D '\0';
> +

Isn't this an off-by-one? The last element of an array of size N is
array[N-1] ...

> +			orc->path[sizeof(orc->path)] =3D '\0';

Same here.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

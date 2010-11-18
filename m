From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
	create '//etc/.git/index.lock': No such file or directory
Date: Thu, 18 Nov 2010 21:36:17 +0100
Message-ID: <20101118203617.GH22067@login.drsnuggles.stderr.nl>
References: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com> <20101117112042.GX22067@login.drsnuggles.stderr.nl> <20101118155211.GE22067@login.drsnuggles.stderr.nl> <AANLkTi=mf_1HaJ0qZJ4nG1=zti9CJdTZHAfhLayR4FRS@mail.gmail.com> <AANLkTin6vir9UT9c4-9ArNvFHNdHiDiXMtXKRUMoExho@mail.gmail.com> <20101118171751.GG22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rZmXUR44+r3t6Ir8"
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Nov 18 21:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJBDW-00013r-8b
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 21:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760238Ab0KRUgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 15:36:21 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:33879 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760237Ab0KRUgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 15:36:20 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PJBDN-0006pi-AK; Thu, 18 Nov 2010 21:36:18 +0100
Received: (nullmailer pid 26265 invoked by uid 1000);
	Thu, 18 Nov 2010 20:36:17 -0000
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
Content-Disposition: inline
In-Reply-To: <20101118171751.GG22067@login.drsnuggles.stderr.nl>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161710>


--rZmXUR44+r3t6Ir8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

> > I think 490544b (get_cwd_relative(): do not misinterpret suffix as
> > subdirectory - 2010-05-22) causes it. Haven't fully understood what's
> > going on in that function though :P
> Seems you're right. I just reverted this commit and the problem seems to
> go away.
A bit more gdb'ing with -O0, I found the following. get_cwd_relative is
called with dir=3D"/". The cwd is "/etc". The stack looks like:

#0  get_relative_cwd (buffer=3D0x7a44c0 "/etc", size=3D4096, dir=3D0x7b1041=
 "") at dir.c:961
#1  0x00000000004dfdf1 in setup_git_directory () at setup.c:612
#2  0x0000000000404f69 in run_builtin (p=3D0x75ea10, argc=3D2, argv=3D0x7ff=
fffffc918) at git.c:257
#3  0x00000000004051e3 in handle_internal_command (argc=3D2, argv=3D0x7ffff=
fffc918) at git.c:431
#4  0x000000000040538a in main (argc=3D2, argv=3D0x7fffffffc918) at git.c:5=
16

After the following code runs:

    while (*dir && *dir =3D=3D *cwd) {
	    dir++;=20
	    cwd++;
    }

I have dir=3D"" and cwd=3D"etc". Then the following code runs:

    switch (*cwd) {
    case '\0':
	    return cwd;
    case '/':
	    return cwd + 1;
    default:
	    return NULL;
    }

Since *cwd=3D'e', it returns NULL.

The old code (before 490544b) was:

   if (*cwd =3D=3D '/')
	   return cwd + 1;
   return cwd;

So this would return "etc".


So, that's what is happens. I think this happens because
get_relative_cwd expects dir to not contain a trailing slash. Normally,
there is no trailing slash, but in the special case of dir=3D"/" there is
(sort of) a trailing slash.

I'm not completely sure how to fix this. Looking at 72ec8ba (Support
working directory located at root - 2010-02-14), perhaps something like
this?

diff --git a/dir.c b/dir.c
index d1e5e5e..5408db9 100644
--- a/dir.c
+++ b/dir.c
@@ -943,6 +943,7 @@ int file_exists(const char *f)
 char *get_relative_cwd(char *buffer, int size, const char *dir)
 {
        char *cwd =3D buffer;
+       size_t len, root_len;
=20
        if (!dir)
                return NULL;
@@ -952,6 +953,15 @@ char *get_relative_cwd(char *buffer, int size, const c=
har *dir)
        if (!is_absolute_path(dir))
                dir =3D make_absolute_path(dir);
=20
+       len =3D strlen(dir);
+       root_len =3D offset_1st_component(dir);
+
+       if (root_len >=3D len) {
+           /* dir is the filesystem root, so the cwd is always inside */
+           root_len =3D offset_1st_component(cwd);
+           return cwd + root_len;
+       }
+
        while (*dir && *dir =3D=3D *cwd) {
                dir++;
                cwd++;

I'm not sure how this stuff really works, though. I think this works for *n=
ix,
but I'm unsure about Windows.

Gr.

Matthijs

--rZmXUR44+r3t6Ir8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzljkEACgkQz0nQ5oovr7xipgCgwx7NqOCaPo6vyptoPSRATinv
L+gAn35BNvjlMY3QMLzCV4z5d1OUP0FN
=t/Ax
-----END PGP SIGNATURE-----

--rZmXUR44+r3t6Ir8--

From: Joey Hess <joey@kitenet.net>
Subject: bug: git merge --no-commit loses track of file modes in the index
Date: Thu, 12 Jun 2014 21:38:58 -0400
Message-ID: <20140613013858.GA28485@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 03:47:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvGa7-0008J3-5b
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 03:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbaFMBq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 21:46:59 -0400
Received: from wren.kitenet.net ([80.68.85.49]:33733 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbaFMBq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 21:46:58 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2014 21:46:58 EDT
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id D201C3071BA; Thu, 12 Jun 2014 22:38:58 -0300 (BRT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251511>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If git merge --no-commit is used to merge a commit adding a=20
file with an unusual mode -- specifically a symlink which has "mode" 120000,
it fails to stage the right mode into the index.

This only happens when core.symlinks=3Dfalse. I noticed it on FAT, but
have managed to reproduce it on ext4.

Here's an example of the bug:

joey@darkstar:~>git clone r1 r2
Cloning into 'r2'...
done.
joey@darkstar:~>cd r1
joey@darkstar:~/r1>ls -l
total 0
lrwxrwxrwx 1 joey joey 11 Jun 12 21:23 foo -> /etc/passwd
joey@darkstar:~/r1>git mv foo bar
joey@darkstar:~/r1>git commit -m moved
[master 516a53c] moved
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename foo =3D> bar (100%)
joey@darkstar:~/r1>cd ..
joey@darkstar:~>cd r2
joey@darkstar:~/r2>git config core.symlinks false
joey@darkstar:~/r2>git fetch origin
remote: Counting objects: 2, done.
remote: Total 2 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (2/2), done.
=46rom /home/joey/r1
   7ab8102..516a53c  master     -> origin/master
joey@darkstar:~/r2>git merge origin/master --no-commit --no-ff
Automatic merge went well; stopped before committing as requested
joey@darkstar:~/r2>git diff --cached
diff --git a/bar b/bar
new file mode 100644
index 0000000..3594e94
--- /dev/null
+++ b/bar
@@ -0,0 +1 @@
+/etc/passwd
\ No newline at end of file
diff --git a/foo b/foo
deleted file mode 120000
index 3594e94..0000000
--- a/foo
+++ /dev/null
@@ -1 +0,0 @@
-/etc/passwd
\ No newline at end of file
joey@darkstar:~/r2>git commit -m oops
[master 63bd960] oops
joey@darkstar:~/r2>git show
commit 63bd9608c96a91582b27c5853ff58053bab6c71c
Merge: 7ab8102 516a53c
Author: Joey Hess <joey@kitenet.net>
Date:   Thu Jun 12 21:37:35 2014 -0400

    oops

diff --cc bar
index 0000000,3594e94..3594e94
mode 000000,120000..100644
--- a/bar
+++ b/bar

joey@darkstar:~/r2>git version
git version 2.0.0

--=20
see shy jo

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBU5pWMMkQ2SIlEuPHAQJn6Q/+KjHkjm4wkSX/SYd78kdY0ztVr2+Wfs4L
ZY2knPUb+rjyvkyq+lYTlSEb3aQR7Te+Y9aupeU8CloDKhULSE4MzJee1AAaJDeB
B5iuFCiPSpDpVjaMPLnPPvWL9P/a8AdVlzPxAwJGEbnj8lZXBlYoYJQkb8+iBO95
1yCb+Q7Hd0AIxgHVPmnY8cfl7wkz493Bcs+PnECWfATTZ3CCZJ7rpz1VstHk583C
yWazGGNYYN9rmywe3DqwfV2MgXlpnA7VlCqY69ITOtGHFUEsKvVjoBle3Se1nvU+
bkcrXqNr3WX+NJ4ABfrjy1NTFz/SsTR86dF/yyfViF5K2URKbm2r2umYsPo5Barf
YYuSv68rJy137dWz7zfYfFd/PwGUuoshfEZaWbMXgCNQDHq2MsyNHz0vd0VGL36L
OZUTmOEYxwlbZwv0+D7T8W6V5Jy9q3Lj/FVaKaD86KgxzGXi8dcHyhVscuuqOu0p
p7lhm1294NLltCBt/jESOzS8i7wU9q+44uQp7VX15HJGxE04xDd2KGZEJX9lAaF6
eALqlLHi7fj9lIMQ+Go8m/SNhL/pQ0lqWtu9pTDGu8ybaJk00cnirbKYKoFVBSpL
kseB0VHwPpoYgMK/W+YvVhIBbSnpR+lVAVqhieaFj++kwmGkLYu6SkiobcoH0t+8
RxXpmXcjQXc=
=JqHE
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

From: "L. A. Linden Levy" <alevy@mobitv.com>
Subject: git-p4.skipSubmitEdit
Date: Thu, 08 Sep 2011 13:40:52 -0700
Organization: MobiTV
Message-ID: <1315514452.10046.0.camel@uncle-pecos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-i1OnQISycCSCsUmJO7Nu"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 02:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1pNE-0007qs-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 02:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab1IIAzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 20:55:11 -0400
Received: from mxout.myoutlookonline.com ([64.95.72.241]:5509 "EHLO
	mxout.myoutlookonline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248Ab1IIAzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 20:55:09 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Sep 2011 20:55:09 EDT
Received: from mxout.myoutlookonline.com (localhost [127.0.0.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id 0BBB4416EAC
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:41:06 -0400 (EDT)
X-Virus-Scanned: by SpamTitan at mail.lan
Received: from mx1.myoutlookonline.com (unknown [10.110.2.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id B7C7E416E30
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:40:54 -0400 (EDT)
Received: from mx1.myoutlookonline.com ([10.9.36.14]) by mx1.myoutlookonline.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Sep 2011 16:40:54 -0400
Received: from [172.16.131.153] ([75.55.199.5]) by mx1.myoutlookonline.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Sep 2011 16:40:27 -0400
X-Mailer: Evolution 2.32.2 
X-OriginalArrivalTime: 08 Sep 2011 20:40:27.0778 (UTC) FILETIME=[8AE3E620:01CC6E67]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181012>


--=-i1OnQISycCSCsUmJO7Nu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

I have been using git-p4 for a while and it has allowed me to completely
change the way I develop and still be able to use perforce which my
company has for its main VCS. One thing that was driving me nuts was
that "git p4 submit" cycles through all of my individual commits and
asks me if I want to change them. The way I develop I often am checking
in 20 to 50 different small commits each with a descriptive git comment.
I felt like I was doing double duty by having emacs open on every commit
into perforce. So I modified git-p4 to have an option to skip the
editor. This option coupled with git-p4.skipSubmitEditCheck will make
the submission non-interactive for "git p4 submit".

Below are the patch and environment results:


$ git config -l
...
user.name=3DLoren A. Linden Levy
git-p4.skipsubmitedit=3Dtrue
git-p4.skipsubmiteditcheck=3Dtrue
...

$ git format-patch origin/master --stdout

=46rom 16c4344de0047cbaf3381eca590a3e59b0d0a25c Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Thu, 8 Sep 2011 13:37:22 -0700
Subject: [PATCH] changed git-p4

---
 contrib/fast-import/git-p4 |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2f7b270..a438b3e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -935,18 +935,23 @@ class P4Submit(Command, P4UserMap):
             tmpFile.write(submitTemplate + separatorLine + diff +
newdiff)
             tmpFile.close()
             mtime =3D os.stat(fileName).st_mtime
-            if os.environ.has_key("P4EDITOR"):
-                editor =3D os.environ.get("P4EDITOR")
+            if gitConfig("git-p4.skipSubmitEdit") =3D=3D "true":
+                pass
             else:
-                editor =3D read_pipe("git var GIT_EDITOR").strip()
-            system(editor + " " + fileName)
-
+                if os.environ.has_key("P4EDITOR"):
+                    editor =3D os.environ.get("P4EDITOR")
+                else:
+                    editor =3D read_pipe("git var GIT_EDITOR").strip()
+                   =20
+                    system(editor + " " + fileName)
+                   =20
             if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
                 checkModTime =3D False
             else:
                 checkModTime =3D True
=20
             response =3D "y"
+
             if checkModTime and (os.stat(fileName).st_mtime <=3D mtime):
                 response =3D "x"
                 while response !=3D "y" and response !=3D "n":
--=20
1.7.6.347.g4db0d


--=20
Alex Linden Levy
Senior Software Engineer
MobiTV, Inc.
6425 Christie Avenue, 5th Floor, Emeryville, CA 94608
phone 510.450.5190 mobile 720.352.8394
email alevy@mobitv.com  web www.mobitv.com



--=-i1OnQISycCSCsUmJO7Nu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5pKFAACgkQlZX6YS+3ZkvexgCcCmH/cb72gW8ygQPp6o1qpuXb
ioAAnjMx83F0bA3IUam3rZ5U+5qiN8m6
=gW6G
-----END PGP SIGNATURE-----

--=-i1OnQISycCSCsUmJO7Nu--

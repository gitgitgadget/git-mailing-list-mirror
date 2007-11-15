From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Fix direct import from perforce after fetching changes through git from origin
Date: Thu, 15 Nov 2007 10:38:45 +0100
Message-ID: <200711151038.45668.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3738413.sFNXqf41DV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 10:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsbC0-0006mc-AZ
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761744AbXKOJjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 04:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761902AbXKOJjE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:39:04 -0500
Received: from verein.lst.de ([213.95.11.210]:39711 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761744AbXKOJjB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 04:39:01 -0500
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id lAF9cnF3018246
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Thu, 15 Nov 2007 10:38:50 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65100>

--nextPart3738413.sFNXqf41DV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When using an existing git repository to cache the perforce import we don't=
 fetch the
branch mapping from perforce as that is a slow operation. However the origi=
n repository
may not be fully up-to-date and therefore it may be necessary to import mor=
e changes
directly from Perforce. Such a direct import needs self.knownBranches to be=
 set up though,
so initialize it from the existing p4/* git branches.

Signed-off-by: Simon Hausmann <simon@lst.de>
=2D--
 contrib/fast-import/git-p4 |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c148b5a..c869bb8 100755
=2D-- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1207,6 +1207,15 @@ class P4Sync(Command):
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] =3D branch
=20
+    def getBranchMappingFromGitBranches(self):
+        branches =3D p4BranchesInGit(self.importIntoRemotes)
+        for branch in branches.keys():
+            if branch =3D=3D "master":
+                branch =3D "main"
+            else:
+                branch =3D branch[len(self.projectName):]
+            self.knownBranches[branch] =3D branch
+
     def listExistingP4GitBranches(self):
         # branches holds mapping from name to commit
         branches =3D p4BranchesInGit(self.importIntoRemotes)
@@ -1541,8 +1550,10 @@ class P4Sync(Command):
             ## FIXME - what's a P4 projectName ?
             self.projectName =3D self.guessProjectName()
=20
=2D            if not self.hasOrigin:
=2D                self.getBranchMapping();
+            if self.hasOrigin:
+                self.getBranchMappingFromGitBranches()
+            else:
+                self.getBranchMapping()
             if self.verbose:
                 print "p4-git branches: %s" % self.p4BranchesInGit
                 print "initial parents: %s" % self.initialParents
=2D-=20
1.5.3.5.576.gfe6193


--nextPart3738413.sFNXqf41DV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHPBOlWXvMThJCpvIRAo+yAKCmidWfHzzjt6FTo7/WPb6/ZKHxCACg7PcU
Pp51k9eOxqN91q26frF11d4=
=grjB
-----END PGP SIGNATURE-----

--nextPart3738413.sFNXqf41DV--

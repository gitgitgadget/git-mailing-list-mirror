From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Fixed two bugs in git-cvsimport-script.
Date: Mon, 15 Aug 2005 20:18:25 +0200
Message-ID: <u5tacjjdpxq.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C. Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 15 20:24:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4jbC-0002Z0-81
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 20:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVHOSWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 Aug 2005 14:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVHOSWL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 14:22:11 -0400
Received: from main.gmane.org ([80.91.229.2]:39629 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964888AbVHOSWK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 14:22:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E4jZO-0002BZ-8L
	for git@vger.kernel.org; Mon, 15 Aug 2005 20:20:23 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 20:20:22 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 20:20:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:wBHgFAF9aFamJ7SLmACa/Qx+vlQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The git-cvsimport-script had a copule of small bugs that prevented me
from importing a big CVS repository.

The first was that it didn't handle removed files with a multi-digit
primary revision number.

The second was that it was asking the CVS server for "F" messages,
although they were not handled.

I also updated the documentation for that script to correspond to
actual flags.

Signed-off-by: David K=E5gedal <davidk@lysator.liu.se>
---

 Documentation/git-cvsimport-script.txt |    9 ++++++++-
 git-cvsimport-script                   |    4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

50452f9c0c2df1f04d83a26266ba704b13861632
diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git=
-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -29,6 +29,10 @@ OPTIONS
 	currently, only the :local:, :ext: and :pserver: access methods=20
 	are supported.
=20
+-C <target-dir>::
+        The GIT repository to import to.  If the directory doesn't
+        exist, it will be created.  Default is the current directory.
+
 -i::
 	Import-only: don't perform a checkout after importing.  This option
 	ensures the working directory and cache remain untouched and will
@@ -44,7 +48,7 @@ OPTIONS
=20
 -p <options-for-cvsps>::
 	Additional options for cvsps.
-	The options '-x' and '-A' are implicit and should not be used here.
+	The options '-u' and '-A' are implicit and should not be used here.
=20
 	If you need to pass multiple options, separate them with a comma.
=20
@@ -57,6 +61,9 @@ OPTIONS
 -h::
 	Print a short usage message and exit.
=20
+-z <fuzz>::
+        Pass the timestamp fuzz factor to cvsps.
+
 OUTPUT
 ------
 If '-v' is specified, the script reports what it is doing.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -190,7 +190,7 @@ sub conn {
 	$self->{'socketo'}->write("Root $repo\n");
=20
 	# Trial and error says that this probably is the minimum set
-	$self->{'socketo'}->write("Valid-responses ok error Valid-requests Mo=
de M Mbinary E F Checked-in Created Updated Merged Removed\n");
+	$self->{'socketo'}->write("Valid-responses ok error Valid-requests Mo=
de M Mbinary E Checked-in Created Updated Merged Removed\n");
=20
 	$self->{'socketo'}->write("valid-requests\n");
 	$self->{'socketo'}->flush();
@@ -691,7 +691,7 @@ while(<CVS>) {
 		unlink($tmpname);
 		my $mode =3D pmode($cvs->{'mode'});
 		push(@new,[$mode, $sha, $fn]); # may be resurrected!
-	} elsif($state =3D=3D 9 and /^\s+(\S+):\d(?:\.\d+)+->(\d(?:\.\d+)+)\(=
DEAD\)\s*$/) {
+	} elsif($state =3D=3D 9 and /^\s+(\S+):\d+(?:\.\d+)+->(\d+(?:\.\d+)+)=
\(DEAD\)\s*$/) {
 		my $fn =3D $1;
 		$fn =3D~ s#^/+##;
 		push(@old,$fn);

--=20
David K=E5gedal

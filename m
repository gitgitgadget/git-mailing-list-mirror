From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH RFC] git-remote-mediawiki: push-by-rev
Date: Sun, 16 Jun 2013 22:28:19 +0200
Message-ID: <1371414499-13027-2-git-send-email-celestin.matte@ensimag.fr>
References: <1371414499-13027-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 22:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoJZ5-00079O-HQ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 22:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab3FPU2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Jun 2013 16:28:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37087 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab3FPU2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 16:28:31 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5GKSRIN015017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 22:28:27 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5GKSUkP018214;
	Sun, 16 Jun 2013 22:28:30 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5GKSR0C012602;
	Sun, 16 Jun 2013 22:28:29 +0200
X-Mailer: git-send-email 1.8.3.1.522.gd761f2b.dirty
In-Reply-To: <1371414499-13027-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 16 Jun 2013 22:28:28 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228026>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Add the push-by-rev option
This allows one to look for changes by revision instead of by page.
The result is a much faster push on little-activity wikis. Indeed, inst=
ead of
sending one request by page to check that the remote revision is our lo=
cal
latest revision, we only send one request for every new local revision.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 24 +++++++++++++++++++++=
+--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 9ff45fd..fa49882 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -102,6 +102,15 @@ if (!$fetch_strategy) {
 	$fetch_strategy =3D 'by_page';
 }
=20
+my $push_strategy =3D run_git("config --get remote.${remotename}.pushS=
trategy");
+if (!$push_strategy) {
+	$push_strategy =3D run_git('config --get mediawiki.pushStrategy');
+}
+chomp($push_strategy);
+if (!$push_strategy) {
+	$push_strategy =3D 'by_page';
+}
+
 # Remember the timestamp corresponding to a revision id.
 my %basetimestamps;
=20
@@ -512,7 +521,7 @@ sub get_last_local_revision {
 # Get the last remote revision without taking in account which pages a=
re
 # tracked or not. This function makes a single request to the wiki thu=
s
 # avoid a loop onto all tracked pages. This is useful for the fetch-by=
-rev
-# option.
+# and the push-by-rev options.
 sub get_last_global_remote_rev {
 	mw_connect_maybe();
=20
@@ -1160,8 +1169,19 @@ sub mw_push_revision {
 	my $local =3D shift;
 	my $remote =3D shift; # actually, this has to be "refs/heads/master" =
at this point.
 	my $last_local_revid =3D get_last_local_revision();
+	my $last_remote_revid;
 	print {*STDERR} ".\n"; # Finish sentence started by get_last_local_re=
vision()
-	my $last_remote_revid =3D get_last_remote_revision();
+	if ($push_strategy eq 'by_page') {
+		print {*STDERR} "Pushing export data by pages...\n";
+		$last_remote_revid =3D get_last_remote_revision();
+	} elsif ($push_strategy eq 'by_rev') {
+		print {*STDERR} "Pushing export data by revs...\n";
+		$last_remote_revid =3D get_last_global_remote_rev();
+	} else {
+		print {*STDERR} qq(fatal: invalid push strategy "${push_strategy}".\=
n);
+		print {*STDERR} "Check your configuration variables remote.${remoten=
ame}.pushStrategy and mediawiki.pushStrategy\n";
+		exit 1;
+	}
 	my $mw_revision =3D $last_remote_revid;
=20
 	# Get sha1 of commit pointed by local HEAD
--=20
1.8.3.1.522.gd761f2b.dirty

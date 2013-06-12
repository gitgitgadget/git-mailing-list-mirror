From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 21/31] git-remote-mediawiki: Put long code into a subroutine
Date: Wed, 12 Jun 2013 17:43:38 +0200
Message-ID: <1371051828-12866-22-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:45:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnEM-0007Ue-89
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109Ab3FLPox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:44:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47552 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756923Ab3FLPoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:18 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiE9B015693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:14 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiGpN015075;
	Wed, 12 Jun 2013 17:44:16 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu66014096;
	Wed, 12 Jun 2013 17:44:16 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 17:44:15 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227633>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 56 ++++++++++++++++-----=
--------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 7acbec8..52817ba 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -126,32 +126,10 @@ $wiki_name =3D~ s{[^/]*://}{};
 $wiki_name =3D~ s/^.*@//;
=20
 # Commands parser
-my @cmd;
 while (<STDIN>) {
 	chomp;
-	@cmd =3D split(/ /);
-	if (defined($cmd[0])) {
-		# Line not blank
-		if ($cmd[0] eq "capabilities") {
-			die("Too many arguments for capabilities\n") if (defined($cmd[1]));
-			mw_capabilities();
-		} elsif ($cmd[0] eq "list") {
-			die("Too many arguments for list\n") if (defined($cmd[2]));
-			mw_list($cmd[1]);
-		} elsif ($cmd[0] eq "import") {
-			die("Invalid arguments for import\n") if ($cmd[1] eq "" || defined(=
$cmd[2]));
-			mw_import($cmd[1]);
-		} elsif ($cmd[0] eq "option") {
-			die("Too many arguments for option\n") if ($cmd[1] eq "" || $cmd[2]=
 eq "" || defined($cmd[3]));
-			mw_option($cmd[1],$cmd[2]);
-		} elsif ($cmd[0] eq "push") {
-			mw_push($cmd[1]);
-		} else {
-			print STDERR "Unknown command. Aborting...\n";
-			last;
-		}
-	} else {
-		# blank line: we should terminate
+
+	if (!parse_command($_)) {
 		last;
 	}
=20
@@ -167,6 +145,36 @@ sub exit_error_usage {
     die "ERROR: git-remote-mediawiki module was not called with a corr=
ect number of parameters\n";
 }
=20
+sub parse_command {
+	my ($line) =3D @_;
+	my @cmd =3D split(/ /, $line);
+	if (!defined @cmd) {
+		return 0;
+	}
+	if ($cmd[0] eq "capabilities") {
+		die("Too many arguments for capabilities\n")
+		    if (defined($cmd[1]));
+		mw_capabilities();
+	} elsif ($cmd[0] eq "list") {
+		die("Too many arguments for list\n") if (defined($cmd[2]));
+		mw_list($cmd[1]);
+	} elsif ($cmd[0] eq "import") {
+		die("Invalid arguments for import\n")
+		    if ($cmd[1] eq "" || defined($cmd[2]));
+		mw_import($cmd[1]);
+	} elsif ($cmd[0] eq "option") {
+		die("Too many arguments for option\n")
+		    if ($cmd[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
+		mw_option($cmd[1],$cmd[2]);
+	} elsif ($cmd[0] eq "push") {
+		mw_push($cmd[1]);
+	} else {
+		print STDERR "Unknown command. Aborting...\n";
+		return 0;
+	}
+	return 1;
+}
+
 # MediaWiki API instance, created lazily.
 my $mediawiki;
=20
--=20
1.8.3.rc3.18.g21a7b2c

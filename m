From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v3 21/28] git-remote-mediawiki: Put long code into a subroutine
Date: Mon, 10 Jun 2013 00:22:46 +0200
Message-ID: <1370816573-3808-22-git-send-email-celestin.matte@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 00:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulo3G-0001bn-33
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab3FIWYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:24:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37818 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab3FIWX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:23:56 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r59MNkEM011013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 00:23:46 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r59MNntX019499;
	Mon, 10 Jun 2013 00:23:49 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r59MNSHi008599;
	Mon, 10 Jun 2013 00:23:48 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 00:23:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59MNkEM011013
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371421431.5768@V1UawxrMB7nLBVXy1UrJEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227195>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   50 +++++++++++++++++--=
--------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index c404e7b..a66cef4 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -126,28 +126,13 @@ $wiki_name =3D~ s{[^/]*://}{};
 $wiki_name =3D~ s/^.*@//;
=20
 # Commands parser
-my @cmd;
+my @cmds;
 while (<STDIN>) {
 	chomp;
-	@cmd =3D split(/ /);
-	if (defined($cmd[0])) {
+	@cmds =3D split(/ /);
+	if (defined($cmds[0])) {
 		# Line not blank
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
+		if (!parse_command(\@cmds)) {
 			last;
 		}
 	} else {
@@ -167,6 +152,33 @@ sub exit_error_usage {
     die "ERROR: git-remote-mediawiki module was not called with a corr=
ect number of parameters\n";
 }
=20
+sub parse_command {
+	my $cmdref =3D shift;
+	my @cmd =3D @{$cmdref};
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
1.7.9.5

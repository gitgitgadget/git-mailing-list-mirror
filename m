From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 15/22] git-remote-mediawiki: Put long code into a subroutine
Date: Fri,  7 Jun 2013 23:42:16 +0200
Message-ID: <1370641344-4253-16-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:44:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4S1-00009l-3a
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab3FGVnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51998 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756423Ab3FGVnS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:18 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lh8Er026103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:08 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57LhAcw029612;
	Fri, 7 Jun 2013 23:43:10 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRq019409;
	Fri, 7 Jun 2013 23:43:10 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Jun 2013 23:43:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lh8Er026103
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246189.02195@6jqk1PB/htNTHEwQP/EAtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226735>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   42 +++++++++++++++++--=
--------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 1c34ada..f37488b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -133,22 +133,7 @@ while (<STDIN>) {
 	@cmd =3D split(/ /);
 	if (defined($cmd[0])) {
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
+		if (parse_commands() =3D=3D 1) {
 			last;
 		}
 	} else {
@@ -168,6 +153,31 @@ sub exit_error_usage {
     die "ERROR: git-remote-mediawiki module was not called with a corr=
ect number of parameters\n";
 }
=20
+sub parse_commands {
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
+		return 1;
+	}
+	return 0;
+}
+
 # MediaWiki API instance, created lazily.
 my $mediawiki;
=20
--=20
1.7.9.5

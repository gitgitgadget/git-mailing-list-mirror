From: Javier.Roucher-Iglesias@ensimag.imag.fr
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20add=20git=20credential=20login=20to=20remote=20mediawiki=20?=
Date: Mon, 11 Jun 2012 20:54:53 +0200
Message-ID: <1339440893-8522-1-git-send-email-Javier.Roucher-Iglesias@enismag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 20:55:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9lk-0004OY-C0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab2FKSzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:55:09 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44542 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab2FKSzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:55:08 -0400
Received: by wibhj8 with SMTP id hj8so3229624wib.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Xq1kSddnUaHjXcFlu6q8020XZsreeBuMsAYWr17gF+Q=;
        b=cbldXwmyBDXq0mItnI+2W8K7BcEULGy5weKAWRxWdziG977WKRdnOYDw36FZmFkLoX
         5KjGNbZoBWppWgMDSYJCG3g7LtrMxG4i7MvDD/tHYsubqGdhwCVvIZkiu/8fJdmaAb3j
         rUskUOlHzpKa/IHRh4x2jIyY4/zNJaU6KGR6nnwK/eYOqAbTa31aRgq67WWA4oeIk3V2
         wVFF6lm3FEZ07vxmW9UXx/2Y2gLZNJMylutDx6iQYTDXJ55ZIr9CKHMBZQqHeSxujVmM
         eNXz1Y/iNluBHkHTm+Tcm7rZZnxHSFs2s0/zK3locRw3AiKlNwYeeIGBSyzJyR1PwDvK
         OGlA==
Received: by 10.180.92.8 with SMTP id ci8mr23263717wib.15.1339440906363;
        Mon, 11 Jun 2012 11:55:06 -0700 (PDT)
Received: from SuperNova.grenet.fr (etu-190-203.vpn-inp.grenoble-inp.fr. [147.171.190.203])
        by mx.google.com with ESMTPS id db7sm225931wib.6.2012.06.11.11.55.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 11:55:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc2.4.gfbe8a84.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199698>

=46rom: Javier Roucher <jroucher@gmail.com>

This path uses git credential to store the login/password of the mediaw=
iki.

Changes in the version2 vs version1:
=C2=B7 Correction of the name of the PATCH v2 vs PATCH_v1
=C2=B7 Code style correction
=2E Code correction, now is user who defines the helper how wants to us=
e


If i miss some correction, please remember me. Thanks.

Adding to the next patch, version3:
=C2=B7 Tests files

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

---
 contrib/mw-to-git/git-remote-mediawiki | 103 +++++++++++++++++++++++++=
++++----
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git=
/git-remote-mediawiki
index c18bfa1..09ec0f0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -154,26 +154,107 @@ while (<STDIN>) {
 # MediaWiki API instance, created lazily.
 my $mediawiki;
=20
+sub run_credential {
+	my $cre_protocol =3D "";
+	my $cre_host =3D "";
+	my $cre_path =3D "";
+	my $msg =3D "";
+	my $result =3D "";
+	my $op =3D $_[0];
+
+	my $parsed =3D URI->new($url);
+	$cre_protocol =3D $parsed->scheme;
+	$cre_host =3D $parsed->host;
+	$cre_path =3D $parsed->path;
+
+        if ($wiki_login ne "") {
+                $msg .=3D "username=3D$wiki_login\n";
+        }
+        if ($wiki_passwd ne "") {
+                $msg .=3D "password=3D$wiki_passwd\n";
+        }
+        if ($cre_protocol ne "") {
+                $msg .=3D "protocol=3D$cre_protocol\n";
+        }
+        if ($cre_host ne "") {
+                $msg .=3D "host=3D$cre_host\n";
+        }
+        if ($cre_path ne "") {
+                $msg .=3D "path=3D$cre_path\n";
+        }
+
+        $msg .=3D "\n";
+
+	my $key;
+	my $value;
+	my $Prog =3D "git credential $op";
+	open2(*Reader, *Writer, $Prog);
+	print Writer $msg;
+	close (Writer);
+
+	if ($op eq "fill") {
+		while (<Reader>) {
+			my ($key, $value) =3D /([^=3D]*)=3D(.*)/;
+			# error if key undef
+			if (not defined $key) {
+				print STDERR "ERROR reciving reponse git credential fill\n";
+				exit 1;
+			}
+			if ($key eq "username") {
+				$wiki_login =3D $value;
+			}
+			if ($key eq "password") {
+				$wiki_passwd =3D $value;
+			}
+		}
+	} else {
+		while (<Reader>) {
+			print STDERR "\nERROR while running git credential $op:\n$_";
+		}
+	}
+}
+
+my $mediawiki;
+
+sub ask_login {
+	run_credential("fill");
+
+	if (!$mediawiki->login( {
+		lgname =3D> $wiki_login,
+		lgpassword =3D> $wiki_passwd,
+		lgdomain =3D> $wiki_domain,
+		} )) {
+			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on $u=
rl\n";
+			print STDERR "URL:$wiki_domain $url\n";
+			print STDERR "(error " .
+			    $mediawiki->{error}->{code} . ': ' .
+			    $mediawiki->{error}->{details} . ")\n";
+			run_credential("reject");
+			exit 1;
+	} else {
+		print STDERR "Logged in with user \"$wiki_login\".\n";
+		run_credential("approve");
+	}
+}
+
 sub mw_connect_maybe {
+
 	if ($mediawiki) {
 	    return;
 	}
 	$mediawiki =3D MediaWiki::API->new;
 	$mediawiki->{config}->{api_url} =3D "$url/api.php";
 	if ($wiki_login) {
-		if (!$mediawiki->login({
-			lgname =3D> $wiki_login,
-			lgpassword =3D> $wiki_passwd,
-			lgdomain =3D> $wiki_domain,
-		})) {
-			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on $u=
rl\n";
-			print STDERR "(error " .
-			    $mediawiki->{error}->{code} . ': ' .
-			    $mediawiki->{error}->{details} . ")\n";
-			exit 1;
+		if (!$wiki_passwd) {
+			#user knows, password not.
+			ask_login();
 		} else {
-			print STDERR "Logged in with user \"$wiki_login\".\n";
+			#user and password knows.
+			ask_login();
 		}
+	} else 	{
+		#user or password not knows
+		ask_login();
 	}
 }
=20
--=20
1.7.11.rc2.4.gfbe8a84.dirty

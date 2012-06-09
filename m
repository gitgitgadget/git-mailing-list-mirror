From: Javier.Roucher-Iglesias@ensimag.imag.fr
Subject: [PATCH_v1] add git credential login to remote mediawiki
Date: Sat,  9 Jun 2012 20:53:48 +0200
Message-ID: <1339268028-13991-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Cc: Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:54:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdQnQ-0007Sh-PI
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 20:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab2FISx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 14:53:57 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40444 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab2FISx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 14:53:56 -0400
Received: by weyu7 with SMTP id u7so1240158wey.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=spHb5PStdLeFQ/66jGEA4MwxVRuLL0X6vQpWRVBV2nA=;
        b=OkixzYG7Po1Q1Qi3FopTIFzN/BbdTKdjL3yVFZ3xRKDiqF/8xDzVv0VWCF4zi54f5C
         kK5NLtoBT69oPtOyjS3fBDN7kK2JKvOJfsSuBpwrCZdvGRaDsReN9Na151+pPt2qZnBL
         tAkQkhNzy5uLUNT9tcksS7S9bYYVkSHYpxhPf4jsu9rpG4YLWlzbxWcZt7aQdhuzfSod
         KS+eLNkaVx3Mw9ZaQME5ZzMhRCxvziU0JURzazlp7YRi8nme7lvX7e+eqbpgw3HitRsW
         PyvniEEOcVQL2adBm+oIW2SSxplzZWn5eIOImToUiSU0Z4Re85XJFsnq5b/bn+PnOlUd
         Nblg==
Received: by 10.216.196.166 with SMTP id r38mr3399652wen.161.1339268035048;
        Sat, 09 Jun 2012 11:53:55 -0700 (PDT)
Received: from SuperNova.grenet.fr (etu-189-107.vpn-inp.grenoble-inp.fr. [147.171.189.107])
        by mx.google.com with ESMTPS id ei4sm17611855wid.5.2012.06.09.11.53.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 11:53:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc2.9.ge2c5c96.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199553>

From: Javier Roucher <jroucher@gmail.com>


This path uses git credential to store the login/password of the mediawiki.


Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 107 +++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 12 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..4b14d78 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -152,28 +152,111 @@ while (<STDIN>) {
 ########################## Functions ##############################
 
 # MediaWiki API instance, created lazily.
+sub run_credential {
+	my $cre_protocol = "";
+	my $cre_host = "";
+	my $cre_path = "";
+	my $msg = "";
+	my $result = "";
+	my $op=$_[0];
+	if (scalar(@_) == 2) {
+		if ($_[1] eq ("store" || "cache")) {
+			run_git("config credential.helper \'$_[1]\'");
+		} else {
+			print STDERR "ERROR: run_credential (fill|approve|reject) [store|cache]\n";
+			exit 1;
+		}
+	}
+	my $parsed = URI->new($url);
+	$cre_protocol = $parsed->scheme;
+	$cre_host = $parsed->host;
+	$cre_path = $parsed->path;
+
+        if ($wiki_login ne "") {
+                $msg .= "username=$wiki_login\n";
+        }
+        if ($wiki_passwd ne "") {
+                $msg .= "password=$wiki_passwd\n";
+        }
+        if ($cre_protocol ne "") {
+                $msg .= "protocol=$cre_protocol\n";
+        }
+        if ($cre_host ne "") {
+                $msg .= "host=$cre_host\n";
+        }
+        if ($cre_path ne "") {
+                $msg .= "path=$cre_path\n";
+        }
+
+        $msg .= "\n";
+
+	my $key;
+	my $value;
+	my $Prog = "git credential $op";
+	open2(*Reader, *Writer, $Prog);
+	print Writer $msg;
+	close (Writer);
+
+	if ($op eq "fill") {
+		while (<Reader>) {
+			my ($key, $value) = /([^=]*)=(.*)/;
+			# error if key undef
+			if (not defined $key) {
+				print STDERR "ERROR reciving reponse git credential fill\n";
+				exit 1;
+			}
+			if ($key eq "username") {
+				$wiki_login = $value;
+			}
+			if ($key eq "password") {
+				$wiki_passwd = $value;
+			}
+		}
+	} else {
+		while (<Reader>) {
+			print STDERR "\nERROR while running git credential $op:\n$_";
+		}
+	}
+}
+
 my $mediawiki;
 
+sub ask_login {
+	run_credential("fill","store");
+
+	if (!$mediawiki->login( {
+		lgname => $wiki_login,
+		lgpassword => $wiki_passwd,
+		lgdomain => $wiki_domain,
+		} )) {
+			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on $url\n";
+			print STDERR "URL:$wiki_domain $url\n";
+			print STDERR "(error " .
+			    $mediawiki->{error}->{code} . ': ' .
+			    $mediawiki->{error}->{details} . ")\n";
+			run_credential("reject");
+	#		exit 1;
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
 	$mediawiki = MediaWiki::API->new;
 	$mediawiki->{config}->{api_url} = "$url/api.php";
 	if ($wiki_login) {
-		if (!$mediawiki->login({
-			lgname => $wiki_login,
-			lgpassword => $wiki_passwd,
-			lgdomain => $wiki_domain,
-		})) {
-			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on $url\n";
-			print STDERR "(error " .
-			    $mediawiki->{error}->{code} . ': ' .
-			    $mediawiki->{error}->{details} . ")\n";
-			exit 1;
-		} else {
-			print STDERR "Logged in with user \"$wiki_login\".\n";
+		if (!$wiki_passwd) {
+			#user knows, password not.
+			ask_login();
 		}
+	} else 	{
+		#user or password not knows
+		ask_login();
 	}
 }
 
-- 
1.7.11.rc2.9.ge2c5c96.dirty

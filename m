From: Javier.Roucher-Iglesias@ensimag.imag.fr
Subject: [PATCH/RFC] add git credential login to remote mediawiki
Date: Tue, 12 Jun 2012 16:42:05 +0200
Message-ID: <1339512125-32761-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Cc: Javier Roucher <jroucher@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 16:42:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSIx-0005jM-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab2FLOmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:42:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61477 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab2FLOmT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:42:19 -0400
Received: by weyu7 with SMTP id u7so2896824wey.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=1ZAabDIwYkwM2EstT/9slhl5KW/rdKlW67Qcp14qXb0=;
        b=XvvRtFXLcbjQg55EH6UfDf9+qiF9YQcQUUN5ymZbuw/QZqw8DdW7PSwWFNa/xgq+C4
         yAzuDcM/GfTVZx+kcfU/bAx0U13N3VzoZImjeGjcpKtpY3O9tUYehgIH8HB/pFrrruYO
         WGq+N1KI/BJhKbGEvOe6Znznxs349D8k9YpIKPIA+LVJqhhO2NXrhG/EP5bKFKGqkMZX
         +/ELIO3Os3+5Ry6FLUIq+GQiY3Hxfciy8H1+bx2npgbv9S+7a+xuPN+6bMk1x11a9+OF
         S/QmskLNIzhZKUuYJlqRaxXlBpedh/mxr/6VwaXtXkBYv6CpOjQ/RGnkpuyd0IRClJO5
         nfdg==
Received: by 10.180.88.194 with SMTP id bi2mr29605642wib.20.1339512138176;
        Tue, 12 Jun 2012 07:42:18 -0700 (PDT)
Received: from SuperNova.grenet.fr ([80.214.9.0])
        by mx.google.com with ESMTPS id f7sm9652625wiv.2.2012.06.12.07.42.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 07:42:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.573.ged8bfa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199794>

From: Javier Roucher <jroucher@gmail.com>


This path uses git credential to store the login/password of the mediawiki.


---
 contrib/mw-to-git/git-remote-mediawiki | 96 ++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 15 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..4dcc189 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -152,29 +152,95 @@ while (<STDIN>) {
 ########################## Functions ##############################
 
 # MediaWiki API instance, created lazily.
+sub run_credential {
+	my $cre_protocol = "";
+	my $cre_host = "";
+	my $cre_path = "";
+	my $msg = "";
+	my $result = "";
+	my $op = $_[0];
+
+	my $parsed = URI->new($url);
+	$cre_protocol = $parsed->scheme;
+	$cre_host = $parsed->host;
+	$cre_path = $parsed->path;
+
+	if ($wiki_login ne "") {
+		$msg .= "username=$wiki_login\n";
+	}
+	if ($wiki_passwd ne "") {
+		$msg .= "password=$wiki_passwd\n";
+	}
+	if ($cre_protocol ne "") {
+		$msg .= "protocol=$cre_protocol\n";
+	}
+	if ($cre_host ne "") {
+		$msg .= "host=$cre_host\n";
+	}
+	if ($cre_path ne "") {
+		$msg .= "path=$cre_path\n";
+	}
+	$msg .= "\n";
+
+	my $key;
+	my $value;
+	my $Prog = "git credential $op";
+	open2 (*Reader, *Writer, $Prog);
+	print Writer $msg;
+	close (Writer);
+
+	if ($op eq "fill") {
+		while (<Reader>) {
+			my ($key, $value) = /([^=]*)=(.*)/;
+			if (not defined $key) {
+				print STDERR "ERROR receiving response git credential fill\n Reponse: $_\n";
+				# exit 1;
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
 
+sub ask_credential {
+	run_credential("fill");
+
+	if (!$mediawiki->login( {
+		lgname => $wiki_login,
+		lgpassword => $wiki_passwd,
+		lgdomain => $wiki_domain,
+		} )) {
+			print STDERR "Failed to log in mediawiki user: $wiki_login\n on: $url\n";
+			print STDERR "URL: $wiki_domain $url\n";
+			print STDERR "(error " .
+				$mediawiki->{error}->{code} . ': ' .
+				$mediawiki->{error}->{details} . ")\n";
+			run_credential("reject");
+#			exit 1;
+	} else {
+		print STDERR "Logged in with user: $wiki_login.\n";
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
-	if ($wiki_login) {
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
-		}
-	}
+	ask_credential();
 }
 
 sub get_mw_first_pages {
-- 
1.7.10.2.573.ged8bfa6

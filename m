From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] git-remote-mediawiki: add credential support
Date: Sun, 24 Jun 2012 13:40:01 +0200
Message-ID: <1340538001-18625-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqr4t5j5yw.fsf@bauges.imag.fr>
 <1340538001-18625-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: peff@peff.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 24 13:40:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SilBM-0007X1-21
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 13:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab2FXLki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 07:40:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39584 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755661Ab2FXLkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 07:40:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5OBdw2B000459
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2012 13:39:58 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SilB6-0006QK-HC; Sun, 24 Jun 2012 13:40:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SilB6-0004r9-Fy; Sun, 24 Jun 2012 13:40:28 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340538001-18625-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 24 Jun 2012 13:39:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5OBdw2B000459
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341142800.76614@GfSxkkl+LpAGh1fzIOBkPg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200524>

The previous version implemented the possibility to log in a wiki, but
the username and password had to be provided as configuration variables.
We add the possibility to use the Git credential system to prompt
the password.

The support if implemented with generic functions that mimic the C API,
designed to be usable from other contexts in the future (i.e. they may
migrate to Git.pm if someone is interested).

While we're there, do a bit of refactoring in mw_connect_maybe.

Based on patch by: Javier Roucher Iglesias <Javier.Roucher-Iglesias@ensimag.imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 106 +++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 12 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..a34f53f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -43,6 +43,8 @@ use encoding 'utf8';
 binmode STDERR, ":utf8";
 
 use URI::Escape;
+use IPC::Open2;
+
 use warnings;
 
 # Mediawiki filenames can contain forward slashes. This variable decides by which pattern they should be replaced
@@ -151,28 +153,108 @@ while (<STDIN>) {
 
 ########################## Functions ##############################
 
+## credential API management (generic functions)
+
+sub credential_from_url {
+	my $url = shift;
+	my $parsed = URI->new($url);
+	my %credential;
+
+	if ($parsed->scheme) {
+		$credential{protocol} = $parsed->scheme;
+	}
+	if ($parsed->host) {
+		$credential{host} = $parsed->host;
+	}
+	if ($parsed->path) {
+		$credential{path} = $parsed->path;
+	}
+	if ($parsed->userinfo) {
+		if ($parsed->userinfo =~ /([^:]*):(.*)/) {
+			$credential{username} = $1;
+			$credential{password} = $2;
+		} else {
+			$credential{username} = $parsed->userinfo;
+		}
+	}
+
+	return %credential;
+}
+
+sub credential_read {
+	my %credential;
+	my $reader = shift;
+	my $op = shift;
+	while (<$reader>) {
+		my ($key, $value) = /([^=]*)=(.*)/;
+		if (not defined $key) {
+			die "ERROR receiving response from git credential $op:\n$_\n";
+		}
+		$credential{$key} = $value;
+	}
+	return %credential;
+}
+
+sub credential_write {
+	my $credential = shift;
+	my $writer = shift;
+	while (my ($key, $value) = each(%$credential) ) {
+		if ($value) {
+			print $writer "$key=$value\n";
+		}
+	}
+}
+
+sub credential_run {
+	my $op = shift;
+	my $credential = shift;
+	my $pid = open2(my $reader, my $writer, "git credential $op");
+	credential_write($credential, $writer);
+	print $writer "\n";
+	close($writer);
+	
+	if ($op eq "fill") {
+		%$credential = credential_read($reader, $op);
+	} else {
+		if (<$reader>) {
+			die "ERROR while running git credential $op:\n$_";
+		}
+	}
+	close($reader);
+	waitpid($pid, 0);
+	my $child_exit_status = $? >> 8;
+	if ($child_exit_status != 0) {
+		die "'git credential $op' failed with code $child_exit_status.";
+	}
+}
+
 # MediaWiki API instance, created lazily.
 my $mediawiki;
 
 sub mw_connect_maybe {
 	if ($mediawiki) {
-	    return;
+		return;
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
+		my %credential = credential_from_url($url);
+		$credential{username} = $wiki_login;
+		$credential{password} = $wiki_passwd;
+		credential_run("fill", \%credential);
+		my $request = {lgname => $credential{username},
+			       lgpassword => $credential{password},
+			       lgdomain => $wiki_domain};
+		if ($mediawiki->login($request)) {
+			credential_run("approve", \%credential);
+			print STDERR "Logged in mediawiki user \"$credential{username}\".\n";
 		} else {
-			print STDERR "Logged in with user \"$wiki_login\".\n";
+			print STDERR "Failed to log in mediawiki user \"$credential{username}\" on $url\n";
+			print STDERR "  (error " .
+				$mediawiki->{error}->{code} . ': ' .
+				$mediawiki->{error}->{details} . ")\n";
+			credential_run("reject", \%credential);
+			exit 1;
 		}
 	}
 }
-- 
1.7.11.5.g0c7e058.dirty

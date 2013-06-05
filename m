From: benoit.person@ensimag.fr
Subject: [PATCH] git-remote-mediawiki: use Git.pm functions for credentials
Date: Wed,  5 Jun 2013 12:58:00 +0200
Message-ID: <1370429880-12696-1-git-send-email-benoit.person@ensimag.fr>
References: <7vr4gh7m24.fsf@alter.siamese.dyndns.org>
Cc: celestin.matte@ensimag.fr, gitster@pobox.com,
	Benoit Person <benoit.person@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 05 12:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkBQJ-0000ef-8I
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 12:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab3FEK6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 06:58:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38598 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab3FEK6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 06:58:20 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r55Aw3DD024131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Jun 2013 12:58:03 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r55Aw4D6011692;
	Wed, 5 Jun 2013 12:58:04 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r55Aw3i8006055;
	Wed, 5 Jun 2013 12:58:04 +0200
X-Mailer: git-send-email 1.8.3.rc3.7.gc2f33ed.dirty
In-Reply-To: <7vr4gh7m24.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 05 Jun 2013 12:58:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r55Aw3DD024131
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1371034687.34934@rtzo0fveyUKYlE6chyPksw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226445>

From: Benoit Person <benoit.person@ensimag.fr>

In 52dce6d, a new credential function was added to Git.pm, based on
git-remote-mediawiki's functions. The logical follow-up is to use
those functions in git-remote-mediawiki.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 66 ++++-------------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 9c14c1f..6672e4c 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -13,6 +13,7 @@
 
 use strict;
 use MediaWiki::API;
+use Git;
 use DateTime::Format::ISO8601;
 
 # By default, use UTF-8 to communicate with Git and the user
@@ -156,57 +157,6 @@ while (<STDIN>) {
 
 ########################## Functions ##############################
 
-## credential API management (generic functions)
-
-sub credential_read {
-	my %credential;
-	my $reader = shift;
-	my $op = shift;
-	while (<$reader>) {
-		my ($key, $value) = /([^=]*)=(.*)/;
-		if (not defined $key) {
-			die "ERROR receiving response from git credential $op:\n$_\n";
-		}
-		$credential{$key} = $value;
-	}
-	return %credential;
-}
-
-sub credential_write {
-	my $credential = shift;
-	my $writer = shift;
-	# url overwrites other fields, so it must come first
-	print $writer "url=$credential->{url}\n" if exists $credential->{url};
-	while (my ($key, $value) = each(%$credential) ) {
-		if (length $value && $key ne 'url') {
-			print $writer "$key=$value\n";
-		}
-	}
-}
-
-sub credential_run {
-	my $op = shift;
-	my $credential = shift;
-	my $pid = open2(my $reader, my $writer, "git credential $op");
-	credential_write($credential, $writer);
-	print $writer "\n";
-	close($writer);
-
-	if ($op eq "fill") {
-		%$credential = credential_read($reader, $op);
-	} else {
-		if (<$reader>) {
-			die "ERROR while running git credential $op:\n$_";
-		}
-	}
-	close($reader);
-	waitpid($pid, 0);
-	my $child_exit_status = $? >> 8;
-	if ($child_exit_status != 0) {
-		die "'git credential $op' failed with code $child_exit_status.";
-	}
-}
-
 # MediaWiki API instance, created lazily.
 my $mediawiki;
 
@@ -217,22 +167,24 @@ sub mw_connect_maybe {
 	$mediawiki = MediaWiki::API->new;
 	$mediawiki->{config}->{api_url} = "$url/api.php";
 	if ($wiki_login) {
-		my %credential = (url => $url);
-		$credential{username} = $wiki_login;
-		$credential{password} = $wiki_passwd;
-		credential_run("fill", \%credential);
+		my %credential = (
+			'url' => $url,
+			'username' => $wiki_login,
+			'password' => $wiki_passwd
+		);
+		Git::credential(\%credential);
 		my $request = {lgname => $credential{username},
 			       lgpassword => $credential{password},
 			       lgdomain => $wiki_domain};
 		if ($mediawiki->login($request)) {
-			credential_run("approve", \%credential);
+			Git::credential(\%credential, 'approve');
 			print STDERR "Logged in mediawiki user \"$credential{username}\".\n";
 		} else {
 			print STDERR "Failed to log in mediawiki user \"$credential{username}\" on $url\n";
 			print STDERR "  (error " .
 				$mediawiki->{error}->{code} . ': ' .
 				$mediawiki->{error}->{details} . ")\n";
-			credential_run("reject", \%credential);
+			Git::credential(\%credential, 'reject');
 			exit 1;
 		}
 	}
-- 
1.8.3.rc3.7.gc2f33ed.dirty

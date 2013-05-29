From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] git-remote-mediawiki: better error message when HTTP(S) access fails
Date: Wed, 29 May 2013 14:06:29 +0200
Message-ID: <1369829189-27881-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqzjvej8p4.fsf@anie.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 29 14:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhf9R-0003NQ-2F
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965964Ab3E2MGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:06:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55452 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965645Ab3E2MGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:06:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4TC6VH9016357
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 May 2013 14:06:31 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uhf9E-0005OU-PB; Wed, 29 May 2013 14:06:32 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uhf9E-0007GO-Cl; Wed, 29 May 2013 14:06:32 +0200
X-Mailer: git-send-email 1.8.3.rc3.8.g5e49f30
In-Reply-To: <vpqzjvej8p4.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 May 2013 14:06:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4TC6VH9016357
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1370433992.57412@SnDC/oFPAnOTyvG90j5tSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225796>

My use-case is an invalid SSL certificate. Pulling from the wiki with a
recent version of libwww-perl fails, and git-remote-mediawiki gave no
clue about the reason. Give the mediawiki API detailed error message, and
since it is not so informative, hint the user about an invalid SSL
certificate on https:// urls.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 9c14c1f..f0c348c 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -238,6 +238,22 @@ sub mw_connect_maybe {
 	}
 }
 
+sub fatal_mw_error {
+	my $action = shift;
+	print STDERR "fatal: could not $action.\n";
+	print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+	if ($url =~ /^https/) {
+		print STDERR "fatal: make sure '$url/api.php' is a valid page\n";
+		print STDERR "fatal: and the SSL certificate is correct.\n";
+	} else {
+		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+	}
+	print STDERR "fatal: (error " .
+	    $mediawiki->{error}->{code} . ': ' .
+	    $mediawiki->{error}->{details} . ")\n";
+	exit 1;
+}
+
 ## Functions for listing pages on the remote wiki
 sub get_mw_tracked_pages {
 	my $pages = shift;
@@ -290,10 +306,7 @@ sub get_mw_all_pages {
 		aplimit => 'max'
 	});
 	if (!defined($mw_pages)) {
-		print STDERR "fatal: could not get the list of wiki pages.\n";
-		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
-		exit 1;
+		fatal_mw_error("get the list of wiki pages");
 	}
 	foreach my $page (@{$mw_pages}) {
 		$pages->{$page->{title}} = $page;
@@ -316,10 +329,7 @@ sub get_mw_first_pages {
 		titles => $titles,
 	});
 	if (!defined($mw_pages)) {
-		print STDERR "fatal: could not query the list of wiki pages.\n";
-		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
-		exit 1;
+		fatal_mw_error("query the list of wiki pages");
 	}
 	while (my ($id, $page) = each(%{$mw_pages->{query}->{pages}})) {
 		if ($id < 0) {
-- 
1.8.3.rc3.8.g5e49f30

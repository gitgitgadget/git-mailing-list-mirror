From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: better error message when HTTP(S) access fails
Date: Thu, 23 May 2013 22:05:03 +0200
Message-ID: <1369339503-12426-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 23 22:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfbmZ-0006Mv-1U
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 22:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758902Ab3EWUGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 16:06:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45503 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206Ab3EWUGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 16:06:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4NK53OB002892
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 23 May 2013 22:05:03 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Ufbl3-0007vc-Ca; Thu, 23 May 2013 22:05:05 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Ufbl3-0003F8-0b; Thu, 23 May 2013 22:05:05 +0200
X-Mailer: git-send-email 1.8.3.rc3.8.g5e49f30
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 23 May 2013 22:05:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4NK53OB002892
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1369944305.67082@SmvJVVsaLuxmi14jtP7B2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225290>

My use-case is an invalid SSL certificate. Pulling from the wiki with a
recent version of libwww-perl fails, and git-remote-mediawiki gave no
clue about the reason. Give the mediawiki API detailed error message, and
since it is not so informative, hint the user about an invalid SSL
certificate on https:// urls.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 9c14c1f..5b6e833 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -292,7 +292,13 @@ sub get_mw_all_pages {
 	if (!defined($mw_pages)) {
 		print STDERR "fatal: could not get the list of wiki pages.\n";
 		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		if ($url =~ /^https/) {
+		    print STDERR "fatal: make sure '$url/api.php' is a valid page\n";
+		    print STDERR "fatal: and the SSL certificate is correct.\n";
+		} else {
+		    print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		}
+		print STDERR "error: " . $mediawiki->{error}->{details} . "\n";
 		exit 1;
 	}
 	foreach my $page (@{$mw_pages}) {
-- 
1.8.3.rc3.8.g5e49f30

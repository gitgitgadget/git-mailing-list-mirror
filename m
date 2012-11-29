From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: escape double quotes and LF in file names
Date: Thu, 29 Nov 2012 13:33:33 +0100
Message-ID: <1354192413-9959-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 29 13:34:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te3Jd-0002Zw-JD
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 13:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab2K2Mdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 07:33:50 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35754 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab2K2Mdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 07:33:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qATCO6FU008504
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2012 13:24:07 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Te3JE-0002lo-Gd; Thu, 29 Nov 2012 13:33:40 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Te3JE-0002bF-CN; Thu, 29 Nov 2012 13:33:40 +0100
X-Mailer: git-send-email 1.8.0.319.g8abfee4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Nov 2012 13:24:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qATCO6FU008504
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1354796650.68517@5l3sW9hCinQ16FMKehcDzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210830>

A mediawiki page can contain, and even start with a " character, we have
to escape it when generating the fast-export stream. While we're there,
also escape newlines, but I don't think we can get them from MediaWiki
pages.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 68555d4..e7a0e7b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -711,6 +711,13 @@ sub fetch_mw_revisions {
 	return ($n, @revisions);
 }
 
+sub fe_escape_path {
+    my $path = shift;
+    $path =~ s/"/\\"/g;
+    $path =~ s/\n/\\n/g;
+    return $path;
+}
+
 sub import_file_revision {
 	my $commit = shift;
 	my %commit = %{$commit};
@@ -738,15 +745,17 @@ sub import_file_revision {
 		print STDOUT "from refs/mediawiki/$remotename/master^0\n";
 	}
 	if ($content ne DELETED_CONTENT) {
-		print STDOUT "M 644 inline $title.mw\n";
+		print STDOUT "M 644 inline " .
+		    fe_escape_path($title . ".mw") . "\n";
 		literal_data($content);
 		if (%mediafile) {
-			print STDOUT "M 644 inline $mediafile{title}\n";
+			print STDOUT "M 644 inline "
+			    . fe_escape_path($mediafile{title}) . "\n";
 			literal_data_raw($mediafile{content});
 		}
 		print STDOUT "\n\n";
 	} else {
-		print STDOUT "D $title.mw\n";
+		print STDOUT "D " . fe_escape_path($title . ".mw") . "\n";
 	}
 
 	# mediawiki revision number in the git note
-- 
1.8.0.319.g8abfee4

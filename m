From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 10/12] git-remote-mediawiki: extract revision-importing loop to a function
Date: Thu,  5 Jul 2012 09:36:10 +0200
Message-ID: <1341473772-28023-11-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:37:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smgcv-0001cS-SH
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab2GEHhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:37:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50077 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628Ab2GEHhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:37:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZmWg011308
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcU-0006cc-GU; Thu, 05 Jul 2012 09:36:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcU-0007mJ-EV; Thu, 05 Jul 2012 09:36:58 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Jul 2012 09:35:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZmWg011308
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078550.18617@QfKB4HKOv3HkxHqK62SNWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201030>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index e19402c..beb4566 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -849,10 +849,18 @@ sub mw_import_ref {
 	@revisions = sort {$a->{revid} <=> $b->{revid}} @revisions;
 	my @revision_ids = map $_->{revid}, @revisions;
 
-	$n = 0;
+	return mw_import_revids($fetch_from, \@revision_ids, \%pages_hash);
+}
+
+sub mw_import_revids {
+	my $fetch_from = shift;
+	my $revision_ids = shift;
+	my $pages = shift;
+
+	my $n = 0;
 	my $last_timestamp = 0; # Placeholer in case $rev->timestamp is undefined
 
-	foreach my $pagerevid (@revision_ids) {
+	foreach my $pagerevid (@$revision_ids) {
 		# fetch the content of the pages
 		my $query = {
 			action => 'query',
@@ -896,7 +904,7 @@ sub mw_import_ref {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print STDERR "$n/", scalar(@revision_ids), ": Revision #$rev->{revid} of $commit{title}\n";
+		print STDERR "$n/", scalar(@$revision_ids), ": Revision #$rev->{revid} of $commit{title}\n";
 		if (%mediafile) {
 			print STDERR "\tDownloading file $mediafile{title}, version $mediafile{timestamp}\n";
 			import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
@@ -911,6 +919,8 @@ sub mw_import_ref {
 		# thrown saying that HEAD is refering to unknown object 0000000000000000000
 		# and the clone fails.
 	}
+
+	return $n;
 }
 
 sub error_non_fast_forward {
-- 
1.7.11.1.147.g47a574d

From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 10/12] git-remote-mediawiki: extract revision-importing loop to a function
Date: Fri,  6 Jul 2012 12:03:13 +0200
Message-ID: <1341568995-12467-11-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhatl9t4a.fsf@bauges.imag.fr>
 <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 12:04:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn5Oe-00071j-O0
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 12:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905Ab2GFKEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 06:04:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51865 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932642Ab2GFKEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 06:04:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q66A2tpK022452
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2012 12:02:55 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5OK-0003Xr-CP; Fri, 06 Jul 2012 12:04:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5OK-0003HY-Au; Fri, 06 Jul 2012 12:04:00 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Jul 2012 12:02:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q66A2tpK022452
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342173776.30686@Ix21zfxB9aca9FxdJiahhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201104>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 47dd574..9305204 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -822,10 +822,18 @@ sub mw_import_ref {
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
@@ -866,7 +874,7 @@ sub mw_import_ref {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print STDERR "$n/", scalar(@revision_ids), ": Revision #$rev->{revid} of $commit{title}\n";
+		print STDERR "$n/", scalar(@$revision_ids), ": Revision #$rev->{revid} of $commit{title}\n";
 		import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
 	}
 
@@ -876,6 +884,8 @@ sub mw_import_ref {
 		# thrown saying that HEAD is refering to unknown object 0000000000000000000
 		# and the clone fails.
 	}
+
+	return $n;
 }
 
 sub error_non_fast_forward {
-- 
1.7.11.1.147.g47a574d

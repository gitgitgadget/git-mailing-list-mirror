From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 8/8] git-remote-mediawiki: properly deal with invalid remote revisions
Date: Mon, 16 Jul 2012 14:00:53 +0200
Message-ID: <1342440053-3058-9-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 14:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqjzj-0006YA-O1
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab2GPMBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:01:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54843 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab2GPMB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 08:01:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GBxgGc021763
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 13:59:43 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqjzJ-0002Wd-9P; Mon, 16 Jul 2012 14:01:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqjzJ-0000oZ-7s; Mon, 16 Jul 2012 14:01:17 +0200
X-Mailer: git-send-email 1.7.11.1.30.g7e1baf9.dirty
In-Reply-To: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 13:59:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GBxgGc021763
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343044788.03254@DtvKgySikzVsgcrNK1OJAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201509>

Some wiki, including https://git.wiki.kernel.org/ have invalid revision
numbers (i.e. the actual revision numbers are non-contiguous). Don't die
when encountering one.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index cf467ac..80a07cc 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -910,6 +910,10 @@ sub mw_import_revids {
 	my $last_timestamp = 0; # Placeholer in case $rev->timestamp is undefined
 
 	foreach my $pagerevid (@$revision_ids) {
+	        # Count page even if we skip it, since we display
+		# $n/$total and $total includes skipped pages.
+		$n++;
+
 		# fetch the content of the pages
 		my $query = {
 			action => 'query',
@@ -924,6 +928,11 @@ sub mw_import_revids {
 			die "Failed to retrieve modified page for revision $pagerevid";
 		}
 
+		if (defined($result->{query}->{badrevids}->{$pagerevid})) {
+			# The revision id does not exist on the remote wiki.
+			next;
+		}
+
 		if (!defined($result->{query}->{pages})) {
 			die "Invalid revision $pagerevid.";
 		}
@@ -932,10 +941,6 @@ sub mw_import_revids {
 		my $result_page = $result_pages[0];
 		my $rev = $result_pages[0]->{revisions}->[0];
 
-	        # Count page even if we skip it, since we display
-		# $n/$total and $total includes skipped pages.
-		$n++;
-
 		my $page_title = $result_page->{title};
 
 		if (!exists($pages->{$page_title})) {
-- 
1.7.11.1.30.g7e1baf9.dirty

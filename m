From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 09/12] git-remote-mediawiki: refactor loop over revision ids
Date: Thu,  5 Jul 2012 09:36:09 +0200
Message-ID: <1341473772-28023-10-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:37:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smgcv-0001cS-BH
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab2GEHhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:37:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58611 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349Ab2GEHg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZsCW029237
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:54 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcS-0006c2-BD; Thu, 05 Jul 2012 09:36:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcS-0007la-8i; Thu, 05 Jul 2012 09:36:56 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Jul 2012 09:35:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZsCW029237
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078555.39842@Dh5r5H8gNraPpXYX7Syalg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201032>

Without changing the behavior, we turn the foreach loop on an array of
revisions into a loop on an array of integer. It will be easier to
implement other strategies as they will only need to produce an array of
integer instead of a more complex data-structure.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 3f57598..e19402c 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -846,30 +846,35 @@ sub mw_import_ref {
 	# Creation of the fast-import stream
 	print STDERR "Fetching & writing export data...\n";
 
+	@revisions = sort {$a->{revid} <=> $b->{revid}} @revisions;
+	my @revision_ids = map $_->{revid}, @revisions;
+
 	$n = 0;
 	my $last_timestamp = 0; # Placeholer in case $rev->timestamp is undefined
 
-	foreach my $pagerevid (sort {$a->{revid} <=> $b->{revid}} @revisions) {
+	foreach my $pagerevid (@revision_ids) {
 		# fetch the content of the pages
 		my $query = {
 			action => 'query',
 			prop => 'revisions',
 			rvprop => 'content|timestamp|comment|user|ids',
-			revids => $pagerevid->{revid},
+			revids => $pagerevid,
 		};
 
 		my $result = $mediawiki->api($query);
 
-		my $rev = pop(@{$result->{query}->{pages}->{$pagerevid->{pageid}}->{revisions}});
+		my @result_pages = values(%{$result->{query}->{pages}});
+		my $result_page = $result_pages[0];
+		my $rev = $result_pages[0]->{revisions}->[0];
 
 		$n++;
 
-		my $page_title = $result->{query}->{pages}->{$pagerevid->{pageid}}->{title};
+		my $page_title = $result_page->{title};
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
 		$commit{title} = mediawiki_smudge_filename($page_title);
-		$commit{mw_revision} = $pagerevid->{revid};
+		$commit{mw_revision} = $rev->{revid};
 		$commit{content} = mediawiki_smudge($rev->{'*'});
 
 		if (!defined($rev->{timestamp})) {
@@ -891,7 +896,7 @@ sub mw_import_ref {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+		print STDERR "$n/", scalar(@revision_ids), ": Revision #$rev->{revid} of $commit{title}\n";
 		if (%mediafile) {
 			print STDERR "\tDownloading file $mediafile{title}, version $mediafile{timestamp}\n";
 			import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
-- 
1.7.11.1.147.g47a574d

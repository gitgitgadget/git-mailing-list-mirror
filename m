From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 09/12] git-remote-mediawiki: refactor loop over revision ids
Date: Fri,  6 Jul 2012 12:03:12 +0200
Message-ID: <1341568995-12467-10-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhatl9t4a.fsf@bauges.imag.fr>
 <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 12:04:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn5OT-0006dd-C3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 12:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845Ab2GFKD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 06:03:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51852 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932642Ab2GFKDy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 06:03:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q66A2kh4022413
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2012 12:02:46 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5OB-0003VA-R7; Fri, 06 Jul 2012 12:03:51 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5OB-0003HU-Pc; Fri, 06 Jul 2012 12:03:51 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Jul 2012 12:02:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q66A2kh4022413
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342173767.2199@9rxFjPMnONgsZ6qeaBDshg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201102>

Without changing the behavior, we turn the foreach loop on an array of
revisions into a loop on an array of integer. It will be easier to
implement other strategies as they will only need to produce an array of
integer instead of a more complex data-structure.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 4bf990b..47dd574 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -819,30 +819,35 @@ sub mw_import_ref {
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
@@ -861,7 +866,7 @@ sub mw_import_ref {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+		print STDERR "$n/", scalar(@revision_ids), ": Revision #$rev->{revid} of $commit{title}\n";
 		import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
 	}
 
-- 
1.7.11.1.147.g47a574d

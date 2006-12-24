From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 2/8] gitweb: We do longer need the --parents flag in rev-list.
Date: Sun, 24 Dec 2006 14:31:43 +0000
Message-ID: <11669707094097-git-send-email-robfitz@273k.net>
References: 20061224143041.GF11474@localhost <11669707092427-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUOC-0005Tw-82
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWLXObn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWLXObn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:43 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32858 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbWLXObn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:43 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNq-0002uT-Ec; Sun, 24 Dec 2006 14:31:26 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: <11669707092427-git-send-email-robfitz@273k.net>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=1, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00, RCVD_IN_NJABL_DUL 3.00)
X-blacknight-igraine-MailScanner-SpamScore: s
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35361>

We only want to know the direct parents of a given commit object,
these parents are available in the --header output of rev-list.  If
--parents is supplied with --full-history the output includes merge
commits that aren't relevant.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6bd57a4..c645686 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1281,13 +1281,14 @@ sub parse_commit_text {
 	if (!($header =~ m/^[0-9a-fA-F]{40}/)) {
 		return;
 	}
-	($co{'id'}, my @parents) = split ' ', $header;
-	$co{'parents'} = \@parents;
-	$co{'parent'} = $parents[0];
+	$co{'id'} = $header;
+	my @parents;
 	while (my $line = shift @commit_lines) {
 		last if $line eq "\n";
 		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
 			$co{'tree'} = $1;
+		} elsif ($line =~ m/^parent ([0-9a-fA-F]{40})$/) {
+			push @parents, $1;
 		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
 			$co{'author'} = $1;
 			$co{'author_epoch'} = $2;
@@ -1314,6 +1315,8 @@ sub parse_commit_text {
 	if (!defined $co{'tree'}) {
 		return;
 	};
+	$co{'parents'} = \@parents;
+	$co{'parent'} = $parents[0];
 
 	foreach my $title (@commit_lines) {
 		$title =~ s/^    //;
@@ -1371,7 +1374,6 @@ sub parse_commit {
 
 	open my $fd, "-|", git_cmd(), "rev-list",
 		"--header",
-		"--parents",
 		"--max-count=1",
 		$commit_id,
 		"--",
@@ -1414,7 +1416,6 @@ sub parse_commits {
 
 	open my $fd, "-|", git_cmd(), "rev-list",
 		"--header",
-		"--parents",
 		($arg ? ($arg) : ()),
 		("--max-count=" . $maxcount),
 		# Add once rev-list supports the --skip option
-- 
1.4.4.3.ge655-dirty

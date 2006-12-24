From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 6/8] gitweb: Change atom, rss actions to use parse_commits.
Date: Sun, 24 Dec 2006 14:31:47 +0000
Message-ID: <1166970711394-git-send-email-robfitz@273k.net>
References: 20061224143041.GF11474@localhost <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net> <11669707102678-git-send-email-robfitz@273k.net> <11669707101872-git-send-email-robfitz@273k.net> <116697071140-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:32:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUOO-0005W6-Ti
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWLXOb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWLXOb4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:56 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32887 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbWLXOby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:54 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNs-0002uo-6o; Sun, 24 Dec 2006 14:31:28 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: <116697071140-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35364>


Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 53dd225..f752a6f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4483,11 +4483,7 @@ sub git_feed {
 
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
 	my $head = $hash || 'HEAD';
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=150",
-		$head, "--", (defined $file_name ? $file_name : ())
-		or die_error(undef, "Open git-rev-list failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd or die_error(undef, "Reading git-rev-list failed");
+	my @commitlist = parse_commits($head, 150);
 
 	my %latest_commit;
 	my %latest_date;
@@ -4497,8 +4493,8 @@ sub git_feed {
 		# browser (feed reader) prefers text/xml
 		$content_type = 'text/xml';
 	}
-	if (defined($revlist[0])) {
-		%latest_commit = parse_commit($revlist[0]);
+	if (defined($commitlist[0])) {
+		%latest_commit = %{$commitlist[0]};
 		%latest_date   = parse_date($latest_commit{'author_epoch'});
 		print $cgi->header(
 			-type => $content_type,
@@ -4588,9 +4584,9 @@ XML
 	}
 
 	# contents
-	for (my $i = 0; $i <= $#revlist; $i++) {
-		my $commit = $revlist[$i];
-		my %co = parse_commit($commit);
+	for (my $i = 0; $i <= $#commitlist; $i++) {
+		my %co = %{$commitlist[$i]};
+		my $commit = $co{'id'};
 		# we read 150, we always show 30 and the ones more recent than 48 hours
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
@@ -4598,7 +4594,7 @@ XML
 		my %cd = parse_date($co{'author_epoch'});
 
 		# get list of changed files
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			$co{'parent'}, $co{'id'}, "--", (defined $file_name ? $file_name : ())
 			or next;
 		my @difftree = map { chomp; $_ } <$fd>;
-- 
1.4.4.3.ge655-dirty

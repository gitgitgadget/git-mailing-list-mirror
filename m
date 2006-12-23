From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 1/3] gitweb: Use rev-list pattern search options.
Date: Sat, 23 Dec 2006 03:35:14 +0000
Message-ID: <11668449162618-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sat Dec 23 04:35:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxxfX-0002GM-8J
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 04:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWLWDfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 22:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbWLWDfY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 22:35:24 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:59445 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbWLWDfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 22:35:23 -0500
Received: from [194.125.99.166] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GxxfA-00060f-1v; Sat, 23 Dec 2006 03:35:08 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.gae7ae3
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35257>

Use rev-list pattern search options instead of hand coded perl.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ebbc397..cc6bd0c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4172,20 +4172,20 @@ sub git_search {
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 1;
 	if ($searchtype eq 'commit' or $searchtype eq 'author' or $searchtype eq 'committer') {
+		my $greptype;
+		if ($searchtype eq 'commit') {
+			$greptype = "--grep=";
+		} elsif ($searchtype eq 'author') {
+			$greptype = "--author=";
+		} elsif ($searchtype eq 'committer') {
+			$greptype = "--committer=";
+		}
 		$/ = "\0";
 		open my $fd, "-|", git_cmd(), "rev-list",
-			"--header", "--parents", $hash, "--"
+			"--header", "--parents", ($greptype . $searchtext),
+			 $hash, "--"
 			or next;
 		while (my $commit_text = <$fd>) {
-			if (!grep m/$searchtext/i, $commit_text) {
-				next;
-			}
-			if ($searchtype eq 'author' && !grep m/\nauthor .*$searchtext/i, $commit_text) {
-				next;
-			}
-			if ($searchtype eq 'committer' && !grep m/\ncommitter .*$searchtext/i, $commit_text) {
-				next;
-			}
 			my @commit_lines = split "\n", $commit_text;
 			my %co = parse_commit(undef, \@commit_lines);
 			if (!%co) {
-- 
1.4.4.3.gae7ae3

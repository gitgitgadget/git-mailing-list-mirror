From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 4/8] gitweb: Change log action to use parse_commits.
Date: Sun, 24 Dec 2006 14:31:45 +0000
Message-ID: <11669707101872-git-send-email-robfitz@273k.net>
References: 20061224143041.GF11474@localhost <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net> <11669707102678-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:32:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUON-0005W6-QP
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWLXOby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWLXOby
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:54 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32882 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbWLXObx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:53 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNr-0002ud-AZ; Sun, 24 Dec 2006 14:31:27 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: <11669707102678-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35365>

Also add missing next link to bottom of page.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5f1ace9..42b7449 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3645,28 +3645,25 @@ sub git_log {
 	}
 	my $refs = git_get_references();
 
-	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash, "--"
-		or die_error(undef, "Open git-rev-list failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd;
+	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#revlist);
+	my $paging_nav = format_paging_nav('log', $hash, $head, $page, (100 * ($page+1)));
 
 	git_header_html();
 	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 
-	if (!@revlist) {
+	if (!@commitlist) {
 		my %co = parse_commit($hash);
 
 		git_print_header_div('summary', $project);
 		print "<div class=\"page_body\"> Last change $co{'age_string'}.<br/><br/></div>\n";
 	}
-	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
-		my $commit = $revlist[$i];
-		my $ref = format_ref_marker($refs, $commit);
-		my %co = parse_commit($commit);
+	my $to = ($#commitlist >= 99) ? (99) : ($#commitlist);
+	for (my $i = 0; $i <= $to; $i++) {
+		my %co = %{$commitlist[$i]};
 		next if !%co;
+		my $commit = $co{'id'};
+		my $ref = format_ref_marker($refs, $commit);
 		my %ad = parse_date($co{'author_epoch'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
@@ -3688,6 +3685,12 @@ sub git_log {
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
 		print "</div>\n";
 	}
+	if ($#commitlist >= 100) {
+		print "<div class=\"page_nav\">\n";
+		print $cgi->a({-href => href(action=>"log", hash=>$hash, page=>$page+1),
+			       -accesskey => "n", -title => "Alt-n"}, "next");
+		print "</div>\n";
+	}
 	git_footer_html();
 }
 
-- 
1.4.4.3.ge655-dirty

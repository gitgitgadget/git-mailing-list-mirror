From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 3/8] gitweb: Change summary, shortlog actions to use parse_commits.
Date: Sun, 24 Dec 2006 14:31:44 +0000
Message-ID: <11669707102678-git-send-email-robfitz@273k.net>
References: 20061224143041.GF11474@localhost <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:31:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUOC-0005Tw-PR
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWLXObp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWLXObp
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:45 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32859 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbWLXObo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:44 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNq-0002uW-R1; Sun, 24 Dec 2006 14:31:27 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: <11669707094097-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35362>

Also added missing accesskey.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   34 ++++++++++++----------------------
 1 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c645686..5f1ace9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2704,20 +2704,19 @@ sub git_project_list_body {
 
 sub git_shortlog_body {
 	# uses global variable $project
-	my ($revlist, $from, $to, $refs, $extra) = @_;
+	my ($commitlist, $from, $to, $refs, $extra) = @_;
 
 	my $have_snapshot = gitweb_have_snapshot();
 
 	$from = 0 unless defined $from;
-	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
+	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
 	print "<table class=\"shortlog\" cellspacing=\"0\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
-		my $commit = $revlist->[$i];
-		#my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
+		my %co = %{$commitlist->[$i]};
+		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
-		my %co = parse_commit($commit);
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -3081,14 +3080,10 @@ sub git_summary {
 
 	# we need to request one more than 16 (0..15) to check if
 	# those 16 are all
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
-		$head, "--"
-		or die_error(undef, "Open git-rev-list failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd;
+	my @commitlist = parse_commits($head, 17);
 	git_print_header_div('shortlog');
-	git_shortlog_body(\@revlist, 0, 15, $refs,
-	                  $#revlist <=  15 ? undef :
+	git_shortlog_body(\@commitlist, 0, 15, $refs,
+	                  $#commitlist <=  15 ? undef :
 	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
 
 	if (@taglist) {
@@ -4456,26 +4451,21 @@ sub git_shortlog {
 	}
 	my $refs = git_get_references();
 
-	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash, "--"
-		or die_error(undef, "Open git-rev-list failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd;
+	my @commitlist = parse_commits($head, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#revlist);
+	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
 	my $next_link = '';
-	if ($#revlist >= (100 * ($page+1)-1)) {
+	if ($#commitlist >= 100) {
 		$next_link =
 			$cgi->a({-href => href(action=>"shortlog", hash=>$hash, page=>$page+1),
-			         -title => "Alt-n"}, "next");
+			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
 
-
 	git_header_html();
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
 	git_print_header_div('summary', $project);
 
-	git_shortlog_body(\@revlist, ($page * 100), $#revlist, $refs, $next_link);
+	git_shortlog_body(\@commitlist, 0, 99, $refs, $next_link);
 
 	git_footer_html();
 }
-- 
1.4.4.3.ge655-dirty

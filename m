From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 7/8] gitweb: Change history action to use parse_commits.
Date: Sun, 24 Dec 2006 14:31:48 +0000
Message-ID: <11669707111273-git-send-email-robfitz@273k.net>
References: 20061224143041.GF11474@localhost <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net> <11669707102678-git-send-email-robfitz@273k.net> <11669707101872-git-send-email-robfitz@273k.net> <116697071140-git-send-email-robfitz@273k.net> <1166970711394-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUOO-0005W6-Ca
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWLXObz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWLXObz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:55 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32886 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbWLXOby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:54 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNs-0002uu-Jz; Sun, 24 Dec 2006 14:31:29 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: <1166970711394-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35367>

Also added missing accesskey.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f752a6f..f9994d9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2750,23 +2750,19 @@ sub git_shortlog_body {
 
 sub git_history_body {
 	# Warning: assumes constant type (blob or tree) during history
-	my ($revlist, $from, $to, $refs, $hash_base, $ftype, $extra) = @_;
+	my ($commitlist, $from, $to, $refs, $hash_base, $ftype, $extra) = @_;
 
 	$from = 0 unless defined $from;
-	$to = $#{$revlist} unless (defined $to && $to <= $#{$revlist});
+	$to = $#{$commitlist} unless (defined $to && $to <= $#{$commitlist});
 
 	print "<table class=\"history\" cellspacing=\"0\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
-		if ($revlist->[$i] !~ m/^([0-9a-fA-F]{40})/) {
-			next;
-		}
-
-		my $commit = $1;
-		my %co = parse_commit($commit);
+		my %co = %{$commitlist->[$i]};
 		if (!%co) {
 			next;
 		}
+		my $commit = $co{'id'};
 
 		my $ref = format_ref_marker($refs, $commit);
 
@@ -4219,12 +4215,7 @@ sub git_history {
 		$ftype = git_get_type($hash);
 	}
 
-	open my $fd, "-|",
-		git_cmd(), "rev-list", $limit, "--full-history", $hash_base, "--", $file_name
-			or die_error(undef, "Open git-rev-list-failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd
-		or die_error(undef, "Reading git-rev-list failed");
+	my @commitlist = parse_commits($hash_base, 101, (100 * $page), "--full-history", $file_name);
 
 	my $paging_nav = '';
 	if ($page > 0) {
@@ -4240,7 +4231,7 @@ sub git_history {
 		$paging_nav .= "first";
 		$paging_nav .= " &sdot; prev";
 	}
-	if ($#revlist >= (100 * ($page+1)-1)) {
+	if ($#commitlist >= 100) {
 		$paging_nav .= " &sdot; " .
 			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
 			                       file_name=>$file_name, page=>$page+1),
@@ -4249,11 +4240,11 @@ sub git_history {
 		$paging_nav .= " &sdot; next";
 	}
 	my $next_link = '';
-	if ($#revlist >= (100 * ($page+1)-1)) {
+	if ($#commitlist >= 100) {
 		$next_link =
 			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
 			                       file_name=>$file_name, page=>$page+1),
-			         -title => "Alt-n"}, "next");
+			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
 
 	git_header_html();
@@ -4261,7 +4252,7 @@ sub git_history {
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype, $hash_base);
 
-	git_history_body(\@revlist, ($page * 100), $#revlist,
+	git_history_body(\@commitlist, 0, 99,
 	                 $refs, $hash_base, $ftype, $next_link);
 
 	git_footer_html();
-- 
1.4.4.3.ge655-dirty

From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 5/8] gitweb: Change header search action to use parse_commits.
Date: Sun, 24 Dec 2006 14:31:46 +0000
Message-ID: <116697071140-git-send-email-robfitz@273k.net>
References: 20061224143041.GF11474@localhost <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net> <11669707102678-git-send-email-robfitz@273k.net> <11669707101872-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUON-0005W6-97
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWLXObw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWLXObw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:52 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32876 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbWLXObw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:52 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNr-0002um-Om; Sun, 24 Dec 2006 14:31:28 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: <11669707101872-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35366>


Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 42b7449..53dd225 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2910,18 +2910,18 @@ sub git_heads_body {
 }
 
 sub git_search_grep_body {
-	my ($greplist, $from, $to, $extra) = @_;
+	my ($commitlist, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
-	$to = $#{$greplist} if (!defined $to || $#{$greplist} < $to);
+	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
 	print "<table class=\"grep\" cellspacing=\"0\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
-		my $commit = $greplist->[$i];
-		my %co = parse_commit($commit);
+		my %co = %{$commitlist->[$i]};
 		if (!%co) {
 			next;
 		}
+		my $commit = $co{'id'};
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -4307,13 +4307,8 @@ sub git_search {
 		} elsif ($searchtype eq 'committer') {
 			$greptype = "--committer=";
 		}
-		open my $fd, "-|", git_cmd(), "rev-list",
-			("--max-count=" . (100 * ($page+1))),
-			($greptype . $searchtext),
-			$hash, "--"
-			or next;
-		my @revlist = map { chomp; $_ } <$fd>;
-		close $fd;
+		$greptype .= $searchtext;
+		my @commitlist = parse_commits($hash, 101, (100 * $page), $greptype);
 
 		my $paging_nav = '';
 		if ($page > 0) {
@@ -4330,7 +4325,7 @@ sub git_search {
 			$paging_nav .= "first";
 			$paging_nav .= " &sdot; prev";
 		}
-		if ($#revlist >= (100 * ($page+1)-1)) {
+		if ($#commitlist >= 100) {
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
 						       searchtext=>$searchtext, searchtype=>$searchtype,
@@ -4340,7 +4335,7 @@ sub git_search {
 			$paging_nav .= " &sdot; next";
 		}
 		my $next_link = '';
-		if ($#revlist >= (100 * ($page+1)-1)) {
+		if ($#commitlist >= 100) {
 			$next_link =
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
 						       searchtext=>$searchtext, searchtype=>$searchtype,
@@ -4350,7 +4345,7 @@ sub git_search {
 
 		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
-		git_search_grep_body(\@revlist, ($page * 100), $#revlist, $next_link);
+		git_search_grep_body(\@commitlist, 0, 99, $next_link);
 	}
 
 	if ($searchtype eq 'pickaxe') {
-- 
1.4.4.3.ge655-dirty

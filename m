From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/7] gitweb: Use parse_rev_list in git_shortlog and git_history
Date: Wed,  6 Sep 2006 15:08:09 +0200
Message-ID: <11575480921279-git-send-email-jnareb@gmail.com>
References: <200609061504.40725.jnareb@gmail.com> <1157548091229-git-send-email-jnareb@gmail.com> <11575480912922-git-send-email-jnareb@gmail.com> <11575480922090-git-send-email-jnareb@gmail.com> <11575480922634-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:08:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx8l-0005m3-GN
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWIFNIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWIFNIY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:08:24 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:43243 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750875AbWIFNIT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:08:19 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86D6qpQ031863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 15:06:52 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86D8Ctm008419;
	Wed, 6 Sep 2006 15:08:12 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86D8CUB008418;
	Wed, 6 Sep 2006 15:08:12 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11575480922634-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26523>

Use parse_rev_list in git_shortlog and git_history, and modify
git_shortlog_body and git_history_body to accept parse_rev_list
output; in the future we can remove support for older unparsed
revision list from git_shortlog_body and git_history_body.

Other places when we can use parse_rev_list are git_log and git_rss.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8aeca52..e665d94 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1946,7 +1946,7 @@ sub git_shortlog_body {
 		my $commit = $revlist->[$i];
 		#my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
 		my $ref = format_ref_marker($refs, $commit);
-		my %co = parse_commit($commit);
+		my %co = ref $commit ? %$commit : parse_commit($commit);
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -1987,12 +1987,13 @@ sub git_history_body {
 	print "<table class=\"history\" cellspacing=\"0\">\n";
 	my $alternate = 0;
 	for (my $i = $from; $i <= $to; $i++) {
-		if ($revlist->[$i] !~ m/^([0-9a-fA-F]{40})/) {
+		if (ref($revlist->[$i]) ne "HASH" &&
+		    $revlist->[$i] !~ m/^([0-9a-fA-F]{40})/) {
 			next;
 		}
 
 		my $commit = $1;
-		my %co = parse_commit($commit);
+		my %co = ref $commit ? %$commit : parse_commit($commit);
 		if (!%co) {
 			next;
 		}
@@ -3179,12 +3180,9 @@ sub git_history {
 		$ftype = git_get_type($hash);
 	}
 
-	open my $fd, "-|",
-		git_cmd(), "rev-list", $limit, @hist_opts, $hash_base, "--", $file_name
-			or die_error(undef, "Open git-rev-list-failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd
-		or die_error(undef, "Reading git-rev-list failed");
+	my @revlist = parse_rev_list($limit, @hist_opts, $hash_base, "--", $file_name)
+		or die_error(undef, "Parsing git-rev-list failed");
+
 
 	my $paging_nav = '';
 	if ($page > 0) {
@@ -3387,10 +3385,9 @@ sub git_shortlog {
 	my $refs = git_get_references();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
-		or die_error(undef, "Open git-rev-list failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd;
+	my @revlist = parse_rev_list($limit, $hash)
+		or die_error(undef, "Parsing git-rev-list failed");
+
 
 	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#revlist);
 	my $next_link = '';
-- 
1.4.2

From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/7] gitweb: Paginate history output
Date: Wed,  6 Sep 2006 15:08:06 +0200
Message-ID: <11575480912922-git-send-email-jnareb@gmail.com>
References: <200609061504.40725.jnareb@gmail.com> <1157548091229-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:08:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx8g-0005m3-2q
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWIFNIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWIFNIS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:08:18 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:39147 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750844AbWIFNIQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:08:16 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86D6qIW031853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 15:06:52 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86D8BSu008401;
	Wed, 6 Sep 2006 15:08:11 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86D8BIW008400;
	Wed, 6 Sep 2006 15:08:11 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1157548091229-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26522>

git_history output is now divided into pages, like git_shortlog,
git_tags and git_heads output. As whole git-rev-list output is now
read into array before writing anything, it allows for better
signaling of errors.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   61 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e95d16f..4c76032 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1936,12 +1936,15 @@ sub git_shortlog_body {
 
 sub git_history_body {
 	# Warning: assumes constant type (blob or tree) during history
-	my ($fd, $refs, $hash_base, $ftype, $extra) = @_;
+	my ($revlist, $from, $to, $refs, $hash_base, $ftype, $extra) = @_;
+
+	$from = 0 unless defined $from;
+	$to = $#{$revlist} unless (defined $to && $to <= $#{$revlist});
 
 	print "<table class=\"history\" cellspacing=\"0\">\n";
 	my $alternate = 0;
-	while (my $line = <$fd>) {
-		if ($line !~ m/^([0-9a-fA-F]{40})/) {
+	for (my $i = $from; $i <= $to; $i++) {
+		if ($revlist->[$i] !~ m/^([0-9a-fA-F]{40})/) {
 			next;
 		}
 
@@ -3122,24 +3125,62 @@ sub git_history {
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
+
 	my $refs = git_get_references();
-	git_header_html();
-	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base);
-	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
+
 	if (!defined $hash && defined $file_name) {
 		$hash = git_get_hash_by_path($hash_base, $file_name);
 	}
 	if (defined $hash) {
 		$ftype = git_get_type($hash);
 	}
-	git_print_page_path($file_name, $ftype, $hash_base);
 
 	open my $fd, "-|",
-		git_cmd(), "rev-list", "--full-history", $hash_base, "--", $file_name;
+		git_cmd(), "rev-list", $limit, "--full-history", $hash_base, "--", $file_name
+			or die_error(undef, "Open git-rev-list-failed");
+	my @revlist = map { chomp; $_ } <$fd>;
+	close $fd
+		or die_error(undef, "Reading git-rev-list failed");
 
-	git_history_body($fd, $refs, $hash_base, $ftype);
+	my $paging_nav = '';
+	if ($page > 0) {
+		$paging_nav .=
+			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
+			                       file_name=>$file_name)},
+			        "first");
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
+			                       file_name=>$file_name, page=>$page-1),
+			         -accesskey => "p", -title => "Alt-p"}, "prev");
+	} else {
+		$paging_nav .= "first";
+		$paging_nav .= " &sdot; prev";
+	}
+	if ($#revlist >= (100 * ($page+1)-1)) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
+			                       file_name=>$file_name, page=>$page+1),
+			         -accesskey => "n", -title => "Alt-n"}, "next");
+	} else {
+		$paging_nav .= " &sdot; next";
+	}
+	my $next_link = '';
+	if ($#revlist >= (100 * ($page+1)-1)) {
+		$next_link =
+			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
+			                       file_name=>$file_name, page=>$page+1),
+			         -title => "Alt-n"}, "next");
+	}
+
+	git_header_html();
+	git_print_page_nav('history','', $hash_base,$co{'tree'},$hash_base, $paging_nav);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_path($file_name, $ftype, $hash_base);
+
+	git_history_body(\@revlist, ($page * 100), $#revlist,
+	                 $refs, $hash_base, $ftype, $next_link);
 
-	close $fd;
 	git_footer_html();
 }
 
-- 
1.4.2

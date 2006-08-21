From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Paginate history output
Date: Tue, 22 Aug 2006 00:53:10 +0200
Message-ID: <200608220053.10741.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 22 00:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFIeF-00032j-PD
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 00:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWHUWxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 18:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWHUWx3
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 18:53:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13978 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751274AbWHUWxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 18:53:13 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2011363nfa
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 15:53:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kJvOLVW+258z2v4SRjwGfrcGSBB7HDKOjJmZw2nBZqb+SL0GjYe5tp0RixTZzxRFAksI2uMe5HY16eHX456qAqEowRvHpPf+vIOXx5+QpSV7ADyrhhvvHJDUVJTn9WgGRzagMRnFAssKxX9oJbFJibc2ZbHE+3Os+390/Um/zyE=
Received: by 10.48.230.18 with SMTP id c18mr153151nfh;
        Mon, 21 Aug 2006 15:53:12 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id c10sm471435nfb.2006.08.21.15.53.11;
        Mon, 21 Aug 2006 15:53:11 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25826>

git_history output is now divided into pages, like git_shortlog,
git_tags and git_heads output. As whole git-rev-list output is now
read into array before writing anything, it allows for better
signaling of errors.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Based on 'next' branch, but should apply to 'master as well.

 gitweb/gitweb.perl |   59 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 31a1824..90157d5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1544,12 +1544,15 @@ sub git_shortlog_body {
 
 sub git_history_body {
 	# Warning: assumes constant type (blob or tree) during history
-	my ($fd, $refs, $hash_base, $ftype, $extra) = @_;
+	my ($revlist, $from, $to, $refs, $hash_base, $ftype, $extra) = @_;
+
+	$from = 0 unless defined $from;
+	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
 	print "<table class=\"history\" cellspacing=\"0\">\n";
 	my $alternate = 0;
-	while (my $line = <$fd>) {
-		if ($line !~ m/^([0-9a-fA-F]{40})/) {
+	for (my $i = $from; $i <= $to; $i++) {
+		if ($revlist->[$i] !~ m/^([0-9a-fA-F]{40})/) {
 			next;
 		}
 
@@ -1559,6 +1562,7 @@ sub git_history_body {
 			next;
 		}
 
+		#my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
 		my $ref = format_ref_marker($refs, $commit);
 
 		if ($alternate) {
@@ -2651,21 +2655,62 @@ sub git_history {
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
+
+	open my $fd, "-|",
+		$GIT, "rev-list", $limit, "--full-history", $hash_base, "--", $file_name
+			or die_error(undef, "Open git-rev-list-failed");
+	my @revlist = map { chomp; $_ } <$fd>;
+	close $fd;
+
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
 	git_print_page_path($file_name, $ftype, $hash_base);
 
 	open my $fd, "-|",
 		$GIT, "rev-list", "--full-history", $hash_base, "--", $file_name;
-	git_history_body($fd, $refs, $hash_base, $ftype);
+	git_history_body(\@revlist, ($page * 100), $#revlist,
+	                 $refs, $hash_base, $ftype, $next_link);
 
 	close $fd;
 	git_footer_html();
-- 
1.4.1.1

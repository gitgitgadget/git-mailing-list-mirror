From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Paginate history output
Date: Mon, 11 Sep 2006 00:36:04 +0200
Message-ID: <200609110036.04827.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 11 00:36:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMXuP-0003Bf-3i
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 00:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWIJWgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 18:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWIJWgJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 18:36:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:55786 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932164AbWIJWgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 18:36:08 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1046342ugc
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 15:36:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EC2d+TCb4p1TB29R86qaLMnupco2Sfk5vS5cOPBmZw6OOYZikP0fQhqamWSD9iYssqPn98XfhKi2EeuiB+W98jYXySEPwXD6DafSnq1cGWyLEILa9w1/3y1XKA7INrjLekJ8l9BxgQ5rrJt1aY+xycMoRdmDb4+5hW35TeqqESI=
Received: by 10.67.89.5 with SMTP id r5mr2403923ugl;
        Sun, 10 Sep 2006 15:36:05 -0700 (PDT)
Received: from host-81-190-17-209.torun.mm.pl ( [81.190.17.209])
        by mx.gmail.com with ESMTP id m1sm7902664uge.2006.09.10.15.36.04;
        Sun, 10 Sep 2006 15:36:04 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26819>

git_history output is now divided into pages, like git_shortlog,
git_tags and git_heads output. As whole git-rev-list output is now
read into array before writing anything, it allows for better
signaling of errors.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This can be seen as the part of series consolidating log-like
view (shortlog, log, history, perhaps tags and heads) generation.

 gitweb/gitweb.perl |   64 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 53e3478..c3544dd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1933,12 +1933,15 @@ sub git_shortlog_body {
 
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
 
@@ -3114,29 +3117,70 @@ sub git_history {
 	if (!defined $hash_base) {
 		$hash_base = git_get_head_hash($project);
 	}
+	if (!defined $page) {
+		$page = 0;
+	}
 	my $ftype;
 	my %co = parse_commit($hash_base);
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
 
-	git_history_body($fd, $refs, $hash_base, $ftype);
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

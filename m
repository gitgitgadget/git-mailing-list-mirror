From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 9] gitweb: Navbar refactoring - use git_page_nav to generate navigation bar
Date: Sun, 30 Jul 2006 15:01:07 +0200
Message-ID: <200607301501.08175.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 15:01:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Auq-0007ji-O7
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 15:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWG3NBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 09:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWG3NBE
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 09:01:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:33456 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932308AbWG3NBC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 09:01:02 -0400
Received: by ug-out-1314.google.com with SMTP id m3so358701ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 06:01:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fZygXZzzcrd29SlI93LpIOc/wzGsupKrYEwu+1rZpa1l/ozPw62zsD2+hf6ekhM1NpnHpuQze3tRhBtKqbazXvaaydeI/ztFU8ZjM3BMlF49xFm8ZhVaKWBUljZmL6NMIqGPhO+kvjnifJIsKAl4B0vAEkDkwujxmr29rb9dlDE=
Received: by 10.67.119.13 with SMTP id w13mr1523202ugm;
        Sun, 30 Jul 2006 06:01:01 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id a1sm4109034ugf.2006.07.30.06.01.00;
        Sun, 30 Jul 2006 06:01:00 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24454>

Use git_page_nav subroutine to generate navigation bar.  Additional
navigation (either formats or pager/pagination) is put into variables.

Corrects error in git_search where hash parameter was added to
"summary" link instead of to "log" link.  Might differ from previous
version by additional "<br/>" in navigation bar.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |  235 +++++++++++++++--------------------------------------
 1 files changed, 66 insertions(+), 169 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2bc3445..6c72d33 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1081,15 +1081,7 @@ sub git_summary {
 
 	my $refs = read_info_ref();
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      "summary".
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$head")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$head")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree")}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	git_page_nav('summary','', $head);
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
@@ -1251,15 +1243,7 @@ sub git_print_page_path {
 sub git_tag {
 	my $head = git_read_head($project);
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$head")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$head")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;hb=$head")}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	git_page_nav('','', $head,undef,$head);
 	my %tag = git_read_tag($hash);
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash"), -class => "title"}, esc_html($tag{'name'})) . "\n" .
@@ -1307,19 +1291,13 @@ sub git_blame2 {
 	open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed.");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
-	print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head") . "<br/>\n";
-	print "</div>\n".
-		"<div>" .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
-		"</div>\n";
+	my $formats_nav = 
+		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
+	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+	print "<div>" .
+	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
+	      "</div>\n";
 	git_print_page_path($file_name, $ftype);
 	my @rev_color = (qw(light dark));
 	my $num_colors = scalar(@rev_color);
@@ -1369,19 +1347,13 @@ sub git_blame {
 	open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
 		or die_error(undef, "Open git-annotate failed.");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
-	print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head") . "<br/>\n";
-	print "</div>\n".
-		"<div>" .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
-		"</div>\n";
+	my $formats_nav = 
+		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
+	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+	print "<div>" .
+	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
+	      "</div>\n";
 	git_print_page_path($file_name);
 	print "<div class=\"page_body\">\n";
 	print <<HTML;
@@ -1456,15 +1428,7 @@ HTML
 sub git_tags {
 	my $head = git_read_head($project);
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$head")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$head")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;hb=$head")}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	git_page_nav('','', $head,undef,$head);
 	my $taglist = git_read_refs("refs/tags");
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
@@ -1515,15 +1479,7 @@ sub git_tags {
 sub git_heads {
 	my $head = git_read_head($project);
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$head")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$head")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;hb=$head")}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	git_page_nav('','', $head,undef,$head);
 	my $taglist = git_read_refs("refs/heads");
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
@@ -1684,25 +1640,20 @@ sub git_blob {
 		return git_blob_plain($mimetype);
 	}
 	git_header_html();
+	my $formats_nav = '';
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
 		if (defined $file_name) {
 			if ($have_blame) {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") .  " | ";
+				$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") . " | ";
 			}
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
-			" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=HEAD;f=$file_name")}, "head") . "<br/>\n";
+			$formats_nav .=
+				$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
+				" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=HEAD;f=$file_name")}, "head");
 		} else {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain") . "<br/>\n";
+			$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain");
 		}
-		print "</div>\n".
-		      "<div>" .
+		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+		print "<div>" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
 		      "</div>\n";
 	} else {
@@ -1757,15 +1708,7 @@ sub git_tree {
 	my $base = "";
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
 		$base_key = ";hb=$hash_base";
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash_base")}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash_base")}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
-		      " | tree" .
-		      "<br/><br/>\n" .
-		      "</div>\n";
+		git_page_nav('tree','', $hash_base);
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'}) . $ref) . "\n" .
 		      "</div>\n";
@@ -1922,14 +1865,6 @@ sub git_log {
 		$page = 0;
 	}
 	my $refs = read_info_ref();
-	git_header_html();
-	print "<div class=\"page_nav\">\n";
-	print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash")}, "shortlog") .
-	      " | log" .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash 
@@ -1937,25 +1872,28 @@ sub git_log {
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
+	my $paging_nav = '';
 	if ($hash ne $head || $page) {
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "HEAD");
+		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "HEAD");
 	} else {
-		print "HEAD";
+		$paging_nav .= "HEAD";
 	}
 	if ($page > 0) {
-		print " &sdot; " .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash;pg=" . ($page-1)), -accesskey => "p", -title => "Alt-p"}, "prev");
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash;pg=" . ($page-1)), -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
-		print " &sdot; prev";
+		$paging_nav .= " &sdot; prev";
 	}
 	if ($#revlist >= (100 * ($page+1)-1)) {
-		print " &sdot; " .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash;pg=" . ($page+1)), -accesskey => "n", -title => "Alt-n"}, "next");
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash;pg=" . ($page+1)), -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
-		print " &sdot; next";
+		$paging_nav .= " &sdot; next";
 	}
-	print "<br/>\n" .
-	      "</div>\n";
+
+	git_header_html();
+	git_page_nav('log','', $hash,undef,undef, $paging_nav);
+
 	if (!@revlist) {
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
@@ -2037,21 +1975,14 @@ sub git_commit {
 		$ref = " <span class=\"tag\">" . esc_html($refs->{$co{'id'}}) . "</span>";
 	}
 	git_header_html(undef, $expires);
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash")}, "log") .
-	      " | commit";
-	if (defined $co{'parent'}) {
-		print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash")}, "commitdiff");
-	}
-	print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") . "\n" .
-		"<br/>\n";
+	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;hb=$parent;f=$file_name")}, "blame") . "\n";
+		$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;hb=$parent;f=$file_name")}, "blame");
 	}
-	print "<br/></div>\n";
+	git_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff', 
+							 $hash, $co{'tree'}, $hash,
+							 $formats_nav);
 
 	if (defined $co{'parent'}) {
 		print "<div>\n" .
@@ -2223,16 +2154,9 @@ sub git_blobdiff {
 	mkdir($git_temp, 0700);
 	git_header_html();
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") .
-		      "<br/>\n";
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent")}, "plain") .
-		      "</div>\n";
+		my $formats_nav = 
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
+		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) . "\n" .
 		      "</div>\n";
@@ -2284,15 +2208,9 @@ sub git_commitdiff {
 		$ref = " <span class=\"tag\">" . esc_html($refs->{$co{'id'}}) . "</span>";
 	}
 	git_header_html(undef, $expires);
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash")}, "commit") .
-	      " | commitdiff" .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") . "<br/>\n";
-	print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent")}, "plain") . "\n" .
-	      "</div>\n";
+	my $formats_nav =
+		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
+	git_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash"), -class => "title"}, esc_html($co{'title'}) . $ref) . "\n" .
 	      "</div>\n";
@@ -2424,15 +2342,7 @@ sub git_history {
 	}
 	my $refs = read_info_ref();
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	git_page_nav('','', $hash_base,$co{'tree'},$hash_base);
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) . "\n" .
 	      "</div>\n";
@@ -2515,15 +2425,7 @@ sub git_search {
 		$pickaxe_search = 1;
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary;h=$hash")}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	git_page_nav('','', $hash,$co{'tree'},$hash);
 
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash"), -class => "title"}, esc_html($co{'title'})) . "\n" .
@@ -2643,14 +2545,6 @@ sub git_shortlog {
 		$page = 0;
 	}
 	my $refs = read_info_ref();
-	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
-	      " | shortlog" .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash 
@@ -2658,25 +2552,28 @@ sub git_shortlog {
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
+	my $paging_nav = '';
 	if ($hash ne $head || $page) {
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "HEAD");
+		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "HEAD");
 	} else {
-		print "HEAD";
+		$paging_nav .= "HEAD";
 	}
 	if ($page > 0) {
-		print " &sdot; " .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page-1)), -accesskey => "p", -title => "Alt-p"}, "prev");
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page-1)), -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
-		print " &sdot; prev";
+		$paging_nav .= " &sdot; prev";
 	}
 	if ($#revlist >= (100 * ($page+1)-1)) {
-		print " &sdot; " .
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page+1)), -accesskey => "n", -title => "Alt-n"}, "next");
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page+1)), -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
-		print " &sdot; next";
+		$paging_nav .= " &sdot; next";
 	}
-	print "<br/>\n" .
-	      "</div>\n";
+
+	git_header_html();
+	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
+
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
 	      "</div>\n";
-- 
1.4.0

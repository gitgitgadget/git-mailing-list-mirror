From: Sven Verdoolaege <skimo@liacs.nl>
Subject: gitweb and tar snapshots
Date: Sat, 18 Jun 2005 13:31:21 +0200
Message-ID: <20050618113121.GA13122@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Cc: Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 13:26:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjbT1-00077l-1v
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 13:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVFRLbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 07:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVFRLbv
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 07:31:51 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:58013 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261468AbVFRLb1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2005 07:31:27 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5IBVLh8031563;
	Sat, 18 Jun 2005 13:31:26 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 3D2EC6FE9; Sat, 18 Jun 2005 13:31:21 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached two patches.

The first factors out the generation of the navigation bar.
The second, which depends on the first, adds "snapshot" to
the navigation bar.

The patches are against (a slightly modified) version 222.

skimo

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gitweb-nav

diff --git a/gitweb.cgi b/gitweb.cgi
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -283,6 +283,27 @@ EOF
 	print "</div>\n";
 }
 
+sub git_page_nav {
+	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
+	$extra = '' if !defined $extra;
+	my @navs = qw(summary shortlog log commit commitdiff tree);
+	my %arg = map { $_, ''} @navs;
+	if (defined $head) {
+		for (qw(shortlog log commit commitdiff)) {
+			$arg{$_} = ";h=$head";
+		}
+	}
+	$arg{tree} .= ";h=$treehead" if defined $treehead;
+	$arg{tree} .= ";hb=$treebase" if defined $treebase;
+
+	print "<div class=\"page_nav\">\n" .
+		(join " | ", map { $_ eq $current ? $_ :
+			$cgi->a({-href => "$my_uri?p=$project;a=$_$arg{$_}"}, "$_") }
+			grep { $_ ne $suppress } @navs) .
+	      "<br/>$extra<br/>\n" .
+	      "</div>\n";
+}
+
 sub git_footer_html {
 	print "<div class=\"page_footer\">\n";
 	if (defined $project) {
@@ -816,15 +837,7 @@ sub git_summary {
 	}
 
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      "summary".
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree"}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	git_page_nav('summary', '', $head);
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . escapeHTML($descr) . "</td></tr>\n" .
@@ -949,15 +962,7 @@ sub git_summary {
 sub git_tags {
 	my $head = git_read_hash("$project/HEAD");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;hb=$head"}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	git_page_nav('', '', $head, undef, $head);
 	my $taglist = git_read_refs("refs/tags");
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=summary", -class => "title"}, "&nbsp;") .
@@ -995,15 +1000,7 @@ sub git_tags {
 sub git_branches {
 	my $head = git_read_hash("$project/HEAD");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$head"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$head"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;hb=$head"}, "tree") . "<br/>\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	git_page_nav('', '', $head, undef, $head);
 	my $taglist = git_read_refs("refs/heads");
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=summary", -class => "title"}, "&nbsp;") .
@@ -1073,15 +1070,9 @@ sub git_blob {
 	my $base = $file_name || "";
 	git_header_html();
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base"}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash_base"}, "commitdiff") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash_base"}, "tree") . "<br/>\n";
-		print $cgi->a({-href => "$my_uri?p=$project;a=blob_plain;h=$hash"}, "plain") . "<br/>\n" .
-		      "</div>\n";
+		git_page_nav('', '', $hash_base, $co{'tree'}, $hash_base,
+			$cgi->a({-href => "$my_uri?p=$project;a=blob_plain;h=$hash"}, "plain")
+		);
 		print "<div>" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base", -class => "title"}, escapeHTML($co{'title'})) .
 		      "</div>\n";
@@ -1141,15 +1132,7 @@ sub git_tree {
 	my $base = "";
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
 		$base_key = ";hb=$hash_base";
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash_base"}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash_base"}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base"}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash_base"}, "commitdiff") .
-		      " | tree" .
-		      "<br/><br/>\n" .
-		      "</div>\n";
+		git_page_nav('tree', '', $hash_base);
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 		      "</div>\n";
@@ -1286,38 +1269,30 @@ sub git_log {
 		$page = 0;
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n";
-	print $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash"}, "shortlog") .
-	      " | log" .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$hash;hb=$hash"}, "tree") . "<br/>\n";
-
+	my $extra = '';
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
 	if ($hash ne $head || $page) {
-		print $cgi->a({-href => "$my_uri?p=$project;a=log"}, "HEAD");
+		$extra .= $cgi->a({-href => "$my_uri?p=$project;a=log"}, "HEAD");
 	} else {
-		print "HEAD";
+		$extra .= "HEAD";
 	}
 	if ($page > 0) {
-		print " &sdot; " .
+		$extra .= " &sdot; " .
 		$cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash;pg=" . ($page-1), -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
-		print " &sdot; prev";
+		$extra .= " &sdot; prev";
 	}
 	if ($#revlist >= (100 * ($page+1)-1)) {
-		print " &sdot; " .
+		$extra .= " &sdot; " .
 		$cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash;pg=" . ($page+1), -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
-		print " &sdot; next";
+		$extra .= " &sdot; next";
 	}
-	print "<br/>\n" .
-	      "</div>\n";
+	git_page_nav('log', '', $hash, $hash, $hash, $extra);
 	if (!@revlist) {
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=summary", -class => "title"}, "&nbsp;") .
@@ -1384,16 +1359,8 @@ sub git_commit {
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
-	      " | commit";
-	if (defined $co{'parent'}) {
-		print " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff");
-	}
-	print " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") . "\n" .
-	      "<br/><br/></div>\n";
+	git_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
+		$hash, $co{'tree'}, $hash);
 	if (defined $co{'parent'}) {
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
@@ -1563,16 +1530,9 @@ sub git_blobdiff {
 	mkdir($git_temp, 0700);
 	git_header_html();
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
-		print "<div class=\"page_nav\">\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base"}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash_base"}, "commitdiff") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash_base"}, "tree") .
-		      "<br/>\n";
-		print $cgi->a({-href => "$my_uri?p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent"}, "plain") .
-		      "</div>\n";
+		git_page_nav('', '', $hash_base, $co{'tree'}, $hash_base,
+			$cgi->a({-href => "$my_uri?p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent"}, "plain")
+		);
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash_base", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 		      "</div>\n";
@@ -1615,15 +1575,9 @@ sub git_commitdiff {
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | commitdiff" .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") . "<br/>\n";
-	print $cgi->a({-href => "$my_uri?p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent"}, "plain") . "\n" .
-	      "</div>\n";
+	git_page_nav('commitdiff', '', $hash, $co{'tree'}, $hash,
+		$cgi->a({-href => "$my_uri?p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent"}, "plain")
+	);
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 	      "</div>\n";
@@ -1731,15 +1685,7 @@ sub git_history {
 		die_error(undef, "Unknown commit object.");
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	git_page_nav('', '', $hash, $co{'tree'}, $hash);
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 	      "</div>\n";
@@ -1815,15 +1761,7 @@ sub git_search {
 		$pickaxe_search = 1;
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary;h=$hash"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") .
-	      "<br/><br/>\n" .
-	      "</div>\n";
+	git_page_nav('', '', $hash, $co{'tree'}, $hash);
 
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
@@ -1944,13 +1882,7 @@ sub git_shortlog {
 		$page = 0;
 	}
 	git_header_html();
-	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | shortlog" .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash"}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$hash;hb=$hash"}, "tree") . "<br/>\n";
+	git_page_nav('shortlog', '', $hash, $hash, $hash);
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gitweb-snapshot

diff --git a/gitweb.cgi b/gitweb.cgi
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -178,6 +178,9 @@ if ($action eq "summary") {
 } elsif ($action eq "shortlog") {
 	git_shortlog();
 	exit;
+} elsif ($action eq "snapshot") {
+	git_snapshot();
+	exit;
 } else {
 	undef $action;
 	die_error(undef, "Unknown action.");
@@ -286,10 +289,10 @@ EOF
 sub git_page_nav {
 	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
 	$extra = '' if !defined $extra;
-	my @navs = qw(summary shortlog log commit commitdiff tree);
+	my @navs = qw(summary shortlog log commit commitdiff tree snapshot);
 	my %arg = map { $_, ''} @navs;
 	if (defined $head) {
-		for (qw(shortlog log commit commitdiff)) {
+		for (qw(shortlog log commit commitdiff snapshot)) {
 			$arg{$_} = ";h=$head";
 		}
 	}
@@ -1943,3 +1946,77 @@ sub git_shortlog {
 	print "</table\n>";
 	git_footer_html();
 }
+
+sub git_snapshot {
+	if (!defined $hash) {
+		$hash = git_read_hash("$project/HEAD");
+	}
+	my %co = git_read_commit($hash);
+	if (!%co) {
+		die_error(undef, "Unknown commit object.");
+	}
+	my $st = $cgi->param('st');
+	if (defined $st) {
+		return git_serve_snapshot($st);
+	}
+
+	git_header_html();
+	git_page_nav('snapshot', '', $hash, $co{'tree'}, $hash);
+	print "<div>\n" .
+	      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
+	      "</div>\n";
+	print "<table cellspacing=\"0\">\n" .
+	      "<tr>\n" .
+	      "<th>Type</th>\n" .
+	      "<th></th>\n" .
+	      "</tr>\n";
+	my %types = (
+		'Bzipped tar archive' => 'tar.bz2',
+		'Gzipped tar archive' => 'tar.gz',
+	);
+	my $alternate = 0;
+	for my $type (sort keys %types) {
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td>$type</td>";
+		$cgi->param("a", "snapshot");
+		print "<td>" .
+		      $cgi->startform(-method => "get", -action => "$my_uri") .
+		      $cgi->hidden(-name => "p") . "\n" .
+		      $cgi->hidden(-name => "a") . "\n" .
+		      $cgi->hidden(-name => "h") . "\n" .
+		      $cgi->hidden(-name => "st", 
+				   -value => $types{$type}) . "\n" .
+		      $cgi->submit(-label => 'Download') . "\n" .
+		      $cgi->end_form() . "\n" .
+		      "</td>";
+	        print "</tr>\n";
+	}
+	print "</table>\n";
+	git_footer_html();
+	return;
+}
+
+sub git_serve_snapshot {
+	my ($st) = @_;
+	my %info = (
+		'tar.bz2' => [ 'application/x-bzip2', 'bzip2' ],
+		'tar.gz' => [ 'application/x-gzip', 'gzip' ],
+	);
+	if (!exists $info{$st}) {
+		die_error(undef, "Unknown snapshot type.");
+	}
+	my ($type, $zip) = @{$info{$st}};
+	print $cgi->header(-type => $type, 
+			   -attachment => "$project-$hash.$st");
+	open my $fd, "-|", "$gitbin/git-tar-tree $hash '$project-$hash' | $zip" 
+		or return;
+	undef $/;
+	print <$fd>;
+	$/ = "\n";
+	close $fd;
+}

--PEIAKu/WMn1b1Hv9--

From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 3/3] gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'}
Date: Wed, 21 Jun 2006 15:09:30 +0200
Message-ID: <20060621130930.G421234bb@leonov.stosberg.net>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 15:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2St-0000lK-Sm
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWFUNJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWFUNJh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:09:37 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:36836 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751563AbWFUNJf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 09:09:35 -0400
Received: from leonov.stosberg.net (p213.54.85.218.tisdip.tiscali.de [213.54.85.218])
	by ncs.stosberg.net (Postfix) with ESMTP id 8C7CBAEBA065;
	Wed, 21 Jun 2006 15:09:26 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id E627E10E081; Wed, 21 Jun 2006 15:09:30 +0200 (CEST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060621130535.G2b34d382@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22269>

---
 gitweb/gitweb.cgi |   67 +++++++++++++++++++++++++++--------------------------
 1 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 8f19fdb..57ac3a3 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -61,6 +61,9 @@ # file to use for guessing MIME types be
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
+# path to the project's repository
+our $git_dir = undef;
+
 # input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
@@ -101,7 +104,7 @@ if (defined $project) {
 	}
 	$rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
 		    "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";
-	$ENV{'GIT_DIR'} = "$projectroot/$project";
+	$git_dir = "$projectroot/$project";
 } else {
 	git_project_list();
 	exit;
@@ -372,7 +375,7 @@ sub die_error {
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", "$gitbin/git-cat-file -t $hash" or return;
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file -t $hash" or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -381,19 +384,15 @@ sub git_get_type {
 
 sub git_read_head {
 	my $project = shift;
-	my $oENV = $ENV{'GIT_DIR'};
 	my $retval = undef;
-	$ENV{'GIT_DIR'} = "$projectroot/$project";
-	if (open my $fd, "-|", "$gitbin/git-rev-parse", "--verify", "HEAD") {
+
+	if (open my $fd, "-|", "$gitbin/git", "--git-dir=$projectroot/$project", "rev-parse", "--verify", "HEAD") {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
 			$retval = $1;
 		}
 	}
-	if (defined $oENV) {
-		$ENV{'GIT_DIR'} = $oENV;
-	}
 	return $retval;
 }
 
@@ -424,7 +423,7 @@ sub git_read_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", "$gitbin/git-cat-file tag $tag_id" or return;
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file tag $tag_id" or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -496,7 +495,7 @@ sub git_read_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", "$gitbin/git-rev-list --header --parents --max-count=1 $commit_id" or return;
+		open my $fd, "-|", "$gitbin/git  --git-dir=$git_dir rev-list --header --parents --max-count=1 $commit_id" or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
 		$/ = "\n";
@@ -594,7 +593,7 @@ sub git_diff_print {
 	if (defined $from) {
 		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
 		open my $fd2, "> $from_tmp";
-		open my $fd, "-|", "$gitbin/git-cat-file blob $from";
+		open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file blob $from";
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -605,7 +604,7 @@ sub git_diff_print {
 	if (defined $to) {
 		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
 		open my $fd2, "> $to_tmp";
-		open my $fd, "-|", "$gitbin/git-cat-file blob $to";
+		open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file blob $to";
 		my @file = <$fd>;
 		print $fd2 @file;
 		close $fd2;
@@ -844,10 +843,12 @@ sub git_project_list {
 	}
 	foreach my $pr (@list) {
 		my $head = git_read_head($pr->{'path'});
+		print STDERR $head;
+
 		if (!defined $head) {
 			next;
 		}
-		$ENV{'GIT_DIR'} = "$projectroot/$pr->{'path'}";
+		$git_dir = "$projectroot/$pr->{'path'}";
 		my %co = git_read_commit($head);
 		if (!%co) {
 			next;
@@ -1046,7 +1047,7 @@ sub git_summary {
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 	print "<div>\n" .
@@ -1224,7 +1225,7 @@ sub git_tag {
 
 sub git_blame {
 	my $fd;
-	die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool ('blame'));
+	#die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool ('blame'));
 	die_error('404 Not Found', "What file will it be, master?") if (!$file_name);
 	$hash_base ||= git_read_head($project);
 	die_error(undef, "Reading commit failed.") unless ($hash_base);
@@ -1234,7 +1235,7 @@ sub git_blame {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(undef, "Error lookup file.");
 	}
-	open ($fd, "-|", "$gitbin/git-annotate", '-l', '-t', '-r', $file_name, $hash_base)
+	open ($fd, "-|", "$gitbin/git", "--git-dir=$git_dir", "annotate", '-l', '-t', '-r', $file_name, $hash_base)
 		or die_error(undef, "Open failed.");
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
@@ -1429,7 +1430,7 @@ sub git_get_hash_by_path {
 	my $tree = $base;
 	my @parts = split '/', $path;
 	while (my $part = shift @parts) {
-		open my $fd, "-|", "$gitbin/git-ls-tree $tree" or die_error(undef, "Open git-ls-tree failed.");
+		open my $fd, "-|", "$gitbin/git --git-dir=$git_dir ls-tree $tree" or die_error(undef, "Open git-ls-tree failed.");
 		my (@entries) = map { chomp; $_ } <$fd>;
 		close $fd or return undef;
 		foreach my $line (@entries) {
@@ -1457,8 +1458,8 @@ sub git_blob {
 		my $base = $hash_base || git_read_head($project);
 		$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
 	}
-	my $have_blame = git_get_project_config_bool ('blame');
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error(undef, "Open failed.");
+	my $have_blame = 1; #git_get_project_config_bool ('blame');
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file blob $hash" or die_error(undef, "Open failed.");
 	git_header_html();
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
 		print "<div class=\"page_nav\">\n" .
@@ -1570,7 +1571,7 @@ sub git_blob_plain_mimetype {
 }
 
 sub git_blob_plain {
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or return;
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file blob $hash" or return;
 	my $type = git_blob_plain_mimetype($fd, $file_name);
 
 	# save as filename, even when no $file_name is given
@@ -1602,7 +1603,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", "$gitbin/git-ls-tree -z $hash" or die_error(undef, "Open git-ls-tree failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir ls-tree -z $hash" or die_error(undef, "Open git-ls-tree failed.");
 	chomp (my (@entries) = <$fd>);
 	close $fd or die_error(undef, "Reading tree failed.");
 	$/ = "\n";
@@ -1683,7 +1684,7 @@ #			      " | " . $cgi->a({-href => "$my
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
@@ -1703,7 +1704,7 @@ sub git_rss {
 			last;
 		}
 		my %cd = date_str($co{'committer_epoch'});
-		open $fd, "-|", "$gitbin/git-diff-tree -r $co{'parent'} $co{'id'}" or next;
+		open $fd, "-|", "$gitbin/git --git-dir=$git_dir diff-tree -r $co{'parent'} $co{'id'}" or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd or next;
 		print "<item>\n" .
@@ -1756,7 +1757,7 @@ sub git_opml {
 		if (!defined $head) {
 			next;
 		}
-		$ENV{'GIT_DIR'} = "$projectroot/$proj{'path'}";
+		$git_dir = "$projectroot/$proj{'path'}";
 		my %co = git_read_commit($head);
 		if (!%co) {
 			next;
@@ -1791,7 +1792,7 @@ sub git_log {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
@@ -1882,7 +1883,7 @@ sub git_commit {
 		$root = " --root";
 		$parent = "";
 	}
-	open my $fd, "-|", "$gitbin/git-diff-tree -r -M $root $parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir diff-tree -r -M $root $parent $hash" or die_error(undef, "Open failed.");
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2124,7 +2125,7 @@ sub git_commitdiff {
 	if (!defined $hash_parent) {
 		$hash_parent = $co{'parent'};
 	}
-	open my $fd, "-|", "$gitbin/git-diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2214,14 +2215,14 @@ sub git_commitdiff {
 
 sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
-	open my $fd, "-|", "$gitbin/git-diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	# try to figure out the next tag after this commit
 	my $tagname;
 	my $refs = read_info_ref("tags");
-	open $fd, "-|", "$gitbin/git-rev-list HEAD";
+	open $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list HEAD";
 	chomp (my (@commits) = <$fd>);
 	close $fd;
 	foreach my $commit (@commits) {
@@ -2291,7 +2292,7 @@ sub git_history {
 	      "</div>\n";
 	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
 
-	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin -- \'$file_name\'";
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list $hash | $gitbin/git --git-dir=$git_dir diff-tree -r --stdin -- \'$file_name\'";
 	my $commit;
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
@@ -2383,7 +2384,7 @@ sub git_search {
 	my $alternate = 0;
 	if ($commit_search) {
 		$/ = "\0";
-		open my $fd, "-|", "$gitbin/git-rev-list --header --parents $hash" or next;
+		open my $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list --header --parents $hash" or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -2433,7 +2434,7 @@ sub git_search {
 
 	if ($pickaxe_search) {
 		$/ = "\n";
-		open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin -S\'$searchtext\'";
+		open my $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list $hash | $gitbin/git --git-dir=$git_dir diff-tree -r --stdin -S\'$searchtext\'";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
@@ -2504,7 +2505,7 @@ sub git_shortlog {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", "$gitbin/git-rev-list $limit $hash" or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir rev-list $limit $hash" or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
-- 
1.4.0

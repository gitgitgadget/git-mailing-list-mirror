From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Great subroutines renaming
Date: Sat, 5 Aug 2006 00:39:39 +0200
Message-ID: <200608050039.40495.jnareb@gmail.com>
References: <200608050036.06490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 00:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98Nq-0007PF-9l
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161546AbWHDWmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161550AbWHDWmy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:42:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:2021 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161546AbWHDWmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:42:52 -0400
Received: by nf-out-0910.google.com with SMTP id k26so45232nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 15:42:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C4BZeMR1vyGLFzw9vhR8L8jE1xmvmdH2ksCtlPhXSX9IDVdPmVc1vCYOuSLP+Kyh1EUAzT3dUwOxXPS0Bp4WhnteypRUany/1TYUtoI3HxJAymO2vl2yy3h2fmujcZ6DLGG84eiXtRoyZrs7z/8qTuRh2Xs3tt3r7gCsWo4OAdg=
Received: by 10.48.254.10 with SMTP id b10mr4815520nfi;
        Fri, 04 Aug 2006 15:42:51 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id q28sm2928781nfc.2006.08.04.15.42.48;
        Fri, 04 Aug 2006 15:42:50 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608050036.06490.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24859>

Rename some of subroutines to better reflect what they do.
Some renames were not performed because subroutine name
reflects hash key.

Subroutines name guideline:
* git_ prefix for subroutines related to git commands,
  or to gitweb actions
* git_get_ prefix for subroutines calling git command
  and returning some output
* git_read_ prefix for subroutines directly accessing git
  repository files
* parse_ prefix for subroutines parsing some text, or reading and
  parsing some text into hash or list
* format_ prefix for subroutines formatting/post-processing some
  HTML/text fragment
* _get_ infix for subroutines which return result
* _print_ infix for subroutines which print fragment of output
* _body suffix for subroutines which outputs main part (body)
  of related action
* _nav suffix for subroutines related to navigation bars
* _div suffix for subroutines returning or ptinting div element

Renames:
- git_get_referencing => format_mark_referencing
- git_read_head => git_get_head
- read_info_ref => git_read_info_refs
- date_str => parse_date
- git_read_tag => parse_tag
- git_read_commit => parse_commit
- git_blob_plain_mimetype => blob_plain_mimetype
- git_page_nav => git_print_page_nav
- git_header_div => git_print_header_div

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I don't follow my own guidelines, not completely.
I should probably post this patch earlier.

 gitweb/gitweb.perl |  232 ++++++++++++++++++++++++++--------------------------
 1 files changed, 117 insertions(+), 115 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dfc2d09..d440546 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -21,7 +21,6 @@ our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
-our $rss_link = "";
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
@@ -347,7 +346,7 @@ sub format_log_line_html {
 }
 
 # format marker of refs pointing to given object
-sub git_get_referencing {
+sub format_mark_referencing {
 	my ($refs, $id) = @_;
 
 	if (defined $refs->{$id}) {
@@ -361,7 +360,7 @@ ## -------------------------------------
 ## git utility subroutines, invoking git commands
 
 # get HEAD ref of given project as hash
-sub git_read_head {
+sub git_get_head {
 	my $project = shift;
 	my $oENV = $ENV{'GIT_DIR'};
 	my $retval = undef;
@@ -496,7 +495,7 @@ sub git_read_projects {
 	return @list;
 }
 
-sub read_info_ref {
+sub git_read_info_refs {
 	my $type = shift || "";
 	my %refs;
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
@@ -521,7 +520,8 @@ sub read_info_ref {
 ## ----------------------------------------------------------------------
 ## parse to hash functions
 
-sub date_str {
+# parse date from epoch and timezone
+sub parse_date {
 	my $epoch = shift;
 	my $tz = shift || "-0000";
 
@@ -546,7 +546,8 @@ sub date_str {
 	return %date;
 }
 
-sub git_read_tag {
+# parse tag given by tag_id
+sub parse_tag {
 	my $tag_id = shift;
 	my %tag;
 	my @comment;
@@ -581,7 +582,8 @@ sub git_read_tag {
 	return %tag
 }
 
-sub git_read_commit {
+# parse commit given by commit_id, with optionally given @commit_lines
+sub parse_commit {
 	my $commit_id = shift;
 	my $commit_text = shift;
 
@@ -701,10 +703,10 @@ sub git_read_refs {
 		$ref_item{'epoch'} = 0;
 		$ref_item{'age'} = "unknown";
 		if ($type eq "tag") {
-			my %tag = git_read_tag($ref_id);
+			my %tag = parse_tag($ref_id);
 			$ref_item{'comment'} = $tag{'comment'};
 			if ($tag{'type'} eq "commit") {
-				%co = git_read_commit($tag{'object'});
+				%co = parse_commit($tag{'object'});
 				$ref_item{'epoch'} = $co{'committer_epoch'};
 				$ref_item{'age'} = $co{'age_string'};
 			} elsif (defined($tag{'epoch'})) {
@@ -716,7 +718,7 @@ sub git_read_refs {
 			$ref_item{'name'} = $tag{'name'};
 			$ref_item{'refid'} = $tag{'object'};
 		} elsif ($type eq "commit"){
-			%co = git_read_commit($ref_id);
+			%co = parse_commit($ref_id);
 			$ref_item{'reftype'} = "commit";
 			$ref_item{'name'} = $ref_file;
 			$ref_item{'title'} = $co{'title'};
@@ -791,7 +793,7 @@ sub mimetype_guess {
 	return $mime;
 }
 
-sub git_blob_plain_mimetype {
+sub blob_plain_mimetype {
 	my $fd = shift;
 	my $filename = shift;
 
@@ -936,7 +938,7 @@ sub die_error {
 ## ----------------------------------------------------------------------
 ## functions printing or outputting HTML: navigation
 
-sub git_page_nav {
+sub git_print_page_nav {
 	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
 	$extra = '' if !defined $extra; # pager or formats
 
@@ -1003,7 +1005,7 @@ sub git_get_paging_nav {
 ## ......................................................................
 ## functions printing or outputting HTML: div
 
-sub git_header_div {
+sub git_print_header_div {
 	my ($action, $title, $hash, $hash_base) = @_;
 	my $rest = '';
 
@@ -1043,10 +1045,10 @@ sub git_shortlog_body {
 	my $alternate = 0;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $commit = $revlist->[$i];
-		#my $ref = defined $refs ? git_get_referencing($refs, $commit) : '';
-		my $ref = git_get_referencing($refs, $commit);
-		my %co = git_read_commit($commit);
-		my %ad = date_str($co{'author_epoch'});
+		#my $ref = defined $refs ? format_mark_referencing($refs, $commit) : '';
+		my $ref = format_mark_referencing($refs, $commit);
+		my %co = parse_commit($commit);
+		my %ad = parse_date($co{'author_epoch'});
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -1275,12 +1277,12 @@ sub git_project_list {
 		die_error(undef, "No projects found.");
 	}
 	foreach my $pr (@list) {
-		my $head = git_read_head($pr->{'path'});
+		my $head = git_get_head($pr->{'path'});
 		if (!defined $head) {
 			next;
 		}
 		$ENV{'GIT_DIR'} = "$projectroot/$pr->{'path'}";
-		my %co = git_read_commit($head);
+		my %co = parse_commit($head);
 		if (!%co) {
 			next;
 		}
@@ -1371,9 +1373,9 @@ sub git_project_list {
 
 sub git_summary {
 	my $descr = git_read_description($project) || "none";
-	my $head = git_read_head($project);
-	my %co = git_read_commit($head);
-	my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
+	my $head = git_get_head($project);
+	my %co = parse_commit($head);
+	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $owner;
 	if (-f $projects_list) {
@@ -1394,9 +1396,9 @@ sub git_summary {
 		$owner = get_file_owner("$projectroot/$project");
 	}
 
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 	git_header_html();
-	git_page_nav('summary','', $head);
+	git_print_page_nav('summary','', $head);
 
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
@@ -1405,24 +1407,24 @@ sub git_summary {
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
 
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project)
+	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head($project)
 		or die_error(undef, "Open git-rev-list failed.");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
-	git_header_div('shortlog');
+	git_print_header_div('shortlog');
 	git_shortlog_body(\@revlist, 0, 15, $refs,
 	                  $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "..."));
 
 	my $taglist = git_read_refs("refs/tags");
 	if (defined @$taglist) {
-		git_header_div('tags');
+		git_print_header_div('tags');
 		git_tags_body($taglist, 0, 15,
 		              $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tags")}, "..."));
 	}
 
 	my $headlist = git_read_refs("refs/heads");
 	if (defined @$headlist) {
-		git_header_div('heads');
+		git_print_header_div('heads');
 		git_heads_body($headlist, $head, 0, 15,
 		               $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads")}, "..."));
 	}
@@ -1431,11 +1433,11 @@ sub git_summary {
 }
 
 sub git_tag {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	git_header_html();
-	git_page_nav('','', $head,undef,$head);
-	my %tag = git_read_tag($hash);
-	git_header_div('commit', esc_html($tag{'name'}), $hash);
+	git_print_page_nav('','', $head,undef,$head);
+	my %tag = parse_tag($hash);
+	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n" .
 	      "<tr>\n" .
@@ -1444,7 +1446,7 @@ sub git_tag {
 	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'type'};h=$tag{'object'}")}, $tag{'type'}) . "</td>\n" .
 	      "</tr>\n";
 	if (defined($tag{'author'})) {
-		my %ad = date_str($tag{'epoch'}, $tag{'tz'});
+		my %ad = parse_date($tag{'epoch'}, $tag{'tz'});
 		print "<tr><td>author</td><td>" . esc_html($tag{'author'}) . "</td></tr>\n";
 		print "<tr><td></td><td>" . $ad{'rfc2822'} . sprintf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'}) . "</td></tr>\n";
 	}
@@ -1464,9 +1466,9 @@ sub git_blame2 {
 	my $ftype;
 	die_error(undef, "Permission denied.") if (!git_get_project_config_bool ('blame'));
 	die_error('404 Not Found', "File name not defined.") if (!$file_name);
-	$hash_base ||= git_read_head($project);
+	$hash_base ||= git_get_head($project);
 	die_error(undef, "Couldn't find base commit.") unless ($hash_base);
-	my %co = git_read_commit($hash_base)
+	my %co = parse_commit($hash_base)
 		or die_error(undef, "Reading commit failed.");
 	if (!defined $hash) {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
@@ -1482,8 +1484,8 @@ sub git_blame2 {
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
 		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
-	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	git_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype);
 	my @rev_color = (qw(light dark));
 	my $num_colors = scalar(@rev_color);
@@ -1522,9 +1524,9 @@ sub git_blame {
 	my $fd;
 	die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool ('blame'));
 	die_error('404 Not Found', "File name not defined.") if (!$file_name);
-	$hash_base ||= git_read_head($project);
+	$hash_base ||= git_get_head($project);
 	die_error(undef, "Couldn't find base commit.") unless ($hash_base);
-	my %co = git_read_commit($hash_base)
+	my %co = parse_commit($hash_base)
 		or die_error(undef, "Reading commit failed.");
 	if (!defined $hash) {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
@@ -1536,8 +1538,8 @@ sub git_blame {
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
 		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
-	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	git_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, 'blob');
 	print "<div class=\"page_body\">\n";
 	print <<HTML;
@@ -1610,10 +1612,10 @@ HTML
 }
 
 sub git_tags {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	git_header_html();
-	git_page_nav('','', $head,undef,$head);
-	git_header_div('summary', $project);
+	git_print_page_nav('','', $head,undef,$head);
+	git_print_header_div('summary', $project);
 
 	my $taglist = git_read_refs("refs/tags");
 	if (defined @$taglist) {
@@ -1623,10 +1625,10 @@ sub git_tags {
 }
 
 sub git_heads {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	git_header_html();
-	git_page_nav('','', $head,undef,$head);
-	git_header_div('summary', $project);
+	git_print_page_nav('','', $head,undef,$head);
+	git_print_header_div('summary', $project);
 
 	my $taglist = git_read_refs("refs/heads");
 	my $alternate = 0;
@@ -1639,7 +1641,7 @@ sub git_heads {
 sub git_blob_plain {
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_read_head($project);
+			my $base = $hash_base || git_get_head($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
 				or die_error(undef, "Error lookup file $file_name");
 		} else {
@@ -1650,7 +1652,7 @@ sub git_blob_plain {
 	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
 		or die_error("Couldn't cat $file_name, $hash");
 
-	$type ||= git_blob_plain_mimetype($fd, $file_name);
+	$type ||= blob_plain_mimetype($fd, $file_name);
 
 	# save as filename, even when no $file_name is given
 	my $save_as = "$hash";
@@ -1672,7 +1674,7 @@ sub git_blob_plain {
 sub git_blob {
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_read_head($project);
+			my $base = $hash_base || git_get_head($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
 				or die_error(undef, "Error lookup file $file_name");
 		} else {
@@ -1682,14 +1684,14 @@ sub git_blob {
 	my $have_blame = git_get_project_config_bool ('blame');
 	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash.");
-	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
+	my $mimetype = blob_plain_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
 		close $fd;
 		return git_blob_plain($mimetype);
 	}
 	git_header_html();
 	my $formats_nav = '';
-	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
+	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		if (defined $file_name) {
 			if ($have_blame) {
 				$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") . " | ";
@@ -1700,8 +1702,8 @@ sub git_blob {
 		} else {
 			$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain");
 		}
-		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		git_header_div('commit', esc_html($co{'title'}), $hash_base);
+		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
@@ -1728,7 +1730,7 @@ sub git_blob {
 
 sub git_tree {
 	if (!defined $hash) {
-		$hash = git_read_head($project);
+		$hash = git_get_head($project);
 		if (defined $file_name) {
 			my $base = $hash_base || $hash;
 			$hash = git_get_hash_by_path($base, $file_name, "tree");
@@ -1744,15 +1746,15 @@ sub git_tree {
 	close $fd or die_error(undef, "Reading tree failed.");
 	$/ = "\n";
 
-	my $refs = read_info_ref();
-	my $ref = git_get_referencing($refs, $hash_base);
+	my $refs = git_read_info_refs();
+	my $ref = format_mark_referencing($refs, $hash_base);
 	git_header_html();
 	my $base_key = "";
 	my $base = "";
-	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
+	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		$base_key = ";hb=$hash_base";
-		git_page_nav('tree','', $hash_base);
-		git_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
+		git_print_page_nav('tree','', $hash_base);
+		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n";
 		print "<br/><br/></div>\n";
@@ -1806,14 +1808,14 @@ #			      " | " . $cgi->a({-href => "$my
 }
 
 sub git_log {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
 	if (!defined $page) {
 		$page = 0;
 	}
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
@@ -1824,24 +1826,24 @@ sub git_log {
 	my $paging_nav = git_get_paging_nav('log', $hash, $head, $page, $#revlist);
 
 	git_header_html();
-	git_page_nav('log','', $hash,undef,undef, $paging_nav);
+	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 
 	if (!@revlist) {
-		my %co = git_read_commit($hash);
+		my %co = parse_commit($hash);
 
-		git_header_div('summary', $project);
+		git_print_header_div('summary', $project);
 		print "<div class=\"page_body\"> Last change $co{'age_string'}.<br/><br/></div>\n";
 	}
 	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
 		my $commit = $revlist[$i];
-		my $ref = git_get_referencing($refs, $commit);
-		my %co = git_read_commit($commit);
+		my $ref = format_mark_referencing($refs, $commit);
+		my %co = parse_commit($commit);
 		next if !%co;
-		my %ad = date_str($co{'author_epoch'});
-		git_header_div('commit',
-									 "<span class=\"age\">$co{'age_string'}</span>" .
-									 esc_html($co{'title'}) . $ref,
-									 $commit);
+		my %ad = parse_date($co{'author_epoch'});
+		git_print_header_div('commit',
+		                     "<span class=\"age\">$co{'age_string'}</span>" .
+		                     esc_html($co{'title'}) . $ref,
+		                     $commit);
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
@@ -1876,12 +1878,12 @@ sub git_log {
 }
 
 sub git_commit {
-	my %co = git_read_commit($hash);
+	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object.");
 	}
-	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
-	my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
+	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
+	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $parent = $co{'parent'};
 	if (!defined $parent) {
@@ -1897,22 +1899,22 @@ sub git_commit {
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		$expires = "+1d";
 	}
-	my $refs = read_info_ref();
-	my $ref = git_get_referencing($refs, $co{'id'});
+	my $refs = git_read_info_refs();
+	my $ref = format_mark_referencing($refs, $co{'id'});
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
 		$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;hb=$parent;f=$file_name")}, "blame");
 	}
 	git_header_html(undef, $expires);
-	git_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
-							 $hash, $co{'tree'}, $hash,
-							 $formats_nav);
+	git_print_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
+	                   $hash, $co{'tree'}, $hash,
+	                   $formats_nav);
 
 	if (defined $co{'parent'}) {
-		git_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
+		git_print_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
 	} else {
-		git_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
+		git_print_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n";
@@ -2074,11 +2076,11 @@ sub git_commit {
 sub git_blobdiff {
 	mkdir($git_temp, 0700);
 	git_header_html();
-	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
+	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my $formats_nav =
 			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
-		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		git_header_div('commit', esc_html($co{'title'}), $hash_base);
+		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
@@ -2104,7 +2106,7 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	mkdir($git_temp, 0700);
-	my %co = git_read_commit($hash);
+	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object.");
 	}
@@ -2121,13 +2123,13 @@ sub git_commitdiff {
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		$expires = "+1d";
 	}
-	my $refs = read_info_ref();
-	my $ref = git_get_referencing($refs, $co{'id'});
+	my $refs = git_read_info_refs();
+	my $ref = format_mark_referencing($refs, $co{'id'});
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
 	git_header_html(undef, $expires);
-	git_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
-	git_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
+	git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
+	git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 	print "<div class=\"page_body\">\n";
 	my $comment = $co{'comment'};
 	my $empty = 0;
@@ -2198,7 +2200,7 @@ sub git_commitdiff_plain {
 
 	# try to figure out the next tag after this commit
 	my $tagname;
-	my $refs = read_info_ref("tags");
+	my $refs = git_read_info_refs("tags");
 	open $fd, "-|", $GIT, "rev-list", "HEAD";
 	my @commits = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2212,8 +2214,8 @@ sub git_commitdiff_plain {
 	}
 
 	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
-	my %co = git_read_commit($hash);
-	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
+	my %co = parse_commit($hash);
+	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my $comment = $co{'comment'};
 	print "From: $co{'author'}\n" .
 	      "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n".
@@ -2247,17 +2249,17 @@ sub git_commitdiff_plain {
 
 sub git_history {
 	if (!defined $hash_base) {
-		$hash_base = git_read_head($project);
+		$hash_base = git_get_head($project);
 	}
 	my $ftype;
-	my %co = git_read_commit($hash_base);
+	my %co = parse_commit($hash_base);
 	if (!%co) {
 		die_error(undef, "Unknown commit object.");
 	}
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 	git_header_html();
-	git_page_nav('','', $hash_base,$co{'tree'},$hash_base);
-	git_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	if (!defined $hash && defined $file_name) {
 		$hash = git_get_hash_by_path($hash_base, $file_name);
 	}
@@ -2273,11 +2275,11 @@ sub git_history {
 	while (my $line = <$fd>) {
 		if ($line =~ m/^([0-9a-fA-F]{40})/){
 			my $commit = $1;
-			my %co = git_read_commit($commit);
+			my %co = parse_commit($commit);
 			if (!%co) {
 				next;
 			}
-			my $ref = git_get_referencing($refs, $commit);
+			my $ref = format_mark_referencing($refs, $commit);
 			if ($alternate) {
 				print "<tr class=\"dark\">\n";
 			} else {
@@ -2313,9 +2315,9 @@ sub git_search {
 		die_error("", "Text field empty.");
 	}
 	if (!defined $hash) {
-		$hash = git_read_head($project);
+		$hash = git_get_head($project);
 	}
-	my %co = git_read_commit($hash);
+	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object.");
 	}
@@ -2334,8 +2336,8 @@ sub git_search {
 		$pickaxe_search = 1;
 	}
 	git_header_html();
-	git_page_nav('','', $hash,$co{'tree'},$hash);
-	git_header_div('commit', esc_html($co{'title'}), $hash);
+	git_print_page_nav('','', $hash,$co{'tree'},$hash);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
@@ -2353,7 +2355,7 @@ sub git_search {
 				next;
 			}
 			my @commit_lines = split "\n", $commit_text;
-			my %co = git_read_commit(undef, \@commit_lines);
+			my %co = parse_commit(undef, \@commit_lines);
 			if (!%co) {
 				next;
 			}
@@ -2434,7 +2436,7 @@ sub git_search {
 					print "</td>\n" .
 					      "</tr>\n";
 				}
-				%co = git_read_commit($1);
+				%co = parse_commit($1);
 			}
 		}
 		close $fd;
@@ -2444,14 +2446,14 @@ sub git_search {
 }
 
 sub git_shortlog {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
 	if (!defined $page) {
 		$page = 0;
 	}
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
@@ -2469,8 +2471,8 @@ sub git_shortlog {
 
 
 	git_header_html();
-	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-	git_header_div('summary', $project);
+	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
+	git_print_header_div('summary', $project);
 
 	git_shortlog_body(\@revlist, ($page * 100), $#revlist, $refs, $next_link);
 
@@ -2482,7 +2484,7 @@ ## feeds (RSS, OPML)
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project)
+	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_get_head($project)
 		or die_error(undef, "Open git-rev-list failed.");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed.");
@@ -2497,12 +2499,12 @@ sub git_rss {
 
 	for (my $i = 0; $i <= $#revlist; $i++) {
 		my $commit = $revlist[$i];
-		my %co = git_read_commit($commit);
+		my %co = parse_commit($commit);
 		# we read 150, we always show 30 and the ones more recent than 48 hours
 		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = date_str($co{'committer_epoch'});
+		my %cd = parse_date($co{'committer_epoch'});
 		open $fd, "-|", $GIT, "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd or next;
@@ -2552,12 +2554,12 @@ sub git_opml {
 
 	foreach my $pr (@list) {
 		my %proj = %$pr;
-		my $head = git_read_head($proj{'path'});
+		my $head = git_get_head($proj{'path'});
 		if (!defined $head) {
 			next;
 		}
 		$ENV{'GIT_DIR'} = "$projectroot/$proj{'path'}";
-		my %co = git_read_commit($head);
+		my %co = parse_commit($head);
 		if (!%co) {
 			next;
 		}
-- 
1.4.1.1

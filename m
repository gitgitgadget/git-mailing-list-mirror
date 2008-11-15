From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: fixes to gitweb feature check code
Date: Sat, 15 Nov 2008 15:26:05 +0100
Message-ID: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 15:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1MDX-0004zz-6G
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 15:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbYKOOZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 09:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755606AbYKOOZ6
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 09:25:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:55295 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbYKOOZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 09:25:57 -0500
Received: by ey-out-2122.google.com with SMTP id 6so728520eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 06:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XsnpKlmXI1Bq5ajC8Ns5rlIVQmO/p2+YhKUPE8eQxx0=;
        b=xdwAKQwymE9OgiLlz6dhJcGi5TlLXjL2hxox0l9lPe8DUmND8jpNHZNdQ4KU9Wt4eI
         lCgfgAlJ5uYgkHmMNWxl2uipXHc2QMaq7hREYLdpQnuh2PHhUwV3Kke6/BWuORo7hPay
         kZLM58mebbU8uADMAs9VHQ0zTOpP4JqviZxo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=w4yfoEWNufnMB7ckNxwAmBJjaD+fjmhc4qcKG3ESuluSnFMKesMUAef5WeE7oHamcy
         FVjrR0+AhPYu8Z79X/yrt9A3jiHQV3pi7760fSbIwwTPhBLt+NPcpH5w3MrtfJAbDHA3
         tIWEfoebSw0z3rITx3Cn6i81tsHK46lDM3uDU=
Received: by 10.210.10.8 with SMTP id 8mr381337ebj.172.1226759155481;
        Sat, 15 Nov 2008 06:25:55 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id 7sm1079345eyg.9.2008.11.15.06.25.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 06:25:55 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101070>

The gitweb_check_feature routine was being used for two different
purposes: retrieving the actual feature value (such as the list of
snapshot formats or the list of additional actions), and to check if a
feature was enabled.

For the latter use, since all features return an array, it led to either
clumsy code or subtle bugs, with disabled features appearing enabled
because (0) evaluates to 1.

We fix these bugs, and simplify the code, by separating feature (list)
value retrieval (gitweb_get_feature) from boolean feature check (i.e.
retrieving the first/only item in the feature value list). Usage of
gitweb_check_feature across gitweb is replaced by the appropriate call
wherever needed.
---
 gitweb/gitweb.perl |   52 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 933e137..b0d00ea 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -190,7 +190,9 @@ our %feature = (
 	# if there is no 'sub' key (no feature-sub), then feature cannot be
 	# overriden
 	#
-	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
+	# use gitweb_get_feature(<feature>) to retrieve the <feature> value
+	# (an array) or gitweb_check_feature(<feature>) to check if <feature>
+	# is enabled
 
 	# Enable the 'blame' blob view, showing the last commit that modified
 	# each line in the file. This can be very CPU-intensive.
@@ -329,7 +331,8 @@ our %feature = (
 		'default' => [0]},
 );
 
-sub gitweb_check_feature {
+# retrieve the value of a given feature, as an array
+sub gitweb_get_feature {
 	my ($name) = @_;
 	return unless exists $feature{$name};
 	my ($sub, $override, @defaults) = (
@@ -344,6 +347,21 @@ sub gitweb_check_feature {
 	return $sub->(@defaults);
 }
 
+# check if a given feature is enabled or not, returning the first (and only)
+# value of the feature. Comfort code, allowing the use of
+#   my $bool_feat = gitweb_check_feature('bool_feat');
+# or
+#   gitweb_check_feature('bool_feat') or somecode;
+# instead of
+#   my ($bool_feat) = gitweb_git_feature('bool_feat');
+# or
+#   (gitweb_check_feature('bool_feat'))[0] or somecode;
+# respectively
+sub gitweb_check_feature {
+	return (gitweb_get_feature(@_))[0];
+}
+
+
 sub feature_blame {
 	my ($val) = git_get_project_config('blame', '--bool');
 
@@ -767,7 +785,7 @@ our $git_dir;
 $git_dir = "$projectroot/$project" if $project;
 
 # list of supported snapshot formats
-our @snapshot_fmts = gitweb_check_feature('snapshot');
+our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
 # dispatch
@@ -810,7 +828,7 @@ sub href (%) {
 		}
 	}
 
-	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
+	my $use_pathinfo = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
@@ -2101,7 +2119,7 @@ sub git_get_projects_list {
 	$filter ||= '';
 	$filter =~ s/\.git$//;
 
-	my ($check_forks) = gitweb_check_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 
 	if (-d $projects_list) {
 		# search in directory
@@ -2947,7 +2965,7 @@ EOF
 	}
 	print "</div>\n";
 
-	my ($have_search) = gitweb_check_feature('search');
+	my $have_search = gitweb_check_feature('search');
 	if (defined $project && $have_search) {
 		if (!defined $searchtext) {
 			$searchtext = "";
@@ -2961,7 +2979,7 @@ EOF
 			$search_hash = "HEAD";
 		}
 		my $action = $my_uri;
-		my ($use_pathinfo) = gitweb_check_feature('pathinfo');
+		my $use_pathinfo = gitweb_check_feature('pathinfo');
 		if ($use_pathinfo) {
 			$action .= "/".esc_url($project);
 		}
@@ -3084,7 +3102,7 @@ sub git_print_page_nav {
 	$arg{'tree'}{'hash'} = $treehead if defined $treehead;
 	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
 
-	my @actions = gitweb_check_feature('actions');
+	my @actions = gitweb_get_feature('actions');
 	my %repl = (
 		'%' => '%',
 		'n' => $project,         # project name
@@ -3454,7 +3472,7 @@ sub is_patch_split {
 sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
 		print(($#{$difftree} + 1) . " files changed:\n");
@@ -3968,7 +3986,7 @@ sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
-	my ($check_forks) = gitweb_check_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 	my @projects = fill_project_list_info($projlist, $check_forks);
 
 	$order ||= $default_projects_order;
@@ -4428,7 +4446,7 @@ sub git_summary {
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16);
 	my @forklist;
-	my ($check_forks) = gitweb_check_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 
 	if ($check_forks) {
 		@forklist = git_get_projects_list($project);
@@ -4457,7 +4475,7 @@ sub git_summary {
 	}
 
 	# Tag cloud
-	my $show_ctags = (gitweb_check_feature('ctags'))[0];
+	my $show_ctags = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my $ctags = git_get_project_ctags($project);
 		my $cloud = git_populate_project_tagcloud($ctags);
@@ -4747,7 +4765,7 @@ sub git_blob {
 		$expires = "+1d";
 	}
 
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(500, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
@@ -4840,7 +4858,7 @@ sub git_tree {
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
 	my $basedir = '';
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my @views_nav = ();
 		if (defined $file_name) {
@@ -5838,7 +5856,7 @@ insensitive).</p>
 <dt><b>commit</b></dt>
 <dd>The commit messages and authorship information will be scanned for the given pattern.</dd>
 EOT
-	my ($have_grep) = gitweb_check_feature('grep');
+	my $have_grep = gitweb_check_feature('grep');
 	if ($have_grep) {
 		print <<EOT;
 <dt><b>grep</b></dt>
@@ -5855,7 +5873,7 @@ EOT
 <dt><b>committer</b></dt>
 <dd>Name and e-mail of the committer and date of commit will be scanned for the given pattern.</dd>
 EOT
-	my ($have_pickaxe) = gitweb_check_feature('pickaxe');
+	my $have_pickaxe = gitweb_check_feature('pickaxe');
 	if ($have_pickaxe) {
 		print <<EOT;
 <dt><b>pickaxe</b></dt>
@@ -5907,7 +5925,7 @@ sub git_shortlog {
 
 sub git_feed {
 	my $format = shift || 'atom';
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 
 	# Atom: http://www.atomenabled.org/developers/syndication/
 	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-- 
1.5.6.5

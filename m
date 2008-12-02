From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3bis] gitweb: fixes to gitweb feature check code
Date: Tue,  2 Dec 2008 11:43:18 +0100
Message-ID: <1228214598-26557-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <200812020253.09430.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 11:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Sjw-0006qS-0N
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 11:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbYLBKnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 05:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbYLBKnG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 05:43:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:39584 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYLBKnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 05:43:03 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2996091ugf.37
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 02:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=t5TbJMxy+Fd2taLeRblby/CBNv5nfrjUHRrTp/EL2kQ=;
        b=YoqtUFxuAlK9hTzCBUtTUDwhJIwB4OkDoOXUOZa8cRluRA/uz5XUMIxYawgFTGZ+Yc
         odSMTg4LAJFvNQStTtzX8q/UG2wJeupjnhDZ1hpuzRSLbmjOxaX1ZpN3vKS19pHZli8a
         PzNZb/SvJGhxD9FoWMc9A39On7zPu0n85lDqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VtU2/HAQGupZLRJcMwM3ZSPstd/uMdKANWDaeFNhIGq8oeKTGZFA2mHfIA4CsKRaJY
         IUUhSAVwqi3FcP8Rhn+Fx80regiPDfyd4TKcAGtXyedPVm27VQK7aZKytGt089r4cIBi
         6RidInBLQu1SqBCAtJO2b2glmPVpxJqCQN3JE=
Received: by 10.103.198.15 with SMTP id a15mr5139507muq.60.1228214580111;
        Tue, 02 Dec 2008 02:43:00 -0800 (PST)
Received: from localhost ([78.13.62.94])
        by mx.google.com with ESMTPS id y2sm7414532mug.14.2008.12.02.02.42.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 02:42:58 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <200812020253.09430.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102129>

The gitweb_check_feature routine was being used for two different
purposes: retrieving the actual feature value (such as the list of
snapshot formats or the list of additional actions), and checking if a
feature was enabled.

This led to subtle bugs in feature checking code: gitweb_check_feature
would return (0) for disabled features, so its use in scalar context
would return true instead of false.

To fix this issue and future-proof the code, we split feature value
retrieval into its own gitweb_get_feature()function, and ensure that
the boolean feature check function gitweb_check_feature() always returns
a scalar (precisely, the first/only item in the feature value list).

Usage of gitweb_check_feature() across gitweb is replaced with
gitweb_get_feature() where appropriate, and list evaluation of
gitweb_check_feature() is demoted to scalar evaluation to prevent
ambiguity. The few previously incorrect uses of gitweb_check_feature()
in scalar context are left untouched because they are now correct.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Fixed typo in commit message.

 gitweb/gitweb.perl |   52 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 933e137..4246819 100755
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
+# value of the feature. This allows us to write
+#   my $bool_feat = gitweb_check_feature('bool_feat');
+# or
+#   gitweb_check_feature('bool_feat') or somecode;
+# instead of
+#   my ($bool_feat) = gitweb_get_feature('bool_feat');
+# or
+#   (gitweb_get_feature('bool_feat'))[0] or somecode;
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

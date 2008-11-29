From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] gitweb: make gitweb_check_feature a boolean wrapper
Date: Sat, 29 Nov 2008 13:16:52 -0800
Message-ID: <7vmyfiz0zf.fsf_-_@gitster.siamese.dyndns.org>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
 <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 22:18:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6XD9-00033z-TT
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 22:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYK2VR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 16:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYK2VR1
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 16:17:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYK2VR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 16:17:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1906B17641;
	Sat, 29 Nov 2008 16:17:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A995E17C30; Sat,
 29 Nov 2008 16:16:53 -0500 (EST)
In-Reply-To: <7vzljiz1qn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 29 Nov 2008 13:00:32 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E50DCA2-BE5B-11DD-8F5D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101928>

The gitweb_get_feature() function retrieves the configuration parameters
for the feature (such as the list of snapshot formats or the list of
additional actions), but it is very often used to see if feature is
enabled (which is returned as the first element in the list).

Because accepting the returned list in a scalar context by mistake yields
the number of elements in the array, which is non-zero in all cases, such
a mistake would result in a bug for the latter use, with disabled features
appearing enabled.  All existing callers that call the function for this
purpose assign the return value in the list context to retrieve the first
element, but that is only because we fixed careless callers recently.

This add gitweb_check_feature() as a wrapper to gitweb_get_feature() that
can be called safely in the scalar context to see if a feature is enabled
to reduce the risk of future bugs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Again, this is to demonstrate how I would have liked to see your
   patches as a reviewable series.  Notice how this naturally justifies
   the dropping of parentheses in many lines that begin with "my", and
   makes it easier to review?  You can review the patch easily by knowing
   that callers that have s/get/check/ are now safe to use scalar context.

 gitweb/gitweb.perl |   56 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7ab16cd..acc4cfd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -190,7 +190,7 @@ our %feature = (
 	# if there is no 'sub' key (no feature-sub), then feature cannot be
 	# overriden
 	#
-	# use gitweb_get_feature(<feature>) to check if <feature> is enabled
+	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
 
 	# Enable the 'blame' blob view, showing the last commit that modified
 	# each line in the file. This can be very CPU-intensive.
@@ -344,6 +344,22 @@ sub gitweb_get_feature {
 	return $sub->(@defaults);
 }
 
+# A wrapper to check if a given feature is enabled.
+# With this, you can say
+#
+#   my $bool_feat = gitweb_check_feature('bool_feat');
+#   gitweb_check_feature('bool_feat') or somecode;
+#
+# instead of
+#
+#   my ($bool_feat) = gitweb_get_feature('bool_feat');
+#   (gitweb_get_feature('bool_feat'))[0] or somecode;
+#
+sub gitweb_check_feature {
+	return (gitweb_get_feature(@_))[0];
+}
+
+
 sub feature_blame {
 	my ($val) = git_get_project_config('blame', '--bool');
 
@@ -810,7 +826,7 @@ sub href (%) {
 		}
 	}
 
-	my ($use_pathinfo) = gitweb_get_feature('pathinfo');
+	my $use_pathinfo = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
@@ -2101,7 +2117,7 @@ sub git_get_projects_list {
 	$filter ||= '';
 	$filter =~ s/\.git$//;
 
-	my ($check_forks) = gitweb_get_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 
 	if (-d $projects_list) {
 		# search in directory
@@ -2947,7 +2963,7 @@ EOF
 	}
 	print "</div>\n";
 
-	my ($have_search) = gitweb_get_feature('search');
+	my $have_search = gitweb_check_feature('search');
 	if (defined $project && $have_search) {
 		if (!defined $searchtext) {
 			$searchtext = "";
@@ -2961,7 +2977,7 @@ EOF
 			$search_hash = "HEAD";
 		}
 		my $action = $my_uri;
-		my ($use_pathinfo) = gitweb_get_feature('pathinfo');
+		my $use_pathinfo = gitweb_check_feature('pathinfo');
 		if ($use_pathinfo) {
 			$action .= "/".esc_url($project);
 		}
@@ -3454,7 +3470,7 @@ sub is_patch_split {
 sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
-	my ($have_blame) = gitweb_get_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
 		print(($#{$difftree} + 1) . " files changed:\n");
@@ -3914,7 +3930,7 @@ sub fill_project_list_info {
 	my ($projlist, $check_forks) = @_;
 	my @projects;
 
-	my ($show_ctags) = gitweb_get_feature('ctags');
+	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
 		my (@activity) = git_get_last_activity($pr->{'path'});
@@ -3968,7 +3984,7 @@ sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
-	my ($check_forks) = gitweb_get_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 	my @projects = fill_project_list_info($projlist, $check_forks);
 
 	$order ||= $default_projects_order;
@@ -3988,7 +4004,7 @@ sub git_project_list_body {
 		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
 	}
 
-	my ($show_ctags) = gitweb_get_feature('ctags');
+	my $show_ctags = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my %ctags;
 		foreach my $p (@projects) {
@@ -4428,7 +4444,7 @@ sub git_summary {
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16);
 	my @forklist;
-	my ($check_forks) = gitweb_get_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 
 	if ($check_forks) {
 		@forklist = git_get_projects_list($project);
@@ -4457,7 +4473,7 @@ sub git_summary {
 	}
 
 	# Tag cloud
-	my ($show_ctags) = gitweb_get_feature('ctags');
+	my $show_ctags = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my $ctags = git_get_project_ctags($project);
 		my $cloud = git_populate_project_tagcloud($ctags);
@@ -4559,7 +4575,7 @@ sub git_blame {
 	my $fd;
 	my $ftype;
 
-	gitweb_get_feature('blame')[0]
+	gitweb_check_feature('blame')
 	    or die_error(403, "Blame view not allowed");
 
 	die_error(400, "No file name given") unless $file_name;
@@ -4747,7 +4763,7 @@ sub git_blob {
 		$expires = "+1d";
 	}
 
-	my ($have_blame) = gitweb_get_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(500, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
@@ -4840,7 +4856,7 @@ sub git_tree {
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
 	my $basedir = '';
-	my ($have_blame) = gitweb_get_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my @views_nav = ();
 		if (defined $file_name) {
@@ -5610,7 +5626,7 @@ sub git_history {
 }
 
 sub git_search {
-	gitweb_get_feature('search')[0] or die_error(403, "Search is disabled");
+	gitweb_check_feature('search') or die_error(403, "Search is disabled");
 	if (!defined $searchtext) {
 		die_error(400, "Text field is empty");
 	}
@@ -5629,11 +5645,11 @@ sub git_search {
 	if ($searchtype eq 'pickaxe') {
 		# pickaxe may take all resources of your box and run for several minutes
 		# with every query - so decide by yourself how public you make this feature
-		gitweb_get_feature('pickaxe')[0]
+		gitweb_check_feature('pickaxe')
 		    or die_error(403, "Pickaxe is disabled");
 	}
 	if ($searchtype eq 'grep') {
-		gitweb_get_feature('grep')[0]
+		gitweb_check_feature('grep')
 		    or die_error(403, "Grep is disabled");
 	}
 
@@ -5838,7 +5854,7 @@ insensitive).</p>
 <dt><b>commit</b></dt>
 <dd>The commit messages and authorship information will be scanned for the given pattern.</dd>
 EOT
-	my ($have_grep) = gitweb_get_feature('grep');
+	my $have_grep = gitweb_check_feature('grep');
 	if ($have_grep) {
 		print <<EOT;
 <dt><b>grep</b></dt>
@@ -5855,7 +5871,7 @@ EOT
 <dt><b>committer</b></dt>
 <dd>Name and e-mail of the committer and date of commit will be scanned for the given pattern.</dd>
 EOT
-	my ($have_pickaxe) = gitweb_get_feature('pickaxe');
+	my $have_pickaxe = gitweb_check_feature('pickaxe');
 	if ($have_pickaxe) {
 		print <<EOT;
 <dt><b>pickaxe</b></dt>
@@ -5907,7 +5923,7 @@ sub git_shortlog {
 
 sub git_feed {
 	my $format = shift || 'atom';
-	my ($have_blame) = gitweb_get_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 
 	# Atom: http://www.atomenabled.org/developers/syndication/
 	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-- 
1.6.0.4.850.g6bd829

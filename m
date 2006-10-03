From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitweb: prepare for repositories with packed refs.
Date: Tue, 03 Oct 2006 02:36:08 -0700
Message-ID: <7vsli5pwqf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 03 11:36:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUghP-0003qY-Jc
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWJCJgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWJCJgK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:36:10 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42700 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932509AbWJCJgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 05:36:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003093608.LITU6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 05:36:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VlcB1V00A1kojtg0000000
	Tue, 03 Oct 2006 05:36:11 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28263>

When a repository is initialized long time ago with symbolic
HEAD, and "git-pack-refs --prune" is run, HEAD will be a
dangling symlink to refs/heads/ somewhere.

Running -e "$dir/HEAD" to guess if $dir is a git repository does
not give us the right answer anymore in such a case.

Also factor out two places that checked if the repository can be
exported with similar code into a call to a new function,
check_export_ok.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is to fix a real breakage (iow, not a throw-away patch).

 gitweb/gitweb.perl |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55d1b2c..671a4e6 100644
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -180,6 +180,22 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+# checking HEAD file with -e is fragile if the repository was
+# initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
+# and then pruned.
+sub check_head_link {
+	my ($dir) = @_;
+	my $headfile = "$dir/HEAD";
+	return ((-e $headfile) ||
+		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
+}
+
+sub check_export_ok {
+	my ($dir) = @_;
+	return (check_head_link($dir) &&
+		(!$export_ok || -e "$dir/$export_ok"));
+}
+
 # rename detection options for git-diff and git-diff-tree
 # - default is '-M', with the cost proportional to
 #   (number of removed files) * (number of new files).
@@ -212,7 +228,7 @@ our $project = $cgi->param('p');
 if (defined $project) {
 	if (!validate_pathname($project) ||
 	    !(-d "$projectroot/$project") ||
-	    !(-e "$projectroot/$project/HEAD") ||
+	    !check_head_link("$projectroot/$project") ||
 	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
 	    ($strict_export && !project_in_list($project))) {
 		undef $project;
@@ -289,7 +305,7 @@ sub evaluate_path_info {
 	# find which part of PATH_INFO is project
 	$project = $path_info;
 	$project =~ s,/+$,,;
-	while ($project && !-e "$projectroot/$project/HEAD") {
+	while ($project && !check_head_link("$projectroot/$project")) {
 		$project =~ s,/*[^/]*$,,;
 	}
 	# validate project
@@ -816,8 +832,7 @@ sub git_get_projects_list {
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-				if (-e "$projectroot/$subdir/HEAD" && (!$export_ok ||
-				    -e "$projectroot/$subdir/$export_ok")) {
+				if (check_export_ok("$projectroot/$subdir")) {
 					push @list, { path => $subdir };
 					$File::Find::prune = 1;
 				}
@@ -838,8 +853,7 @@ sub git_get_projects_list {
 			if (!defined $path) {
 				next;
 			}
-			if (-e "$projectroot/$path/HEAD" && (!$export_ok ||
-			    -e "$projectroot/$path/$export_ok")) {
+			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
 					path => $path,
 					owner => decode("utf8", $owner, Encode::FB_DEFAULT),
-- 
1.4.2.3.gd1e9e

From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-svn: allow to specify svn branch for commands
Date: Tue,  5 Jun 2007 15:42:37 +1200
Message-ID: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Git Central <git@vger.kernel.org>, stephen@touset.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 05:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvPwZ-0003s9-S5
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 05:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873AbXFEDmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 23:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758275AbXFEDmn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 23:42:43 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:39783 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873AbXFEDmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 23:42:42 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1HvPwL-0006qY-O0; Tue, 05 Jun 2007 15:42:37 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id AB0555ED09; Tue,  5 Jun 2007 15:42:37 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.0.45.gfea6d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49151>

"git-svn dcommit" ends up making an arbitrary decision when pushing
back merges.  Allow the user to specify which one is used, albeit in a
rather hack-ish way.
---
 Documentation/git-svn.txt |   11 +++++++++++
 git-svn.perl              |   16 +++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c0d7d95..3e64522 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -69,6 +69,17 @@ COMMANDS
 	argument if that is what you want.  This is useful if
 	you wish to track multiple projects that share a common
 	repository.
+-B<svn_branch>;;
+--branch=<svn_branch>;;
+	Normally, git-svn is capable of figuring out which branch you
+	are working on.  However, if you are doing merges between svn
+	branches using git then the decision about which branch to
+	dcommit to will end up being made based on which of the
+	branches you are merging has the newest upstream commit.  This
+	option enables a global filter that tells git-svn what to look
+	for in the git-svn-id: line - specify a repository UUID or a
+	branch name here.  So, it may be used with "git-svn log",
+	"git-svn dcommit", etc.
 
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
diff --git a/git-svn.perl b/git-svn.perl
index e350061..b667f80 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -54,7 +54,7 @@ $sha1 = qr/[a-f\d]{40}/;
 $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
 	$_message, $_file,
-	$_template, $_shared,
+	$_template, $_shared, $_branch,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_verbose);
@@ -69,6 +69,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'useSvmProps' => \$Git::SVN::_use_svm_props,
 		'useSvnsyncProps' => \$Git::SVN::_use_svnsync_props,
 		'log-window-size=i' => \$Git::SVN::Ra::_log_window_size,
+		'branch|B=s' => \$_branch,
 		'no-checkout' => \$_no_checkout,
 		'quiet|q' => \$_q,
 		'repack-flags|repack-args|repack-opts=s' =>
@@ -367,7 +368,7 @@ sub cmd_dcommit {
 	my $head = shift;
 	$head ||= 'HEAD';
 	my @refs;
-	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
+	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs, $_branch);
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history\n";
@@ -441,7 +442,7 @@ sub cmd_find_rev {
 		my $head = shift;
 		$head ||= 'HEAD';
 		my @refs;
-		my (undef, undef, undef, $gs) = working_head_info($head, \@refs);
+		my (undef, undef, undef, $gs) = working_head_info($head, \@refs, $_branch);
 		unless ($gs) {
 			die "Unable to determine upstream SVN information from ",
 			    "$head history\n";
@@ -457,7 +458,7 @@ sub cmd_find_rev {
 
 sub cmd_rebase {
 	command_noisy(qw/update-index --refresh/);
-	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', undef, $_branch);
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "working tree history\n";
@@ -474,7 +475,7 @@ sub cmd_rebase {
 }
 
 sub cmd_show_ignore {
-	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', undef, $_branch);
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
 	$gs->traverse_ignore(\*STDOUT, $gs->{path}, $r);
@@ -801,11 +802,12 @@ sub cmt_metadata {
 }
 
 sub working_head_info {
-	my ($head, $refs) = @_;
+	my ($head, $refs, $grep) = @_;
 	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
 	while (my $hash = <$fh>) {
 		chomp($hash);
 		my ($url, $rev, $uuid) = cmt_metadata($hash);
+		next unless (!$grep or $url =~ m{$grep} or $uuid =~ m{$grep});
 		if (defined $url && defined $rev) {
 			if (my $gs = Git::SVN->find_by_url($url)) {
 				my $c = $gs->rev_db_get($rev);
@@ -3394,7 +3396,7 @@ sub git_svn_log_cmd {
 		last;
 	}
 
-	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
+	my ($url, $rev, $uuid, $gs) = ::working_head_info($head, undef, $_branch);
 	$gs ||= Git::SVN->_new;
 	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
 	           $gs->refname);
-- 
1.5.2.0.45.gfea6d-dirty

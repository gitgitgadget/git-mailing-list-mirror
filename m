From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCHv2 2/5] Implement git svn create-ignore.
Date: Tue, 16 Oct 2007 16:36:49 +0200
Message-ID: <1192545412-10929-2-git-send-email-tsuna@lrde.epita.fr>
References: <1192545412-10929-1-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 16:38:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnZ0-0006fy-A9
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862AbXJPOhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbXJPOhj
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:37:39 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:56270 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759381AbXJPOha (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 10:37:30 -0400
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id D3D71B93467; Tue, 16 Oct 2007 16:36:52 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.214.g6f43
In-Reply-To: <1192545412-10929-1-git-send-email-tsuna@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61180>

	* git-svn.perl (%cmd): Add the new command `create-ignore'.
	(&cmd_create_ignore): New.
	* t/t9101-git-svn-props.sh: Adjust the test-case for show-ignore and
	add a test case for create-ignore.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-svn.perl             |   27 +++++++++++++++++++++++++++
 t/t9101-git-svn-props.sh |   28 +++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 95393b6..4d643d7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -123,6 +123,10 @@ my %cmd = (
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
+	'create-ignore' => [ \&cmd_create_ignore,
+			     'Create a .gitignore per svn:ignore',
+			     { 'revision|r=i' => \$_revision
+			     } ],
 	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
 			{ 'revision|r=i' => \$_revision
 			} ],
@@ -499,6 +503,29 @@ sub cmd_show_ignore {
 	});
 }
 
+sub cmd_create_ignore {
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	$gs ||= Git::SVN->new;
+	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
+	$gs->prop_walk($gs->{path}, $r, sub {
+		my ($gs, $path, $props) = @_;
+		# $path is of the form /path/to/dir/
+		my $ignore = '.' . $path . '.gitignore';
+		my $s = $props->{'svn:ignore'} or return;
+		open(GITIGNORE, '>', $ignore)
+		  or fatal("Failed to open `$ignore' for writing: $!\n");
+		$s =~ s/[\r\n]+/\n/g;
+		chomp $s;
+		# Prefix all patterns so that the ignore doesn't apply
+		# to sub-directories.
+		$s =~ s#^#/#gm;
+		print GITIGNORE "$s\n";
+		close(GITIGNORE)
+		  or fatal("Failed to close `$ignore': $!\n");
+		command_noisy('add', $ignore);
+	});
+}
+
 sub cmd_multi_init {
 	my $url = shift;
 	unless (defined $_trunk || defined $_branches || defined $_tags) {
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 5aac644..796d80e 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -126,19 +126,20 @@ cat > show-ignore.expect <<\EOF
 # /
 /no-such-file*
 
-# deeply
+# /deeply/
 /deeply/no-such-file*
 
-# deeply/nested
+# /deeply/nested/
 /deeply/nested/no-such-file*
 
-# deeply/nested/directory
+# /deeply/nested/directory/
 /deeply/nested/directory/no-such-file*
 EOF
 
 test_expect_success 'test show-ignore' "
 	cd test_wc &&
 	mkdir -p deeply/nested/directory &&
+	touch deeply/nested/directory/.keep &&
 	svn add deeply &&
 	svn up &&
 	svn propset -R svn:ignore 'no-such-file*' .
@@ -148,4 +149,25 @@ test_expect_success 'test show-ignore' "
 	cmp show-ignore.expect show-ignore.got
 	"
 
+cat >create-ignore.expect <<\EOF
+/no-such-file*
+EOF
+
+cat >create-ignore-index.expect <<\EOF
+100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	.gitignore
+100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/.gitignore
+100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/nested/.gitignore
+100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/nested/directory/.gitignore
+EOF
+
+test_expect_success 'test create-ignore' "
+	git-svn fetch && git pull . remotes/git-svn &&
+	git-svn create-ignore &&
+	cmp ./.gitignore create-ignore.expect &&
+	cmp ./deeply/.gitignore create-ignore.expect &&
+	cmp ./deeply/nested/.gitignore create-ignore.expect &&
+	cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
+	git ls-files -s | grep gitignore | cmp - create-ignore-index.expect
+	"
+
 test_done
-- 
1.5.3.4.214.g6f43

From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH 3/5] Add git svn propget.
Date: Mon, 15 Oct 2007 17:35:04 +0200
Message-ID: <1192462506-3783-3-git-send-email-tsuna@lrde.epita.fr>
References: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr>
 <1192462506-3783-2-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 16:38:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnYy-0006fy-Uh
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbXJPOhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbXJPOhg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:37:36 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:56256 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759137AbXJPOh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 10:37:28 -0400
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id 225DCB411D2; Mon, 15 Oct 2007 17:35:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.214.g6f43
In-Reply-To: <1192462506-3783-2-git-send-email-tsuna@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61179>

	* git-svn.perl (%cmd): Add the new command `propget'.
	($cmd_dir_prefix): New global.
	(&get_svnprops): New helper.
	(&cmd_propget): New.  Use &get_svnprops.
	* t/t9101-git-svn-props.sh: Add a test case for propget.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-svn.perl             |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t9101-git-svn-props.sh |   23 ++++++++++++++++++
 2 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 94091ea..e58ff38 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -9,6 +9,8 @@ use vars qw/	$AUTHOR $VERSION
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
 
+# From which subdir have we been invoked?
+my $cmd_dir_prefix = command_oneline(qw/rev-parse --show-prefix/) || '';
 my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
 $ENV{GIT_DIR} ||= '.git';
 $Git::SVN::default_repo_id = 'svn';
@@ -127,6 +129,9 @@ my %cmd = (
 			     'Create a .gitignore per svn:ignore',
 			     { 'revision|r=i' => \$_revision
 			     } ],
+        'propget' => [ \&cmd_propget,
+		       'Print the value of a property on a file or directory',
+		       { 'revision|r=i' => \$_revision } ],
 	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
 			{ 'revision|r=i' => \$_revision
 			} ],
@@ -526,6 +531,58 @@ sub cmd_create_ignore {
 	});
 }
 
+# get_svnprops(PATH)
+# ------------------
+# Helper for cmd_propget below.
+sub get_svnprops {
+	my $path = shift;
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	$gs ||= Git::SVN->new;
+
+	# prefix THE PATH by the sub-directory from which the user
+	# invoked us.
+	$path = $cmd_dir_prefix . $path;
+	fatal("No such file or directory: $path\n") unless -e $path;
+	my $is_dir = -d $path ? 1 : 0;
+	$path = $gs->{path} . '/' . $path;
+
+	# canonicalize the path (otherwise libsvn will abort or fail to
+	# find the file)
+	# File::Spec->canonpath doesn't collapse x/../y into y (for a
+	# good reason), so let's do this manually.
+	$path =~ s#/+#/#g;
+	$path =~ s#/\.(?:/|$)#/#g;
+	$path =~ s#/[^/]+/\.\.##g;
+	$path =~ s#/$##g;
+
+	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
+	my $props;
+	if ($is_dir)
+	{
+		(undef, undef, $props) = $gs->ra->get_dir($path, $r);
+	}
+	else
+	{
+		(undef, $props) = $gs->ra->get_file($path, $r, undef);
+	}
+	return $props;
+}
+
+# cmd_propget (PROP, PATH)
+# ------------------------
+# Print the SVN property PROP for PATH.
+sub cmd_propget {
+	my ($prop, $path) = @_;
+	$path = '.' if not defined $path;
+	usage(1) if not defined $prop;
+	my $props = get_svnprops($path);
+	if (not defined $props->{$prop})
+	{
+		fatal("`$path' does not have a `$prop' SVN property.\n");
+	}
+	print $props->{$prop} . "\n";
+}
+
 sub cmd_multi_init {
 	my $url = shift;
 	unless (defined $_trunk || defined $_branches || defined $_tags) {
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 796d80e..61c8799 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -170,4 +170,27 @@ test_expect_success 'test create-ignore' "
 	git ls-files -s | grep gitignore | cmp - create-ignore-index.expect
 	"
 
+cat >prop.expect <<\EOF
+no-such-file*
+
+EOF
+cat >prop2.expect <<\EOF
+8
+EOF
+
+# This test can be improved: since all the svn:ignore contain the same
+# pattern, it can pass even though the propget did not execute on the
+# right directory.
+test_expect_success 'test propget' "
+	git-svn propget svn:ignore . | cmp - prop.expect &&
+	cd deeply &&
+	git-svn propget svn:ignore . | cmp - ../prop.expect &&
+	git-svn propget svn:entry:committed-rev nested/directory/.keep \
+	  | cmp - ../prop2.expect &&
+	git-svn propget svn:ignore .. | cmp - ../prop.expect &&
+	git-svn propget svn:ignore nested/ | cmp - ../prop.expect &&
+	git-svn propget svn:ignore ./nested | cmp - ../prop.expect &&
+	git-svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
+	"
+
 test_done
-- 
1.5.3.4.214.g6f43

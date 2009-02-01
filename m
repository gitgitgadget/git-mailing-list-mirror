From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: allow disabling expensive broken symlink checks
Date: Sat, 31 Jan 2009 18:18:44 -0800
Message-ID: <20090201021844.GB18855@dcvr.yhbt.net>
References: <200901311414.58205.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 03:20:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRwf-0003sQ-2X
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 03:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbZBACSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 21:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbZBACSq
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 21:18:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52948 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbZBACSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 21:18:45 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE441F799;
	Sun,  1 Feb 2009 02:18:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901311414.58205.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107971>

Since dbc6c74d0858d77e61e092a48d467e725211f8e9, git-svn has had
an expensive check for broken symlinks that exist in some
repositories.  This leads to a heavy performance hit on
repositories with many empty blobs that are not supposed to be
symlinks.

The workaround is enabled by default; and may be disabled via:

  git config svn.brokenSymlinkWorkaround false

Reported by Markus Heidelberg.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  Markus Heidelberg <markus.heidelberg@web.de> wrote:
  > Hi,
  > 
  > since several days "git svn fetch" didn't seem to work any more. I
  > bisected it down to
  > 
  >     commit dbc6c74d0858d77e61e092a48d467e725211f8e9
  >     git-svn: handle empty files marked as symlinks in SVN
  >     2009-01-11
  > 
  > In the new function _mark_empty_symlinks() there is a loop that takes
  > about 36 seconds for me. That means each svn revision takes 36+x seconds
  > for downloading. So it still works, but I aborted it before waiting so
  > much time, so I thought, it didn't work any more.
  > 
  > The loop loops over each blob ("git ls-tree -r git-svn | wc -l" times).
  > The project I'm using git-svn with is Buildroot and it has currently
  > 3074 blobs in the tree. Printing a loop counter every time the loop is
  > executed, I can see that it mostly goes really fast, but there are
  > files, where it needs much time then.
  > 
  > Could there be a way to avoid this time consuming step?
  > 
  > Markus

 Documentation/git-svn.txt        |    8 ++++++++
 git-svn.perl                     |   20 ++++++++++++++++++++
 t/t9131-git-svn-empty-symlink.sh |   10 ++++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 7b654f7..3d45654 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -499,6 +499,14 @@ svn-remote.<name>.rewriteRoot::
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
 
+svn.brokenSymlinkWorkaround::
+This disables potentially expensive checks to workaround broken symlinks
+checked into SVN by broken clients.  Set this option to "false" if you
+track a SVN repository with many empty blobs that are not symlinks.
+This option may be changed while "git-svn" is running and take effect on
+the next revision fetched.  If unset, git-svn assumes this option to be
+"true".
+
 --
 
 Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
diff --git a/git-svn.perl b/git-svn.perl
index 79888a0..bebcbde 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3271,10 +3271,18 @@ sub new {
 # do_{switch,update}
 sub _mark_empty_symlinks {
 	my ($git_svn) = @_;
+	my $bool = Git::config_bool('svn.brokenSymlinkWorkaround');
+	return {} if (defined($bool) && ! $bool);
+
 	my %ret;
 	my ($rev, $cmt) = $git_svn->last_rev_commit;
 	return {} unless ($rev && $cmt);
 
+	# allow the warning to be printed for each revision we fetch to
+	# ensure the user sees it.  The user can also disable the workaround
+	# on the repository even while git svn is running and the next
+	# revision fetched will skip this expensive function.
+	my $printed_warning;
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
 	local $/ = "\0";
@@ -3283,6 +3291,18 @@ sub _mark_empty_symlinks {
 	while (<$ls>) {
 		chomp;
 		s/\A100644 blob $empty_blob\t//o or next;
+		unless ($printed_warning) {
+			print STDERR "Scanning for empty symlinks, ",
+			             "this may take a while if you have ",
+				     "many empty files\n",
+				     "You may disable this with `",
+				     "git config svn.brokenSymlinkWorkaround ",
+				     "false'.\n",
+				     "This may be done in a different ",
+				     "terminal without restarting ",
+				     "git svn\n";
+			$printed_warning = 1;
+		}
 		my $path = $_;
 		my (undef, $props) =
 		               $git_svn->ra->get_file($pfx.$path, $rev, undef);
diff --git a/t/t9131-git-svn-empty-symlink.sh b/t/t9131-git-svn-empty-symlink.sh
index 704a4f8..c3c3e42 100755
--- a/t/t9131-git-svn-empty-symlink.sh
+++ b/t/t9131-git-svn-empty-symlink.sh
@@ -87,4 +87,14 @@ test_expect_success '"bar" is an empty file' 'test -f x/bar && ! test -s x/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd x && git svn rebase)'
 test_expect_success '"bar" becomes a symlink' 'test -L x/bar'
+
+
+test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" y'
+test_expect_success 'disable broken symlink workaround' \
+  '(cd y && git config svn.brokenSymlinkWorkaround false)'
+test_expect_success '"bar" is an empty file' 'test -f y/bar && ! test -s y/bar'
+test_expect_success 'get "bar" => symlink fix from svn' \
+		'(cd y && git svn rebase)'
+test_expect_success '"bar" becomes a symlink' '! test -L y/bar'
+
 test_done
-- 
Eric Wong

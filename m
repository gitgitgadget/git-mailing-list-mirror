From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: use refs/remotes/git-svn instead of git-svn-HEAD
Date: Wed, 1 Mar 2006 21:58:31 -0800
Message-ID: <20060302055831.GA16600@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 06:58:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEgpp-0006vd-DA
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 06:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWCBF6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 00:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCBF6f
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 00:58:35 -0500
Received: from hand.yhbt.net ([66.150.188.102]:24020 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751148AbWCBF6e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 00:58:34 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AC3FF2DC034;
	Wed,  1 Mar 2006 21:58:31 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed,  1 Mar 2006 21:58:31 -0800
To: git list <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17055>

After reading a lengthy discussion on the list, I've come to the
conclusion that creating a 'remotes' directory in refs isn't
such a bad idea.

You can still branch from it by specifying remotes/git-svn (not
needing the leading 'refs/'), and the documentation has been
updated to reflect that.

The 'git-svn' part of the ref can of course be set to whatever
you want by using the GIT_SVN_ID environment variable, as
before.

I'm using refs/remotes/git-svn, and not going with something
like refs/remotes/git-svn/HEAD as it's redundant for Subversion
where there's zero distinction between branches and directories.

Run git-svn rebuild --upgrade to upgrade your repository to use
the new head.  git-svn-HEAD must be manually deleted for safety
reasons.

Side note: if you ever (and I hope you never) want to run
git-update-refs on a 'remotes/' ref, make sure you have the
'refs/' prefix as you don't want to be clobbering your
'remotes/' in $GIT_DIR (where remote URLs are stored).

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl               |   63 +++++++++++++++++++++++-----
 contrib/git-svn/git-svn.txt                |   18 ++++----
 contrib/git-svn/t/t0000-contrib-git-svn.sh |   36 ++++++++--------
 3 files changed, 78 insertions(+), 39 deletions(-)

98158fd226f764a4d20a4a66b651f3a154a92bf2
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 0b74165..0e092c5 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -34,13 +34,14 @@ use POSIX qw/strftime/;
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{6,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
-	$_find_copies_harder, $_l, $_version);
+	$_find_copies_harder, $_l, $_version, $_upgrade);
 
 GetOptions(	'revision|r=s' => \$_revision,
 		'no-ignore-externals' => \$_no_ignore_ext,
 		'stdin|' => \$_stdin,
 		'edit|e' => \$_edit,
 		'rmdir' => \$_rmdir,
+		'upgrade' => \$_upgrade,
 		'help|H|h' => \$_help,
 		'find-copies-harder' => \$_find_copies_harder,
 		'l=i' => \$_l,
@@ -106,13 +107,18 @@ sub rebuild {
 	$SVN_URL = shift or undef;
 	my $repo_uuid;
 	my $newest_rev = 0;
+	if ($_upgrade) {
+		sys('git-update-ref',"refs/remotes/$GIT_SVN","$GIT_SVN-HEAD");
+	} else {
+		check_upgrade_needed();
+	}
 
 	my $pid = open(my $rev_list,'-|');
 	defined $pid or croak $!;
 	if ($pid == 0) {
-		exec("git-rev-list","$GIT_SVN-HEAD") or croak $!;
+		exec("git-rev-list","refs/remotes/$GIT_SVN") or croak $!;
 	}
-	my $first;
+	my $latest;
 	while (<$rev_list>) {
 		chomp;
 		my $c = $_;
@@ -132,18 +138,20 @@ sub rebuild {
 					"$c, $id\n";
 			}
 		}
+
+		# if we merged or otherwise started elsewhere, this is
+		# how we break out of it
+		next if (defined $repo_uuid && ($uuid ne $repo_uuid));
+		next if (defined $SVN_URL && ($url ne $SVN_URL));
+
 		print "r$rev = $c\n";
-		unless (defined $first) {
+		unless (defined $latest) {
 			if (!$SVN_URL && !$url) {
 				croak "SVN repository location required: $url\n";
 			}
 			$SVN_URL ||= $url;
-			$repo_uuid = setup_git_svn();
-			$first = $rev;
-		}
-		if ($uuid ne $repo_uuid) {
-			croak "Repository UUIDs do not match!\ngot: $uuid\n",
-						"expected: $repo_uuid\n";
+			$repo_uuid ||= setup_git_svn();
+			$latest = $rev;
 		}
 		assert_revision_eq_or_unknown($rev, $c);
 		sys('git-update-ref',"$GIT_SVN/revs/$rev",$c);
@@ -151,7 +159,7 @@ sub rebuild {
 	}
 	close $rev_list or croak $?;
 	if (!chdir $SVN_WC) {
-		my @svn_co = ('svn','co',"-r$first");
+		my @svn_co = ('svn','co',"-r$latest");
 		push @svn_co, '--ignore-externals' unless $_no_ignore_ext;
 		sys(@svn_co, $SVN_URL, $SVN_WC);
 		chdir $SVN_WC or croak $!;
@@ -168,6 +176,13 @@ sub rebuild {
 		exec('git-write-tree');
 	}
 	waitpid $pid, 0;
+
+	if ($_upgrade) {
+		print STDERR <<"";
+Keeping deprecated refs/head/$GIT_SVN-HEAD for now.  Please remove it
+when you have upgraded your tools and habits to use refs/remotes/$GIT_SVN
+
+	}
 }
 
 sub init {
@@ -180,6 +195,7 @@ sub init {
 
 sub fetch {
 	my (@parents) = @_;
+	check_upgrade_needed();
 	$SVN_URL ||= file_to_s("$GIT_DIR/$GIT_SVN/info/url");
 	my @log_args = -d $SVN_WC ? ($SVN_WC) : ($SVN_URL);
 	unless ($_revision) {
@@ -222,6 +238,7 @@ sub fetch {
 
 sub commit {
 	my (@commits) = @_;
+	check_upgrade_needed();
 	if ($_stdin || !@commits) {
 		print "Reading from stdin...\n";
 		@commits = ();
@@ -863,7 +880,7 @@ sub git_commit {
 	if ($commit !~ /^$sha1$/o) {
 		croak "Failed to commit, invalid sha1: $commit\n";
 	}
-	my @update_ref = ('git-update-ref',"refs/heads/$GIT_SVN-HEAD",$commit);
+	my @update_ref = ('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
 	if (my $primary_parent = shift @exec_parents) {
 		push @update_ref, $primary_parent;
 	}
@@ -936,6 +953,28 @@ sub svn_check_ignore_externals {
 		$_no_ignore_ext = 1;
 	}
 }
+
+sub check_upgrade_needed {
+	my $old = eval {
+		my $pid = open my $child, '-|';
+		defined $pid or croak $!;
+		if ($pid == 0) {
+			close STDERR;
+			exec('git-rev-parse',"$GIT_SVN-HEAD") or croak $?;
+		}
+		my @ret = (<$child>);
+		close $child or croak $?;
+		die $? if $?; # just in case close didn't error out
+		return wantarray ? @ret : join('',@ret);
+	};
+	return unless $old;
+	my $head = eval { safe_qx('git-rev-parse',"refs/remotes/$GIT_SVN") };
+	if ($@ || !$head) {
+		print STDERR "Please run: $0 rebuild --upgrade\n";
+		exit 1;
+	}
+}
+
 __END__
 
 Data structures:
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index b290739..4102deb 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -41,12 +41,12 @@ init::
 
 fetch::
 	Fetch unfetched revisions from the SVN_URL we are tracking.
-	refs/heads/git-svn-HEAD will be updated to the latest revision.
+	refs/heads/remotes/git-svn will be updated to the latest revision.
 
-	Note: You should never attempt to modify the git-svn-HEAD branch
-	outside of git-svn.  Instead, create a branch from git-svn-HEAD
+	Note: You should never attempt to modify the remotes/git-svn branch
+	outside of git-svn.  Instead, create a branch from remotes/git-svn
 	and work on that branch.  Use the 'commit' command (see below)
-	to write git commits back to git-svn-HEAD.
+	to write git commits back to remotes/git-svn.
 
 commit::
 	Commit specified commit or tree objects to SVN.  This relies on
@@ -155,13 +155,13 @@ Tracking and contributing to an Subversi
 # Fetch remote revisions::
 	git-svn fetch
 # Create your own branch to hack on::
-	git checkout -b my-branch git-svn-HEAD
+	git checkout -b my-branch remotes/git-svn
 # Commit only the git commits you want to SVN::
 	git-svn commit <tree-ish> [<tree-ish_2> ...]
 # Commit all the git commits from my-branch that don't exist in SVN::
-	git-svn commit git-svn-HEAD..my-branch
+	git-svn commit remotes/git-svn..my-branch
 # Something is committed to SVN, pull the latest into your branch::
-	git-svn fetch && git pull . git-svn-HEAD
+	git-svn fetch && git pull . remotes/git-svn
 # Append svn:ignore settings to the default git exclude file:
 	git-svn show-ignore >> .git/info/exclude
 
@@ -184,8 +184,8 @@ SVN repositories via one git repository.
 environment variable to a name other other than "git-svn" (the default)
 and git-svn will ignore the contents of the $GIT_DIR/git-svn directory
 and instead do all of its work in $GIT_DIR/$GIT_SVN_ID for that
-invocation.  The interface branch will be $GIT_SVN_ID-HEAD, instead of
-git-svn-HEAD.  Any $GIT_SVN_ID-HEAD branch should never be modified
+invocation.  The interface branch will be remotes/$GIT_SVN_ID, instead of
+remotes/git-svn.  Any remotes/$GIT_SVN_ID branch should never be modified
 by the user outside of git-svn commands.
 
 ADDITIONAL FETCH ARGUMENTS
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index 181dfe0..80ad357 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -71,14 +71,14 @@ test_expect_success \
 
 
 name='try a deep --rmdir with a commit'
-git checkout -b mybranch git-svn-HEAD
+git checkout -b mybranch remotes/git-svn
 mv dir/a/b/c/d/e/file dir/file
 cp dir/file file
 git update-index --add --remove dir/a/b/c/d/e/file dir/file file
 git commit -m "$name"
 
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch &&
+    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch &&
      test -d $SVN_TREE/dir && test ! -d $SVN_TREE/dir/a"
 
 
@@ -91,13 +91,13 @@ git update-index --add dir/file/file
 git commit -m "$name"
 
 test_expect_code 1 "$name" \
-    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch' \
+    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch' \
     || true
 
 
 name='detect node change from directory to file #1'
 rm -rf dir $GIT_DIR/index
-git checkout -b mybranch2 git-svn-HEAD
+git checkout -b mybranch2 remotes/git-svn
 mv bar/zzz zzz
 rm -rf bar
 mv zzz bar
@@ -106,13 +106,13 @@ git update-index --add -- bar
 git commit -m "$name"
 
 test_expect_code 1 "$name" \
-    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch2' \
+    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch2' \
     || true
 
 
 name='detect node change from file to directory #2'
 rm -f $GIT_DIR/index
-git checkout -b mybranch3 git-svn-HEAD
+git checkout -b mybranch3 remotes/git-svn
 rm bar/zzz
 git-update-index --remove bar/zzz
 mkdir bar/zzz
@@ -121,13 +121,13 @@ git-update-index --add bar/zzz/yyy
 git commit -m "$name"
 
 test_expect_code 1 "$name" \
-    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch3' \
+    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch3' \
     || true
 
 
 name='detect node change from directory to file #2'
 rm -f $GIT_DIR/index
-git checkout -b mybranch4 git-svn-HEAD
+git checkout -b mybranch4 remotes/git-svn
 rm -rf dir
 git update-index --remove -- dir/file
 touch dir
@@ -136,19 +136,19 @@ git update-index --add -- dir
 git commit -m "$name"
 
 test_expect_code 1 "$name" \
-    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch4' \
+    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch4' \
     || true
 
 
 name='remove executable bit from a file'
 rm -f $GIT_DIR/index
-git checkout -b mybranch5 git-svn-HEAD
+git checkout -b mybranch5 remotes/git-svn
 chmod -x exec.sh
 git update-index exec.sh
 git commit -m "$name"
 
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
      test ! -x $SVN_TREE/exec.sh"
 
 
@@ -158,7 +158,7 @@ git update-index exec.sh
 git commit -m "$name"
 
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
      test -x $SVN_TREE/exec.sh"
 
 
@@ -170,7 +170,7 @@ git update-index exec.sh
 git commit -m "$name"
 
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
      test -L $SVN_TREE/exec.sh"
 
 
@@ -182,7 +182,7 @@ git update-index --add bar/zzz exec-2.sh
 git commit -m "$name"
 
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
      test -x $SVN_TREE/bar/zzz &&
      test -L $SVN_TREE/exec-2.sh"
 
@@ -196,7 +196,7 @@ git update-index exec-2.sh
 git commit -m "$name"
 
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
      test -f $SVN_TREE/exec-2.sh &&
      test ! -L $SVN_TREE/exec-2.sh &&
      diff -u help $SVN_TREE/exec-2.sh"
@@ -207,9 +207,9 @@ name='test fetch functionality (svn => g
 GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
-    "git-svn init $svnrepo && git-svn fetch -v &&
-     git-rev-list --pretty=raw git-svn-HEAD | grep ^tree | uniq > a &&
-     git-rev-list --pretty=raw alt-HEAD | grep ^tree | uniq > b &&
+    "git-svn init $svnrepo && git-svn fetch &&
+     git-rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
+     git-rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      diff -u a b"
 
 test_done
-- 
1.2.3.g4676

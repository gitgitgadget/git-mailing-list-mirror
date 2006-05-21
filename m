From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: ignore expansion of svn:keywords
Date: Sat, 20 May 2006 20:03:30 -0700
Message-ID: <20060521030330.GA15812@soma>
References: <446A0CCF.2060903@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 05:03:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FheED-00007R-GB
	for gcvg-git@gmane.org; Sun, 21 May 2006 05:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWEUDDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 23:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWEUDDe
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 23:03:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:62935 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751436AbWEUDDd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 23:03:33 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7EAB72DC034;
	Sat, 20 May 2006 20:03:31 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 20 May 2006 20:03:30 -0700
To: Tommi Virtanen <tv@inoi.fi>
Content-Disposition: inline
In-Reply-To: <446A0CCF.2060903@inoi.fi>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20429>

Can you try this patch?

This weakens an integrity in order to work on certain
repositories (see comments).  It's probably safe to use,
though...  More testing and feedback would be nice.

I've split out the test for this feature to make things easier
to manage and test, too.

Also changed assert_svn_wc_clean() to only work on svn, and
require a separate call to assert_tree() to check wc integrity
against git in preparation for another change I'm planning.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 @Junio: please don't apply this to git.git just yet, thanks.

 contrib/git-svn/Makefile                         |    1 
 contrib/git-svn/git-svn.perl                     |   79 +++++++++++++++++-----
 contrib/git-svn/t/lib-git-svn.sh                 |   39 +++++++++++
 contrib/git-svn/t/t0000-contrib-git-svn.sh       |   43 +-----------
 contrib/git-svn/t/t0001-contrib-git-svn-props.sh |   51 ++++++++++++++
 5 files changed, 153 insertions(+), 60 deletions(-)
 create mode 100644 contrib/git-svn/t/lib-git-svn.sh
 create mode 100644 contrib/git-svn/t/t0001-contrib-git-svn-props.sh

eb8f17257c7d15ec6815baf18208af06f72b3cdb
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index acedf73..48f60b3 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -30,6 +30,7 @@ git-svn.html : git-svn.txt
 		-f ../../Documentation/asciidoc.conf $<
 test: git-svn
 	cd t && $(SHELL) ./t0000-contrib-git-svn.sh
+	cd t && $(SHELL) ./t0001-contrib-git-svn-props.sh
 
 clean:
 	rm -f git-svn *.xml *.html *.1
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index de13a96..86b687a 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -26,6 +26,7 @@ use Carp qw/croak/;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
+use File::Copy qw/cp/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use File::Spec qw//;
 use POSIX qw/strftime/;
@@ -207,7 +208,7 @@ sub rebuild {
 		push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
 		sys(@svn_up,"-r$newest_rev");
 		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
-		git_addremove();
+		index_changes();
 		exec('git-write-tree');
 	}
 	waitpid $pid, 0;
@@ -249,7 +250,7 @@ sub fetch {
 		chdir $SVN_WC or croak $!;
 		read_uuid();
 		$last_commit = git_commit($base, @parents);
-		assert_svn_wc_clean($base->{revision}, $last_commit);
+		assert_tree($last_commit);
 	} else {
 		chdir $SVN_WC or croak $!;
 		read_uuid();
@@ -259,7 +260,11 @@ sub fetch {
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
 	my $last = $base;
 	while (my $log_msg = next_log_entry($svn_log)) {
-		assert_svn_wc_clean($last->{revision}, $last_commit);
+		# this assertion is commented out because it breaks keywords
+		# on https://svn.musicpd.org/Jamming/trunk (r166:167), but
+		# I can't seem to reproduce something like that on a test...
+		# assert_svn_wc_clean($last->{revision});
+		assert_tree($last_commit);
 		if ($last->{revision} >= $log_msg->{revision}) {
 			croak "Out of order: last >= current: ",
 				"$last->{revision} >= $log_msg->{revision}\n";
@@ -268,7 +273,8 @@ sub fetch {
 		$last_commit = git_commit($log_msg, $last_commit, @parents);
 		$last = $log_msg;
 	}
-	assert_svn_wc_clean($last->{revision}, $last_commit);
+	assert_svn_wc_clean($last->{revision});
+	assert_tree($last_commit);
 	unless (-e "$GIT_DIR/refs/heads/master") {
 		sys(qw(git-update-ref refs/heads/master),$last_commit);
 	}
@@ -314,7 +320,6 @@ sub commit {
 		$svn_current_rev = svn_commit_tree($svn_current_rev, $c);
 	}
 	print "Done committing ",scalar @revs," revisions to SVN\n";
-
 }
 
 sub show_ignore {
@@ -367,13 +372,11 @@ sub setup_git_svn {
 }
 
 sub assert_svn_wc_clean {
-	my ($svn_rev, $treeish) = @_;
+	my ($svn_rev) = @_;
 	croak "$svn_rev is not an integer!\n" unless ($svn_rev =~ /^\d+$/);
-	croak "$treeish is not a sha1!\n" unless ($treeish =~ /^$sha1$/o);
 	my $lcr = svn_info('.')->{'Last Changed Rev'};
 	if ($svn_rev != $lcr) {
 		print STDERR "Checking for copy-tree ... ";
-		# use
 		my @diff = grep(/^Index: /,(safe_qx(qw(svn diff),
 						"-r$lcr:$svn_rev")));
 		if (@diff) {
@@ -389,7 +392,6 @@ sub assert_svn_wc_clean {
 		print STDERR $_ foreach @status;
 		croak;
 	}
-	assert_tree($treeish);
 }
 
 sub assert_tree {
@@ -416,7 +418,7 @@ sub assert_tree {
 		unlink $tmpindex or croak $!;
 	}
 	$ENV{GIT_INDEX_FILE} = $tmpindex;
-	git_addremove();
+	index_changes(1);
 	chomp(my $tree = `git-write-tree`);
 	if ($old_index) {
 		$ENV{GIT_INDEX_FILE} = $old_index;
@@ -426,6 +428,7 @@ sub assert_tree {
 	if ($tree ne $expected) {
 		croak "Tree mismatch, Got: $tree, Expected: $expected\n";
 	}
+	unlink $tmpindex;
 }
 
 sub parse_diff_tree {
@@ -562,7 +565,8 @@ sub precommit_check {
 sub svn_checkout_tree {
 	my ($svn_rev, $treeish) = @_;
 	my $from = file_to_s("$REV_DIR/$svn_rev");
-	assert_svn_wc_clean($svn_rev,$from);
+	assert_svn_wc_clean($svn_rev);
+	assert_tree($from);
 	print "diff-tree $from $treeish\n";
 	my $pid = open my $diff_fh, '-|';
 	defined $pid or croak $!;
@@ -852,13 +856,50 @@ sub svn_info {
 
 sub sys { system(@_) == 0 or croak $? }
 
-sub git_addremove {
-	system( "git-diff-files --name-only -z ".
-				" | git-update-index --remove -z --stdin && ".
-		"git-ls-files -z --others ".
-			"'--exclude-from=$GIT_DIR/$GIT_SVN/info/exclude'".
-				" | git-update-index --add -z --stdin"
-		) == 0 or croak $?
+sub do_update_index {
+	my ($z_cmd, $cmd, $no_text_base) = @_;
+
+	my $z = open my $p, '-|';
+	defined $z or croak $!;
+	unless ($z) { exec @$z_cmd or croak $! }
+
+	my $pid = open my $ui, '|-';
+	defined $pid or croak $!;
+	unless ($pid) {
+		exec('git-update-index',"--$cmd",'-z','--stdin') or croak $!;
+	}
+	local $/ = "\0";
+	while (my $x = <$p>) {
+		chomp $x;
+		if (!$no_text_base && lstat $x && ! -l _) {
+			my $mode = -x _ ? 0755 : 0644;
+			my ($v,$d,$f) = File::Spec->splitpath($x);
+			my $tb = File::Spec->catfile($d, '.svn', 'tmp',
+						'text-base',"$f.svn-base");
+			$tb =~ s#^/##;
+			unless (-f $tb) {
+				$tb = File::Spec->catfile($d, '.svn',
+						'text-base',"$f.svn-base");
+				$tb =~ s#^/##;
+			}
+			unlink $x or croak $!;
+			cp($tb, $x) or croak $!;
+			chmod(($mode &~ umask), $x) or croak $!;
+		}
+		print $ui $x,"\0";
+	}
+	close $ui or croak $!;
+}
+
+sub index_changes {
+	my $no_text_base = shift;
+	do_update_index([qw/git-diff-files --name-only -z/],
+			'remove',
+			$no_text_base);
+	do_update_index([qw/git-ls-files -z --others/,
+			      "--exclude-from=$GIT_DIR/$GIT_SVN/info/exclude"],
+			'add',
+			$no_text_base);
 }
 
 sub s_to_file {
@@ -936,7 +977,7 @@ sub git_commit {
 	defined $pid or croak $!;
 	if ($pid == 0) {
 		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
-		git_addremove();
+		index_changes();
 		chomp(my $tree = `git-write-tree`);
 		croak if $?;
 		if (exists $tree_map{$tree}) {
diff --git a/contrib/git-svn/t/lib-git-svn.sh b/contrib/git-svn/t/lib-git-svn.sh
new file mode 100644
index 0000000..a98e9d1
--- /dev/null
+++ b/contrib/git-svn/t/lib-git-svn.sh
@@ -0,0 +1,39 @@
+PATH=$PWD/../:$PATH
+if test -d ../../../t
+then
+    cd ../../../t
+else
+    echo "Must be run in contrib/git-svn/t" >&2
+    exit 1
+fi
+
+. ./test-lib.sh
+
+GIT_DIR=$PWD/.git
+GIT_SVN_DIR=$GIT_DIR/git-svn
+SVN_TREE=$GIT_SVN_DIR/tree
+
+svnadmin >/dev/null 2>&1
+if test $? != 1
+then
+    test_expect_success 'skipping contrib/git-svn test' :
+    test_done
+    exit
+fi
+
+svn >/dev/null 2>&1
+if test $? != 1
+then
+    test_expect_success 'skipping contrib/git-svn test' :
+    test_done
+    exit
+fi
+
+svnrepo=$PWD/svnrepo
+
+set -e
+
+svnadmin create $svnrepo
+svnrepo="file://$svnrepo/test-git-svn"
+
+
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index 80ad357..8b3a0d9 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -3,48 +3,10 @@ #
 # Copyright (c) 2006 Eric Wong
 #
 
-
-PATH=$PWD/../:$PATH
 test_description='git-svn tests'
-if test -d ../../../t
-then
-    cd ../../../t
-else
-    echo "Must be run in contrib/git-svn/t" >&2
-    exit 1
-fi
-
-. ./test-lib.sh
-
-GIT_DIR=$PWD/.git
-GIT_SVN_DIR=$GIT_DIR/git-svn
-SVN_TREE=$GIT_SVN_DIR/tree
-
-svnadmin >/dev/null 2>&1
-if test $? != 1
-then
-    test_expect_success 'skipping contrib/git-svn test' :
-    test_done
-    exit
-fi
-
-svn >/dev/null 2>&1
-if test $? != 1
-then
-    test_expect_success 'skipping contrib/git-svn test' :
-    test_done
-    exit
-fi
-
-svnrepo=$PWD/svnrepo
-
-set -e
-
-svnadmin create $svnrepo
-svnrepo="file://$svnrepo/test-git-svn"
+. ./lib-git-svn.sh
 
 mkdir import
-
 cd import
 
 echo foo > foo
@@ -55,10 +17,9 @@ mkdir -p bar
 echo 'zzz' > bar/zzz
 echo '#!/bin/sh' > exec.sh
 chmod +x exec.sh
-svn import -m 'import for git-svn' . $svnrepo >/dev/null
+svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
 
 cd ..
-
 rm -rf import
 
 test_expect_success \
diff --git a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
new file mode 100644
index 0000000..20c5c4e
--- /dev/null
+++ b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+
+test_description='git-svn property tests'
+. ./lib-git-svn.sh
+
+mkdir import
+
+cd import
+	cat >> kw.c <<''
+/* Make it look like somebody copied a file from CVS into SVN: */
+/* $Id: kw.c,v 1.1.1.1 1994/03/06 00:00:00 eric Exp $ */
+
+	svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
+cd ..
+
+rm -rf import
+svn co "$svnrepo" test_wc
+
+cd test_wc
+	echo 'Greetings' >> kw.c
+	svn commit -m 'Not yet an $Id$'
+	svn up
+
+	echo 'Hello world' >> kw.c
+	svn commit -m 'Modified file, but still not yet an $Id$'
+	svn up
+
+	svn propset svn:keywords Id kw.c
+	svn commit -m 'Propset $Id$'
+	svn up
+cd ..
+
+git-svn init "$svnrepo"
+git-svn fetch
+
+git checkout -b mybranch remotes/git-svn
+echo 'Hi again' >> kw.c
+name='test svn:keywords ignoring'
+
+git commit -a -m "$name"
+git-svn commit remotes/git-svn..mybranch
+git pull . remotes/git-svn
+
+expect='/* $Id$ */'
+got="`sed -ne 2p kw.c`"
+test_expect_success 'raw $Id$ found in kw.c' "test '$expect' = '$got'"
+
+test_done
-- 
1.3.2.g7d11

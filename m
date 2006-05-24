From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: ignore expansion of svn:keywords
Date: Tue, 23 May 2006 19:23:41 -0700
Message-ID: <11484374243815-git-send-email-normalperson@yhbt.net>
References: <11484374222795-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 24 04:24:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fij2R-0007B6-PB
	for gcvg-git@gmane.org; Wed, 24 May 2006 04:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWEXCXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 22:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWEXCXr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 22:23:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37252 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932552AbWEXCXq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 22:23:46 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 542817DC021;
	Tue, 23 May 2006 19:23:45 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 23 May 2006 19:23:44 -0700
To: Tommi Virtanen <tv@inoi.fi>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <11484374222795-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20661>

Unlike my earlier test patch, this also checks svn:eol-style and
makes sure it's applied to working copy updates.  This is
definitely more correct than my original attempt at killing
keyword expansions, but I still haven't tested it enough to
know.  Feedback would be much appreciated.

Also changed assert_svn_wc_clean() to only work on the svn
working copy.  This requires a separate call to assert_tree() to
check wc integrity against git in preparation for another change
I'm planning.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/Makefile                         |    1 
 contrib/git-svn/git-svn.perl                     |  106 +++++++++++++++----
 contrib/git-svn/t/lib-git-svn.sh                 |   39 +++++++
 contrib/git-svn/t/t0000-contrib-git-svn.sh       |   43 --------
 contrib/git-svn/t/t0001-contrib-git-svn-props.sh |  125 ++++++++++++++++++++++
 5 files changed, 254 insertions(+), 60 deletions(-)
 create mode 100644 contrib/git-svn/t/lib-git-svn.sh
 create mode 100644 contrib/git-svn/t/t0001-contrib-git-svn-props.sh

b9ba79157fc4f92e14aac89d9a5f838539d6eede
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
index 39471b5..fc9b7ef 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -39,6 +39,10 @@ my $_svn_co_url_revs;
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
 		'authors-file|A=s' => \$_authors );
+
+# yes, 'native' sets "\n".  Patches to fix this for non-*nix systems welcome:
+my %EOL = ( CR => "\015", LF => "\012", CRLF => "\015\012", native => "\012" );
+
 my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision, %fc_opts } ],
@@ -207,7 +211,7 @@ sub rebuild {
 		push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
 		sys(@svn_up,"-r$newest_rev");
 		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
-		git_addremove();
+		index_changes();
 		exec('git-write-tree');
 	}
 	waitpid $pid, 0;
@@ -249,7 +253,7 @@ sub fetch {
 		chdir $SVN_WC or croak $!;
 		read_uuid();
 		$last_commit = git_commit($base, @parents);
-		assert_svn_wc_clean($base->{revision}, $last_commit);
+		assert_tree($last_commit);
 	} else {
 		chdir $SVN_WC or croak $!;
 		read_uuid();
@@ -259,16 +263,20 @@ sub fetch {
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
 	my $last = $base;
 	while (my $log_msg = next_log_entry($svn_log)) {
-		assert_svn_wc_clean($last->{revision}, $last_commit);
+		assert_tree($last_commit);
 		if ($last->{revision} >= $log_msg->{revision}) {
 			croak "Out of order: last >= current: ",
 				"$last->{revision} >= $log_msg->{revision}\n";
 		}
+		# Revert is needed for cases like:
+		# https://svn.musicpd.org/Jamming/trunk (r166:167), but
+		# I can't seem to reproduce something like that on a test...
+		sys(qw/svn revert -R ./);
+		assert_svn_wc_clean($last->{revision});
 		sys(@svn_up,"-r$log_msg->{revision}");
 		$last_commit = git_commit($log_msg, $last_commit, @parents);
 		$last = $log_msg;
 	}
-	assert_svn_wc_clean($last->{revision}, $last_commit);
 	unless (-e "$GIT_DIR/refs/heads/master") {
 		sys(qw(git-update-ref refs/heads/master),$last_commit);
 	}
@@ -314,7 +322,6 @@ sub commit {
 		$svn_current_rev = svn_commit_tree($svn_current_rev, $c);
 	}
 	print "Done committing ",scalar @revs," revisions to SVN\n";
-
 }
 
 sub show_ignore {
@@ -367,13 +374,11 @@ sub setup_git_svn {
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
@@ -389,7 +394,6 @@ sub assert_svn_wc_clean {
 		print STDERR $_ foreach @status;
 		croak;
 	}
-	assert_tree($treeish);
 }
 
 sub assert_tree {
@@ -416,7 +420,7 @@ sub assert_tree {
 		unlink $tmpindex or croak $!;
 	}
 	$ENV{GIT_INDEX_FILE} = $tmpindex;
-	git_addremove();
+	index_changes(1);
 	chomp(my $tree = `git-write-tree`);
 	if ($old_index) {
 		$ENV{GIT_INDEX_FILE} = $old_index;
@@ -426,6 +430,7 @@ sub assert_tree {
 	if ($tree ne $expected) {
 		croak "Tree mismatch, Got: $tree, Expected: $expected\n";
 	}
+	unlink $tmpindex;
 }
 
 sub parse_diff_tree {
@@ -562,7 +567,8 @@ sub precommit_check {
 sub svn_checkout_tree {
 	my ($svn_rev, $treeish) = @_;
 	my $from = file_to_s("$REV_DIR/$svn_rev");
-	assert_svn_wc_clean($svn_rev,$from);
+	assert_svn_wc_clean($svn_rev);
+	assert_tree($from);
 	print "diff-tree $from $treeish\n";
 	my $pid = open my $diff_fh, '-|';
 	defined $pid or croak $!;
@@ -852,13 +858,75 @@ sub svn_info {
 
 sub sys { system(@_) == 0 or croak $? }
 
-sub git_addremove {
-	system( "git-diff-files --name-only -z ".
-				" | git-update-index --remove -z --stdin && ".
-		"git-ls-files -z --others ".
-			"'--exclude-from=$GIT_DIR/$GIT_SVN/info/exclude'".
-				" | git-update-index --add -z --stdin"
-		) == 0 or croak $?
+sub eol_cp {
+	my ($from, $to) = @_;
+	my $es = safe_qx(qw/svn propget svn:eol-style/, $to);
+	open my $rfd, '<', $from or croak $!;
+	binmode $rfd or croak $!;
+	open my $wfd, '>', $to or croak $!;
+	binmode $wfd or croak $!;
+
+	my $eol = $EOL{$es} or undef;
+	if ($eol) {
+		print  "$eol: $from => $to\n";
+	}
+	my $buf;
+	while (1) {
+		my ($r, $w, $t);
+		defined($r = sysread($rfd, $buf, 4096)) or croak $!;
+		return unless $r;
+		$buf =~ s/(?:\015|\012|\015\012)/$eol/gs if $eol;
+		for ($w = 0; $w < $r; $w += $t) {
+			$t = syswrite($wfd, $buf, $r - $w, $w) or croak $!;
+		}
+	}
+}
+
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
+		if (!$no_text_base && lstat $x && ! -l _ &&
+				safe_qx(qw/svn propget svn:keywords/,$x)) {
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
+			eol_cp($tb, $x);
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
@@ -936,7 +1004,7 @@ sub git_commit {
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
index f400202..a07fbad 100644
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
index 0000000..6fa7889
--- /dev/null
+++ b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
@@ -0,0 +1,125 @@
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
+a_crlf=
+a_lf=
+a_cr=
+a_ne_crlf=
+a_ne_lf=
+a_ne_cr=
+a_empty=
+a_empty_lf=
+a_empty_cr=
+a_empty_crlf=
+
+cd import
+	cat >> kw.c <<''
+/* Make it look like somebody copied a file from CVS into SVN: */
+/* $Id: kw.c,v 1.1.1.1 1994/03/06 00:00:00 eric Exp $ */
+
+	printf "Hello\r\nWorld\r\n" > crlf
+	a_crlf=`git-hash-object -w crlf`
+	printf "Hello\rWorld\r" > cr
+	a_cr=`git-hash-object -w cr`
+	printf "Hello\nWorld\n" > lf
+	a_lf=`git-hash-object -w lf`
+
+	printf "Hello\r\nWorld" > ne_crlf
+	a_ne_crlf=`git-hash-object -w ne_crlf`
+	printf "Hello\nWorld" > ne_lf
+	a_ne_lf=`git-hash-object -w ne_lf`
+	printf "Hello\rWorld" > ne_cr
+	a_ne_cr=`git-hash-object -w ne_cr`
+
+	touch empty
+	a_empty=`git-hash-object -w empty`
+	printf "\n" > empty_lf
+	a_empty_lf=`git-hash-object -w empty_lf`
+	printf "\r" > empty_cr
+	a_empty_cr=`git-hash-object -w empty_cr`
+	printf "\r\n" > empty_crlf
+	a_empty_crlf=`git-hash-object -w empty_crlf`
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
+cd test_wc
+	svn propset svn:eol-style CR empty
+	svn propset svn:eol-style CR crlf
+	svn propset svn:eol-style CR ne_crlf
+	svn commit -m 'propset CR on crlf files'
+	svn up
+cd ..
+
+git-svn fetch
+git pull . remotes/git-svn
+
+svn co "$svnrepo" new_wc
+for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
+do
+	test_expect_success "Comparing $i" "cmp $i new_wc/$i"
+done
+
+
+cd test_wc
+	printf '$Id$\rHello\rWorld\r' > cr
+	printf '$Id$\rHello\rWorld' > ne_cr
+	a_cr=`printf '$Id$\r\nHello\r\nWorld\r\n' | git-hash-object --stdin`
+	a_ne_cr=`printf '$Id$\r\nHello\r\nWorld' | git-hash-object --stdin`
+	svn propset svn:eol-style CRLF cr
+	svn propset svn:eol-style CRLF ne_cr
+	svn propset svn:keywords Id cr
+	svn propset svn:keywords Id ne_cr
+	svn commit -m 'propset CRLF on cr files'
+	svn up
+cd ..
+
+git-svn fetch
+git pull . remotes/git-svn
+
+b_cr="`git-hash-object cr`"
+b_ne_cr="`git-hash-object ne_cr`"
+
+test_expect_success 'CRLF + $Id$' "test '$a_cr' = '$b_cr'"
+test_expect_success 'CRLF + $Id$ (no newline)' "test '$a_ne_cr' = '$b_ne_cr'"
+
+test_done
-- 
1.3.2.g7d11

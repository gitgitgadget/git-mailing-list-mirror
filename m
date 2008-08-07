From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2 2/2] git-svn: Allow deep branch names by supporting multi-globs
Date: Thu,  7 Aug 2008 11:34:02 -0400
Message-ID: <1218123242-26260-3-git-send-email-marcus@griep.us>
References: <20080807090008.GA9161@untitled>
 <1218123242-26260-1-git-send-email-marcus@griep.us>
 <1218123242-26260-2-git-send-email-marcus@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 17:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR7h7-0007v2-OP
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 17:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYHGPp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 11:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbYHGPp3
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 11:45:29 -0400
Received: from boohaunt.net ([209.40.206.144]:46973 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbYHGPpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 11:45:24 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 1699F1878CD9; Thu,  7 Aug 2008 11:34:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.4.g39f8
In-Reply-To: <1218123242-26260-2-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91588>

Some repositories use a deep branching strategy, such as:
branches/1.0/1.0.rc1
branches/1.0/1.0.rc2
branches/1.0/1.0.rtm
branches/1.0/1.0.gold

Only allowing a single glob stiffles this.

This change allows for a single glob 'set' to accept this deep branching
strategy.

The ref glob depth must match the branch glob depth.  When using the -b or -t
options for init or clone, this is automatically done.

For example, using the above branches:
  svn-remote.svn.branches = branches/*/*:refs/remote/*/*
gives the following branch names:
  1.0/1.0.rc1
  1.0/1.0.rc2
  1.0/1.0.rtm
  1.0/1.0.gold

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 git-svn.perl                               |   64 +++++++++---
 t/t9108-git-svn-glob.sh                    |    9 +-
 t/t9108-git-svn-multi-glob.sh              |  155 ++++++++++++++++++++++++++++
 t/t9125-git-svn-multi-glob-branch-names.sh |   41 ++++++++
 4 files changed, 248 insertions(+), 21 deletions(-)
 create mode 100755 t/t9108-git-svn-multi-glob.sh
 create mode 100755 t/t9125-git-svn-multi-glob-branch-names.sh

diff --git a/git-svn.perl b/git-svn.perl
index 5974a06..fe78461 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -169,7 +169,8 @@ my %cmd = (
 			  'color' => \$Git::SVN::Log::color,
 			  'pager=s' => \$Git::SVN::Log::pager
 			} ],
-	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
+	'find-rev' => [ \&cmd_find_rev, 
+				   "Translate between SVN revision numbers and tree-ish",
 			{} ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
@@ -229,7 +230,9 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
 read_repo_config(\%opts);
-Getopt::Long::Configure('pass_through') if ($cmd && ($cmd eq 'log' || $cmd eq 'blame'));
+if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
+	Getopt::Long::Configure('pass_through');
+}
 my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
                     'id|i=s' => \$Git::SVN::default_ref_id,
@@ -985,7 +988,7 @@ sub complete_url_ls_init {
 		die "--prefix='$pfx' must have a trailing slash '/'\n";
 	}
 	command_noisy('config', "svn-remote.$gs->{repo_id}.$n",
-				"$remote_path:refs/remotes/$pfx*");
+				"$remote_path:refs/remotes/$pfx*" . ('/*' x (($remote_path =~ tr/*/*/)-1)));
 }
 
 sub verify_ref {
@@ -4121,16 +4124,38 @@ sub gs_fetch_loop_common {
 	Git::SVN::gc();
 }
 
+sub get_dir_globbed {
+	my ($self, $left, $depth, $r) = @_;
+
+	my @x = eval { $self->get_dir($left, $r) };
+	return unless scalar @x == 3;
+	my $dirents = $x[0];
+	my @finalents;
+	foreach my $de (keys %$dirents) {
+		next if $dirents->{$de}->{kind} != $SVN::Node::dir;
+		if ($depth > 1) {
+			foreach my $dir ($self->get_dir_globbed($left.'/'.$de, $depth - 1, $r)) {
+				push @finalents, "$de/$dir";
+			}
+		} else {
+			push @finalents, $de;
+		}
+	}
+	@finalents;
+}
+
 sub match_globs {
 	my ($self, $exists, $paths, $globs, $r) = @_;
 
 	sub get_dir_check {
 		my ($self, $exists, $g, $r) = @_;
-		my @x = eval { $self->get_dir($g->{path}->{left}, $r) };
-		return unless scalar @x == 3;
-		my $dirents = $x[0];
-		foreach my $de (keys %$dirents) {
-			next if $dirents->{$de}->{kind} != $SVN::Node::dir;
+
+		my @dirs = $self->get_dir_globbed(
+							$g->{path}->{left}, 
+							$g->{path}->{depth}, 
+							$r);
+
+		foreach my $de (@dirs) {
 			my $p = $g->{path}->full_path($de);
 			next if $exists->{$p};
 			next if (length $g->{path}->{right} &&
@@ -4912,16 +4937,21 @@ sub new {
 	my ($class, $glob) = @_;
 	my $re = $glob;
 	$re =~ s!/+$!!g; # no need for trailing slashes
-	my $nr = $re =~ tr/*/*/;
-	if ($nr > 1) {
-		die "Only one '*' wildcard expansion ",
-		    "is supported (got $nr): '$glob'\n";
-	} elsif ($nr == 0) {
+	$re =~ m!^([^*]*)(\*(?:/\*)*)([^*]*)$!;
+	my $temp = $re;
+	my ($left, $right) = ($1, $3);
+	$re = $2;
+	my $depth = $re =~ tr/*/*/;
+	if ($depth != $temp =~ tr/*/*/) {
+		die "Only one set of wildcard directories " .
+			"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
+	}
+	if ($depth == 0) {
 		die "One '*' is needed for glob: '$glob'\n";
 	}
-	$re =~ s!^(.*)\*(.*)$!\(\[^/\]+\)!g;
-	my ($left, $right) = ($1, $2);
-	$re = quotemeta($left) . $re . quotemeta($right);
+	$re =~ s!\*!\[^/\]*!g;
+#	$re =~ s!\?!\[^/\]!g;
+	$re = quotemeta($left) . "($re)" . quotemeta($right);
 	if (length $left && !($left =~ s!/+$!!g)) {
 		die "Missing trailing '/' on left side of: '$glob' ($left)\n";
 	}
@@ -4930,7 +4960,7 @@ sub new {
 	}
 	my $left_re = qr/^\/\Q$left\E(\/|$)/;
 	bless { left => $left, right => $right, left_regex => $left_re,
-	        regex => qr/$re/, glob => $glob }, $class;
+	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
 }
 
 sub full_path {
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index ef6d88e..46958e5 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -52,7 +52,8 @@ test_expect_success 'test refspec globbing' '
 	test "`git rev-parse refs/remotes/tags/end~1`" = \
 		"`git rev-parse refs/remotes/branches/start`" &&
 	test "`git rev-parse refs/remotes/branches/start~2`" = \
-		"`git rev-parse refs/remotes/trunk`"
+		"`git rev-parse refs/remotes/trunk`" &&
+	test_must_fail git rev-parse refs/remotes/tags/end@3
 	'
 
 echo try to try > expect.two
@@ -83,14 +84,14 @@ test_expect_success 'test left-hand-side only globbing' '
 	cmp expect.two output.two
 	'
 
-echo "Only one '*' wildcard expansion is supported (got 2): 'branches/*/*'" > expect.three
+echo "Only one set of wildcard directories (e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
 echo "" >> expect.three
 
-test_expect_success 'test disallow multi-globs' '
+test_expect_success 'test disallow multiple globs' '
 	git config --add svn-remote.three.url "$svnrepo" &&
 	git config --add svn-remote.three.fetch trunk:refs/remotes/three/trunk &&
 	git config --add svn-remote.three.branches \
-	                 "branches/*/*:refs/remotes/three/branches/*" &&
+	                 "branches/*/t/*:refs/remotes/three/branches/*" &&
 	git config --add svn-remote.three.tags \
 	                 "tags/*/*:refs/remotes/three/tags/*" &&
 	cd tmp &&
diff --git a/t/t9108-git-svn-multi-glob.sh b/t/t9108-git-svn-multi-glob.sh
new file mode 100755
index 0000000..1d80cb1
--- /dev/null
+++ b/t/t9108-git-svn-multi-glob.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+# Copyright (c) 2007 Eric Wong
+test_description='git-svn globbing refspecs'
+. ./lib-git-svn.sh
+
+cat > expect.end <<EOF
+the end
+hi
+start a new branch
+initial
+EOF
+
+test_expect_success 'test refspec globbing' '
+	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
+	echo "hello world" > trunk/src/a/readme &&
+	echo "goodbye world" > trunk/src/b/readme &&
+	svn import -m "initial" trunk "$svnrepo"/trunk &&
+	svn co "$svnrepo" tmp &&
+	cd tmp &&
+		mkdir branches branches/v1 tags &&
+		svn add branches tags &&
+		svn cp trunk branches/v1/start &&
+		svn commit -m "start a new branch" &&
+		svn up &&
+		echo "hi" >> branches/v1/start/src/b/readme &&
+		poke branches/v1/start/src/b/readme &&
+		echo "hey" >> branches/v1/start/src/a/readme &&
+		poke branches/v1/start/src/a/readme &&
+		svn commit -m "hi" &&
+		svn up &&
+		svn cp branches/v1/start tags/end &&
+		echo "bye" >> tags/end/src/b/readme &&
+		poke tags/end/src/b/readme &&
+		echo "aye" >> tags/end/src/a/readme &&
+		poke tags/end/src/a/readme &&
+		svn commit -m "the end" &&
+		echo "byebye" >> tags/end/src/b/readme &&
+		poke tags/end/src/b/readme &&
+		svn commit -m "nothing to see here"
+		cd .. &&
+	git config --add svn-remote.svn.url "$svnrepo" &&
+	git config --add svn-remote.svn.fetch \
+	                 "trunk/src/a:refs/remotes/trunk" &&
+	git config --add svn-remote.svn.branches \
+	                 "branches/*/*/src/a:refs/remotes/branches/*/*" &&
+	git config --add svn-remote.svn.tags\
+	                 "tags/*/src/a:refs/remotes/tags/*" &&
+	git-svn multi-fetch &&
+	git log --pretty=oneline refs/remotes/tags/end | \
+	    sed -e "s/^.\{41\}//" > output.end &&
+	cmp expect.end output.end &&
+	test "`git rev-parse refs/remotes/tags/end~1`" = \
+		"`git rev-parse refs/remotes/branches/v1/start`" &&
+	test "`git rev-parse refs/remotes/branches/v1/start~2`" = \
+		"`git rev-parse refs/remotes/trunk`" &&
+	test_must_fail git rev-parse refs/remotes/tags/end@3
+	'
+
+echo try to try > expect.two
+echo nothing to see here >> expect.two
+cat expect.end >> expect.two
+
+test_expect_success 'test left-hand-side only globbing' '
+	git config --add svn-remote.two.url "$svnrepo" &&
+	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
+	git config --add svn-remote.two.branches \
+	                 "branches/*/*:refs/remotes/two/branches/*/*" &&
+	git config --add svn-remote.two.tags \
+	                 "tags/*:refs/remotes/two/tags/*" &&
+	cd tmp &&
+		echo "try try" >> tags/end/src/b/readme &&
+		poke tags/end/src/b/readme &&
+		svn commit -m "try to try"
+		cd .. &&
+	git-svn fetch two &&
+	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
+	test `git rev-list refs/remotes/two/branches/v1/start | wc -l` -eq 3 &&
+	test `git rev-parse refs/remotes/two/branches/v1/start~2` = \
+	     `git rev-parse refs/remotes/two/trunk` &&
+	test `git rev-parse refs/remotes/two/tags/end~3` = \
+	     `git rev-parse refs/remotes/two/branches/v1/start` &&
+	git log --pretty=oneline refs/remotes/two/tags/end | \
+	    sed -e "s/^.\{41\}//" > output.two &&
+	cmp expect.two output.two
+	'
+cat > expect.four <<EOF
+adios
+adding more
+Changed 2 in v2/start
+Another versioned branch
+initial
+EOF
+
+test_expect_success 'test another branch' '
+	(
+		cd tmp &&
+		mkdir branches/v2 &&
+		svn add branches/v2 &&
+		svn cp trunk branches/v2/start &&
+		svn commit -m "Another versioned branch" &&
+		svn up &&
+		echo "hello" >> branches/v2/start/src/b/readme &&
+		poke branches/v2/start/src/b/readme &&
+		echo "howdy" >> branches/v2/start/src/a/readme &&
+		poke branches/v2/start/src/a/readme &&
+		svn commit -m "Changed 2 in v2/start" &&
+		svn up &&
+		svn cp branches/v2/start tags/next &&
+		echo "bye" >> tags/next/src/b/readme &&
+		poke tags/next/src/b/readme &&
+		echo "aye" >> tags/next/src/a/readme &&
+		poke tags/next/src/a/readme &&
+		svn commit -m "adding more" &&
+		echo "byebye" >> tags/next/src/b/readme &&
+		poke tags/next/src/b/readme &&
+		svn commit -m "adios"
+	) &&
+	git config --add svn-remote.four.url "$svnrepo" &&
+	git config --add svn-remote.four.fetch trunk:refs/remotes/four/trunk &&
+	git config --add svn-remote.four.branches \
+	                 "branches/*/*:refs/remotes/four/branches/*/*" &&
+	git config --add svn-remote.four.tags \
+	                 "tags/*:refs/remotes/four/tags/*" &&
+	git-svn fetch four &&
+	test `git rev-list refs/remotes/four/tags/next | wc -l` -eq 5 &&
+	test `git rev-list refs/remotes/four/branches/v2/start | wc -l` -eq 3 &&
+	test `git rev-parse refs/remotes/four/branches/v2/start~2` = \
+	     `git rev-parse refs/remotes/four/trunk` &&
+	test `git rev-parse refs/remotes/four/tags/next~2` = \
+	     `git rev-parse refs/remotes/four/branches/v2/start` &&
+	git log --pretty=oneline refs/remotes/four/tags/next | \
+	    sed -e "s/^.\{41\}//" > output.four &&
+	cmp expect.four output.four
+	'
+
+echo "Only one set of wildcard directories (e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
+echo "" >> expect.three
+
+test_expect_success 'test disallow multiple globs' '
+	git config --add svn-remote.three.url "$svnrepo" &&
+	git config --add svn-remote.three.fetch trunk:refs/remotes/three/trunk &&
+	git config --add svn-remote.three.branches \
+	                 "branches/*/t/*:refs/remotes/three/branches/*/*" &&
+	git config --add svn-remote.three.tags \
+	                 "tags/*:refs/remotes/three/tags/*" &&
+	cd tmp &&
+		echo "try try" >> tags/end/src/b/readme &&
+		poke tags/end/src/b/readme &&
+		svn commit -m "try to try"
+		cd .. &&
+	test_must_fail git-svn fetch three &> stderr.three &&
+	cmp expect.three stderr.three
+	'
+
+test_done
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-svn-multi-glob-branch-names.sh
new file mode 100755
index 0000000..5560db0
--- /dev/null
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description='git-svn multi-glob branch names'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svnrepo' '
+	mkdir project project/trunk project/branches \
+			project/branches/v14.1 project/tags &&
+	echo foo > project/trunk/foo &&
+	svn import -m "$test_description" project "$svnrepo/project" &&
+	rm -rf project &&
+	svn cp -m "fun" "$svnrepo/project/trunk" \
+	                "$svnrepo/project/branches/v14.1/beta" &&
+	svn cp -m "more fun!" "$svnrepo/project/branches/v14.1/beta" \
+	                      "$svnrepo/project/branches/v14.1/gold" &&
+	start_httpd
+	'
+
+test_expect_success 'test clone with multi-glob in branch names' '
+	git svn clone -T trunk -b branches/*/* -t tags "$svnrepo/project" project &&
+	cd project &&
+		git rev-parse "refs/remotes/v14.1/beta" &&
+		git rev-parse "refs/remotes/v14.1/gold" &&
+	cd ..
+	'
+
+test_expect_success 'test dcommit to multi-globbed branch' "
+	cd project &&
+	git reset --hard 'refs/remotes/v14.1/gold' &&
+	echo hello >> foo &&
+	git commit -m 'hello' -- foo &&
+	git svn dcommit &&
+	cd ..
+	"
+
+stop_httpd
+
+test_done
-- 
1.6.0.rc2.4.g39f8

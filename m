From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] git-svn: Allow deep branch names by supporting multi-globs
Date: Fri, 8 Aug 2008 01:57:24 -0700
Message-ID: <20080808085724.GB9479@untitled>
References: <20080807090008.GA9161@untitled> <1218123242-26260-1-git-send-email-marcus@griep.us> <20080808084025.GA8718@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marcus Griep <marcus@griep.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRNno-0006Tv-EE
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYHHI50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 04:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYHHI5Z
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:57:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56550 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbYHHI5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:57:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 85B542DC01B;
	Fri,  8 Aug 2008 01:57:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080808084025.GA8718@untitled>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91641>

From: Marcus Griep <marcus@griep.us>
Date: Thu, 7 Aug 2008 11:34:02 -0400
Subject: [PATCH 2/3] git-svn: Allow deep branch names by supporting multi-globs

Some repositories use a deep branching strategy, such as:
branches/1.0/1.0.rc1
branches/1.0/1.0.rc2
branches/1.0/1.0.rtm
branches/1.0/1.0.gold

Only allowing a single glob stiffles this.

This change allows for a single glob 'set' to accept this deep
branching strategy.

The ref glob depth must match the branch glob depth.  When using
the -b or -t options for init or clone, this is automatically
done.

For example, using the above branches:
  svn-remote.svn.branches = branches/*/*:refs/remote/*/*
gives the following branch names:
  1.0/1.0.rc1
  1.0/1.0.rc2
  1.0/1.0.rtm
  1.0/1.0.gold

[ew:
  * removed unrelated line-wrapping changes
  * fixed line-wrapping in a few more places
  * removed trailing whitespace
  * fixed bashism in test
  * removed unnecessary httpd startup in test
  * changed copyright on tests to 2008 Marcus Griep
  * added executable permissions to new tests
]

Signed-off-by: Marcus Griep <marcus@griep.us>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Oops, resent as I forgot to change the From: header

 git-svn.perl                               |   61 ++++++++---
 t/t9108-git-svn-glob.sh                    |    9 +-
 t/t9108-git-svn-multi-glob.sh              |  157 ++++++++++++++++++++++++++++
 t/t9125-git-svn-multi-glob-branch-names.sh |   37 +++++++
 4 files changed, 244 insertions(+), 20 deletions(-)
 create mode 100755 t/t9108-git-svn-multi-glob.sh
 create mode 100755 t/t9125-git-svn-multi-glob-branch-names.sh

diff --git a/git-svn.perl b/git-svn.perl
index 503a7c9..47ad378 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -987,8 +987,10 @@ sub complete_url_ls_init {
 	if (length $pfx && $pfx !~ m#/$#) {
 		die "--prefix='$pfx' must have a trailing slash '/'\n";
 	}
-	command_noisy('config', "svn-remote.$gs->{repo_id}.$n",
-				"$remote_path:refs/remotes/$pfx*");
+	command_noisy('config',
+	              "svn-remote.$gs->{repo_id}.$n",
+	              "$remote_path:refs/remotes/$pfx*" .
+	                ('/*' x (($remote_path =~ tr/*/*/) - 1)) );
 }
 
 sub verify_ref {
@@ -4124,16 +4126,38 @@ sub gs_fetch_loop_common {
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
+			my @args = ("$left/$de", $depth - 1, $r);
+			foreach my $dir ($self->get_dir_globbed(@args)) {
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
+		my @dirs = $self->get_dir_globbed($g->{path}->{left},
+		                                  $g->{path}->{depth},
+		                                  $r);
+
+		foreach my $de (@dirs) {
 			my $p = $g->{path}->full_path($de);
 			next if $exists->{$p};
 			next if (length $g->{path}->{right} &&
@@ -4915,16 +4939,21 @@ sub new {
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
@@ -4933,7 +4962,7 @@ sub new {
 	}
 	my $left_re = qr/^\/\Q$left\E(\/|$)/;
 	bless { left => $left, right => $right, left_regex => $left_re,
-	        regex => qr/$re/, glob => $glob }, $class;
+	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
 }
 
 sub full_path {
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index a6f88bd..bb9df56 100755
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
@@ -83,8 +84,8 @@ test_expect_success 'test left-hand-side only globbing' '
 	cmp expect.two output.two
 	'
 
-echo "Only one '*' wildcard expansion is supported (got 2): 'branches/*/*'" \
-     > expect.three
+echo "Only one set of wildcard directories" \
+     "(e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
 echo "" >> expect.three
 
 test_expect_success 'test disallow multi-globs' '
@@ -92,7 +93,7 @@ test_expect_success 'test disallow multi-globs' '
 	git config --add svn-remote.three.fetch \
 	                 trunk:refs/remotes/three/trunk &&
 	git config --add svn-remote.three.branches \
-	                 "branches/*/*:refs/remotes/three/branches/*" &&
+	                 "branches/*/t/*:refs/remotes/three/branches/*" &&
 	git config --add svn-remote.three.tags \
 	                 "tags/*/*:refs/remotes/three/tags/*" &&
 	cd tmp &&
diff --git a/t/t9108-git-svn-multi-glob.sh b/t/t9108-git-svn-multi-glob.sh
new file mode 100755
index 0000000..9fb51d6
--- /dev/null
+++ b/t/t9108-git-svn-multi-glob.sh
@@ -0,0 +1,157 @@
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
+echo "Only one set of wildcard directories" \
+     "(e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
+echo "" >> expect.three
+
+test_expect_success 'test disallow multiple globs' '
+	git config --add svn-remote.three.url "$svnrepo" &&
+	git config --add svn-remote.three.fetch \
+	                 trunk:refs/remotes/three/trunk &&
+	git config --add svn-remote.three.branches \
+	                 "branches/*/t/*:refs/remotes/three/branches/*/*" &&
+	git config --add svn-remote.three.tags \
+	                 "tags/*:refs/remotes/three/tags/*" &&
+	cd tmp &&
+		echo "try try" >> tags/end/src/b/readme &&
+		poke tags/end/src/b/readme &&
+		svn commit -m "try to try"
+		cd .. &&
+	test_must_fail git-svn fetch three 2> stderr.three &&
+	cmp expect.three stderr.three
+	'
+
+test_done
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-svn-multi-glob-branch-names.sh
new file mode 100755
index 0000000..6b62b52
--- /dev/null
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# Copyright (c) 2008 Marcus Griep
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
+	                      "$svnrepo/project/branches/v14.1/gold"
+	'
+
+test_expect_success 'test clone with multi-glob in branch names' '
+	git svn clone -T trunk -b branches/*/* -t tags \
+	              "$svnrepo/project" project &&
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
+test_done
-- 
1.6.0.rc2.4.g0643f

From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH v2] git-svn: add support for prefixed globs in config
Date: Thu, 17 Dec 2015 17:34:42 +0300
Message-ID: <1450362882-716-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 15:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Zds-0004Bv-TV
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 15:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965833AbbLQOes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 09:34:48 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33135 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934373AbbLQOer (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 09:34:47 -0500
Received: by mail-lb0-f173.google.com with SMTP id kw15so46555160lbb.0
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4UtzgNzT98yAIxi5/7rK+NzJqt8V2A8rxYy5UJQTG64=;
        b=OJnNPYU/R9UH1zFxnKDpTUv4dXw0CVr60+/QSXpxRcrMnnxsWfw7j1ZNL1cJ++kgSJ
         +cT2IblvgljXXL0M5MTnkMSLAR3hcHBWb6+20ZNYZNcwDpJ8A3002H+f0EICGjranmer
         1Cl8DPTF6+sGCcClHnNg7frlRJ/XFh3Kb+oTTpqNVobGva7tweUfBjuPkMlsNmenM/uf
         5kZF3i2ie4cQfhNkfvncXSjNKy7A+mwJHDDDDeJntN8HcPzuw0jnEYd+BVvjHFaF7e9t
         nat1qkpbw7thbx3edrnNSQw7/tbqL3X/Ci/nGNAlDXYRdK7g/EjmYJSNsaGZUrGvaMhi
         sDgg==
X-Received: by 10.112.36.130 with SMTP id q2mr21141000lbj.116.1450362885888;
        Thu, 17 Dec 2015 06:34:45 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id a190sm1979290lfa.32.2015.12.17.06.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2015 06:34:45 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a9Zdk-0000CE-7w; Thu, 17 Dec 2015 17:34:44 +0300
X-Mailer: git-send-email 2.7.0.rc0.21.gb793f61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282655>

Introduce prefixed globs for branches and tags in git-svn.
Globs like 'release_*' allow users to avoid long lines in config like:

branches = branches/{release_20,release_21,release_22,...}

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
Changes from v1:
	* Joined implementation and test in one patch
	* Fixed test code style according to current coding style guide

 Documentation/git-svn.txt        |   5 ++
 perl/Git/SVN/GlobSpec.pm         |   9 ++-
 t/t9168-git-svn-prefixed-glob.sh | 136 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 5 deletions(-)
 create mode 100755 t/t9168-git-svn-prefixed-glob.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 0c0f60b..529cffe 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1034,6 +1034,7 @@ listed below are allowed:
 	url = http://server.org/svn
 	fetch = trunk/project-a:refs/remotes/project-a/trunk
 	branches = branches/*/project-a:refs/remotes/project-a/branches/*
+	branches = branches/release_*:refs/remotes/project-a/branches/release_*
 	tags = tags/*/project-a:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
 
@@ -1044,6 +1045,10 @@ independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using 'git config'.
 
+Also note that prefixed globs (e.g. 'release_*') match everything after prefix
+but do not match exact prefix. For example:
+'release_*' will match 'release_1' or 'release_v1' but will not match 'release_'.
+
 It is also possible to fetch a subset of branches or tags by using a
 comma-separated list of names within braces. For example:
 
diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index c95f5d7..a136090 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -11,16 +11,15 @@ sub new {
 	my $die_msg = "Only one set of wildcard directories " .
 				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
 	for my $part (split(m|/|, $glob)) {
-		if ($part =~ /\*/ && $part ne "*") {
-			die "Invalid pattern in '$glob': $part\n";
-		} elsif ($pattern_ok && $part =~ /[{}]/ &&
+		if ($pattern_ok && $part =~ /[{}]/ &&
 			 $part !~ /^\{[^{}]+\}/) {
 			die "Invalid pattern in '$glob': $part\n";
 		}
-		if ($part eq "*") {
+		if ($part =~ /(\w*)\*/) {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
-			push(@patterns, "[^/]*");
+			my $pat = $1 ? "${1}[^/]+" : "[^/]*";
+			push(@patterns, $pat);
 		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
diff --git a/t/t9168-git-svn-prefixed-glob.sh b/t/t9168-git-svn-prefixed-glob.sh
new file mode 100755
index 0000000..b8a059b
--- /dev/null
+++ b/t/t9168-git-svn-prefixed-glob.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+test_description='git svn globbing refspecs with prefixed globs'
+. ./lib-git-svn.sh
+
+cat >expect.end <<EOF
+the end
+hi
+start a new branch
+initial
+EOF
+
+test_expect_success 'test refspec prefixed globbing' '
+	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
+	echo "hello world" >trunk/src/a/readme &&
+	echo "goodbye world" >trunk/src/b/readme &&
+	svn_cmd import -m "initial" trunk "$svnrepo"/trunk &&
+	svn_cmd co "$svnrepo" tmp &&
+	(
+		cd tmp &&
+		mkdir branches tags &&
+		svn_cmd add branches tags &&
+		svn_cmd cp trunk branches/b_start &&
+		svn_cmd commit -m "start a new branch" &&
+		svn_cmd up &&
+		echo "hi" >>branches/b_start/src/b/readme &&
+		poke branches/b_start/src/b/readme &&
+		echo "hey" >>branches/b_start/src/a/readme &&
+		poke branches/b_start/src/a/readme &&
+		svn_cmd commit -m "hi" &&
+		svn_cmd up &&
+		svn_cmd cp branches/b_start tags/t_end &&
+		echo "bye" >>tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		echo "aye" >>tags/t_end/src/a/readme &&
+		poke tags/t_end/src/a/readme &&
+		svn_cmd commit -m "the end" &&
+		echo "byebye" >>tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		svn_cmd commit -m "nothing to see here"
+	) &&
+	git config --add svn-remote.svn.url "$svnrepo" &&
+	git config --add svn-remote.svn.fetch \
+	                 "trunk/src/a:refs/remotes/trunk" &&
+	git config --add svn-remote.svn.branches \
+	                 "branches/b_*/src/a:refs/remotes/branches/b_*" &&
+	git config --add svn-remote.svn.tags\
+	                 "tags/t_*/src/a:refs/remotes/tags/t_*" &&
+	git svn multi-fetch &&
+	git log --pretty=oneline refs/remotes/tags/t_end | \
+	    sed -e "s/^.\{41\}//" >output.end &&
+	test_cmp expect.end output.end &&
+	test "`git rev-parse refs/remotes/tags/t_end~1`" = \
+		"`git rev-parse refs/remotes/branches/b_start`" &&
+	test "`git rev-parse refs/remotes/branches/b_start~2`" = \
+		"`git rev-parse refs/remotes/trunk`" &&
+	test_must_fail git rev-parse refs/remotes/tags/t_end@3
+	'
+
+echo try to try >expect.two &&
+echo nothing to see here >>expect.two &&
+cat expect.end >>expect.two
+
+test_expect_success 'test left-hand-side only prefixed globbing' '
+	git config --add svn-remote.two.url "$svnrepo" &&
+	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
+	git config --add svn-remote.two.branches \
+	                 "branches/b_*:refs/remotes/two/branches/*" &&
+	git config --add svn-remote.two.tags \
+	                 "tags/t_*:refs/remotes/two/tags/*" &&
+	(
+		cd tmp &&
+		echo "try try" >>tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		svn_cmd commit -m "try to try"
+	) &&
+	git svn fetch two &&
+	test `git rev-list refs/remotes/two/tags/t_end | wc -l` -eq 6 &&
+	test `git rev-list refs/remotes/two/branches/b_start | wc -l` -eq 3 &&
+	test `git rev-parse refs/remotes/two/branches/b_start~2` = \
+	     `git rev-parse refs/remotes/two/trunk` &&
+	test `git rev-parse refs/remotes/two/tags/t_end~3` = \
+	     `git rev-parse refs/remotes/two/branches/b_start` &&
+	git log --pretty=oneline refs/remotes/two/tags/t_end | \
+	    sed -e "s/^.\{41\}//" >output.two &&
+	test_cmp expect.two output.two
+	'
+
+test_expect_success 'test prefixed globs do not match just prefix' '
+	git config --add svn-remote.three.url "$svnrepo" &&
+	git config --add svn-remote.three.fetch \
+	                 trunk:refs/remotes/three/trunk &&
+	git config --add svn-remote.three.branches \
+	                 "branches/b_*:refs/remotes/three/branches/*" &&
+	git config --add svn-remote.three.tags \
+	                 "tags/t_*:refs/remotes/three/tags/*" &&
+	(
+		cd tmp &&
+		svn_cmd cp trunk branches/b_ &&
+		echo "You should never see me" >>branches/b_/src/a/readme &&
+		poke branches/b_/src/a/readme &&
+		svn_cmd commit -m "Never seen branch commit" &&
+		svn_cmd up &&
+		svn_cmd cp branches/b_ tags/t_ &&
+		echo "You should never see mee too" >>tags/t_/src/a/readme &&
+		poke tags/t_/src/a/readme &&
+		svn_cmd commit -m "Never seen tag commit" &&
+		svn_cmd up
+	) &&
+	git svn fetch three &&
+	test_path_is_missing refs/remotes/three/branches/b_ &&
+	test_path_is_missing refs/remotes/three/tags/t_
+	'
+
+echo "Only one set of wildcard directories" \
+     "(e.g. '*' or '*/*/*') is supported: 'branches/b_*/t/*'" >expect.four &&
+echo "" >>expect.four
+
+test_expect_success 'test disallow prefixed multi-globs' '
+	git config --add svn-remote.four.url "$svnrepo" &&
+	git config --add svn-remote.four.fetch \
+	                 trunk:refs/remotes/four/trunk &&
+	git config --add svn-remote.four.branches \
+	                 "branches/b_*/t/*:refs/remotes/four/branches/*" &&
+	git config --add svn-remote.four.tags \
+	                 "tags/t_*/*:refs/remotes/four/tags/*" &&
+	(
+		cd tmp &&
+		echo "try try" >>tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		svn_cmd commit -m "try to try"
+	) &&
+	test_must_fail git svn fetch four 2>stderr.four &&
+	test_cmp expect.four stderr.four
+	'
+
+test_done
-- 
2.7.0.rc0.21.gb793f61

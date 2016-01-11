From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH] git-svn: loosen config globs limitations
Date: Mon, 11 Jan 2016 17:25:58 +0300
Message-ID: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, normalperson@yhbt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 15:26:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIdQD-0003Zg-E3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 15:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbcAKO0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 09:26:09 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34640 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073AbcAKO0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 09:26:07 -0500
Received: by mail-lb0-f172.google.com with SMTP id cl12so37565723lbc.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Rooru7eBXwJ6M0ty9EO40RqoMCOfs9E3zLyFBBeDu1c=;
        b=gJCqBydr2dPTERgFkb1vPJGfeMIrF4B57KNVgQnRTZmaZ0hktQVianmublaxPdBBSj
         YfZfOLv3bFfZlJ3gzmdABsJ5B9QXQ4AI09LK8v0mqF6Fx7KuzWjj221+JL7blqGqIdPM
         lYtP5JldrelOWo5x9ewymmUO467DDLIibKL1abB/onCir14wzGN7EkoDuKEnet1UL3K/
         TT6+zuTV1KPY4UaK/VVBm8LmOv1JIjulSmhjzH6gBS91FE603zxDZsnn3QKVkabLWXW+
         sc0bLudlTvLPLB4mMJkPA+9thsKx9rs3DxSqcyjejn6s/RTq3oAXvSe6yb7eW1g13Ige
         ijOA==
X-Received: by 10.112.160.104 with SMTP id xj8mr3689922lbb.77.1452522365808;
        Mon, 11 Jan 2016 06:26:05 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id xo4sm16051066lbb.27.2016.01.11.06.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 06:26:04 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1aIdQ0-0004Pv-Fl; Mon, 11 Jan 2016 17:26:00 +0300
X-Mailer: git-send-email 2.7.0.1.g72018be.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283654>

Expand the area of globs applicability for branches and tags
in git-svn. It is now possible to use globs like 'a*e', or 'release_*'.
This allows users to avoid long lines in config like:

branches = branches/{release_20,release_21,release_22,...}

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
Changes from $gmane/283172:
  * Not only prefixed globs are allowed now (one can put '*' in the middle of a word) - thus changed patch name
  * Added tests for globs in the middle of a word

 Documentation/git-svn.txt                  |  12 ++
 perl/Git/SVN/GlobSpec.pm                   |  12 +-
 t/t9168-git-svn-partially-globbed-names.sh | 222 +++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+), 5 deletions(-)
 create mode 100755 t/t9168-git-svn-partially-globbed-names.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 0c0f60b..fb23a98 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1034,6 +1034,8 @@ listed below are allowed:
 	url = http://server.org/svn
 	fetch = trunk/project-a:refs/remotes/project-a/trunk
 	branches = branches/*/project-a:refs/remotes/project-a/branches/*
+	branches = branches/release_*:refs/remotes/project-a/branches/release_*
+	branches = branches/re*se:refs/remotes/project-a/branches/*
 	tags = tags/*/project-a:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
 
@@ -1044,6 +1046,16 @@ independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using 'git config'.
 
+Also note that only one asterisk is allowed per word. For example:
+
+	branches = branches/re*se:refs/remotes/project-a/branches/*
+
+will match branches 'release', 'rese', 're123se', however
+
+	branches = branches/re*s*e:refs/remotes/project-a/branches/*
+
+will produce an error.
+
 It is also possible to fetch a subset of branches or tags by using a
 comma-separated list of names within braces. For example:
 
diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index c95f5d7..1248e6d 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -11,16 +11,18 @@ sub new {
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
+		my $nstars = $part =~ tr/\*//;
+		die "Only one '*' is allowed in a pattern: '$part'\n" if $nstars > 1;
+		if ($part =~ /(.*)\*(.*)/) {
 			die $die_msg if $state eq "right";
+			my ($l, $r) = ($1, $2);
 			$state = "pattern";
-			push(@patterns, "[^/]*");
+			my $pat = quotemeta($l) . '[^/]*' . quotemeta($r);
+			push(@patterns, $pat);
 		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
diff --git a/t/t9168-git-svn-partially-globbed-names.sh b/t/t9168-git-svn-partially-globbed-names.sh
new file mode 100755
index 0000000..8e4100a
--- /dev/null
+++ b/t/t9168-git-svn-partially-globbed-names.sh
@@ -0,0 +1,222 @@
+#!/bin/sh
+test_description='git svn globbing refspecs with prefixed globs'
+. ./lib-git-svn.sh
+
+test_expect_success 'prepare test refspec prefixed globbing' '
+	cat >expect.end <<EOF
+the end
+hi
+start a new branch
+initial
+EOF
+	'
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
+	test "$(git rev-parse refs/remotes/tags/t_end~1)" = \
+		"$(git rev-parse refs/remotes/branches/b_start)" &&
+	test "$(git rev-parse refs/remotes/branches/b_start~2)" = \
+		"$(git rev-parse refs/remotes/trunk)" &&
+	test_must_fail git rev-parse refs/remotes/tags/t_end@3
+	'
+
+test_expect_success 'prepare test left-hand-side only prefixed globbing' '
+	echo try to try >expect.two &&
+	echo nothing to see here >>expect.two &&
+	cat expect.end >>expect.two
+	'
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
+	test $(git rev-list refs/remotes/two/tags/t_end | wc -l) -eq 6 &&
+	test $(git rev-list refs/remotes/two/branches/b_start | wc -l) -eq 3 &&
+	test $(git rev-parse refs/remotes/two/branches/b_start~2) = \
+	     $(git rev-parse refs/remotes/two/trunk) &&
+	test $(git rev-parse refs/remotes/two/tags/t_end~3) = \
+	     $(git rev-parse refs/remotes/two/branches/b_start) &&
+	git log --pretty=oneline refs/remotes/two/tags/t_end | \
+	    sed -e "s/^.\{41\}//" >output.two &&
+	test_cmp expect.two output.two
+	'
+
+test_expect_success 'prepare test prefixed globs match just prefix' '
+	cat >expect.three <<EOF
+Tag commit to t_
+Branch commit to b_
+initial
+EOF
+	'
+
+test_expect_success 'test prefixed globs match just prefix' '
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
+		echo "Branch commit to b_" >>branches/b_/src/a/readme &&
+		poke branches/b_/src/a/readme &&
+		svn_cmd commit -m "Branch commit to b_" &&
+		svn_cmd up && svn_cmd cp branches/b_ tags/t_ &&
+		echo "Tag commit to t_" >>tags/t_/src/a/readme &&
+		poke tags/t_/src/a/readme &&
+		svn_cmd commit -m "Tag commit to t_" &&
+		svn_cmd up
+	) &&
+	git svn fetch three &&
+	test $(git rev-list refs/remotes/three/branches/b_ | wc -l) -eq 2 &&
+	test $(git rev-list refs/remotes/three/tags/t_ | wc -l) -eq 3 &&
+	test $(git rev-parse refs/remotes/three/branches/b_~1) = \
+	     $(git rev-parse refs/remotes/three/trunk) &&
+	test $(git rev-parse refs/remotes/three/tags/t_~1) = \
+	     $(git rev-parse refs/remotes/three/branches/b_) &&
+	git log --pretty=oneline refs/remotes/three/tags/t_ | \
+	    sed -e "s/^.\{41\}//" >output.three &&
+	test_cmp expect.three output.three
+	'
+
+test_expect_success 'prepare test disallow prefixed multi-globs' "
+	echo \"Only one set of wildcard directories\" \
+	     \"(e.g. '*' or '*/*/*') is supported: 'branches/b_*/t/*'\" >expect.four &&
+	echo \"\" >>expect.four
+	"
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
+	test_cmp expect.four stderr.four &&
+	git config --unset svn-remote.four.branches &&
+	git config --unset svn-remote.four.tags
+	'
+
+test_expect_success 'prepare test globbing in the middle of the word' '
+	cat >expect.five <<EOF
+Tag commit to fghij
+Branch commit to abcde
+initial
+EOF
+	'
+
+test_expect_success 'test globbing in the middle of the word' '
+	git config --add svn-remote.five.url "$svnrepo" &&
+	git config --add svn-remote.five.fetch \
+	                 trunk:refs/remotes/five/trunk &&
+	git config --add svn-remote.five.branches \
+	                 "branches/a*e:refs/remotes/five/branches/*" &&
+	git config --add svn-remote.five.tags \
+	                 "tags/f*j:refs/remotes/five/tags/*" &&
+	(
+		cd tmp &&
+		svn_cmd cp trunk branches/abcde &&
+		echo "Branch commit to abcde" >>branches/abcde/src/a/readme &&
+		poke branches/b_/src/a/readme &&
+		svn_cmd commit -m "Branch commit to abcde" &&
+		svn_cmd up &&
+		svn_cmd cp branches/abcde tags/fghij &&
+		echo "Tag commit to fghij" >>tags/fghij/src/a/readme &&
+		poke tags/fghij/src/a/readme &&
+		svn_cmd commit -m "Tag commit to fghij" &&
+		svn_cmd up
+	) &&
+	git svn fetch five &&
+	test $(git rev-list refs/remotes/five/branches/abcde | wc -l) -eq 2 &&
+	test $(git rev-list refs/remotes/five/tags/fghij | wc -l) -eq 3 &&
+	test $(git rev-parse refs/remotes/five/branches/abcde~1) = \
+	     $(git rev-parse refs/remotes/five/trunk) &&
+	test $(git rev-parse refs/remotes/five/tags/fghij~1) = \
+	     $(git rev-parse refs/remotes/five/branches/abcde) &&
+	git log --pretty=oneline refs/remotes/five/tags/fghij | \
+	    sed -e "s/^.\{41\}//" >output.five &&
+	test_cmp expect.five output.five
+	'
+
+test_expect_success 'prepare test disallow multiple asterisks in one word' "
+	echo \"Only one '*' is allowed in a pattern: 'a*c*e'\" >expect.six &&
+	echo \"\" >>expect.six
+	"
+
+test_expect_success 'test disallow multiple asterisks in one word' '
+	git config --add svn-remote.six.url "$svnrepo" &&
+	git config --add svn-remote.six.fetch \
+	                 trunk:refs/remotes/six/trunk &&
+	git config --add svn-remote.six.branches \
+	                 "branches/a*c*e:refs/remotes/six/branches/*" &&
+	git config --add svn-remote.six.tags \
+	                 "tags/f*h*j:refs/remotes/six/tags/*" &&
+	(
+		cd tmp &&
+		echo "try try" >>tags/fghij/src/b/readme &&
+		poke tags/fghij/src/b/readme &&
+		svn_cmd commit -m "try to try"
+	) &&
+	test_must_fail git svn fetch six 2>stderr.six &&
+	test_cmp expect.six stderr.six
+	'
+
+test_done
-- 
2.7.0.1.g72018be.dirty

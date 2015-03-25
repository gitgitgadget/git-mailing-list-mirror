From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] t: fix some trivial cases of ignored exit codes in loops
Date: Wed, 25 Mar 2015 01:29:52 -0400
Message-ID: <20150325052952.GE31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:30:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yadt9-0001YJ-S0
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbbCYF34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:29:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:38170 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750868AbbCYF3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:29:55 -0400
Received: (qmail 17454 invoked by uid 102); 25 Mar 2015 05:29:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:29:55 -0500
Received: (qmail 11709 invoked by uid 107); 25 Mar 2015 05:30:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:30:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:29:52 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266258>

These are all cases where we do a setup step of the form:

  for i in $foo; do
	  set_up $i || break
  done &&
  more_setup

would not notice a failure in set_up (because break always
returns a 0 exit code). These are just setup steps that we
do not expect to fail, but it does not hurt to be defensive.

Most can be fixed by converting the "break" to a "return 1"
(since we eval our tests inside a function for just this
purpose). A few of the loops are inside subshells, so we can
use just "exit 1" to break out of the subshell. And a few
can actually be made shorter by just unrolling the loop.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3010-ls-files-killed-modified.sh | 11 ++++-------
 t/t3031-merge-criscross.sh          |  2 +-
 t/t3202-show-branch-octopus.sh      |  2 +-
 t/t4024-diff-optimize-common.sh     |  2 +-
 t/t4046-diff-unmerged.sh            |  8 ++++----
 t/t4151-am-abort.sh                 |  2 +-
 t/t5505-remote.sh                   |  8 ++++----
 t/t5514-fetch-multiple.sh           |  4 ++--
 t/t6026-merge-attr.sh               |  6 +++---
 t/t6040-tracking-info.sh            |  7 +++----
 10 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 62fce10..580e158 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -55,13 +55,10 @@ test_expect_success 'git update-index --add to add various paths.' '
 	: >path9 &&
 	date >path10 &&
 	git update-index --add -- path0 path?/file? pathx/ju path7 path8 path9 path10 &&
-	for i in 1 2
-	do
-		git init submod$i &&
-		(
-			cd submod$i && git commit --allow-empty -m "empty $i"
-		) || break
-	done &&
+	git init submod1 &&
+	git -C submod1 commit --allow-empty -m "empty 1" &&
+	git init submod2 &&
+	git -C submod2 commit --allow-empty -m "empty 2" &&
 	git update-index --add submod[12] &&
 	(
 		cd submod1 &&
diff --git a/t/t3031-merge-criscross.sh b/t/t3031-merge-criscross.sh
index 7f41607..e59b0a3 100755
--- a/t/t3031-merge-criscross.sh
+++ b/t/t3031-merge-criscross.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup repo with criss-cross history' '
 	do
 		echo $n > data/$n &&
 		n=$(($n+1)) ||
-		break
+		return 1
 	done &&
 
 	# check them in
diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch-octopus.sh
index 0a5d5e6..6adf478 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch-octopus.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 		> file$i &&
 		git add file$i &&
 		test_tick &&
-		git commit -m branch$i || break
+		git commit -m branch$i || return 1
 	done
 
 '
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index c4d733f..7e76018 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -139,7 +139,7 @@ test_expect_success setup '
 		( printf C; zs $n ) >file-c$n &&
 		( echo D; zs $n ) >file-d$n &&
 
-		expect_pattern $n || break
+		expect_pattern $n || return 1
 
 	done >expect
 '
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index 25d50a6..d0f1447 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -8,7 +8,7 @@ test_expect_success setup '
 	do
 		blob=$(echo $i | git hash-object --stdin) &&
 		eval "blob$i=$blob" &&
-		eval "m$i=\"100644 \$blob$i $i\"" || break
+		eval "m$i=\"100644 \$blob$i $i\"" || return 1
 	done &&
 	paths= &&
 	for b in o x
@@ -24,9 +24,9 @@ test_expect_success setup '
 				case "$b" in x) echo "$m1$p" ;; esac &&
 				case "$o" in x) echo "$m2$p" ;; esac &&
 				case "$t" in x) echo "$m3$p" ;; esac ||
-				break
-			done || break
-		done || break
+				return 1
+			done
+		done
 	done >ls-files-s.expect &&
 	git update-index --index-info <ls-files-s.expect &&
 	git ls-files -s >ls-files-s.actual &&
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 1176bcc..8d90634 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 		echo $i >otherfile-$i &&
 		git add otherfile-$i &&
 		test_tick &&
-		git commit -a -m $i || break
+		git commit -a -m $i || return 1
 	done &&
 	git format-patch --no-numbered initial &&
 	git checkout -b side initial &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 17c6330..7a8499c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -579,7 +579,7 @@ test_expect_success 'update with arguments' '
 		cd one &&
 		for b in $(git branch -r)
 		do
-		git branch -r -d $b || break
+		git branch -r -d $b || exit 1
 		done &&
 		git remote add manduca ../mirror &&
 		git remote add megaloprepus ../mirror &&
@@ -622,7 +622,7 @@ test_expect_success 'update default' '
 		cd one &&
 		for b in $(git branch -r)
 		do
-		git branch -r -d $b || break
+		git branch -r -d $b || exit 1
 		done &&
 		git config remote.drosophila.skipDefaultUpdate true &&
 		git remote update default &&
@@ -642,7 +642,7 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 		cd one &&
 		for b in $(git branch -r)
 		do
-		git branch -r -d $b || break
+		git branch -r -d $b || exit 1
 		done &&
 		git config remotes.default "$(printf "\t drosophila  \n")" &&
 		git remote update default &&
@@ -656,7 +656,7 @@ test_expect_success 'update (with remotes.default defined)' '
 		cd one &&
 		for b in $(git branch -r)
 		do
-		git branch -r -d $b || break
+		git branch -r -d $b || exit 1
 		done &&
 		git config remotes.default "drosophila" &&
 		git remote update &&
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 0f81409..4b4b667 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -120,7 +120,7 @@ test_expect_success 'git fetch --all (skipFetchAll)' '
 	(cd test4 &&
 	 for b in $(git branch -r)
 	 do
-		git branch -r -d $b || break
+		git branch -r -d $b || exit 1
 	 done &&
 	 git remote add three ../three &&
 	 git config remote.three.skipFetchAll true &&
@@ -144,7 +144,7 @@ test_expect_success 'git fetch --multiple (ignoring skipFetchAll)' '
 	(cd test4 &&
 	 for b in $(git branch -r)
 	 do
-		git branch -r -d $b || break
+		git branch -r -d $b || exit 1
 	 done &&
 	 git fetch --multiple one two three &&
 	 git branch -r > output &&
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 5e43997..3c21938 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -11,7 +11,7 @@ test_expect_success setup '
 
 	for f in text binary union
 	do
-		echo Initial >$f && git add $f || break
+		echo Initial >$f && git add $f || return 1
 	done &&
 	test_tick &&
 	git commit -m Initial &&
@@ -19,7 +19,7 @@ test_expect_success setup '
 	git branch side &&
 	for f in text binary union
 	do
-		echo Master >>$f && git add $f || break
+		echo Master >>$f && git add $f || return 1
 	done &&
 	test_tick &&
 	git commit -m Master &&
@@ -27,7 +27,7 @@ test_expect_success setup '
 	git checkout side &&
 	for f in text binary union
 	do
-		echo Side >>$f && git add $f || break
+		echo Side >>$f && git add $f || return 1
 	done &&
 	test_tick &&
 	git commit -m Side &&
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 7ac8fd0..3d5c238 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -12,10 +12,9 @@ advance () {
 }
 
 test_expect_success setup '
-	for i in a b c;
-	do
-		advance $i || break
-	done &&
+	advance a &&
+	advance b &&
+	advance c &&
 	git clone . test &&
 	(
 		cd test &&
-- 
2.3.4.635.gd6ffcfe

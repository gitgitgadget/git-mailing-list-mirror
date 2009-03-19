From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-am: teach git-am to apply a patch to an unborn branch
Date: Fri, 20 Mar 2009 07:12:31 +0900
Message-ID: <20090320071231.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 23:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQVd-0006wb-DM
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbZCSWNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbZCSWNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:13:09 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58364 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576AbZCSWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:13:08 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id C6AD411B818
	for <git@vger.kernel.org>; Thu, 19 Mar 2009 17:13:03 -0500 (CDT)
Received: from 3509.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id D3PNHENS3OEP
	for <git@vger.kernel.org>; Thu, 19 Mar 2009 17:13:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=nfGPRkuR6ViLgA/aBiwo/kK55RXF2x2v5t6fSew0oMhO2q/yTDmPRd9Rgbu8cBP+e5Y8IuPcRuTzop9it7mge6WMAz7NL+J83p8p6pdSpAfZHj1XLT0yBqzeSax+zmRBuq3ezGEWUQTK8213Leqvo5yuANHAZtli1dPmdINSThM=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113847>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 git-am.sh     |   33 ++++++++++++++++++++++++++++-----
 t/t4150-am.sh |   15 +++++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d339075..c21642b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -36,6 +36,13 @@ cd_to_toplevel
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
+if git rev-parse --verify -q HEAD >/dev/null
+then
+	HAS_HEAD=yes
+else
+	HAS_HEAD=
+fi
+
 sq () {
 	for sqarg
 	do
@@ -290,16 +297,26 @@ else
 		: >"$dotest/rebasing"
 	else
 		: >"$dotest/applying"
-		git update-ref ORIG_HEAD HEAD
+		if test -n "$HAS_HEAD"
+		then
+			git update-ref ORIG_HEAD HEAD
+		else
+			git update-ref -d ORIG_HEAD >/dev/null 2>&1
+		fi
 	fi
 fi
 
 case "$resolved" in
 '')
-	files=$(git diff-index --cached --name-only HEAD --) || exit
+	if test -n "$HAS_HEAD"
+	then
+		files=$(git diff-index --cached --name-only HEAD --)
+	else
+		files=$(git ls-files)
+	fi || exit
 	if test "$files"
 	then
-		: >"$dotest/dirtyindex"
+		test -n "$HAS_HEAD" && : >"$dotest/dirtyindex"
 		die "Dirty index: cannot apply patches (dirty: $files)"
 	fi
 esac
@@ -541,7 +558,13 @@ do
 	fi
 
 	tree=$(git write-tree) &&
-	parent=$(git rev-parse --verify HEAD) &&
+	if parent=$(git rev-parse --verify -q HEAD)
+	then
+		pparent="-p $parent"
+	else
+		echo >&2 "applying to an empty history"
+		parent= pparent=
+	fi &&
 	commit=$(
 		if test -n "$ignore_date"
 		then
@@ -552,7 +575,7 @@ do
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 			export GIT_COMMITTER_DATE
 		fi &&
-		git commit-tree $tree -p $parent <"$dotest/final-commit"
+		git commit-tree $tree $pparent <"$dotest/final-commit"
 	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5e65afa..b97d102 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -290,4 +290,19 @@ test_expect_success 'am --ignore-date' '
 	echo "$at" | grep "+0000"
 '
 
+test_expect_success 'am in an unborn branch' '
+	rm -fr subdir &&
+	mkdir -p subdir &&
+	git format-patch --numbered-files -o subdir -1 first &&
+	(
+		cd subdir &&
+		git init &&
+		git am 1
+	) &&
+	result=$(
+		cd subdir && git rev-parse HEAD^{tree}
+	) &&
+	test "z$result" = "z$(git rev-parse first^{tree})"
+'
+
 test_done
-- 
1.6.2.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

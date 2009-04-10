From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-am: teach git-am to apply a patch to an unborn branch
Date: Fri, 10 Apr 2009 09:34:42 +0900
Message-ID: <20090410093442.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4kZ-0007hz-Hl
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937064AbZDJAfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936976AbZDJAff
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:35:35 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56680 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936725AbZDJAfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:35:33 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 032BD11B8B7;
	Thu,  9 Apr 2009 19:35:33 -0500 (CDT)
Received: from 1828.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id FEMRY7SVS6PG; Thu, 09 Apr 2009 19:35:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=E4GF3ziixfqKYPobR7eiqmsKNXFZtHFIuk+xNwsDTpczqMHgsWaund3go5kkHJ9SBUb8vRRL+gr1WF0cjbaiMRQRd1ptsRoxLx7nm/l9oySwsgztwCIsqrMssw4asmSPsxaGBjEDX840hLItQyqOatSgvF2yFRh66nOfMHjyYfw=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116227>

People sometimes wonder why they cannot apply a patch that only
creates new files to an unborn branch.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 git-am.sh     |   29 ++++++++++++++++++++++++-----
 t/t4150-am.sh |   15 +++++++++++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d339075..774383f 100755
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
+	case "$HAS_HEAD" in
+	'')
+		files=$(git ls-files) ;;
+	?*)
+		files=$(git diff-index --cached --name-only HEAD --) ;;
+	esac || exit
 	if test "$files"
 	then
-		: >"$dotest/dirtyindex"
+		test -n "$HAS_HEAD" && : >"$dotest/dirtyindex"
 		die "Dirty index: cannot apply patches (dirty: $files)"
 	fi
 esac
@@ -541,18 +558,20 @@ do
 	fi
 
 	tree=$(git write-tree) &&
-	parent=$(git rev-parse --verify HEAD) &&
 	commit=$(
 		if test -n "$ignore_date"
 		then
 			GIT_AUTHOR_DATE=
 		fi
+		parent=$(git rev-parse --verify -q HEAD) ||
+		echo >&2 "applying to an empty history"
+
 		if test -n "$committer_date_is_author_date"
 		then
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 			export GIT_COMMITTER_DATE
 		fi &&
-		git commit-tree $tree -p $parent <"$dotest/final-commit"
+		git commit-tree $tree ${parent:+-p $parent} <"$dotest/final-commit"
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
 
+test_expect_success 'am into an unborn branch' '
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
1.6.2.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

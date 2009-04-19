From: Ben Jackson <ben@ben.com>
Subject: [PATCH v2] Work around ash "alternate value" expansion bug
Date: Sat, 18 Apr 2009 20:42:07 -0700
Message-ID: <1240112527-79979-1-git-send-email-ben@ben.com>
References: <1240044459-57227-1-git-send-email-ben@ben.com>
Cc: gitster@pobox.com, Ben Jackson <ben@ben.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 05:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvNwf-0003oP-Sc
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 05:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbZDSDmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 23:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbZDSDmO
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 23:42:14 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:50555 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZDSDmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 23:42:13 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n3J3g9Ew080113;
	Sat, 18 Apr 2009 20:42:09 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n3J3g72m080112;
	Sat, 18 Apr 2009 20:42:07 -0700 (PDT)
	(envelope-from bjj)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1240044459-57227-1-git-send-email-ben@ben.com>
X-Virus-Scanned: ClamAV 0.93.3/9256/Sat Apr 18 16:13:04 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116880>

Ash (used as /bin/sh on many distros) has a shell expansion bug
for the form ${var:+word word}.  The result is a single argument
"word word".  Work around by using ${var:+word} ${var:+word} or
equivalent.

Signed-off-by: Ben Jackson <ben@ben.com>
---

See http://thread.gmane.org/gmane.comp.version-control.git/116816 for
the original notes which describe the problem in more detail.

This version uses a different workaround suggested by Junio for
git-submodule which is less likely to be "cleaned up" back to the
original problem.  Since new the change is more complex I beefed
up the new test slightly to ensure we are getting into the right case.

 git-am.sh                  |    2 +-
 git-submodule.sh           |   11 +++++++++--
 t/t7400-submodule-basic.sh |   10 ++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index bfc50c9..e539c60 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -570,7 +570,7 @@ do
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 			export GIT_COMMITTER_DATE
 		fi &&
-		git commit-tree $tree ${parent:+-p $parent} <"$dotest/final-commit"
+		git commit-tree $tree ${parent:+-p} $parent <"$dotest/final-commit"
 	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c2e060..8e234a4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -204,8 +204,15 @@ cmd_add()
 	else
 
 		module_clone "$path" "$realrepo" || exit
-		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b "$branch" "origin/$branch"}) ||
-		die "Unable to checkout submodule '$path'"
+		(
+			unset GIT_DIR
+			cd "$path" &&
+			# ash fails to wordsplit ${branch:+-b "$branch"...}
+			case "$branch" in
+			'') git checkout -f -q ;;
+			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
+			esac
+		) || die "Unable to checkout submodule '$path'"
 	fi
 
 	git add "$path" ||
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index af690ec..0f2ccc6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -64,6 +64,16 @@ test_expect_success 'submodule add' '
 	)
 '
 
+test_expect_success 'submodule add --branch' '
+	(
+		cd addtest &&
+		git submodule add -b initial "$submodurl" submod-branch &&
+		git submodule init &&
+		cd submod-branch &&
+		git branch | grep initial
+	)
+'
+
 test_expect_success 'submodule add with ./ in path' '
 	(
 		cd addtest &&
-- 
1.6.0.1

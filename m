From: Knut Franke <Knut.Franke@gmx.de>
Subject: [PATCH] rebase -m: skip cherry-picked commits more reliably
Date: Tue, 23 Nov 2010 00:09:32 +0100
Message-ID: <1290467372-6487-1-git-send-email-Knut.Franke@gmx.de>
Cc: Eric Wong <normalperson@yhbt.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Knut Franke <Knut.Franke@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 00:11:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKfXW-00019H-9e
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 00:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367Ab0KVXLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 18:11:07 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:45867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S932359Ab0KVXLG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 18:11:06 -0500
Received: (qmail invoked by alias); 22 Nov 2010 23:11:00 -0000
Received: from g228071243.adsl.alicedsl.de (EHLO localhost.localdomain) [92.228.71.243]
  by mail.gmx.net (mp047) with SMTP; 23 Nov 2010 00:11:00 +0100
X-Authenticated: #377055
X-Provags-ID: V01U2FsdGVkX18aDMUdM80a8E11p/34jR8OZsSSHVSj68vUo6TZdS
	NyroxRHyhT5Qs7
X-Mailer: git-send-email 1.7.3.2
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161917>

Unlike ordinary and interactive rebase, rebase -m halts with a conflict
if two conflicting patches have been applied to both source and target
branch (e.g. by cherry-picking). Fix this by using git rev-list
--cherry-pick to generate the list of patches to apply.

Also adapt t3406 a) to catch this case and b) not to expect
"Already applied" messages which can't be emitted easily if duplicates
are removed already when storing the patches.

Signed-off-by: Knut Franke <Knut.Franke@gmx.de>
---
 git-rebase.sh             |   29 +++++++++++++++++++----------
 t/t3406-rebase-message.sh |   14 +++++++-------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 10a238a..aa42744 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -552,15 +552,14 @@ then
 	exit 0
 fi
 
-if test -n "$rebase_root"
-then
-	revisions="$onto..$orig_head"
-else
-	revisions="$upstream..$orig_head"
-fi
-
 if test -z "$do_merge"
 then
+	if test -n "$rebase_root"
+	then
+		revisions="$onto..$orig_head"
+	else
+		revisions="$upstream..$orig_head"
+	fi
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		--src-prefix=a/ --dst-prefix=b/ \
 		--no-renames $root_flag "$revisions" |
@@ -587,11 +586,21 @@ echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
 echo "$GIT_QUIET" > "$dotest/quiet"
 
+if test -n "$rebase_root"
+then
+	revisions="$onto...$orig_head"
+else
+	revisions="$upstream...$orig_head"
+fi
+
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
+for cmt in `git rev-list --reverse --no-merges --cherry-pick "$revisions"`
 do
-	msgnum=$(($msgnum + 1))
-	echo "$cmt" > "$dotest/cmt.$msgnum"
+	if test $(git merge-base "$cmt" "$orig_head") = "$cmt"
+	then
+		msgnum=$(($msgnum + 1))
+		echo "$cmt" > "$dotest/cmt.$msgnum"
+	fi
 done
 
 echo 1 >"$dotest/msgnum"
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 85fc7c4..41cb039 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -5,8 +5,10 @@ test_description='messages from rebase operation'
 . ./test-lib.sh
 
 quick_one () {
-	echo "$1" >"file$1" &&
-	git add "file$1" &&
+	fileno=$2
+	test -z "$fileno" && fileno=$1
+	echo "$1" >"file$fileno" &&
+	git add "file$fileno" &&
 	test_tick &&
 	git commit -m "$1"
 }
@@ -16,21 +18,19 @@ test_expect_success setup '
 	git branch topic &&
 	quick_one X &&
 	quick_one A &&
-	quick_one B &&
+	quick_one B A &&
 	quick_one Y &&
 
 	git checkout topic &&
 	quick_one A &&
-	quick_one B &&
+	quick_one B A &&
 	quick_one Z &&
 	git tag start
 
 '
 
 cat >expect <<\EOF
-Already applied: 0001 A
-Already applied: 0002 B
-Committed: 0003 Z
+Committed: 0001 Z
 EOF
 
 test_expect_success 'rebase -m' '
-- 
1.7.3.2

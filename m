From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] rebase: allow --skip to work with --merge
Date: Sat, 24 Jun 2006 18:29:49 -0700
Message-ID: <11511989931962-git-send-email-normalperson@yhbt.net>
References: <20060622110941.GA32261@hand.yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:30:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJRv-0002gX-Qf
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWFYB34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWFYB34
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:29:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56507 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964890AbWFYB3y (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:29:54 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 653737DC025;
	Sat, 24 Jun 2006 18:29:53 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Jun 2006 18:29:53 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g937a
In-Reply-To: <20060622110941.GA32261@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22562>

Now that we control the merge base selection, we won't be forced
into rolling things in that we wanted to skip beforehand.

Also, add a test to ensure this all works as intended.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-rebase.txt |    1 -
 git-rebase.sh                |   13 ++++++++-
 t/t3403-rebase-skip.sh       |   61 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c339c45..9d7bcaa 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -108,7 +108,6 @@ OPTIONS
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
-	This does not work with the --merge option.
 
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
diff --git a/git-rebase.sh b/git-rebase.sh
index a95ada6..9ad1c44 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -137,7 +137,18 @@ do
 	--skip)
 		if test -d "$dotest"
 		then
-			die "--skip is not supported when using --merge"
+			prev_head="`cat $dotest/prev_head`"
+			end="`cat $dotest/end`"
+			msgnum="`cat $dotest/msgnum`"
+			msgnum=$(($msgnum + 1))
+			onto="`cat $dotest/onto`"
+			while test "$msgnum" -le "$end"
+			do
+				call_merge "$msgnum"
+				continue_merge
+			done
+			finish_rb_merge
+			exit
 		fi
 		git am -3 --skip --resolvemsg="$RESOLVEMSG"
 		exit
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
new file mode 100755
index 0000000..8ab63c5
--- /dev/null
+++ b/t/t3403-rebase-skip.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+
+test_description='git rebase --merge --skip tests'
+
+. ./test-lib.sh
+
+# we assume the default git-am -3 --skip strategy is tested independently
+# and always works :)
+
+if test "$no_python"; then
+	echo "Skipping: no python => no recursive merge"
+	test_done
+	exit 0
+fi
+
+test_expect_success setup '
+	echo hello > hello &&
+	git add hello &&
+	git commit -m "hello" &&
+	git branch skip-reference &&
+
+	echo world >> hello &&
+	git commit -a -m "hello world" &&
+	echo goodbye >> hello &&
+	git commit -a -m "goodbye" &&
+
+	git checkout -f skip-reference &&
+	echo moo > hello &&
+	git commit -a -m "we should skip this" &&
+	echo moo > cow &&
+	git add cow &&
+	git commit -m "this should not be skipped" &&
+	git branch pre-rebase skip-reference &&
+	git branch skip-merge skip-reference
+	'
+
+test_expect_failure 'rebase with git am -3 (default)' 'git rebase master'
+
+test_expect_success 'rebase --skip with am -3' '
+	git reset --hard HEAD &&
+	git rebase --skip
+	'
+test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
+
+test_expect_failure 'rebase with --merge' 'git rebase --merge master'
+
+test_expect_success 'rebase --skip with --merge' '
+	git reset --hard HEAD &&
+	git rebase --skip
+	'
+
+test_expect_success 'merge and reference trees equal' \
+	'test -z "`git-diff-tree skip-merge skip-reference`"'
+
+test_debug 'gitk --all & sleep 1'
+
+test_done
+
-- 
1.4.0.g937a

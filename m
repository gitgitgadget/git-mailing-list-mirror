From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: test to exclude commits from todo based on its parents
Date: Wed, 15 Oct 2008 02:44:34 -0500
Message-ID: <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq14z-00012V-Sx
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYJOHor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYJOHoq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:46 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49868 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYJOHoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:44 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 8E5A41E06AC;
	Wed, 15 Oct 2008 03:44:44 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 34FB91E0660;
	Wed, 15 Oct 2008 03:44:44 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98246>

The first case was based off a script from Avi Kivity <avi@redhat.com>.

The second case includes a merge-of-a-merge to ensure both are included in todo.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 t/t3411-rebase-preserve-around-merges.sh |  136 ++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100644 t/t3411-rebase-preserve-around-merges.sh

diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
new file mode 100644
index 0000000..b3973c9
--- /dev/null
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Stephen Haberman
+#
+
+test_description='git rebase preserve merges
+
+This test runs git rebase with and tries to squash a commit from after a merge
+to before the merge.
+'
+. ./test-lib.sh
+
+# Copy/paste from t3404-rebase-interactive.sh
+echo "#!$SHELL_PATH" >fake-editor.sh
+cat >> fake-editor.sh <<\EOF
+case "$1" in
+*/COMMIT_EDITMSG)
+	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
+	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
+	exit
+	;;
+esac
+test -z "$EXPECT_COUNT" ||
+	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
+	exit
+test -z "$FAKE_LINES" && exit
+grep -v '^#' < "$1" > "$1".tmp
+rm -f "$1"
+cat "$1".tmp
+action=pick
+for line in $FAKE_LINES; do
+	case $line in
+	squash|edit)
+		action="$line";;
+	*)
+		echo sed -n "${line}s/^pick/$action/p"
+		sed -n "${line}p" < "$1".tmp
+		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
+		action=pick;;
+	esac
+done
+EOF
+
+test_set_editor "$(pwd)/fake-editor.sh"
+chmod a+x fake-editor.sh
+
+# set up two branches like this:
+#
+# A1 - B1 - D1 - E1 - F1
+#       \        /
+#        -- C1 --
+
+test_expect_success 'setup' '
+	touch a &&
+	touch b &&
+	git add a &&
+	git commit -m A1 &&
+	git tag A1
+	git add b &&
+	git commit -m B1 &&
+	git tag B1 &&
+	git checkout -b branch &&
+	touch c &&
+	git add c &&
+	git commit -m C1 &&
+	git checkout master &&
+	touch d &&
+	git add d &&
+	git commit -m D1 &&
+	git merge branch &&
+	touch f &&
+	git add f &&
+	git commit -m F1 &&
+	git tag F1
+'
+
+# Should result in:
+#
+# A1 - B1 - D2 - E2
+#       \        /
+#        -- C1 --
+#
+test_expect_failure 'squash F1 into D1' '
+	FAKE_LINES="1 squash 3 2" git rebase -i -p B1 &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse branch)" &&
+	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
+	git tag E2
+'
+
+# Start with:
+#
+# A1 - B1 - D2 - E2
+#  \
+#   G1 ---- L1 ---- M1
+#    \             /
+#     H1 -- J1 -- K1
+#      \         /
+#        -- I1 --
+#
+# And rebase G1..M1 onto E2
+
+test_expect_failure 'rebase two levels of merge' '
+	git checkout -b branch2 A1 &&
+	touch g &&
+	git add g &&
+	git commit -m G1 &&
+	git checkout -b branch3 &&
+	touch h
+	git add h &&
+	git commit -m H1 &&
+	git checkout -b branch4 &&
+	touch i &&
+	git add i &&
+	git commit -m I1 &&
+	git tag I1 &&
+	git checkout branch3 &&
+	touch j &&
+	git add j &&
+	git commit -m J1 &&
+	git merge I1 --no-commit &&
+	git commit -m K1 &&
+	git tag K1 &&
+	git checkout branch2 &&
+	touch l &&
+	git add l &&
+	git commit -m L1 &&
+	git merge K1 --no-commit &&
+	git commit -m M1 &&
+	GIT_EDITOR=: git rebase -i -p E2 &&
+	test "$(git rev-parse HEAD~3)" = "$(git rev-parse E2)" &&
+	test "$(git rev-parse HEAD~2)" = "$(git rev-parse HEAD^2^2~2)" &&
+	test "$(git rev-parse HEAD^2^1^1)" = "$(git rev-parse HEAD^2^2^1)"
+'
+
+test_done
+
-- 
1.6.0.2

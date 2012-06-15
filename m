From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Fri, 15 Jun 2012 07:17:35 -0700
Message-ID: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net>
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, "David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 17:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfYHP-00062w-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 17:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab2FOPRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 11:17:39 -0400
Received: from crispin.apple.com ([17.151.62.50]:45351 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab2FOPRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 11:17:38 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2012 11:17:38 EDT
Received: from relay16.apple.com ([17.128.113.55])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0M5N00I3MX129HL2@mail-out.apple.com> for git@vger.kernel.org;
 Fri, 15 Jun 2012 07:17:35 -0700 (PDT)
X-AuditID: 11807137-b7f536d000006fcc-5b-4fdb43ff43a6
Received: from ddkilzer.apple.com (ddkilzer.apple.com [17.202.44.147])
	by relay16.apple.com (Apple SCV relay) with SMTP id 5B.B0.28620.FF34BDF4; Fri,
 15 Jun 2012 07:17:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.6 (Apple Git-31)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJMWRmVeSWpSXmKPExsUieEpnsu5/59v+BpvXcFv83PuC3aLrSjeT
	RUPvFWYHZo9F+4M9Ll5S9vi8SS6AOYrLJiU1J7MstUjfLoEro+WObMFi6Ypj//YwNTBOE+1i
	5OSQEDCRaFy2hwnCFpO4cG89WxcjF4eQwA5GiTV3n7GAJNgEdCWeN39hBbFFBMQl3h6fyQ5i
	Mws4SNx5tZERxBYW8JR4svACmM0ioCox78FfsF5eAWeJl49eskIs0Jc4uPU08wRGrgWMDKsY
	BYtScxIrDc30EgsKclL1kvNzNzGCfNhQaL6DcftfuUOMAhyMSjy8F1lv+QuxJpYVV+YeYpTg
	YFYS4RWKAgrxpiRWVqUW5ccXleakFh9ilOZgURLn5Um75i8kkJ5YkpqdmlqQWgSTZeLglGpg
	7D9s2p9YKHx156318+RW3rjZ/7J6GceqDfGPL1Rs4Egv9WvwDfgf5ab6OW9lWZPhK9GTpa7N
	r6Z5b//ceVGQM1x1YdTk8HuJ6p/EIuZMSW3f3so5+YnLt05Ln/1xky6wfDKPk/TcZjz99k9J
	v8j82bZ2+8wXzZq/5vlMbrcTM+S/rwxYa3vtpxJLcUaioRZzUXEiABoH6sbdAQAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200060>

From: "David D. Kilzer" <ddkilzer@kilzer.net>

When performing an interactive rebase that preserves merges with
rerere enabled, the --rerere-autoupdate switch should be passed
to git-merge.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 git-rebase--interactive.sh                    |    7 ++-
 t/t3420-rebase-preserve-merges-with-rerere.sh |   75 +++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100755 t/t3420-rebase-preserve-merges-with-rerere.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2e13258..958bbf8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -297,9 +297,12 @@ pick_one_preserving_merges () {
 			msg_content="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
+			# If rerere is enabled, pass the --rerere-autoupdate flag
+			test "$(git config --bool rerere.enabled)" = "true" &&
+				rerere_autoupdate=--rerere-autoupdate || rerere_autoupdate=
 			if ! do_with_author output \
-				git merge --no-ff ${strategy:+-s $strategy} -m \
-					"$msg_content" $new_parents
+				git merge --no-ff ${strategy:+-s $strategy} $rerere_autoupdate \
+					-m "$msg_content" $new_parents
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
diff --git a/t/t3420-rebase-preserve-merges-with-rerere.sh b/t/t3420-rebase-preserve-merges-with-rerere.sh
new file mode 100755
index 0000000..679937d
--- /dev/null
+++ b/t/t3420-rebase-preserve-merges-with-rerere.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+# Copyright (c) 2012 David D. Kilzer
+#
+
+test_description='git rebase -i -p should use rerere to resolve conflicts if enabled'
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+# Setup
+#
+# A--AA--B    <-- master
+#     \
+#      \
+#       \
+#        C    <-- topic1
+
+test_expect_success 'setup' '
+	test_commit A file1 &&
+	test_commit AA file2 &&
+	test_commit B file1 &&
+	git checkout -b topic1 HEAD^ &&
+	test_commit C file1 &&
+	git checkout master
+'
+
+# Use rerere to resolve conflicts
+#
+# Before interactive rebase:
+#
+# A--AA--B    <-- master
+#     \   \
+#      \   M  <-- merge1-baseline, merge1
+#       \ /
+#        C    <-- topic1
+#
+# After interactive rebase:
+#
+# A--AA--B    <-- master
+#    |\   \
+#    | \   M  <-- merge1-baseline
+#    |  \ /
+#    |   C    <-- topic1
+#     \   \
+#      \   M' <-- merge1
+#       \ /
+#        B'
+
+test_expect_success 'rebase -i -p uses rerere to resolve conflicts' '
+	git config rerere.enabled true &&
+	git rerere clear &&
+
+	git checkout -b merge1 master &&
+	test_must_fail git merge topic1 &&
+	test "`git rerere status`" = "file1" &&
+	printf "B\nC\n" > file1 &&
+	git add file1 &&
+	git commit -m "M: Merge with conflict resolved." &&
+	git branch merge1-baseline &&
+
+	FAKE_LINES="edit 1 2 3" git rebase -i -p HEAD~2 &&
+	echo BB >> file2 &&
+	git add file2 &&
+	git commit -m "B'\'': Edit file2 to prevent fast-forward." --amend &&
+	test_must_fail git rebase --continue &&
+	git commit -m "M'\'': Merge with conflict resolved by rerere." &&
+	git rebase --continue &&
+	git diff --exit-code merge1-baseline..merge1 file1
+'
+
+test_done
-- 
1.7.9.6 (Apple Git-31)

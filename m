From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/6] t3404 & t3411: undo copy&paste
Date: Tue, 27 Jan 2009 23:34:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272334210.3586@pacific.mpi-cbg.de>
References: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 27 23:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwX1-0002dI-7v
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZA0WeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbZA0WeM
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:34:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:36035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753048AbZA0WeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:34:10 -0500
Received: (qmail invoked by alias); 27 Jan 2009 22:34:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 27 Jan 2009 23:34:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IzTYP9EnIFeepFwDJV9oPeVz51i/sQBXU/PmK/S
	Z5JPwv/Pa9WY5d
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107400>

Rather than copying and pasting, which is prone to lead to fixes
missing in one version, move the fake-editor generator to t/t3404/.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-rebase.sh                          |   36 ++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh            |   37 +++--------------------------
 t/t3411-rebase-preserve-around-merges.sh |   38 +++--------------------------
 3 files changed, 44 insertions(+), 67 deletions(-)
 create mode 100644 t/lib-rebase.sh

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
new file mode 100644
index 0000000..762ffcf
--- /dev/null
+++ b/t/lib-rebase.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+set_fake_editor () {
+	echo "#!$SHELL_PATH" >fake-editor.sh
+	cat >> fake-editor.sh <<\EOF
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
+	test_set_editor "$(pwd)/fake-editor.sh"
+	chmod a+x fake-editor.sh
+}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2cc8e7a..3592403 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -10,6 +10,10 @@ that the result still makes sense.
 '
 . ./test-lib.sh
 
+. ../lib-rebase.sh
+
+set_fake_editor
+
 # set up two branches like this:
 #
 # A - B - C - D - E
@@ -61,39 +65,6 @@ test_expect_success 'setup' '
 	git tag I
 '
 
-echo "#!$SHELL_PATH" >fake-editor.sh
-cat >> fake-editor.sh <<\EOF
-case "$1" in
-*/COMMIT_EDITMSG)
-	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
-	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
-	exit
-	;;
-esac
-test -z "$EXPECT_COUNT" ||
-	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
-	exit
-test -z "$FAKE_LINES" && exit
-grep -v '^#' < "$1" > "$1".tmp
-rm -f "$1"
-cat "$1".tmp
-action=pick
-for line in $FAKE_LINES; do
-	case $line in
-	squash|edit)
-		action="$line";;
-	*)
-		echo sed -n "${line}s/^pick/$action/p"
-		sed -n "${line}p" < "$1".tmp
-		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
-		action=pick;;
-	esac
-done
-EOF
-
-test_set_editor "$(pwd)/fake-editor.sh"
-chmod a+x fake-editor.sh
-
 test_expect_success 'no changes are a nop' '
 	git rebase -i F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index aacfaae..6a1586a 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -5,44 +5,14 @@
 
 test_description='git rebase preserve merges
 
-This test runs git rebase with and tries to squash a commit from after a merge
-to before the merge.
+This test runs git rebase with -p and tries to squash a commit from after
+a merge to before the merge.
 '
 . ./test-lib.sh
 
-# Copy/paste from t3404-rebase-interactive.sh
-echo "#!$SHELL_PATH" >fake-editor.sh
-cat >> fake-editor.sh <<\EOF
-case "$1" in
-*/COMMIT_EDITMSG)
-	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
-	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
-	exit
-	;;
-esac
-test -z "$EXPECT_COUNT" ||
-	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
-	exit
-test -z "$FAKE_LINES" && exit
-grep -v '^#' < "$1" > "$1".tmp
-rm -f "$1"
-cat "$1".tmp
-action=pick
-for line in $FAKE_LINES; do
-	case $line in
-	squash|edit)
-		action="$line";;
-	*)
-		echo sed -n "${line}s/^pick/$action/p"
-		sed -n "${line}p" < "$1".tmp
-		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
-		action=pick;;
-	esac
-done
-EOF
+. ../lib-rebase.sh
 
-test_set_editor "$(pwd)/fake-editor.sh"
-chmod a+x fake-editor.sh
+set_fake_editor
 
 # set up two branches like this:
 #
-- 
1.6.1.482.g7d54be

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/6] t3404 & t3411: undo copy&paste
Date: Tue, 27 Jan 2009 18:45:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271845380.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs1g-0007pj-Nt
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbZA0Rpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755303AbZA0Rpi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:45:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:41118 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755156AbZA0Rph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:45:37 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:45:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 27 Jan 2009 18:45:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VCYcStcNVXVrc3J3F2IxcuLjqJy3XGGdasNYzM/
	zcWx1LOAYjRPXI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107366>


Rather than copying and pasting, which is prone to lead to fixes
missing in one version, move the fake-editor generator to t/t3404/.

While at it, fix a typo that causes head-scratching: use
${SHELL_PATH-/bin/sh} instead of $SHELL_PATH.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-rebase.sh                          |   36 ++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh            |   37 +++--------------------------
 t/t3411-rebase-preserve-around-merges.sh |   38 +++--------------------------
 3 files changed, 44 insertions(+), 67 deletions(-)
 create mode 100644 t/lib-rebase.sh

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
new file mode 100644
index 0000000..8c8caab
--- /dev/null
+++ b/t/lib-rebase.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+set_fake_editor () {
+	echo "#!${SHELL_PATH-/bin_sh}" >fake-editor.sh
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

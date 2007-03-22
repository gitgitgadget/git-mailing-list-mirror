From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] Bisect: implement "git bisect run <cmd>..." to
 automatically bisect.
Date: Thu, 22 Mar 2007 07:08:59 +0100
Message-ID: <20070322070859.a86c0cb4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 07:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUGMv-0000we-PP
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 07:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965774AbXCVGBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 02:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965776AbXCVGBq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 02:01:46 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:47084 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965774AbXCVGBp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 02:01:45 -0400
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 901C9CA4896
	for <git@vger.kernel.org>; Thu, 22 Mar 2007 06:02:02 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id AE33BB55B3;
	Thu, 22 Mar 2007 07:00:43 +0100 (CET)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42839>

This idea was suggested by Bill Lear
(Message-ID: <17920.38942.364466.642979@lisa.zopyra.com>)
and I think it is a very good one.

This patch adds a new test file for "git bisect run", but there
is currently only one basic test.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh         |   54 +++++++++++++++++++++++++++++++++++++++++++--
 t/t6030-bisect-run.sh |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 3 deletions(-)
 create mode 100755 t/t6030-bisect-run.sh

diff --git a/git-bisect.sh b/git-bisect.sh
index b1c3a6b..53dff7d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,14 +1,15 @@
 #!/bin/sh
 
-USAGE='[start|bad|good|next|reset|visualize|replay|log]'
+USAGE='[start|bad|good|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect start [<pathspec>]	reset bisect state and start bisection.
 git bisect bad [<rev>]		mark <rev> a known-bad revision.
 git bisect good [<rev>...]	mark <rev>... known-good revisions.
 git bisect next			find next bisection to test and check it out.
 git bisect reset [<branch>]	finish bisection search and go back to branch.
 git bisect visualize            show bisect status in gitk.
-git bisect replay <logfile>	replay bisection log
-git bisect log			show bisect log.'
+git bisect replay <logfile>	replay bisection log.
+git bisect log			show bisect log.
+git bisect run <cmd>... 	use <cmd>... to automatically bisect.'
 
 . git-sh-setup
 require_work_tree
@@ -185,6 +186,7 @@ bisect_reset() {
 		rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
 		rm -f "$GIT_DIR/BISECT_LOG"
 		rm -f "$GIT_DIR/BISECT_NAMES"
+		rm -f "$GIT_DIR/BISECT_RUN"
 	fi
 }
 
@@ -220,6 +222,50 @@ bisect_replay () {
 	bisect_auto_next
 }
 
+bisect_run () {
+    while true
+    do
+      echo "running $@"
+      "$@"
+      res=$?
+
+      # Check for really bad run error.
+      if [ $res -lt 0 -o $res -ge 128 ]; then
+	  echo >&2 "bisect run failed:"
+	  echo >&2 "exit code $res from '$@' is < 0 or >= 128"
+	  exit $res
+      fi
+
+      # Use "git-bisect good" or "git-bisect bad"
+      # depending on run success or failure.
+      # We cannot use bisect_good or bisect_bad functions
+      # because they can exit.
+      if [ $res -gt 0 ]; then
+	  next_bisect='git-bisect bad'
+      else
+	  next_bisect='git-bisect good'
+      fi
+
+      $next_bisect > "$GIT_DIR/BISECT_RUN"
+      res=$?
+
+      cat "$GIT_DIR/BISECT_RUN"
+
+      if [ $res -ne 0 ]; then
+	  echo >&2 "bisect run failed:"
+	  echo >&2 "$next_bisect exited with error code $res"
+	  exit $res
+      fi
+
+      if grep "is first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
+	  echo "bisect run success"
+	  exit 0;
+      fi
+
+    done
+}
+
+
 case "$#" in
 0)
     usage ;;
@@ -244,6 +290,8 @@ case "$#" in
 	bisect_replay "$@" ;;
     log)
 	cat "$GIT_DIR/BISECT_LOG" ;;
+    run)
+        bisect_run "$@" ;;
     *)
         usage ;;
     esac
diff --git a/t/t6030-bisect-run.sh b/t/t6030-bisect-run.sh
new file mode 100755
index 0000000..39c7228
--- /dev/null
+++ b/t/t6030-bisect-run.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Christian Couder
+#
+test_description='Tests git-bisect run functionality'
+
+. ./test-lib.sh
+
+add_line_into_file()
+{
+    _line=$1
+    _file=$2
+
+    if [ -f "$_file" ]; then
+        echo "$_line" >> $_file || return $?
+        MSG="Add <$_line> into <$_file>."
+    else
+        echo "$_line" > $_file || return $?
+        git add $_file || return $?
+        MSG="Create file <$_file> with <$_line> inside."
+    fi
+
+    git-commit -m "$MSG" $_file
+}
+
+HASH1=
+HASH3=
+HASH4=
+
+test_expect_success \
+    'set up basic repo with 1 file (hello) and 4 commits' \
+    'add_line_into_file "1: Hello World" hello &&
+     add_line_into_file "2: A new day for git" hello &&
+     add_line_into_file "3: Another new day for git" hello &&
+     add_line_into_file "4: Ciao for now" hello &&
+     HASH1=$(git rev-list HEAD | tail -1) &&
+     HASH3=$(git rev-list HEAD | head -2 | tail -1) &&
+     HASH4=$(git rev-list HEAD | head -1)'
+
+# We want to automatically find the commit that
+# introduced "Another" into hello.
+test_expect_success \
+    'git bisect run simple case' \
+    'echo "#!/bin/sh" > test_script.sh &&
+     echo "grep Another hello > /dev/null" >> test_script.sh &&
+     echo "test \$? -ne 0" >> test_script.sh &&
+     chmod +x test_script.sh &&
+     git bisect start &&
+     git bisect good $HASH1 &&
+     git bisect bad $HASH4 &&
+     git bisect run ./test_script.sh > my_bisect_log.txt &&
+     grep "$HASH3 is first bad commit" my_bisect_log.txt'
+
+#
+#
+test_done
+
-- 
1.5.1.rc1.13.g0872-dirty

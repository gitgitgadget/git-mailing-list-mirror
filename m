From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: implement "git bisect run <cmd>..." to
 automatically bisect.
Date: Fri, 23 Mar 2007 08:49:59 +0100
Message-ID: <20070323084959.d6321f53.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 08:41:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUePM-0006S1-Ad
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 08:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXCWHlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 03:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXCWHlp
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 03:41:45 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49783 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbXCWHlo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 03:41:44 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 2D33BB5B43;
	Fri, 23 Mar 2007 08:41:43 +0100 (CET)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42908>

This idea was suggested by Bill Lear
(Message-ID: <17920.38942.364466.642979@lisa.zopyra.com>)
and I think it is a very good one.

This patch adds a new test file for "git bisect run", but there
is currently only one basic test.

Thanks to Junio for the documentation and suggestions
(Message-ID: <7vejnhwy0y.fsf@assigned-by-dhcp.cox.net>).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   29 +++++++++++++++++++++
 git-bisect.sh                |   54 +++++++++++++++++++++++++++++++++++++--
 t/t6030-bisect-run.sh        |   57 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 3 deletions(-)
 create mode 100755 t/t6030-bisect-run.sh

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 16ec726..36d690e 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -22,6 +22,7 @@ depending on the subcommand:
  git bisect visualize
  git bisect replay <logfile>
  git bisect log
+ git bisect run <cmd>...
 
 This command uses 'git-rev-list --bisect' option to help drive
 the binary search process to find which change introduced a bug,
@@ -121,6 +122,34 @@ like this:
 $ git bisect start arch/i386 include/asm-i386
 ------------
 
+If you have a script or a shell command that can tell if the current
+source code is good or bad, you can automatically bisect using:
+
+------------
+$ git bisect run my_script_or_shell_command
+------------
+
+Note that the "run" script or shell command should exit with code 0 in
+case the current source code is good and with a code between 1 and 127
+(included) in case the current source code is bad.
+
+Any other exit code (a program that does "exit(-1)" leaves $? = 255,
+see exit(3) manual page, the value is chopped with "& 0377") will
+abort the automatic bisect process.
+
+You may often find that during bisect you want to have near-constant
+tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or
+"revision that does not have this commit needs this patch applied to
+work around other problem this bisection is not interested in")
+applied to the revision being tested.
+
+To cope with such a situation, after the inner git-bisect finds the
+next revision to test, with the "run" script, you can apply that tweak
+before compiling, run the real test, and after the test decides if the
+revision (possibly with the needed tweaks) passed the test, rewind the
+tree to the pristine state.  Finally the "run" script can exit with
+the status of the real test to let "git bisect run" command loop to
+know the outcome.
 
 Author
 ------
diff --git a/git-bisect.sh b/git-bisect.sh
index b1c3a6b..baf2ad5 100755
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
+      # Use "bisect_good" or "bisect_bad"
+      # depending on run success or failure.
+      if [ $res -gt 0 ]; then
+	  next_bisect='bisect_bad'
+      else
+	  next_bisect='bisect_good'
+      fi
+
+      # We have to use a subshell because bisect_good or
+      # bisect_bad functions can exit.
+      ( $next_bisect > "$GIT_DIR/BISECT_RUN" )
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
1.5.1.rc1.14.ge96a-dirty

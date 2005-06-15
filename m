From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/3] Adds support to git-commit-script for an optional .nextmsg file. [rev 4]
Date: Thu, 16 Jun 2005 00:38:14 +1000
Message-ID: <20050615143814.27266.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 16:36:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiYz0-0004la-SZ
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 16:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVFOOkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 10:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFOOkI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 10:40:08 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:29313 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261520AbVFOOiR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 10:38:17 -0400
Received: (qmail 27276 invoked by uid 500); 15 Jun 2005 14:38:14 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If ${GIT_DIR}/.nextmsg exists, the text will be copied into the .editmsg file
together with a sentinel line prior to invoking the editor.

After editing, the edited text (but not the status lines) are saved
back to the ${GIT_DIR}/.nextmsg file.

If the sentinel line still exists in .editmsg after editing, the
file is truncated, thereby causing the commit to abort (per previous
behaviour).

The ${GIT_DIR}/.nextmsg file is deleted if, and only if,
the commit was successful.

The behaviour of git-commit-script is unchanged with respect to the
previous versions if ${GIT_DIR}/.nextmsg does not exist.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 git-commit-script        |   32 +++++++++++++++++++++++++++++++-
 t/t1200-commit-script.sh |   41 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -36,12 +36,41 @@ print_status() {
 	fi
 }
 
+merge_next_message()
+{
+	status=$1
+	next=$2
+	mv -f $status .status.$$ || exit 1
+	cat >$status <<EOF
+$SENTINEL
+#---
+$(cat $next)
+#---
+$(cat .status.$$)
+EOF
+	rm .status.$$
+}
+
+save_next_message()
+{
+	status=$1
+	next=$2
+	grep -v "^#" < $status > $next
+	if grep "^$SENTINEL" < $status >/dev/null; then
+		:> $status
+		echo "commit aborted - you must delete the SENTINEL line to confirm the commit"
+	fi
+}
+
 edit_message() {
 	status=$1
 	msg=$2
+	next=$3
 
 	:> $msg
+	[ -f "$next" ] && merge_next_message "$status" "$next"
 	${VISUAL:-${EDITOR:-vi}} "$status"
+	[ -f "$next" ] && save_next_message "$status" "$next"
 	grep -v '^#' < $status | git-stripspace >$msg
 	[ -s $msg ] || exit 1
 }
@@ -76,9 +105,10 @@ if ! print_status > .editmsg; then
 	exit 1
 fi
 
-if edit_message .editmsg .cmitmsg; then
+if edit_message .editmsg .cmitmsg ${GIT_DIR}/.nextmsg ; then
 	exec_commit .cmitmsg
 	[ -f .editmsg ] && rm .editmsg
 	[ -f .cmitmsg ] && rm .cmitmsg
+	[ -f ${GIT_DIR}/.nextmsg ] && rm ${GIT_DIR}/.nextmsg
 	exit 0
 fi
diff --git a/t/t1200-commit-script.sh b/t/t1200-commit-script.sh
--- a/t/t1200-commit-script.sh
+++ b/t/t1200-commit-script.sh
@@ -75,6 +75,15 @@ run_with_vars()
      TZ= "$@" 2>/dev/null
 }
 
+reset()
+{
+     [ -f .git/HEAD ] && rm .git/HEAD
+     [ -f .git/MERGE_HEAD ] && rm .git/MERGE_HEAD
+     [ -f .git/index ] && rm .git/index
+     [ -f treeid ] && rm treeid
+     [ -f commit ] && rm commit
+}
+
 test_phase1()
 {
      condition=$1
@@ -146,8 +155,34 @@ test_phase3()
 
 }
 
-test_phase1 "simulated user" ./do_nothing_editor
-test_phase2 "simulated user" ./add_one_line_editor
-test_phase3 "simulated used" ./add_one_line_editor
+test_phase1 "without .nextmsg" ./do_nothing_editor
+test_phase2 "without .nextmsg" ./add_one_line_editor
+test_phase3 "without .nextmsg" ./add_one_line_editor
+
+reset
+
+one_line > .git/.nextmsg
+test_phase1 "with .nextmsg" ./do_nothing_editor
+test_expect_success ".nextmsg file kept" "[ -f .git/.nextmsg -a \"$(cat .git/.nextmsg)\" == \"$(one_line)\" ]"
+
+one_line    > .git/.nextmsg
+test_phase2 "with .nextmsg" ./delete_sentinel_editor
+test_expect_success ".nextmsg file deleted" '! [ -f .git/.nextmsg ]'
+
+one_line    > .git/.nextmsg
+test_phase3 "with .nextmsg" ./delete_sentinel_editor
+test_expect_success ".nextmsg file deleted" '! [ -f .git/.nextmsg ]'
+
+reset
+
+: > .git/.nextmsg
+test_phase1 "with .nextmsg, change preserved, sentinel kept" ./add_one_line_editor
+test_expect_success "edit preserved - sentinel not deleted" "[ -f .git/.nextmsg -a \"$(cat .git/.nextmsg | tr -d \\012 )\" == \"$(one_line)\" ]"
+
+reset
+
+: > .git/.nextmsg
+test_phase1 "with .nextmsg, no data, no edit, sentinel kept" ./do_nothing_editor
+test_expect_success "no change - sentinel not deleted" "[ -f .git/.nextmsg -a \"$(cat .git/.nextmsg)\" == \"\" ]"
 
 test_done
------------

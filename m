From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Adds support to git-commit-script for an optional .nextmsg file. [rev 2]
Date: Wed, 15 Jun 2005 16:07:52 +1000
Message-ID: <20050615060752.11370.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 08:03:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiQzX-00051x-Rg
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 08:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFOGIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 02:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFOGIH
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 02:08:07 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:52867 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261503AbVFOGHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 02:07:54 -0400
Received: (qmail 11381 invoked by uid 500); 15 Jun 2005 06:07:52 -0000
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
This patch set is a complete replacement for:

     [PATCH 1/1] Add support for an optional .nextmsg file to git-commit-script

I have incorporated most of Junio's feedback, except the prompting
suggestion and the suggested restructuring is slightly different.

[rev 2] fixed 2 errors with handling of .nextmsg file
---

 git-commit-script |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -5,7 +5,7 @@ print_status() {
 		if [ -z "$(git-ls-files)" ]; then
 			echo Nothing to commit 1>&2
 			return 1
-		fi
+	fi
 cat <<EOF
 #
 # Initial commit
@@ -26,12 +26,41 @@ EOF
 	git-status-script
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
 	[ -s $msg ]
 	return $?
@@ -67,8 +96,9 @@ if ! print_status > .editmsg; then
 	exit 1
 fi
 
-if edit_message .editmsg .cmitmsg; then
+if edit_message .editmsg .cmitmsg ${GIT_DIR}/.nextmsg ; then
 	exec_commit .cmitmsg
 	[ -f .editmsg ] && rm .editmsg
 	[ -f .cmitmsg ] && rm .cmitmsg
+	[ -f ${GIT_DIR}/.nextmsg ] && rm ${GIT_DIR}/.nextmsg
 fi
------------

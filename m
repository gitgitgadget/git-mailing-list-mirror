From: ted@tedpavlic.com
Subject: [PATCH] Added giteditor script to show diff while editing commit message.
Date: Wed, 21 Jan 2009 15:47:21 -0500
Message-ID: <1232570841-25641-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 21:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPk0O-00069u-4W
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 21:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbZAUUrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 15:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbZAUUrb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 15:47:31 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:41411 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbZAUUra (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 15:47:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 581E980D8051;
	Wed, 21 Jan 2009 15:41:33 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pqspIdUsGbtw; Wed, 21 Jan 2009 15:41:33 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 438D780D8005;
	Wed, 21 Jan 2009 15:41:33 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106664>

From: Ted Pavlic <ted@tedpavlic.com>

This new script (contrib/giteditor/giteditor) is an example GIT_EDITOR
that causes the editor to open the commit message as well as a "git diff
--cached". As a result, a window showing a diff of what is being
committed is opened alongside the commit message.

This script also detects when "stg edit" is being called and uses "stg
show" instead.

This script is highly influenced by the "hgeditor" script distributed
with the Mercurial SCM.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 contrib/giteditor/README    |    9 ++++
 contrib/giteditor/giteditor |  111 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 contrib/giteditor/README
 create mode 100755 contrib/giteditor/giteditor

diff --git a/contrib/giteditor/README b/contrib/giteditor/README
new file mode 100644
index 0000000..b769c3e
--- /dev/null
+++ b/contrib/giteditor/README
@@ -0,0 +1,9 @@
+A GIT_EDITOR to show diff alongside commit message. User can review diff
+within commit edit window. Works with StGit ("stg edit") as well.
+
+To use this script, set it as the value of GIT_EDITOR (or core.editor).
+
+
+Copyright (c) 2009 by Theodore P. Pavlic <ted@tedpavlic.com>
+Highly influenced by hgeditor script distributed with Mercurial SCM.
+Distributed under the GNU General Public License, version 2.0.
diff --git a/contrib/giteditor/giteditor b/contrib/giteditor/giteditor
new file mode 100755
index 0000000..13ca5f6
--- /dev/null
+++ b/contrib/giteditor/giteditor
@@ -0,0 +1,111 @@
+#!/bin/sh
+#
+# A GIT_EDITOR to show diff alongside commit message. User can review
+# diff within commit edit window. Works with StGit ("stg edit") as well.
+#
+# Copyright (c) 2009 by Theodore P. Pavlic <ted@tedpavlic.com>
+# Highly influenced by hgeditor script distributed with Mercurial SCM.
+# Distributed under the GNU General Public License, version 2.0.
+#
+# To use this script, set it as the value of GIT_EDITOR (or
+# core.editor).
+#
+
+# Find git
+[ -z "${GIT}" ] && GIT="git"
+
+# Find stg
+[ -z "${STG}" ] && STG="stg"
+
+# Use an editor. To prevent loops, avoid GIT_EDITOR and core.editor.
+EDITOR=${GIT_EDITOR_EDITOR} || \
+    EDITOR=${VISUAL} || \
+    EDITOR=${EDITOR} || \
+    EDITOR="vi";
+
+# If we recognize a popular editor, add necessary flags
+case "${EDITOR}" in
+    emacs)
+        EDITOR="${EDITOR} -nw"
+        ;;
+    mvim|gvim|vim)
+        EDITOR="${EDITOR} -f -o"
+        ;;
+esac
+
+# Remove temporary files even if we get interrupted
+GITTMP=""
+cleanup_exit() { 
+    [ -n "${GITTMP}" ] && rm -rf "${GITTMP}" 
+}
+trap "cleanup_exit" 0 # normal exit
+trap "exit 255" 1 2 3 6 15 # HUP INT QUIT ABRT TERM
+
+# End GITTMP in ".git" so that "*.git/" syntax highlighting recognition
+# doesn't break
+GITTMP="${TMPDIR-/tmp}/giteditor.$RANDOM.$RANDOM.$RANDOM.$$.git"
+(umask 077 && mkdir "${GITTMP}") || {
+    echo "Could not create temporary directory! Exiting." 1>&2
+    exit 1
+}
+
+# For git, COMMITMSG=COMMIT_EDITMSG
+# For stg, COMMITMSG=.stgit-edit.txt
+# etc.
+COMMITMSG=$( basename "$1" )
+
+case "${COMMITMSG}" in
+    .stgit-edit.txt) 
+        DIFFCMD="${STG}"
+        DIFFARGS="show"
+        ;;
+    *) 
+        DIFFCMD="${GIT}"
+        DIFFARGS="diff --cached"
+        ;;
+esac
+
+if [ -f "$1" ]; then
+    # We were passed an existing commit message
+
+    "${DIFFCMD}" ${DIFFARGS} >> "${GITTMP}/diff"
+## Uncomment if you only want to see diff of what changed
+## (note that it only works if DIFFCMD is git)
+#    (
+#        grep '^#.*modified:' "$1" | cut -b 15- | while read changed; do
+#            "${DIFFCMD}" ${DIFFARGS} "${changed}" >> "${GITTMP}/diff"
+#        done
+#    )
+
+     cat "$1" > "${GITTMP}/${COMMITMSG}"
+
+else
+
+    # Give us a blank COMMITMSG to edit
+    touch "${GITTMP}/${COMMITMSG}"
+
+    # Generate the diff
+    "${DIFFCMD}" ${DIFFARGS} >> "${GITTMP}/diff"
+    #touch "${GITTMP}/diff"
+
+fi
+
+# Use MD5 to see if commit message changed (necessary?)
+MD5=$(which md5sum 2>/dev/null) || \
+    MD5=$(which md5 2>/dev/null)
+
+[ -x "${MD5}" ] && CHECKSUM=$( ${MD5} "${GITTMP}/${COMMITMSG}" )
+if [ -s "${GITTMP}/diff" ]; then
+    # Diff is non-empty, so edit msg and diff
+    ${EDITOR} "${GITTMP}/${COMMITMSG}" "${GITTMP}/diff" || exit $?
+else
+    # Empty diff. Only edit msg
+    ${EDITOR} "${GITTMP}/${COMMITMSG}" || exit $?
+fi
+[ -x "${MD5}" ] && (echo "${CHECKSUM}" | ${MD5} -c >/dev/null 2>&1 && exit 13)
+
+# Commit message changed, so dump it on original message from Git
+mv "${GITTMP}/${COMMITMSG}" "$1"
+
+# (recall that GITTMP directory gets cleaned up by trap above)
+exit $?
-- 
1.6.1.213.g28da8

From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH] contrib: A script to show diff in new window while editing commit message.
Date: Wed, 21 Jan 2009 17:45:06 -0500
Message-ID: <1232577906-868-1-git-send-email-ted@tedpavlic.com>
References: <4977A2C9.1070502@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 23:46:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlqL-0006UU-Vu
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbZAUWpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbZAUWpQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:45:16 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:58504 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218AbZAUWpP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 17:45:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id F1CCE80D8056;
	Wed, 21 Jan 2009 17:39:17 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZ1RWoYke-0u; Wed, 21 Jan 2009 17:39:17 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id D3DD080D8054;
	Wed, 21 Jan 2009 17:39:17 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
In-Reply-To: <4977A2C9.1070502@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106694>

This new script (contrib/giteditor/giteditor) is an example GIT_EDITOR
that causes the editor to open the commit message as well as a "git diff
--cached" in a separate window. This behavior differs from "git commit
-v" in that the diff can be browsed independently of the commit message
without having to invoke a split window view in an editor.

This script also detects when "stg edit" is being called and uses "stg
show" instead. Hence, it implements a kind of "stg show -v".

This script is highly influenced by the "hgeditor" script distributed
with the Mercurial SCM.

It could be improved by supporting a command-line flag that would mimic
the "git commit -v"-type behavior of opening the diff in the same window
as the commit message. This would extend existing commands like "stg
edit" that do not already have a "-v"-type option.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---

This version attempts to answer the concerns brought up by Johannes
Schindlin.

 contrib/giteditor/giteditor |   68 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100755 contrib/giteditor/giteditor

diff --git a/contrib/giteditor/giteditor b/contrib/giteditor/giteditor
new file mode 100755
index 0000000..501a11c
--- /dev/null
+++ b/contrib/giteditor/giteditor
@@ -0,0 +1,68 @@
+#!/bin/sh
+#
+# Set GIT_EDITOR (or core.editor) to this script to see a diff alongside
+# commit message. This script differs from "git commit -v" in that the
+# diff shows up in a separate buffer. Additionally, this script works
+# with "stg edit" as well.
+#
+# Copyright (c) 2009 by Theodore P. Pavlic <ted@tedpavlic.com>
+# Highly influenced by hgeditor script distributed with Mercurial SCM.
+# Distributed under the GNU General Public License, version 2.0.
+
+# Find git
+test -z "${GIT}" && GIT="git"
+
+# Find stg
+test -z "${STG}" && STG="stg"
+
+# Use an editor. To prevent loops, avoid GIT_EDITOR and core.editor.
+EDITOR=${GIT_EDITOR_EDITOR-${VISUAL-${EDITOR-vi}}}
+
+# If we recognize a popular editor, add necessary flags (e.g., to
+# prevent forking)
+case "${EDITOR}" in
+    emacs)
+        EDITOR="${EDITOR} -nw"
+        ;;
+    mvim|gvim|vim|vi)
+        EDITOR="${EDITOR} -f -o"
+        ;;
+esac
+
+# Remove temporary files even if we get interrupted
+DIFFOUTPUT="giteditor.${RANDOM}.${RANDOM}.${RANDOM}.$$.diff"
+cleanup_exit() { 
+    rm -f "${DIFFOUTPUT}" 
+}
+trap "cleanup_exit" 0       # normal exit
+trap "exit 255" 1 2 3 6 15  # HUP INT QUIT ABRT TERM
+
+# For git, COMMITMSG=COMMIT_EDITMSG
+# For stg, COMMITMSG=.stgit-edit.txt
+# etc.
+COMMITMSG=$(basename "$1")
+case "${COMMITMSG}" in
+    .stgit-edit.txt)        # From "stg edit" 
+        DIFFCMD="${STG}"
+        DIFFARGS="show"
+        ;;
+    *)                      # Fall through to "git commit" case
+        DIFFCMD="${GIT}"
+        DIFFARGS="diff --cached"
+        # To focus on files that changed, use:
+        #DIFFARGS="diff --cached --diff-filter=M"
+        ;;
+esac
+
+"${DIFFCMD}" ${DIFFARGS} > ${DIFFOUTPUT}
+
+if test -s "${DIFFOUTPUT}"; then
+    # Diff is non-empty, so edit msg and diff
+    ${EDITOR} "$1" "${DIFFOUTPUT}" || exit $?
+else
+    # Empty diff. Only edit msg
+    ${EDITOR} "$1" || exit $?
+fi
+
+# (recall that DIFFOUTPUT file gets cleaned up by trap above)
+exit
-- 
1.6.1.213.g28da8

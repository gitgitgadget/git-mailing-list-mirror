From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH] contrib: A script to show diff in new window while editing commit message.
Date: Wed, 21 Jan 2009 22:50:08 -0500
Message-ID: <1232596208-7384-1-git-send-email-ted@tedpavlic.com>
References: <7vy6x4b48e.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 22 04:51:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPqba-0006CQ-Ac
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 04:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbZAVDuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 22:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbZAVDuT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 22:50:19 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:54139 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753018AbZAVDuS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 22:50:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 6235980D8029;
	Wed, 21 Jan 2009 22:44:20 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8K3rgLpOBmC7; Wed, 21 Jan 2009 22:44:20 -0500 (EST)
Received: from localhost.localdomain (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id CCC0C80D8021;
	Wed, 21 Jan 2009 22:44:19 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
In-Reply-To: <7vy6x4b48e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106714>

This new script (contrib/giteditor/giteditor) is an example GIT_EDITOR
that causes the editor to open the commit message as well as a "git diff
--cached" in a separate window. This behavior differs from "git commit
-v" in that the diff can be browsed independently of the commit message
without having to invoke a split window view in an editor.

This script also detects when "stg edit" is being called and uses "stg
show" instead. Hence, it implements a kind of "stg edit -v".

This script is highly influenced by the "hgeditor" script distributed
with the Mercurial SCM.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---

This new commit responds to some of the issues brought up by Junio C
Hemano (and Johannes Schindelin). In particular, it removes the
paragraph from the commit message discussing how it could be "improved." 

Also, this new version uses a "DIFFPIPE" to strip the old commit message
from the top of the "stg show" output so that the "stg edit" behavior
matches the "git commit" behavior. 

Finally, this version adds a comment giving an idea for personalizing by
adding the temporary directory creation back in (as a way to prevent
editor backup files from piling up inside .git).

 contrib/giteditor/giteditor |   86 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100755 contrib/giteditor/giteditor

diff --git a/contrib/giteditor/giteditor b/contrib/giteditor/giteditor
new file mode 100755
index 0000000..5369732
--- /dev/null
+++ b/contrib/giteditor/giteditor
@@ -0,0 +1,86 @@
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
+#
+# Possible personalizations:
+#
+# * If your GIT_DIR gets polluted with backup files created by your
+#   editor when COMMIT_EDITMSG is saved, then have this script copy
+#   COMMIT_EDITMSG (i.e., $1) to a temporary directory and then back to
+#   COMMIT_EDITMSG when done. When the script cleans up after itself, it
+#   can delete the temporary directory and any leftover backup files.
+#   Note that the vim setting 'nobackup' disables saving backup files,
+#   and this setting can be set automatically on gitcommit-type files
+#   and files matching .stgit-*.txt with an appropriate ftdetect entry.
+
+# Find git
+test -z "${GIT}" && GIT="git"
+
+# Find stg
+test -z "${STG}" && STG="stg"
+
+# Find the nearest git-dir
+GITDIR=$(git rev-parse --git-dir) || exit
+
+# Use an editor. To prevent loops, avoid GIT_EDITOR and core.editor.
+EDITOR="${GIT_EDITOR_EDITOR-${VISUAL-${EDITOR-vi}}}"
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
+DIFFOUTPUT="${GITDIR}/giteditor.${RANDOM}.${RANDOM}.${RANDOM}.$$.diff"
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
+DIFFPIPE="cat"
+case "${COMMITMSG}" in
+    .stgit-edit.txt)        # From "stg edit" 
+        DIFFCMD="${STG}"
+        DIFFARGS="show"
+        DIFFPIPE="tail +$(wc -l "$1"|awk '{print $1+3}')"
+        ;;
+    *)                      # Fall through to "git commit" case
+        DIFFCMD="${GIT}"
+        DIFFARGS="diff --cached"
+        # To focus on files that changed, use:
+        #DIFFARGS="diff --cached --diff-filter=M"
+        ;;
+esac
+
+# Do the diff and save the result in DIFFOUTPUT
+"${DIFFCMD}" ${DIFFARGS} | ${DIFFPIPE} > ${DIFFOUTPUT}
+
+# If DIFFOUTPUT is nonempty, open it alongside commit message
+if test -s "${DIFFOUTPUT}"; then
+    # Diff is non-empty, so edit msg and diff
+    ${EDITOR} "$1" "${DIFFOUTPUT}" || exit
+else
+    # Empty diff. Only edit msg
+    ${EDITOR} "$1" || exit
+fi
+
+# (recall that DIFFOUTPUT file gets cleaned up by trap above)
+exit
-- 
1.6.1.213.g28da8

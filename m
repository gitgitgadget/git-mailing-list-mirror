From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 6/6] contrib: add a hook that copies notes over rewrites
Date: Sun, 14 Feb 2010 17:17:11 +0100
Message-ID: <fba55036b8c07f1ee10c4d8f7ed22045277aeb21.1266164150.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NghAO-0003W2-SI
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab0BNQRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:17:38 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:1994 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab0BNQRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:17:37 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:33 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:13 +0100
X-Mailer: git-send-email 1.7.0.216.g74d8e
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139922>

This hook can be used to copy your notes across rewrites.  You must
also choose across which type of rewrite you want to copy them, or
just enable all of them by saying

  git config hooks.rewriteCopyNotes all

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/hooks/post-rewrite-copy-notes |   37 +++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/post-rewrite-copy-notes

diff --git a/contrib/hooks/post-rewrite-copy-notes b/contrib/hooks/post-rewrite-copy-notes
new file mode 100644
index 0000000..73d6a82
--- /dev/null
+++ b/contrib/hooks/post-rewrite-copy-notes
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+# This hook copies over the git-notes annotation from the
+# pre-rewritten commit to the post-rewritten one.  It only does so if
+# the invoking command is listed in hooks.rewriteCopyNotes (which must
+# be space separated).  If hooks.rewriteCopyNotesVerbose is set, it
+# lists the commits for which 'git notes copy' was successful on
+# stderr.
+
+type="$1"
+run=
+
+enabled="$(git config --get hooks.rewriteCopyNotes)"
+if test "$enabled" = all || test "$enabled" = true; then
+    enabled="amend rebase filter-branch"
+fi
+
+for enabled_type in $enabled; do
+    test "$enabled_type" = "$type" && run=t
+done
+
+if test -z "$run"; then
+    exit
+done
+
+verbose=$(git config --get hooks.rewriteCopyNotesVerbose)
+test "$verbose" = true && echo "Copying notes:" >2
+end_msg="No commit had any notes."
+
+while read pre post extra; do
+    git notes copy "$pre" "$post" 2>/dev/null &&
+    end_msg="Done." &&
+    test "$verbose" = true &&
+    echo "    $pre -> $post" >2
+done
+
+test "$verbose" = true && echo "$end_msg" >2
-- 
1.7.0.216.g74d8e

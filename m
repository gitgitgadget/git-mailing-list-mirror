From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCHv2 2/3] lib-rebase: Allow comments and blank lines to be added to the rebase script
Date: Tue, 12 Jan 2010 16:38:35 +0100
Message-ID: <253943b83514372775e375575bba9d7de33c0b28.1263310175.git.mhagger@alum.mit.edu>
References: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 16:39:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUiqZ-0004m4-Gp
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab0ALPjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571Ab0ALPjv
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:39:51 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45206 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab0ALPju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:39:50 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0CFd2FS019745;
	Tue, 12 Jan 2010 16:39:22 +0100
X-Mailer: git-send-email 1.6.6.140.ga53ad
In-Reply-To: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1263310175.git.mhagger@alum.mit.edu>
References: <cover.1263310175.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136727>

(For testing "rebase -i"): Support new action types in $FAKE_LINES to
allow comments and blank lines to be added to the "rebase -i" command
list.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/lib-rebase.sh |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 0fce595..0db8250 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -5,13 +5,20 @@
 # - override the commit message with $FAKE_COMMIT_MESSAGE,
 # - amend the commit message with $FAKE_COMMIT_AMEND
 # - check that non-commit messages have a certain line count with $EXPECT_COUNT
-# - rewrite a rebase -i script with $FAKE_LINES in the form
+# - rewrite a rebase -i script as directed by $FAKE_LINES.
+#   $FAKE_LINES consists of a sequence of words separated by spaces.
+#   The following word combinations are possible:
 #
-#	"[<lineno1>] [<lineno2>]..."
+#   "<lineno>" -- add a "pick" line with the SHA1 taken from the
+#       specified line.
 #
-#   If a line number is prefixed with "squash", "fixup", "edit", or
-#   "reword", the respective line's command will be replaced with the
-#   specified one.
+#   "<cmd> <lineno>" -- add a line with the specified command
+#       ("squash", "fixup", "edit", or "reword") and the SHA1 taken
+#       from the specified line.
+#
+#   "#" -- Add a comment line.
+#
+#   ">" -- Add a blank line.
 
 set_fake_editor () {
 	echo "#!$SHELL_PATH" >fake-editor.sh
@@ -36,6 +43,10 @@ for line in $FAKE_LINES; do
 	case $line in
 	squash|fixup|edit|reword)
 		action="$line";;
+	"#")
+		echo '# comment' >> "$1";;
+	">")
+		echo >> "$1";;
 	*)
 		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
 		action=pick;;
-- 
1.6.6.140.ga53ad

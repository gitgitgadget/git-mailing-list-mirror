From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] mergetool: Don't keep temporary merge files unless told to
Date: Fri, 12 Dec 2008 21:48:41 +0000
Message-ID: <1229118521-22923-3-git-send-email-charles@hashpling.org>
References: <1229118521-22923-1-git-send-email-charles@hashpling.org>
 <1229118521-22923-2-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:50:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBFtq-00072z-LR
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 22:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbYLLVtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 16:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbYLLVtB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 16:49:01 -0500
Received: from ptb-relay02.plus.net ([212.159.14.146]:34034 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbYLLVs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 16:48:59 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1LBFsM-0007cE-7q; Fri, 12 Dec 2008 21:48:46 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mBCLmjoY022992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Dec 2008 21:48:45 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mBCLmjaK022991;
	Fri, 12 Dec 2008 21:48:45 GMT
X-Mailer: git-send-email 1.6.1.rc1.342.g83b24d
In-Reply-To: <1229118521-22923-2-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: e959be2f054b65faf99507d5d5baef8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102945>

This changes git mergetool to remove the temporary files used to invoke
the merge tool even if it returns non-zero.

This also adds a configuration option (mergetool.keepTemporaries) to
retain the previous behaviour if desired.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/config.txt |    7 +++++++
 git-mergetool.sh         |    6 ++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bc5642d..3d5a8df 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -976,6 +976,13 @@ mergetool.keepBackup::
 	is set to `false` then this file is not preserved.  Defaults to
 	`true` (i.e. keep the backup files).
 
+mergetool.keepTemporaries::
+	When invoking a custom merge tool, git uses a set of temporary
+	files to pass to the tool. If the tool returns an error and this
+	variable is set to `true`, then these temporary files will be
+	preserved, otherwise they will be removed after the tool has
+	exited. Defaults to `false`.
+
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 5144971..f04240d 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -269,6 +269,11 @@ merge_file () {
     if test "$status" -ne 0; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
+
+	if test "$merge_keep_temporaries" = "false"; then
+	    cleanup_temp_files
+	fi
+
 	return 1
     fi
 
@@ -415,6 +420,7 @@ else
     init_merge_tool_path "$merge_tool"
 
     merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+    merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
     if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
         echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
-- 
1.6.1.rc1.342.g83b24d

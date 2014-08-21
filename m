From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH v4] Allow the user to change the temporary file name for mergetool
Date: Thu, 21 Aug 2014 09:47:20 +0200
Message-ID: <1408607240-11369-1-git-send-email-robin.rosenberg@dewire.com>
References: <1933929003.2352.1408519467593.JavaMail.zimbra@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 09:47:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKN5z-00062h-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 09:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbaHUHrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 03:47:33 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:55932 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaHUHrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 03:47:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 69F66816A9;
	Thu, 21 Aug 2014 09:47:31 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NtWvay0agD9t; Thu, 21 Aug 2014 09:47:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id E77708168B;
	Thu, 21 Aug 2014 09:47:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3xmFfsrf8I-E; Thu, 21 Aug 2014 09:47:26 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local.com (unknown [10.1.2.67])
	by zimbra.dewire.com (Postfix) with ESMTP id C721C8164F;
	Thu, 21 Aug 2014 09:47:26 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.rc2.6.g39c33ff.dirty
In-Reply-To: <1933929003.2352.1408519467593.JavaMail.zimbra@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255599>

Using the original filename suffix for the temporary input files to
the merge tool confuses IDEs like Eclipse. This patch introduces
a configurtion option, mergetool.tmpsuffix, which get appended to
the temporary file name. That way the user can choose to use a
suffix like ".tmp", which does not cause confusion.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/config.txt        |  5 +++++
 Documentation/git-mergetool.txt |  7 +++++++
 git-mergetool.sh                | 10 ++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

Fixed a spelling error.

-- robin

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c55c22a..0e15800 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1778,6 +1778,11 @@ notes.displayRef::
 	several times.  A warning will be issued for refs that do not
 	exist, but a glob that does not match any refs is silently
 	ignored.
+
+mergetool.tmpsuffix::
+	A string to append the names of the temporary files mergetool
+	creates in the worktree as input to a custom merge tool. The
+	primary use is to avoid confusion in IDEs during merge.
 +
 This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
 environment variable, which must be a colon separated list of refs or
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e846c2e..80a0526 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -89,6 +89,13 @@ Setting the `mergetool.keepBackup` configuration variable to `false`
 causes `git mergetool` to automatically remove the backup as files
 are successfully merged.
 
+`git mergetool` may also create other temporary files for the
+different versions involved in the merge. By default these files have
+the same filename suffix as the file being merged. This may confuse
+other tools in use during a long merge operation. The user can set
+`mergetool.tmpsuffix` to be used as an extra suffix, which will be
+appened to the temporary filename to lessen that problem.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9a046b7..d7cc76c 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -214,6 +214,8 @@ checkout_staged_file () {
 }
 
 merge_file () {
+	tmpsuffix=$(git config mergetool.tmpsuffix || true)
+
 	MERGED="$1"
 
 	f=$(git ls-files -u -- "$MERGED")
@@ -229,10 +231,10 @@ merge_file () {
 	fi
 
 	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-	BACKUP="./$MERGED.BACKUP.$ext"
-	LOCAL="./$MERGED.LOCAL.$ext"
-	REMOTE="./$MERGED.REMOTE.$ext"
-	BASE="./$MERGED.BASE.$ext"
+	BACKUP="./$MERGED.BACKUP.$ext$tmpsuffix"
+	LOCAL="./$MERGED.LOCAL.$ext$tmpsuffix"
+	REMOTE="./$MERGED.REMOTE.$ext$tmpsuffix"
+	BASE="./$MERGED.BASE.$ext$tmpsuffix"
 
 	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
 	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
-- 
2.1.0.rc2.6.g39c33ff.dirty

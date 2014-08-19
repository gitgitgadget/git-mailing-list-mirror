From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH v3] Allow the user to change the temporary file name for mergetool
Date: Tue, 19 Aug 2014 19:15:45 +0200
Message-ID: <1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
References: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:16:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJn0o-0003Cv-2G
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 19:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbaHSRPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 13:15:54 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:54771 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbaHSRPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 13:15:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 1F71E81683;
	Tue, 19 Aug 2014 19:15:52 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 24SdHEjBmdT3; Tue, 19 Aug 2014 19:15:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 9F83181656;
	Tue, 19 Aug 2014 19:15:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ERcpmAVwcMEf; Tue, 19 Aug 2014 19:15:47 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local.com (unknown [10.1.2.67])
	by zimbra.dewire.com (Postfix) with ESMTP id 3D381815E0;
	Tue, 19 Aug 2014 19:15:47 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.rc2.6.g39c33ff.dirty
In-Reply-To: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255504>

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

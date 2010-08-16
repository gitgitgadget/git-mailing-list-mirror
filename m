From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/6] Add case insensitivity support when using git ls-files
Date: Mon, 16 Aug 2010 21:38:12 +0200
Message-ID: <f7e0d9cf470a519f7a7a35ab64a635f5675e9c7d.1281985411.git.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 21:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol5Wq-0007Pw-4N
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194Ab0HPTih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:38:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59110 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178Ab0HPTie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:38:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7F5FD1001D;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 277A419F7CD;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.402.gf1eeb
In-Reply-To: <cover.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153674>

From: Joshua Jensen <jjensen@workspacewhiz.com>

When mydir/filea.txt is added, mydir/ is renamed to MyDir/, and
MyDir/fileb.txt is added, running git ls-files mydir only shows
mydir/filea.txt. Running git ls-files MyDir shows MyDir/fileb.txt.
Running git ls-files mYdIR shows nothing.

With this patch running git ls-files for mydir, MyDir, and mYdIR shows
mydir/filea.txt and MyDir/fileb.txt.

Wildcards are not handled case insensitively in this patch. Example:
MyDir/aBc/file.txt is added. git ls-files MyDir/a* works fine, but git
ls-files mydir/a* does not.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 dir.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index f80e091..af5f54f 100644
--- a/dir.c
+++ b/dir.c
@@ -107,16 +107,30 @@ static int match_one(const char *match, const char *name, int namelen)
 	if (!*match)
 		return MATCHED_RECURSIVELY;
 
-	for (;;) {
-		unsigned char c1 = *match;
-		unsigned char c2 = *name;
-		if (c1 == '\0' || is_glob_special(c1))
-			break;
-		if (c1 != c2)
-			return 0;
-		match++;
-		name++;
-		namelen--;
+	if (ignore_case) {
+		for (;;) {
+			unsigned char c1 = tolower(*match);
+			unsigned char c2 = tolower(*name);
+			if (c1 == '\0' || is_glob_special(c1))
+				break;
+			if (c1 != c2)
+				return 0;
+			match++;
+			name++;
+			namelen--;
+		}
+	} else {
+		for (;;) {
+			unsigned char c1 = *match;
+			unsigned char c2 = *name;
+			if (c1 == '\0' || is_glob_special(c1))
+				break;
+			if (c1 != c2)
+				return 0;
+			match++;
+			name++;
+			namelen--;
+		}
 	}
 
 
@@ -125,8 +139,8 @@ static int match_one(const char *match, const char *name, int namelen)
 	 * we need to match by fnmatch
 	 */
 	matchlen = strlen(match);
-	if (strncmp(match, name, matchlen))
-		return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
+	if (strncmp_icase(match, name, matchlen))
+		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
 
 	if (namelen == matchlen)
 		return MATCHED_EXACTLY;
-- 
1.7.1.402.gf1eeb

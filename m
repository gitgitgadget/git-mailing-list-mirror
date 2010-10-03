From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH v2 4/6] Add case insensitivity support when using git
 ls-files
Date: Sat, 02 Oct 2010 22:32:45 -0600
Message-ID: <20101003043245.1960.24041.stgit@SlamDunk>
References: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 06:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2GFl-0005hQ-OB
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 06:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab0JCEcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 00:32:45 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49489 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab0JCEcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 00:32:45 -0400
Received: (qmail 1354 invoked by uid 399); 2 Oct 2010 22:32:43 -0600
Received: from unknown (HELO ?192.168.56.1?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Oct 2010 22:32:43 -0600
X-Originating-IP: 76.27.116.215
In-Reply-To: <20101003043221.1960.73178.stgit@SlamDunk>
User-Agent: StGit/0.15-60-g0641
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157821>

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
---
 dir.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index 86768fb..6e2505d 100644
--- a/dir.c
+++ b/dir.c
@@ -153,16 +153,30 @@ static int match_one(const char *match, const char *name, int namelen)
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
 
 
@@ -171,8 +185,8 @@ static int match_one(const char *match, const char *name, int namelen)
 	 * we need to match by fnmatch
 	 */
 	matchlen = strlen(match);
-	if (strncmp(match, name, matchlen))
-		return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
+	if (strncmp_icase(match, name, matchlen))
+		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
 
 	if (namelen == matchlen)
 		return MATCHED_EXACTLY;

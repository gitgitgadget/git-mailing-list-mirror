From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 4/7] Add case insensitivity support when using git ls-files
Date: Thu, 20 May 2010 22:50:32 -0600
Message-ID: <1274417435-2344-5-git-send-email-jjensen@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:51:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCf-0007k0-1b
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab0EUEvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:51:01 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39244 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0EUEut (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:49 -0400
Received: (qmail 28907 invoked by uid 399); 20 May 2010 22:50:48 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE
	autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:47 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAMMMMM; 20 May 2010 22:50:47 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147439>

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
index c861f3e..d67ec68 100644
--- a/dir.c
+++ b/dir.c
@@ -126,16 +126,30 @@ static int match_one(const char *match, const char *name, int namelen)
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
 
 
@@ -144,8 +158,8 @@ static int match_one(const char *match, const char *name, int namelen)
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
1.7.1.1930.gca7dd4

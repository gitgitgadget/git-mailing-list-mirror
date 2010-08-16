From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/6] Support case folding for git add when core.ignorecase=true
Date: Mon, 16 Aug 2010 21:38:13 +0200
Message-ID: <0071a1bcd83200e693d73049672fa2d6ac73dbbc.1281985411.git.j6t@kdbg.org>
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
	id 1Ol5Wp-0007Pw-3G
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190Ab0HPTig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:38:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59116 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932181Ab0HPTie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:38:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 972242C400B;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3A8C519F7CE;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.402.gf1eeb
In-Reply-To: <cover.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153673>

From: Joshua Jensen <jjensen@workspacewhiz.com>

When MyDir/ABC/filea.txt is added to Git, the disk directory MyDir/ABC/
is renamed to mydir/aBc/, and then mydir/aBc/fileb.txt is added, the
index will contain MyDir/ABC/filea.txt and mydir/aBc/fileb.txt. Although
the earlier portions of this patch series account for those differences
in case, this patch makes the pathing consistent by folding the case of
newly added files against the first file added with that path.

In read-cache.c's add_to_index(), the index_name_exists() support used
for git status's case insensitive directory lookups is used to find the
proper directory case according to what the user already checked in.
That is, MyDir/ABC/'s case is used to alter the stored path for
fileb.txt to MyDir/ABC/fileb.txt (instead of mydir/aBc/fileb.txt).

This is especially important when cloning a repository to a case
sensitive file system. MyDir/ABC/ and mydir/aBc/ exist in the same
directory on a Windows machine, but on Linux, the files exist in two
separate directories. The update to add_to_index(), in effect, treats a
Windows file system as case sensitive by making path case consistent.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 read-cache.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f1f789b..ae1366a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -608,6 +608,29 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		ce->ce_mode = ce_mode_from_stat(ent, st_mode);
 	}
 
+	/* When core.ignorecase=true, determine if a directory of the same name but differing
+	 * case already exists within the Git repository.  If it does, ensure the directory
+	 * case of the file being added to the repository matches (is folded into) the existing
+	 * entry's directory case.
+	 */
+	if (ignore_case) {
+		const char *startPtr = ce->name;
+		const char *ptr = startPtr;
+		while (*ptr) {
+			while (*ptr && *ptr != '/')
+				++ptr;
+			if (*ptr == '/') {
+				struct cache_entry *foundce;
+				++ptr;
+				foundce = index_name_exists(&the_index, ce->name, ptr - ce->name, ignore_case);
+				if (foundce) {
+					memcpy((void*)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
+					startPtr = ptr;
+				}
+			}
+		}
+	}
+
 	alias = index_name_exists(istate, ce->name, ce_namelen(ce), ignore_case);
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
-- 
1.7.1.402.gf1eeb

From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH v2 5/6] Support case folding for git add when
 core.ignorecase=true
Date: Sat, 02 Oct 2010 22:32:51 -0600
Message-ID: <20101003043251.1960.1774.stgit@SlamDunk>
References: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 06:33:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2GG8-0005lr-Ji
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 06:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553Ab0JCEcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 00:32:50 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49491 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab0JCEcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 00:32:50 -0400
Received: (qmail 1370 invoked by uid 399); 2 Oct 2010 22:32:49 -0600
Received: from unknown (HELO ?192.168.56.1?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Oct 2010 22:32:49 -0600
X-Originating-IP: 76.27.116.215
In-Reply-To: <20101003043221.1960.73178.stgit@SlamDunk>
User-Agent: StGit/0.15-60-g0641
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157824>

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
---
 read-cache.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1f42473..379862c 100644
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

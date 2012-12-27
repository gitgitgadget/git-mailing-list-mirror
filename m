From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 08/19] dir.c: refactor is_excluded()
Date: Thu, 27 Dec 2012 02:32:27 +0000
Message-ID: <1356575558-2674-9-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hg-0006Tl-In
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab2L0Cct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:49 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53765 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab2L0Ccq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:46 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id A578D2E5DB
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:44 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212172>

In a similar way to the previous commit, this extracts a new helper
function last_exclude_matching() which returns the last exclude_list
element which matched, or NULL if no match was found.  is_excluded()
becomes a wrapper around this, and just returns 0 or 1 depending on
whether any matching exclude_list element was found.

This allows callers to find out _why_ a given path was excluded,
rather than just whether it was or not, paving the way for a new git
sub-command which allows users to test their exclude lists from the
command line.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index d1a0413..b9d4234 100644
--- a/dir.c
+++ b/dir.c
@@ -664,24 +664,44 @@ int is_excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
-static int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded.
+ * Returns the exclude_list element which matched, or NULL for
+ * undecided.
+ */
+static struct exclude *last_exclude_matching(struct dir_struct *dir,
+					     const char *pathname,
+					     int *dtype_p)
 {
 	int pathlen = strlen(pathname);
 	int st;
+	struct exclude *exclude;
 	const char *basename = strrchr(pathname, '/');
 	basename = (basename) ? basename+1 : pathname;
 
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (is_excluded_from_list(pathname, pathlen,
-					      basename, dtype_p,
-					      &dir->exclude_list[st])) {
-		case 0:
-			return 0;
-		case 1:
-			return 1;
-		}
+		exclude = last_exclude_matching_from_list(
+			pathname, pathlen, basename, dtype_p,
+			&dir->exclude_list[st]);
+		if (exclude)
+			return exclude;
 	}
+	return NULL;
+}
+
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded.
+ * Returns 1 if true, otherwise 0.
+ */
+static int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+{
+	struct exclude *exclude =
+		last_exclude_matching(dir, pathname, dtype_p);
+	if (exclude)
+		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
 }
 
-- 
1.7.11.2.249.g31c7954

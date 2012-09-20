From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 08/14] Refactor is_excluded()
Date: Thu, 20 Sep 2012 20:46:17 +0100
Message-ID: <1348170383-15751-9-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:47:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmiZ-0000ut-4Z
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab2ITTqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:39 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46191 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab2ITTqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:32 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 69AD52E5E7;
	Thu, 20 Sep 2012 20:46:31 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206084>

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
index 70b7d7e..3e2161e 100644
--- a/dir.c
+++ b/dir.c
@@ -606,24 +606,44 @@ int is_excluded_from_list(const char *pathname,
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
+		return exclude->to_exclude;
 	return 0;
 }
 
-- 
1.7.12.147.g6d168f4

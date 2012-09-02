From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 4/9] Refactor excluded_from_list
Date: Sun,  2 Sep 2012 01:12:06 +0100
Message-ID: <1346544731-938-5-git-send-email-git@adamspiers.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:20:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xvD-0001VH-J5
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab2IBATw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:19:52 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55523 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab2IBAS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:18:58 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B9EEB2E5E8;
	Sun,  2 Sep 2012 01:12:16 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
In-Reply-To: <1346544731-938-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204660>

The excluded function uses a new helper function called
exclude_from_list_1() to perform the inner loop over all of the
exclude patterns.  The helper just tells us whether the path is
included, excluded, or undecided.

However, it may be useful to know _which_ pattern was
triggered.  So let's pass out the entire exclude match,
which contains the status information we were already
passing out.

Further patches can make use of this.

This is a modified forward port of a patch from 2009 by Jeff King:
http://article.gmane.org/gmane.comp.version-control.git/108815

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index 57a5d11..3a532d5 100644
--- a/dir.c
+++ b/dir.c
@@ -509,22 +509,24 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	dir->basebuf[baselen] = '\0';
 }
 
-/* Scan the list and let the last match determine the fate.
- * Return 1 for exclude, 0 for include and -1 for undecided.
+/*
+ * Scan the given exclude list in reverse to see whether pathname
+ * should be ignored.  The first match (i.e. the last on the list), if
+ * any, determines the fate.  Returns the exclude_list element which
+ * matched, or NULL for undecided.
  */
-int excluded_from_list(const char *pathname,
-		       int pathlen, const char *basename, int *dtype,
-		       struct exclude_list *el)
+struct exclude *excluded_from_list_1(const char *pathname, int pathlen,
+				     const char *basename, int *dtype,
+				     struct exclude_list *el)
 {
 	int i;
 
 	if (!el->nr)
-		return -1;	/* undefined */
+		return NULL;	/* undefined */
 
 	for (i = el->nr - 1; 0 <= i; i--) {
 		struct exclude *x = el->excludes[i];
 		const char *name, *exclude = x->pattern;
-		int to_exclude = x->to_exclude;
 		int namelen, prefix = x->nowildcardlen;
 
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
@@ -538,14 +540,14 @@ int excluded_from_list(const char *pathname,
 			/* match basename */
 			if (prefix == x->patternlen) {
 				if (!strcmp_icase(exclude, basename))
-					return to_exclude;
+					return x;
 			} else if (x->flags & EXC_FLAG_ENDSWITH) {
 				if (x->patternlen - 1 <= pathlen &&
 				    !strcmp_icase(exclude + 1, pathname + pathlen - x->patternlen + 1))
-					return to_exclude;
+					return x;
 			} else {
 				if (fnmatch_icase(exclude, basename, 0) == 0)
-					return to_exclude;
+					return x;
 			}
 			continue;
 		}
@@ -580,7 +582,23 @@ int excluded_from_list(const char *pathname,
 		}
 
 		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
-			return to_exclude;
+			return x;
+	}
+	return NULL; /* undecided */
+}
+
+/*
+ * Scan the list and let the last match determine the fate.
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int excluded_from_list(const char *pathname,
+		       int pathlen, const char *basename, int *dtype,
+		       struct exclude_list *el)
+{
+	struct exclude *exclude;
+	exclude = excluded_from_list_1(pathname, pathlen, basename, dtype, el);
+	if (exclude) {
+		return exclude->to_exclude;
 	}
 	return -1; /* undecided */
 }
-- 
1.7.12.155.ge5750d5.dirty

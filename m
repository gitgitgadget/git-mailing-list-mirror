From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 07/19] dir.c: refactor is_excluded_from_list()
Date: Thu, 27 Dec 2012 02:32:26 +0000
Message-ID: <1356575558-2674-8-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hf-0006Tl-SF
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab2L0Ccr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:47 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53764 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2L0Cco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:44 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id EA22D2E5E4
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:43 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212171>

The excluded function uses a new helper function called
last_exclude_matching_from_list() to perform the inner loop over all of
the exclude patterns.  The helper just tells us whether the path is
included, excluded, or undecided.

However, it may be useful to know _which_ pattern was triggered.  So
let's pass out the entire exclude match, which contains the status
information we were already passing out.

Further patches can make use of this.

This is a modified forward port of a patch from 2009 by Jeff King:
http://article.gmane.org/gmane.comp.version-control.git/108815

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 8c99dc4..d1a0413 100644
--- a/dir.c
+++ b/dir.c
@@ -602,22 +602,26 @@ int match_pathname(const char *pathname, int pathlen,
 	return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
 }
 
-/* Scan the list and let the last match determine the fate.
- * Return 1 for exclude, 0 for include and -1 for undecided.
+/*
+ * Scan the given exclude list in reverse to see whether pathname
+ * should be ignored.  The first match (i.e. the last on the list), if
+ * any, determines the fate.  Returns the exclude_list element which
+ * matched, or NULL for undecided.
  */
-int is_excluded_from_list(const char *pathname,
-			  int pathlen, const char *basename, int *dtype,
-			  struct exclude_list *el)
+static struct exclude *last_exclude_matching_from_list(const char *pathname,
+						       int pathlen,
+						       const char *basename,
+						       int *dtype,
+						       struct exclude_list *el)
 {
 	int i;
 
 	if (!el->nr)
-		return -1;	/* undefined */
+		return NULL;	/* undefined */
 
 	for (i = el->nr - 1; 0 <= i; i--) {
 		struct exclude *x = el->excludes[i];
 		const char *exclude = x->pattern;
-		int to_exclude = x->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 		int prefix = x->nowildcardlen;
 
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
@@ -632,7 +636,7 @@ int is_excluded_from_list(const char *pathname,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, x->patternlen,
 					   x->flags))
-				return to_exclude;
+				return x;
 			continue;
 		}
 
@@ -640,8 +644,23 @@ int is_excluded_from_list(const char *pathname,
 		if (match_pathname(pathname, pathlen,
 				   x->base, x->baselen ? x->baselen - 1 : 0,
 				   exclude, prefix, x->patternlen, x->flags))
-			return to_exclude;
+			return x;
 	}
+	return NULL; /* undecided */
+}
+
+/*
+ * Scan the list and let the last match determine the fate.
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int is_excluded_from_list(const char *pathname,
+			  int pathlen, const char *basename, int *dtype,
+			  struct exclude_list *el)
+{
+	struct exclude *exclude;
+	exclude = last_exclude_matching_from_list(pathname, pathlen, basename, dtype, el);
+	if (exclude)
+		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
 }
 
-- 
1.7.11.2.249.g31c7954

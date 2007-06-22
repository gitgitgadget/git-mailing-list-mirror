From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 02:14:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706220214250.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 03:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Xjk-0002mY-4H
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 03:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbXFVBOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 21:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXFVBOu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 21:14:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:33345 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750824AbXFVBOt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 21:14:49 -0400
Received: (qmail invoked by alias); 22 Jun 2007 01:14:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 22 Jun 2007 03:14:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZQdolUrVZRbtdJQVcPUwvsyFsxtkx/IM0TVzXWO
	1lKh4bt3cCc9UR
X-X-Sender: gene099@racer.site
In-Reply-To: <20070621131915.GD4487@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50662>

Hi,

On Thu, 21 Jun 2007, Jeff King wrote:

> I think something like a Levenshtein distance between the full pathnames 
> would give good results, and would cover almost every situation that the 
> basename heuristic would (there are a few exceptions, like getting 
> "file.c" from either "file2.c" or "foo/file.c", but that seems kind of 
> pathological).

Well, now you only have to test if it makes sense:

-- snipsnap --
[PATCH] diffcore-rename: replace basename_same() heuristics by Levenshtein

Instead of insisting on identical basenames, try the levenshtein
distance.

Basically, if there are multiple rename source candidates, take the
one with the smallest Levenshtein distance.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The dangerous thing is that the score can get negative now.

 Makefile          |    4 ++--
 diffcore-rename.c |   42 +++++++++++++++---------------------------
 levenshtein.c     |   39 +++++++++++++++++++++++++++++++++++++++
 levenshtein.h     |    6 ++++++
 4 files changed, 62 insertions(+), 29 deletions(-)
 create mode 100644 levenshtein.c
 create mode 100644 levenshtein.h

diff --git a/Makefile b/Makefile
index 74b69fb..e015833 100644
--- a/Makefile
+++ b/Makefile
@@ -303,12 +303,12 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h
+	mailmap.h remote.h levenshtein.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
 	diffcore-pickaxe.o diffcore-rename.o tree-diff.o combine-diff.o \
-	diffcore-delta.o log-tree.o
+	diffcore-delta.o log-tree.o levenshtein.o
 
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 79c984c..41448c9 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "levenshtein.h"
 
 /* Table of rename/copy destinations */
 
@@ -119,21 +120,6 @@ static int is_exact_match(struct diff_filespec *src,
 	return 0;
 }
 
-static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
-{
-	int src_len = strlen(src->path), dst_len = strlen(dst->path);
-	while (src_len && dst_len) {
-		char c1 = src->path[--src_len];
-		char c2 = dst->path[--dst_len];
-		if (c1 != c2)
-			return 0;
-		if (c1 == '/')
-			return 1;
-	}
-	return (!src_len || src->path[src_len - 1] == '/') &&
-		(!dst_len || dst->path[dst_len - 1] == '/');
-}
-
 struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
@@ -201,11 +187,9 @@ static int estimate_similarity(struct diff_filespec *src,
 	 */
 	if (!dst->size)
 		score = 0; /* should not happen */
-	else {
-		score = (int)(src_copied * MAX_SCORE / max_size);
-		if (basename_same(src, dst))
-			score++;
-	}
+	else
+		score = (int)(src_copied * MAX_SCORE / max_size)
+			- levenshtein(src->path, dst->path);
 	return score;
 }
 
@@ -313,20 +297,24 @@ void diffcore_rename(struct diff_options *options)
 			if (rename_dst[i].pair)
 				continue; /* dealt with an earlier round */
 			for (j = 0; j < rename_src_nr; j++) {
-				int k;
+				int k, distance;
 				struct diff_filespec *one = rename_src[j].one;
 				if (!is_exact_match(one, two, contents_too))
 					continue;
 
+				distance = levenshtein(one->path, two->path);
 				/* see if there is a basename match, too */
 				for (k = j; k < rename_src_nr; k++) {
+					int d2;
 					one = rename_src[k].one;
-					if (basename_same(one, two) &&
-						is_exact_match(one, two,
-							contents_too)) {
-						j = k;
-						break;
-					}
+					if (!is_exact_match(one, two,
+								contents_too))
+						continue;
+					d2 = levenshtein(one->path, two->path);
+					if (d2 > distance)
+						continue;
+					distance = d2;
+					j = k;
 				}
 
 				record_rename_pair(i, j, (int)MAX_SCORE);
diff --git a/levenshtein.c b/levenshtein.c
new file mode 100644
index 0000000..80ef860
--- /dev/null
+++ b/levenshtein.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "levenshtein.h"
+
+int levenshtein(const char *string1, const char *string2)
+{
+	int len1 = strlen(string1), len2 = strlen(string2);
+	int *row1 = xmalloc(sizeof(int) * (len2 + 1));
+	int *row2 = xmalloc(sizeof(int) * (len2 + 1));
+	int i, j;
+
+	for (j = 1; j <= len2; j++)
+		row1[j] = j;
+	for (i = 0; i < len1; i++) {
+		int *dummy;
+
+		row2[0] = i + 1;
+		for (j = 0; j < len2; j++) {
+			/* substitution */
+			row2[j + 1] = row1[j] + (string1[i] != string2[j]);
+			/* insertion */
+			if (row2[j + 1] > row1[j + 1] + 1)
+				row2[j + 1] = row1[j + 1] + 1;
+			/* deletion */
+			if (row2[j + 1] > row2[j] + 1)
+				row2[j + 1] = row2[j] + 1;
+		}
+
+		dummy = row1;
+		row1 = row2;
+		row2 = dummy;
+	}
+
+	i = row1[len2];
+	free(row1);
+	free(row2);
+
+	return i;
+}
+
diff --git a/levenshtein.h b/levenshtein.h
new file mode 100644
index 0000000..74a6626
--- /dev/null
+++ b/levenshtein.h
@@ -0,0 +1,6 @@
+#ifndef LEVENSHTEIN_H
+#define LEVENSHTEIN_H
+
+int levenshtein(const char *string1, const char *string2);
+
+#endif
-- 
1.5.2.2.2822.g027a6-dirty

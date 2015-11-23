From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] merge-file: consider core.crlf when writing merge markers
Date: Mon, 23 Nov 2015 22:32:12 +0100
Message-ID: <1448314332-15581-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 22:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0ysU-0000UR-AT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 22:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbbKWVmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 16:42:22 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:58084 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbbKWVmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 16:42:21 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2015 16:42:20 EST
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 84608C3442;
	Mon, 23 Nov 2015 22:32:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 66C67C343E;
	Mon, 23 Nov 2015 22:32:24 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
	id 2D49E1FF86; Mon, 23 Nov 2015 22:32:24 +0100 (CET)
X-Mailer: git-send-email 2.6.2.440.g063f640
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281600>

When merging files in repos with core.eol = crlf, git merge-file inserts
just a LF at the end of the merge markers. Files with mixed line endings
cause trouble in Windows editors and e.g. contrib/git-jump, where an
unmerged file in a run of "git jump merge" is reported as simply "binary
file matches".

Fixing this improves Git's behavior under Windows.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-file.c  |  1 +
 ll-merge.c            |  1 +
 t/t6023-merge-file.sh |  7 +++++++
 xdiff/xdiff.h         |  1 +
 xdiff/xmerge.c        | 29 +++++++++++++++++++----------
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 5544705..c534c91 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -81,6 +81,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 					argv[i]);
 	}
 
+	xmp.crlf = (core_eol == EOL_CRLF);
 	xmp.ancestor = names[1];
 	xmp.file1 = names[0];
 	xmp.file2 = names[2];
diff --git a/ll-merge.c b/ll-merge.c
index 0338630..a548a29 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -111,6 +111,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;
+	xmp.crlf = (core_eol == EOL_CRLF);
 	xmp.ancestor = orig_name;
 	xmp.file1 = name1;
 	xmp.file2 = name2;
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 190ee90..245359a 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -346,4 +346,11 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
 	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
 	 test_cmp expect.txt output.txt'
 
+
+test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
+	test_must_fail git -c core.eol=crlf merge-file -p \
+		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
+'
+
 test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c033991..a5bea4a 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -122,6 +122,7 @@ typedef struct s_xmparam {
 	int level;
 	int favor;
 	int style;
+	int crlf;
 	const char *ancestor;	/* label for orig */
 	const char *file1;	/* label for mf1 */
 	const char *file2;	/* label for mf2 */
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 625198e..4ff0db4 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -146,7 +146,7 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      xdfenv_t *xe2, const char *name2,
 			      const char *name3,
-			      int size, int i, int style,
+			      int size, int i, int style, int crlf,
 			      xdmerge_t *m, char *dest, int marker_size)
 {
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
@@ -161,7 +161,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      dest ? dest + size : NULL);
 
 	if (!dest) {
-		size += marker_size + 1 + marker1_size;
+		size += marker_size + 1 + crlf + marker1_size;
 	} else {
 		memset(dest + size, '<', marker_size);
 		size += marker_size;
@@ -170,6 +170,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			memcpy(dest + size + 1, name1, marker1_size - 1);
 			size += marker1_size;
 		}
+		if (crlf)
+			dest[size++] = '\r';
 		dest[size++] = '\n';
 	}
 
@@ -180,7 +182,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (style == XDL_MERGE_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
-			size += marker_size + 1 + marker3_size;
+			size += marker_size + 1 + crlf + marker3_size;
 		} else {
 			memset(dest + size, '|', marker_size);
 			size += marker_size;
@@ -189,6 +191,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 				memcpy(dest + size + 1, name3, marker3_size - 1);
 				size += marker3_size;
 			}
+			if (crlf)
+				dest[size++] = '\r';
 			dest[size++] = '\n';
 		}
 		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
@@ -196,10 +200,12 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	}
 
 	if (!dest) {
-		size += marker_size + 1;
+		size += marker_size + 1 + crlf;
 	} else {
 		memset(dest + size, '=', marker_size);
 		size += marker_size;
+		if (crlf)
+			dest[size++] = '\r';
 		dest[size++] = '\n';
 	}
 
@@ -207,7 +213,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
 			      dest ? dest + size : NULL);
 	if (!dest) {
-		size += marker_size + 1 + marker2_size;
+		size += marker_size + 1 + crlf + marker2_size;
 	} else {
 		memset(dest + size, '>', marker_size);
 		size += marker_size;
@@ -216,6 +222,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			memcpy(dest + size + 1, name2, marker2_size - 1);
 			size += marker2_size;
 		}
+		if (crlf)
+			dest[size++] = '\r';
 		dest[size++] = '\n';
 	}
 	return size;
@@ -226,7 +234,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 				 const char *ancestor_name,
 				 int favor,
 				 xdmerge_t *m, char *dest, int style,
-				 int marker_size)
+				 int crlf, int marker_size)
 {
 	int size, i;
 
@@ -237,8 +245,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 		if (m->mode == 0)
 			size = fill_conflict_hunk(xe1, name1, xe2, name2,
 						  ancestor_name,
-						  size, i, style, m, dest,
-						  marker_size);
+						  size, i, style, crlf, m,
+						  dest, marker_size);
 		else if (m->mode & 3) {
 			/* Before conflicting part */
 			size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
@@ -419,6 +427,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int level = xmp->level;
 	int style = xmp->style;
 	int favor = xmp->favor;
+	int crlf = xmp->crlf;
 
 	if (style == XDL_MERGE_DIFF3) {
 		/*
@@ -554,7 +563,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
 						 ancestor_name,
 						 favor, changes, NULL, style,
-						 marker_size);
+						 crlf, marker_size);
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
@@ -563,7 +572,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		result->size = size;
 		xdl_fill_merge_buffer(xe1, name1, xe2, name2,
 				      ancestor_name, favor, changes,
-				      result->ptr, style, marker_size);
+				      result->ptr, style, crlf, marker_size);
 	}
 	return xdl_cleanup_merge(changes);
 }
-- 
2.6.2.440.g063f640

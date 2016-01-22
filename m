From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Fri, 22 Jan 2016 18:01:25 +0100 (CET)
Message-ID: <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:01:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMf5c-0003qV-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbcAVRBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:01:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:60160 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373AbcAVRBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:01:30 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJmcS-1aNlY23YRA-0016ui; Fri, 22 Jan 2016 18:01:26
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453482052.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:WLCM6UcRRWHqwYfonNMJffnu25U4sDok6dkW/3Of25lnrRI/aMh
 ON88HKjN5tZyGCBlNi82drpQlWGDeQANh7rtWiV0UITYHgncqEiEl3I8YG/Lnvrrb/p+UUJ
 H5qb2HI9ImvVIOZlMuvpO9/e4RtTWjgmnoE52HnKvHYKRPzMboS0Rq+Ji64vgKXJmlO4eDa
 vAsA8NAbQKzhhSlMo3YCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2fGyum3XBto=:ML1RphUdYz2jYq0dtkN2pY
 YP1lGstxI1g5MFD2Yb2k3S6QM4DSKe5Va4xtWyQ7kxzkslxZ+URORj3Wq7LxJB06T5mNMZdc1
 ZObtffAKM2yiBlkwMSmPdMy6+0+cdwuD5gsMF1Q8df1k6dj+TkZGPzJ8zF6dh3T2eBCaCGgTm
 6QI3npplOoEGlgzyUI/gDC6YgnqKoYpsq/4Cd8N37ONJ6rk4Xzmt9gyx1xqppL8PhYXV/GMq+
 aUKg/RWyI5BVxjVD2XqbTPBkl2nL9uRWywbeIySoi3tjBz/8hYCAe/6xKX5ZWImcdLiGFTX3P
 +Bgqix92nUCd4roK+vf2BdhnKy+7GElbciCIhCpnpe+ESdGQAa20+nEzb/RB1oQFWd6z318X/
 jau61OQM/N4RqB6JoWqYfHg5suQL6Jxpp0DaOt6gPHo2J8+bcN48cpcu4GPeuVHe0M13w06LT
 lYrOozpv4nfYlZppdb2DoCmcPUkSYWk4Y8MFwkm96D4PV0KJbCXPvJzbEwuVjiPfJ3eCLOfsQ
 d1Edy0N+PJXbndUC9GYXCBSXa24G4RrG3SUWgX9SuDhtInF+f/YA81PhV1j/kIuRq0h0U7AKb
 t0ExAlVFynreKcQnHCEf3cHVsIAwLYlXXqhIZyKAwPwE6FkKIeTTW9OOVravKah0wnbmiP0qD
 j9hQdNuBsGteeHfri3Mn4cwOdCpPlZ22uTLiCwRYHLLsO0DfPPw9cHnUz6I//pD3QxbOJ603g
 k6+XNPe9/BRTUh5lklo1YxFY/OXkIoMIjXyYRSChIwPBllEFNtUfgLllUebeIlvFL9EBWx4m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284565>

From: Beat Bolli <dev+git@drbeat.li>

When merging files in repos with core.eol = crlf, git merge-file inserts
just a LF at the end of the merge markers. Files with mixed line endings
cause trouble in Windows editors and e.g. contrib/git-jump, where an
unmerged file in a run of "git jump merge" is reported as simply "binary
file matches".

Fixing this improves merge-file's behavior under Windows.

The original version of this patch also modified ll_merge(), but that
was incorrect: low-level merge operates on blobs, not on working files.
Therefore, the data passed to the low-level merge, as well as its
result, is expected to have LF-only line endings.

It is the duty of ll_merge()'s *caller* (in case of Git's `merge`
command, the merge_content() function) to convert the merge result into
the correct working file contents, and ll_merge() should not muck with
line endings at all.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-file.c  |  1 +
 t/t6023-merge-file.sh | 14 ++++++++++++++
 xdiff/xdiff.h         |  1 +
 xdiff/xmerge.c        | 29 +++++++++++++++++++----------
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 5544705..9ce830a 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -81,6 +81,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 					argv[i]);
 	}
 
+	xmp.crlf = eol_for_path(names[0], NULL, 0) == EOL_CRLF;
 	xmp.ancestor = names[1];
 	xmp.file1 = names[0];
 	xmp.file2 = names[2];
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 190ee90..a131749 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -346,4 +346,18 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
 	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
 	 test_cmp expect.txt output.txt'
 
+test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
+	test_must_fail git -c core.eol=crlf merge-file -p \
+		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
+'
+
+test_expect_success 'conflict markers heed gitattributes over core.eol=crlf' '
+	git config core.eol crlf &&
+	echo "*.txt eol=lf" >>.gitattributes &&
+	test_must_fail git -c core.eol=crlf merge-file -p \
+		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 0
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
2.7.0.windows.1.7.g55a05c8

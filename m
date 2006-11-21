X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: (unknown)
Date: Tue, 21 Nov 2006 23:24:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611212316080.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 22:24:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32046>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gme2j-00081h-E2 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031239AbWKUWYh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031172AbWKUWYh
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:24:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:42982 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030994AbWKUWYg (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:24:36 -0500
Received: (qmail invoked by alias); 21 Nov 2006 22:24:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 21 Nov 2006 23:24:34 +0100
To: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

[PATCH] xdiff: add xdl_merge()

This new function implements the functionality of RCS merge, but
in-memory. It returns < 0 on error, otherwise the number of conflicts.

Finding the conflicting lines can be a very expensive task. You can
control the eagerness of this algorithm:

- a level value of 0 means that all overlapping changes are treated
  as conflicts,
- a value of 1 means that if the overlapping changes are identical,
  it is not treated as a conflict.
- If you set level to 2, overlapping changes will be analyzed, so that
  almost identical changes will not result in huge conflicts. Rather,
  only the conflicting lines will be shown inside conflict markers.

With each increasing level, the algorithm gets slower, but more accurate.
Note that the code for level 2 depends on the simple definition of
mmfile_t specific to git, and therefore it will be harder to port that
to LibXDiff.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This code is only lightly tested, but I am tired and hungry.

	My hopes are that when I wake up in the morning, all bugs are
	fixed, git-merge-one-file is rewritten as a builtin,
	git-merge-index defaults to calling xdl_merge() directly when
	no program is passed with "-o", and git-merge-recursive also
	avoids fork()ing RCS' merge.

	A funny side effect is that you can merge with white space
	corruption by setting the xpparam flags to ignore whitespace.
	The file passed as mf1 wins over mf2 in that case.

	Oh, and maybe I did not need to use xdl_change_compact() (and
	thus could have left that static to xdiffi.c)? Davide, if you 
	could enlighten me, I will take the time next weekend to port this 
	to LibXDiff ;-)

	BTW if anybody wonders why these diffstats do not look correct:
	"git apply --stat" does not yet have our new scaling...

 Makefile       |    3 
 xdiff/xdiff.h  |    7 +
 xdiff/xdiffi.c |    3 
 xdiff/xdiffi.h |    1 
 xdiff/xmerge.c |  433 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 444 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4c3f87f..b10d65e 100644
--- a/Makefile
+++ b/Makefile
@@ -769,7 +769,8 @@ $(DIFF_OBJS): diffcore.h
 $(LIB_FILE): $(LIB_OBJS)
 	rm -f $@ && $(AR) rcs $@ $(LIB_OBJS)
 
-XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o
+XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
+	xdiff/xmerge.o
 $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c9f8178..fa409d5 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -49,6 +49,9 @@ extern "C" {
 #define XDL_BDOP_CPY 2
 #define XDL_BDOP_INSB 3
 
+#define XDL_MERGE_MINIMAL 0
+#define XDL_MERGE_EAGER 1
+#define XDL_MERGE_ZEALOUS 2
 
 typedef struct s_mmfile {
 	char *ptr;
@@ -90,6 +93,10 @@ long xdl_mmfile_size(mmfile_t *mmf);
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 
+int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
+		mmfile_t *mf2, const char *name2,
+		xpparam_t const *xpp, int level, mmbuffer_t *result);
+
 #ifdef __cplusplus
 }
 #endif /* #ifdef __cplusplus */
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index d76e76a..9aeebc4 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -45,7 +45,6 @@ static long xdl_split(unsigned long cons
 		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
 		      xdalgoenv_t *xenv);
 static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2);
-static int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags);
 
 
 
@@ -397,7 +396,7 @@ static xdchange_t *xdl_add_change(xdchan
 }
 
 
-static int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
+int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
 	xrecord_t **recs = xdf->recs;
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index d3b7271..472aeae 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -50,6 +50,7 @@ int xdl_recs_cmp(diffdata_t *dd1, long o
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
 int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *xe);
+int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags);
 int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr);
 void xdl_free_script(xdchange_t *xscr);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
new file mode 100644
index 0000000..7b85aa5
--- /dev/null
+++ b/xdiff/xmerge.c
@@ -0,0 +1,433 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003-2006 Davide Libenzi, Johannes E. Schindelin
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Davide Libenzi <davidel@xmailserver.org>
+ *
+ */
+
+#include "xinclude.h"
+
+typedef struct s_xdmerge {
+	struct s_xdmerge *next;
+	/*
+	 * 0 = conflict,
+	 * 1 = no conflict, take first,
+	 * 2 = no conflict, take second.
+	 */
+	int mode;
+	long i1, i2;
+	long chg1, chg2;
+} xdmerge_t;
+
+static int xdl_append_merge(xdmerge_t **merge, int mode,
+		long i1, long chg1, long i2, long chg2)
+{
+	xdmerge_t *m = *merge;
+	if (m && mode == m->mode &&
+			(i1 == m->i1 + m->chg1 || i2 == m->i2 + m->chg2)) {
+		m->chg1 = i1 + chg1 - m->i1;
+		m->chg2 = i2 + chg2 - m->i2;
+	} else {
+		m = xdl_malloc(sizeof(xdmerge_t));
+		if (!m)
+			return -1;
+		m->next = NULL;
+		m->mode = mode;
+		m->i1 = i1;
+		m->chg1 = chg1;
+		m->i2 = i2;
+		m->chg2 = chg2;
+		if (*merge)
+			(*merge)->next = m;
+		*merge = m;
+	}
+	return 0;
+}
+
+static int xdl_cleanup_merge(xdmerge_t *c)
+{
+	int count = 0;
+	xdmerge_t *next_c;
+
+	/* were there conflicts? */
+	for (; c; c = next_c) {
+		if (c->mode == 0)
+			count++;
+		next_c = c->next;
+		free(c);
+	}
+	return count;
+}
+
+static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
+		int line_count, long flags)
+{
+	int i;
+	xrecord_t **rec1 = xe1->xdf2.recs + i1;
+	xrecord_t **rec2 = xe2->xdf2.recs + i2;
+
+	for (i = 0; i < line_count; i++) {
+		int result = xdl_recmatch(rec1[i]->ptr, rec1[i]->size,
+			rec2[i]->ptr, rec2[i]->size, flags);
+		if (!result)
+			return -1;
+	}
+	return 0;
+}
+
+static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
+{
+	xrecord_t **recs = xe->xdf2.recs + i;
+	int size = 0;
+
+	if (count < 1)
+		return 0;
+
+	for (i = 0; i < count; size += recs[i++]->size)
+		if (dest)
+			memcpy(dest + size, recs[i]->ptr, recs[i]->size);
+	if (add_nl) {
+		i = recs[count - 1]->size;
+		if (i == 0 || recs[count - 1]->ptr[i - 1] != '\n') {
+			if (dest)
+				dest[size] = '\n';
+			size++;
+		}
+	}
+	return size;
+}
+
+static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
+		xdfenv_t *xe2, const char *name2, xdmerge_t *m, char *dest)
+{
+	const int marker_size = 7;
+	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
+	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
+	int conflict_marker_size = 3 * (marker_size + 1)
+		+ marker1_size + marker2_size;
+	int size, i1, j;
+
+	for (size = i1 = 0; m; m = m->next) {
+		if (m->mode == 0) {
+			size += xdl_recs_copy(xe1, i1, m->i1 - i1, 0,
+					dest ? dest + size : NULL);
+			if (dest) {
+				for (j = 0; j < marker_size; j++)
+					dest[size++] = '<';
+				if (marker1_size) {
+					dest[size] = ' ';
+					memcpy(dest + size + 1, name1,
+							marker1_size - 1);
+					size += marker1_size;
+				}
+				dest[size++] = '\n';
+			} else
+				size += conflict_marker_size;
+			size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
+					dest ? dest + size : NULL);
+			if (dest) {
+				for (j = 0; j < marker_size; j++)
+					dest[size++] = '=';
+				dest[size++] = '\n';
+			}
+			size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
+					dest ? dest + size : NULL);
+			if (dest) {
+				for (j = 0; j < marker_size; j++)
+					dest[size++] = '>';
+				if (marker2_size) {
+					dest[size] = ' ';
+					memcpy(dest + size + 1, name2,
+							marker2_size - 1);
+					size += marker2_size;
+				}
+				dest[size++] = '\n';
+			}
+		} else if (m->mode == 1)
+			size += xdl_recs_copy(xe1, i1, m->i1 + m->chg1 - i1, 0,
+					dest ? dest + size : NULL);
+		else if (m->mode == 2)
+			size += xdl_recs_copy(xe2, m->i2 - m->i1 + i1,
+					m->i1 + m->chg2 - i1, 0,
+					dest ? dest + size : NULL);
+		i1 = m->i1 + m->chg1;
+	}
+	size += xdl_recs_copy(xe1, i1, xe1->xdf2.nrec - i1, 0,
+			dest ? dest + size : NULL);
+	return size;
+}
+
+/*
+ * Sometimes, changes are not quite identical, but differ in only a few
+ * lines. Try hard to show only these few lines as conflicting.
+ */
+static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
+		xpparam_t const *xpp)
+{
+	for (; m; m = m->next) {
+		mmfile_t t1, t2;
+		xdfenv_t xe;
+		xdchange_t *xscr, *x;
+		int i1 = m->i1, i2 = m->i2;
+
+		/* let's handle just the conflicts */
+		if (m->mode)
+			continue;
+
+		/*
+		 * This probably does not work outside git, since
+		 * we have a very simple mmfile structure.
+		 */
+		t1.ptr = (char *)xe1->xdf2.recs[m->i1]->ptr;
+		t1.size = xe1->xdf2.recs[m->i1 + m->chg1]->ptr
+			+ xe1->xdf2.recs[m->i1 + m->chg1]->size - t1.ptr;
+		t2.ptr = (char *)xe2->xdf2.recs[m->i1]->ptr;
+		t2.size = xe2->xdf2.recs[m->i1 + m->chg1]->ptr
+			+ xe2->xdf2.recs[m->i1 + m->chg1]->size - t2.ptr;
+		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
+			return -1;
+		if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
+		    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
+		    xdl_build_script(&xe, &xscr) < 0) {
+			xdl_free_env(&xe);
+			return -1;
+		}
+		if (!xscr) {
+			/* If this happens, it's a bug. */
+			xdl_free_env(&xe);
+			return -2;
+		}
+		x = xscr;
+		m->i1 = xscr->i1 + i1;
+		m->chg1 = xscr->chg1;
+		m->i2 = xscr->i2 + i2;
+		m->chg2 = xscr->chg2;
+		while (xscr->next) {
+			xdmerge_t *m2 = xdl_malloc(sizeof(xdmerge_t));
+			if (!m2) {
+				xdl_free_env(&xe);
+				xdl_free_script(x);
+				return -1;
+			}
+			xscr = xscr->next;
+			m2->next = m->next;
+			m->next = m2;
+			m = m2;
+			m->mode = 0;
+			m->i1 = xscr->i1 + i1;
+			m->chg1 = xscr->chg1;
+			m->i2 = xscr->i2 + i2;
+			m->chg2 = xscr->chg2;
+		}
+		xdl_free_env(&xe);
+		xdl_free_script(x);
+	}
+	return 0;
+}
+
+/*
+ * level == 0: mark all overlapping changes as conflict
+ * level == 1: mark overlapping changes as conflict only if not identical
+ * level == 2: analyze non-identical changes for minimal conflict set
+ *
+ * returns < 0 on error, == 0 for no conflicts, else number of conflicts
+ */
+static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
+		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
+		int level, xpparam_t const *xpp, mmbuffer_t *result) {
+	xdmerge_t *changes, *c;
+	int i1, i2, chg1, chg2;
+
+	c = changes = NULL;
+
+	while (xscr1 && xscr2) {
+		if (!changes)
+			changes = c;
+		if (xscr1->i1 + xscr1->chg1 < xscr2->i1) {
+			i1 = xscr1->i2;
+			i2 = xscr2->i2 - xscr2->i1 + xscr1->i1;
+			chg1 = xscr1->chg2;
+			chg2 = xscr1->chg1;
+			if (xdl_append_merge(&c, 1, i1, chg1, i2, chg2)) {
+				xdl_cleanup_merge(changes);
+				return -1;
+			}
+			xscr1 = xscr1->next;
+			continue;
+		}
+		if (xscr2->i1 + xscr2->chg1 < xscr1->i1) {
+			i1 = xscr1->i2 - xscr1->i1 + xscr2->i1;
+			i2 = xscr2->i2;
+			chg1 = xscr2->chg1;
+			chg2 = xscr2->chg2;
+			if (xdl_append_merge(&c, 2, i1, chg1, i2, chg2)) {
+				xdl_cleanup_merge(changes);
+				return -1;
+			}
+			xscr2 = xscr2->next;
+			continue;
+		}
+		if (level < 1 || xscr1->i1 != xscr2->i1 ||
+				xscr1->chg1 != xscr2->chg1 ||
+				xscr1->chg2 != xscr2->chg2 ||
+				xdl_merge_cmp_lines(xe1, xscr1->i2,
+					xe2, xscr2->i2,
+					xscr1->chg2, xpp->flags)) {
+			/* conflict */
+			int off = xscr1->i1 - xscr2->i1;
+			int ffo = off + xscr1->chg1 - xscr2->chg1;
+
+			i1 = xscr1->i2;
+			i2 = xscr2->i2;
+			if (off > 0)
+				i1 -= off;
+			else
+				i2 += off;
+			chg1 = xscr1->i2 + xscr1->chg2 - i1;
+			chg2 = xscr2->i2 + xscr2->chg2 - i2;
+			if (ffo > 0)
+				chg2 += ffo;
+			else
+				chg1 -= ffo;
+			if (xdl_append_merge(&c, 0, i1, chg1, i2, chg2)) {
+				xdl_cleanup_merge(changes);
+				return -1;
+			}
+		}
+
+		i1 = xscr1->i1 + xscr1->chg1;
+		i2 = xscr2->i1 + xscr2->chg1;
+
+		if (i1 > i2) {
+			xscr1->chg1 -= i1 - i2;
+			xscr1->i1 = i2;
+			xscr1->i2 += xscr1->chg2;
+			xscr1->chg2 = 0;
+			xscr1 = xscr1->next;
+		} else if (i2 > i1) {
+			xscr2->chg1 -= i2 - i1;
+			xscr2->i1 = i1;
+			xscr2->i2 += xscr2->chg2;
+			xscr2->chg2 = 0;
+			xscr2 = xscr2->next;
+		} else {
+			xscr1 = xscr1->next;
+			xscr2 = xscr2->next;
+		}
+	}
+	while (xscr1) {
+		if (!changes)
+			changes = c;
+		i1 = xscr1->i2;
+		i2 = xscr1->i1 + xe2->xdf2.nrec - xe2->xdf1.nrec;
+		chg1 = xscr1->chg2;
+		chg2 = xscr1->chg1;
+		if (xdl_append_merge(&c, 1, i1, chg1, i2, chg2)) {
+			xdl_cleanup_merge(changes);
+			return -1;
+		}
+		xscr1 = xscr1->next;
+	}
+	while (xscr2) {
+		if (!changes)
+			changes = c;
+		i1 = xscr2->i1 + xe1->xdf2.nrec - xe1->xdf1.nrec;
+		i2 = xscr2->i2;
+		chg1 = xscr2->chg1;
+		chg2 = xscr2->chg2;
+		if (xdl_append_merge(&c, 2, i1, chg1, i2, chg2)) {
+			xdl_cleanup_merge(changes);
+			return -1;
+		}
+		xscr2 = xscr2->next;
+	}
+	if (!changes)
+		changes = c;
+	/* refine conflicts */
+	if (level > 1 && xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0) {
+		xdl_cleanup_merge(changes);
+		return -1;
+	}
+	/* output */
+	if (result) {
+		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
+			changes, NULL);
+		result->ptr = xdl_malloc(size);
+		if (!result->ptr) {
+			xdl_cleanup_merge(changes);
+			return -1;
+		}
+		result->size = size;
+		xdl_fill_merge_buffer(xe1, name1, xe2, name2, changes,
+				result->ptr);
+	}
+	return xdl_cleanup_merge(changes);
+}
+
+int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
+		mmfile_t *mf2, const char *name2,
+		xpparam_t const *xpp, int level, mmbuffer_t *result) {
+	xdchange_t *xscr1, *xscr2;
+	xdfenv_t xe1, xe2;
+
+	result->ptr = NULL;
+	result->size = 0;
+
+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0 ||
+			xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
+		return -1;
+	}
+	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
+	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
+	    xdl_build_script(&xe1, &xscr1) < 0) {
+		xdl_free_env(&xe1);
+		return -1;
+	}
+	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
+	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
+	    xdl_build_script(&xe2, &xscr2) < 0) {
+		xdl_free_env(&xe2);
+		return -1;
+	}
+	if (xscr1 || xscr2) {
+		if (!xscr1) {
+			result->ptr = xdl_malloc(mf2->size);
+			memcpy(result->ptr, mf2->ptr, mf2->size);
+			result->size = mf2->size;
+		} else if (!xscr2) {
+			result->ptr = xdl_malloc(mf1->size);
+			memcpy(result->ptr, mf1->ptr, mf1->size);
+			result->size = mf1->size;
+		} else if (xdl_do_merge(&xe1, xscr1, name1,
+					&xe2, xscr2, name2,
+					level, xpp, result) < 0) {
+			xdl_free_script(xscr1);
+			xdl_free_script(xscr2);
+			xdl_free_env(&xe1);
+			xdl_free_env(&xe2);
+			return -1;
+		}
+		xdl_free_script(xscr1);
+		xdl_free_script(xscr2);
+	}
+	xdl_free_env(&xe1);
+	xdl_free_env(&xe2);
+
+	return 0;
+}

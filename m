From: Linus Torvalds <torvalds@osdl.org>
Subject: Use a *real* built-in diff generator
Date: Fri, 24 Mar 2006 20:13:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 05:13:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN09m-0002dm-FI
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 05:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWCYENh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 23:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWCYENg
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 23:13:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbWCYENe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 23:13:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2P4DODZ016744
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Mar 2006 20:13:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2P4DM1F011323;
	Fri, 24 Mar 2006 20:13:23 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17952>


This uses a simplified libxdiff setup to generate unified diffs _without_ 
doing  fork/execve of GNU "diff".

This has several huge advantages, for example:

Before:

	[torvalds@g5 linux]$ time git diff v2.6.16.. > /dev/null 

	real    0m24.818s
	user    0m13.332s
	sys     0m8.664s

After:

	[torvalds@g5 linux]$ time git diff v2.6.16.. > /dev/null 
	
	real    0m4.563s
	user    0m2.944s
	sys     0m1.580s

and the fact that this should be a lot more portable (ie we can ignore all 
the issues with doing fork/execve under Windows).

Perhaps even more importantly, this allows us to do diffs without actually 
ever writing out the git file contents to a temporary file (and without 
any of the shell quoting issues on filenames etc etc).

NOTE! THIS PATCH DOES NOT DO THAT OPTIMIZATION YET! I was lazy, and the 
current "diff-core" code actually will always write the temp-files, 
because it used to be something that you simply had to do. So this current 
one actually writes a temp-file like before, and then reads it into memory 
again just to do the diff. Stupid.

But if this basic infrastructure is accepted, we can start switching over 
diff-core to not write temp-files, which should speed things up even 
further, especially when doing big tree-to-tree diffs.

Now, in the interest of full disclosure, I should also point out a few 
downsides:

 - the libxdiff algorithm is different, and I bet GNU diff has gotten a 
   lot more testing. And the thing is, generating a diff is not an exact 
   science - you can get two different diffs (and you will), and they can 
   both be perfectly valid. So it's not possible to "validate" the 
   libxdiff output by just comparing it against GNU diff.

 - GNU diff does some nice eye-candy, like trying to figure out what the 
   last function was, and adding that information to the "@@ .." line. 
   libxdiff doesn't do that. 

 - The libxdiff thing has some known deficiencies. In particular, it gets 
   the "\No newline at end of file" case wrong. So this is currently for 
   the experimental branch only. I hope Davide will help fix it.

That said, I think the huge performance advantage, and the fact that it 
integrates better is definitely worth it. But it should go into a 
development branch at least due to the missing newline issue.

Technical note: this is based on libxdiff-0.17, but I did some surgery to 
get rid of the extraneous fat - stuff that git doesn't need, and seriously 
cutting down on mmfile_t, which had much more capabilities than the diff 
algorithm either needed or used. In this version, "mmfile_t" is just a 
trivial <pointer,length> tuple.

That said, I tried to keep the differences to simple removals, so that you 
can do a diff between this and the libxdiff origin, and you'll basically 
see just things getting deleted. Even the mmfile_t simplifications are 
left in a state where the diffs should be readable.

Apologies to Davide, whom I'd love to get feedback on this all from (I 
wrote my own "fill_mmfile()" for the new simpler mmfile_t format: the old 
complex format had a helper function for that, but I did my surgery with 
the goal in mind that eventually we _should_ just do

	mmfile_t mf;

	buf = read_sha1_file(sha1, type, &size);
	mf->ptr = buf;
	mf->size = size;
	.. use "mf" directly ..

which was really a nightmare with the old "helpful" mmfile_t, and really 
is that easy with the new cut-down interfaces).

[ Btw, as any hawk-eye can see from the diff, this was actually generated 
  with itself, so it is "self-hosting". That's about all the testing it 
  has gotten, along with the above kernel diff, which eye-balls correctly, 
  but shows the newline issue when you double-check it with "git-apply" ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----
 Makefile         |   11 +
 diff.c           |   79 ++++++++-
 xdiff/xdiff.h    |   91 ++++++++++
 xdiff/xdiffi.c   |  469 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xdiffi.h   |   60 +++++++
 xdiff/xemit.c    |  141 ++++++++++++++++
 xdiff/xemit.h    |   34 ++++
 xdiff/xinclude.h |   42 +++++
 xdiff/xmacros.h  |   53 ++++++
 xdiff/xprepare.c |  436 ++++++++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xprepare.h |   35 ++++
 xdiff/xtypes.h   |   68 ++++++++
 xdiff/xutils.c   |  265 +++++++++++++++++++++++++++++++
 xdiff/xutils.h   |   44 +++++
 14 files changed, 1820 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 8d45378..0f565eb 100644
--- a/Makefile
+++ b/Makefile
@@ -188,6 +188,7 @@
 	gitMergeCommon.py
 
 LIB_FILE=libgit.a
+XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
 	blob.h cache.h commit.h count-delta.h csum-file.h delta.h \
@@ -209,7 +210,7 @@
 	fetch-clone.o revision.o pager.o \
 	$(DIFF_OBJS)
 
-LIBS = $(LIB_FILE)
+LIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS += -lz
 
 #
@@ -544,11 +545,17 @@
 		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c
 
 $(LIB_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H)
+$(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIBS)
 $(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
+
+XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o
+
+$(XDIFF_LIB): $(XDIFF_OBJS)
+	$(AR) rcs $@ $(XDIFF_OBJS)
+
 
 doc:
 	$(MAKE) -C Documentation all
diff --git a/diff.c b/diff.c
index c0548ee..f6a1f5d 100644
--- a/diff.c
+++ b/diff.c
@@ -8,6 +8,7 @@
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "xdiff/xdiff.h"
 
 static const char *diff_opts = "-pu";
 
@@ -178,6 +179,49 @@
 		copy_file('+', temp[1].name);
 }
 
+static int fill_mmfile(mmfile_t *mf, const char *file)
+{
+	int fd = open(file, O_RDONLY);
+	struct stat st;
+	char *buf;
+	unsigned long size;
+
+	mf->ptr = NULL;
+	mf->size = 0;
+	if (fd < 0)
+		return 0;
+	fstat(fd, &st);
+	size = st.st_size;
+	buf = xmalloc(size);
+	mf->ptr = buf;
+	mf->size = size;
+	while (size) {
+		int retval = read(fd, buf, size);
+		if (retval < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			break;
+		}
+		if (!retval)
+			break;
+		buf += retval;
+		size -= retval;
+	}
+	mf->size -= size;
+	close(fd);
+	return 0;
+}
+
+static int fn_out(void *priv, mmbuffer_t *mb, int nbuf)
+{
+	int i;
+
+	for (i = 0; i < nbuf; i++)
+		if (!fwrite(mb[i].ptr, mb[i].size, 1, stdout))
+			return -1;
+	return 0;
+}
+
 static const char *builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_tempfile *temp,
@@ -186,6 +230,7 @@
 			 const char **args)
 {
 	int i, next_at, cmd_size;
+	mmfile_t mf1, mf2;
 	const char *const diff_cmd = "diff -L%s -L%s";
 	const char *const diff_arg  = "-- %s %s||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
@@ -253,14 +298,36 @@
 			emit_rewrite_diff(name_a, name_b, temp);
 			return NULL;
 		}
+	}
+
+	/* Un-quote the paths */
+	if (label_path[0][0] != '/')
+		label_path[0] = quote_two("a/", name_a);
+	if (label_path[1][0] != '/')
+		label_path[1] = quote_two("b/", name_b);
+
+	printf("--- %s\n", label_path[0]);
+	printf("+++ %s\n", label_path[1]);
+
+	if (fill_mmfile(&mf1, temp[0].name) < 0 ||
+	    fill_mmfile(&mf2, temp[1].name) < 0)
+		die("unable to read files to diff");
+
+	/* Crazy xdl interfaces.. */
+	{
+		xpparam_t xpp;
+		xdemitconf_t xecfg;
+		xdemitcb_t ecb;
+
+		xpp.flags = XDF_NEED_MINIMAL;
+		xecfg.ctxlen = 3;
+		ecb.outf = fn_out;
+		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
 
-	/* This is disgusting */
-	*args++ = "sh";
-	*args++ = "-c";
-	*args++ = cmd;
-	*args = NULL;
-	return "/bin/sh";
+	free(mf1.ptr);
+	free(mf2.ptr);
+	return NULL;
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
new file mode 100644
index 0000000..d900295
--- /dev/null
+++ b/xdiff/xdiff.h
@@ -0,0 +1,91 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XDIFF_H)
+#define XDIFF_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* #ifdef __cplusplus */
+
+
+#define XDF_NEED_MINIMAL (1 << 1)
+
+#define XDL_PATCH_NORMAL '-'
+#define XDL_PATCH_REVERSE '+'
+#define XDL_PATCH_MODEMASK ((1 << 8) - 1)
+#define XDL_PATCH_IGNOREBSPACE (1 << 8)
+	
+#define XDL_MMB_READONLY (1 << 0)
+
+#define XDL_MMF_ATOMIC (1 << 0)
+
+#define XDL_BDOP_INS 1
+#define XDL_BDOP_CPY 2
+#define XDL_BDOP_INSB 3
+
+
+typedef struct s_mmfile {
+	char *ptr;
+	long size;
+} mmfile_t;
+
+typedef struct s_mmbuffer {
+	char *ptr;
+	long size;
+} mmbuffer_t;
+
+typedef struct s_xpparam {
+	unsigned long flags;
+} xpparam_t;
+
+typedef struct s_xdemitcb {
+	void *priv;
+	int (*outf)(void *, mmbuffer_t *, int);
+} xdemitcb_t;
+
+typedef struct s_xdemitconf {
+	long ctxlen;
+} xdemitconf_t;
+
+typedef struct s_bdiffparam {
+	long bsize;
+} bdiffparam_t;
+
+
+#define xdl_malloc(x) malloc(x)
+#define xdl_free(ptr) free(ptr)
+#define xdl_realloc(ptr,x) realloc(ptr,x)
+
+void *xdl_mmfile_first(mmfile_t *mmf, long *size);
+void *xdl_mmfile_next(mmfile_t *mmf, long *size);
+long xdl_mmfile_size(mmfile_t *mmf);
+
+int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+	     xdemitconf_t const *xecfg, xdemitcb_t *ecb);
+
+#ifdef __cplusplus
+}
+#endif /* #ifdef __cplusplus */
+
+#endif /* #if !defined(XDIFF_H) */
+
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
new file mode 100644
index 0000000..8ea0483
--- /dev/null
+++ b/xdiff/xdiffi.c
@@ -0,0 +1,469 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003	Davide Libenzi
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
+
+
+#define XDL_MAX_COST_MIN 256
+#define XDL_HEUR_MIN_COST 256
+#define XDL_LINE_MAX (long)((1UL << (8 * sizeof(long) - 1)) - 1)
+#define XDL_SNAKE_CNT 20
+#define XDL_K_HEUR 4
+
+
+
+typedef struct s_xdpsplit {
+	long i1, i2;
+	int min_lo, min_hi;
+} xdpsplit_t;
+
+
+
+
+static long xdl_split(unsigned long const *ha1, long off1, long lim1,
+		      unsigned long const *ha2, long off2, long lim2,
+		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
+		      xdalgoenv_t *xenv);
+static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2);
+
+
+
+
+/*
+ * See "An O(ND) Difference Algorithm and its Variations", by Eugene Myers.
+ * Basically considers a "box" (off1, off2, lim1, lim2) and scan from both
+ * the forward diagonal starting from (off1, off2) and the backward diagonal
+ * starting from (lim1, lim2). If the K values on the same diagonal crosses
+ * returns the furthest point of reach. We might end up having to expensive
+ * cases using this algorithm is full, so a little bit of heuristic is needed
+ * to cut the search and to return a suboptimal point.
+ */
+static long xdl_split(unsigned long const *ha1, long off1, long lim1,
+		      unsigned long const *ha2, long off2, long lim2,
+		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
+		      xdalgoenv_t *xenv) {
+	long dmin = off1 - lim2, dmax = lim1 - off2;
+	long fmid = off1 - off2, bmid = lim1 - lim2;
+	long odd = (fmid - bmid) & 1;
+	long fmin = fmid, fmax = fmid;
+	long bmin = bmid, bmax = bmid;
+	long ec, d, i1, i2, prev1, best, dd, v, k;
+
+	/*
+	 * Set initial diagonal values for both forward and backward path.
+	 */
+	kvdf[fmid] = off1;
+	kvdb[bmid] = lim1;
+
+	for (ec = 1;; ec++) {
+		int got_snake = 0;
+
+		/*
+		 * We need to extent the diagonal "domain" by one. If the next
+		 * values exits the box boundaries we need to change it in the
+		 * opposite direction because (max - min) must be a power of two.
+		 * Also we initialize the extenal K value to -1 so that we can
+		 * avoid extra conditions check inside the core loop.
+		 */
+		if (fmin > dmin)
+			kvdf[--fmin - 1] = -1;
+		else
+			++fmin;
+		if (fmax < dmax)
+			kvdf[++fmax + 1] = -1;
+		else
+			--fmax;
+
+		for (d = fmax; d >= fmin; d -= 2) {
+			if (kvdf[d - 1] >= kvdf[d + 1])
+				i1 = kvdf[d - 1] + 1;
+			else
+				i1 = kvdf[d + 1];
+			prev1 = i1;
+			i2 = i1 - d;
+			for (; i1 < lim1 && i2 < lim2 && ha1[i1] == ha2[i2]; i1++, i2++);
+			if (i1 - prev1 > xenv->snake_cnt)
+				got_snake = 1;
+			kvdf[d] = i1;
+			if (odd && bmin <= d && d <= bmax && kvdb[d] <= i1) {
+				spl->i1 = i1;
+				spl->i2 = i2;
+				spl->min_lo = spl->min_hi = 1;
+				return ec;
+			}
+		}
+
+		/*
+		 * We need to extent the diagonal "domain" by one. If the next
+		 * values exits the box boundaries we need to change it in the
+		 * opposite direction because (max - min) must be a power of two.
+		 * Also we initialize the extenal K value to -1 so that we can
+		 * avoid extra conditions check inside the core loop.
+		 */
+		if (bmin > dmin)
+			kvdb[--bmin - 1] = XDL_LINE_MAX;
+		else
+			++bmin;
+		if (bmax < dmax)
+			kvdb[++bmax + 1] = XDL_LINE_MAX;
+		else
+			--bmax;
+
+		for (d = bmax; d >= bmin; d -= 2) {
+			if (kvdb[d - 1] < kvdb[d + 1])
+				i1 = kvdb[d - 1];
+			else
+				i1 = kvdb[d + 1] - 1;
+			prev1 = i1;
+			i2 = i1 - d;
+			for (; i1 > off1 && i2 > off2 && ha1[i1 - 1] == ha2[i2 - 1]; i1--, i2--);
+			if (prev1 - i1 > xenv->snake_cnt)
+				got_snake = 1;
+			kvdb[d] = i1;
+			if (!odd && fmin <= d && d <= fmax && i1 <= kvdf[d]) {
+				spl->i1 = i1;
+				spl->i2 = i2;
+				spl->min_lo = spl->min_hi = 1;
+				return ec;
+			}
+		}
+
+		if (need_min)
+			continue;
+
+		/*
+		 * If the edit cost is above the heuristic trigger and if
+		 * we got a good snake, we sample current diagonals to see
+		 * if some of the, have reached an "interesting" path. Our
+		 * measure is a function of the distance from the diagonal
+		 * corner (i1 + i2) penalized with the distance from the
+		 * mid diagonal itself. If this value is above the current
+		 * edit cost times a magic factor (XDL_K_HEUR) we consider
+		 * it interesting.
+		 */
+		if (got_snake && ec > xenv->heur_min) {
+			for (best = 0, d = fmax; d >= fmin; d -= 2) {
+				dd = d > fmid ? d - fmid: fmid - d;
+				i1 = kvdf[d];
+				i2 = i1 - d;
+				v = (i1 - off1) + (i2 - off2) - dd;
+
+				if (v > XDL_K_HEUR * ec && v > best &&
+				    off1 + xenv->snake_cnt <= i1 && i1 < lim1 &&
+				    off2 + xenv->snake_cnt <= i2 && i2 < lim2) {
+					for (k = 1; ha1[i1 - k] == ha2[i2 - k]; k++)
+						if (k == xenv->snake_cnt) {
+							best = v;
+							spl->i1 = i1;
+							spl->i2 = i2;
+							break;
+						}
+				}
+			}
+			if (best > 0) {
+				spl->min_lo = 1;
+				spl->min_hi = 0;
+				return ec;
+			}
+
+			for (best = 0, d = bmax; d >= bmin; d -= 2) {
+				dd = d > bmid ? d - bmid: bmid - d;
+				i1 = kvdb[d];
+				i2 = i1 - d;
+				v = (lim1 - i1) + (lim2 - i2) - dd;
+
+				if (v > XDL_K_HEUR * ec && v > best &&
+				    off1 < i1 && i1 <= lim1 - xenv->snake_cnt &&
+				    off2 < i2 && i2 <= lim2 - xenv->snake_cnt) {
+					for (k = 0; ha1[i1 + k] == ha2[i2 + k]; k++)
+						if (k == xenv->snake_cnt - 1) {
+							best = v;
+							spl->i1 = i1;
+							spl->i2 = i2;
+							break;
+						}
+				}
+			}
+			if (best > 0) {
+				spl->min_lo = 0;
+				spl->min_hi = 1;
+				return ec;
+			}
+		}
+
+		/*
+		 * Enough is enough. We spent too much time here and now we collect
+		 * the furthest reaching path using the (i1 + i2) measure.
+		 */
+		if (ec >= xenv->mxcost) {
+			long fbest, fbest1, bbest, bbest1;
+
+			fbest = -1;
+			for (d = fmax; d >= fmin; d -= 2) {
+				i1 = XDL_MIN(kvdf[d], lim1);
+				i2 = i1 - d;
+				if (lim2 < i2)
+					i1 = lim2 + d, i2 = lim2;
+				if (fbest < i1 + i2) {
+					fbest = i1 + i2;
+					fbest1 = i1;
+				}
+			}
+
+			bbest = XDL_LINE_MAX;
+			for (d = bmax; d >= bmin; d -= 2) {
+				i1 = XDL_MAX(off1, kvdb[d]);
+				i2 = i1 - d;
+				if (i2 < off2)
+					i1 = off2 + d, i2 = off2;
+				if (i1 + i2 < bbest) {
+					bbest = i1 + i2;
+					bbest1 = i1;
+				}
+			}
+
+			if ((lim1 + lim2) - bbest < fbest - (off1 + off2)) {
+				spl->i1 = fbest1;
+				spl->i2 = fbest - fbest1;
+				spl->min_lo = 1;
+				spl->min_hi = 0;
+			} else {
+				spl->i1 = bbest1;
+				spl->i2 = bbest - bbest1;
+				spl->min_lo = 0;
+				spl->min_hi = 1;
+			}
+			return ec;
+		}
+	}
+
+	return -1;
+}
+
+
+/*
+ * Rule: "Divide et Impera". Recursively split the box in sub-boxes by calling
+ * the box splitting function. Note that the real job (marking changed lines)
+ * is done in the two boundary reaching checks.
+ */
+int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
+		 diffdata_t *dd2, long off2, long lim2,
+		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
+	unsigned long const *ha1 = dd1->ha, *ha2 = dd2->ha;
+
+	/*
+	 * Shrink the box by walking through each diagonal snake (SW and NE).
+	 */
+	for (; off1 < lim1 && off2 < lim2 && ha1[off1] == ha2[off2]; off1++, off2++);
+	for (; off1 < lim1 && off2 < lim2 && ha1[lim1 - 1] == ha2[lim2 - 1]; lim1--, lim2--);
+
+	/*
+	 * If one dimension is empty, then all records on the other one must
+	 * be obviously changed.
+	 */
+	if (off1 == lim1) {
+		char *rchg2 = dd2->rchg;
+		long *rindex2 = dd2->rindex;
+
+		for (; off2 < lim2; off2++)
+			rchg2[rindex2[off2]] = 1;
+	} else if (off2 == lim2) {
+		char *rchg1 = dd1->rchg;
+		long *rindex1 = dd1->rindex;
+
+		for (; off1 < lim1; off1++)
+			rchg1[rindex1[off1]] = 1;
+	} else {
+		long ec;
+		xdpsplit_t spl;
+
+		/*
+		 * Divide ...
+		 */
+		if ((ec = xdl_split(ha1, off1, lim1, ha2, off2, lim2, kvdf, kvdb,
+				    need_min, &spl, xenv)) < 0) {
+
+			return -1;
+		}
+
+		/*
+		 * ... et Impera.
+		 */
+		if (xdl_recs_cmp(dd1, off1, spl.i1, dd2, off2, spl.i2,
+				 kvdf, kvdb, spl.min_lo, xenv) < 0 ||
+		    xdl_recs_cmp(dd1, spl.i1, lim1, dd2, spl.i2, lim2,
+				 kvdf, kvdb, spl.min_hi, xenv) < 0) {
+
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+
+int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		xdfenv_t *xe) {
+	long ndiags;
+	long *kvd, *kvdf, *kvdb;
+	xdalgoenv_t xenv;
+	diffdata_t dd1, dd2;
+
+	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
+
+		return -1;
+	}
+
+	/*
+	 * Allocate and setup K vectors to be used by the differential algorithm.
+	 * One is to store the forward path and one to store the backward path.
+	 */
+	ndiags = xe->xdf1.nreff + xe->xdf2.nreff + 3;
+	if (!(kvd = (long *) xdl_malloc((2 * ndiags + 2) * sizeof(long)))) {
+
+		xdl_free_env(xe);
+		return -1;
+	}
+	kvdf = kvd;
+	kvdb = kvdf + ndiags;
+	kvdf += xe->xdf2.nreff + 1;
+	kvdb += xe->xdf2.nreff + 1;
+
+	/*
+	 * Classical integer square root approximation using shifts.
+	 */
+	xenv.mxcost = 1;
+	for (; ndiags; ndiags >>= 2)
+		xenv.mxcost <<= 1;
+	if (xenv.mxcost < XDL_MAX_COST_MIN)
+		xenv.mxcost = XDL_MAX_COST_MIN;
+	xenv.snake_cnt = XDL_SNAKE_CNT;
+	xenv.heur_min = XDL_HEUR_MIN_COST;
+
+	dd1.nrec = xe->xdf1.nreff;
+	dd1.ha = xe->xdf1.ha;
+	dd1.rchg = xe->xdf1.rchg;
+	dd1.rindex = xe->xdf1.rindex;
+	dd2.nrec = xe->xdf2.nreff;
+	dd2.ha = xe->xdf2.ha;
+	dd2.rchg = xe->xdf2.rchg;
+	dd2.rindex = xe->xdf2.rindex;
+
+	if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
+			 kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0, &xenv) < 0) {
+
+		xdl_free(kvd);
+		xdl_free_env(xe);
+		return -1;
+	}
+
+	xdl_free(kvd);
+
+	return 0;
+}
+
+
+static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2) {
+	xdchange_t *xch;
+
+	if (!(xch = (xdchange_t *) xdl_malloc(sizeof(xdchange_t))))
+		return NULL;
+
+	xch->next = xscr;
+	xch->i1 = i1;
+	xch->i2 = i2;
+	xch->chg1 = chg1;
+	xch->chg2 = chg2;
+
+	return xch;
+}
+
+
+int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
+	xdchange_t *cscr = NULL, *xch;
+	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
+	long i1, i2, l1, l2;
+
+	/*
+	 * Trivial. Collects "groups" of changes and creates an edit script.
+	 */
+	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
+		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
+			for (l1 = i1; rchg1[i1 - 1]; i1--);
+			for (l2 = i2; rchg2[i2 - 1]; i2--);
+
+			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
+				xdl_free_script(cscr);
+				return -1;
+			}
+			cscr = xch;
+		}
+
+	*xscr = cscr;
+
+	return 0;
+}
+
+
+void xdl_free_script(xdchange_t *xscr) {
+	xdchange_t *xch;
+
+	while ((xch = xscr) != NULL) {
+		xscr = xscr->next;
+		xdl_free(xch);
+	}
+}
+
+
+int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
+	xdchange_t *xscr;
+	xdfenv_t xe;
+
+	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
+
+		return -1;
+	}
+
+	if (xdl_build_script(&xe, &xscr) < 0) {
+
+		xdl_free_env(&xe);
+		return -1;
+	}
+
+	if (xscr) {
+		if (xdl_emit_diff(&xe, xscr, ecb, xecfg) < 0) {
+
+			xdl_free_script(xscr);
+			xdl_free_env(&xe);
+			return -1;
+		}
+
+		xdl_free_script(xscr);
+	}
+
+	xdl_free_env(&xe);
+
+	return 0;
+}
+
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
new file mode 100644
index 0000000..dd8f3c9
--- /dev/null
+++ b/xdiff/xdiffi.h
@@ -0,0 +1,60 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XDIFFI_H)
+#define XDIFFI_H
+
+
+typedef struct s_diffdata {
+	long nrec;
+	unsigned long const *ha;
+	long *rindex;
+	char *rchg;
+} diffdata_t;
+
+typedef struct s_xdalgoenv {
+	long mxcost;
+	long snake_cnt;
+	long heur_min;
+} xdalgoenv_t;
+
+typedef struct s_xdchange {
+	struct s_xdchange *next;
+	long i1, i2;
+	long chg1, chg2;
+} xdchange_t;
+
+
+
+int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
+		 diffdata_t *dd2, long off2, long lim2,
+		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
+int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		xdfenv_t *xe);
+int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr);
+void xdl_free_script(xdchange_t *xscr);
+int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+		  xdemitconf_t const *xecfg);
+
+
+#endif /* #if !defined(XDIFFI_H) */
+
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
new file mode 100644
index 0000000..2e5d54c
--- /dev/null
+++ b/xdiff/xemit.c
@@ -0,0 +1,141 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003	Davide Libenzi
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
+
+
+
+static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb);
+static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg);
+
+
+
+
+static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
+
+	*rec = xdf->recs[ri]->ptr;
+
+	return xdf->recs[ri]->size;
+}
+
+
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
+	long size, psize = strlen(pre);
+	char const *rec;
+
+	size = xdl_get_rec(xdf, ri, &rec);
+	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+
+		return -1;
+	}
+
+	return 0;
+}
+
+
+/*
+ * Starting at the passed change atom, find the latest change atom to be included
+ * inside the differential hunk according to the specified configuration.
+ */
+static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
+	xdchange_t *xch, *xchp;
+
+	for (xchp = xscr, xch = xscr->next; xch; xchp = xch, xch = xch->next)
+		if (xch->i1 - (xchp->i1 + xchp->chg1) > 2 * xecfg->ctxlen)
+			break;
+
+	return xchp;
+}
+
+
+int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+		  xdemitconf_t const *xecfg) {
+	long s1, s2, e1, e2, lctx;
+	xdchange_t *xch, *xche;
+
+	for (xch = xche = xscr; xch; xch = xche->next) {
+		xche = xdl_get_hunk(xch, xecfg);
+
+		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
+		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
+
+		lctx = xecfg->ctxlen;
+		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
+		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
+
+		e1 = xche->i1 + xche->chg1 + lctx;
+		e2 = xche->i2 + xche->chg2 + lctx;
+
+		/*
+		 * Emit current hunk header.
+		 */
+		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2, ecb) < 0)
+			return -1;
+
+		/*
+		 * Emit pre-context.
+		 */
+		for (; s1 < xch->i1; s1++)
+			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+				return -1;
+
+		for (s1 = xch->i1, s2 = xch->i2;; xch = xch->next) {
+			/*
+			 * Merge previous with current change atom.
+			 */
+			for (; s1 < xch->i1 && s2 < xch->i2; s1++, s2++)
+				if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+					return -1;
+
+			/*
+			 * Removes lines from the first file.
+			 */
+			for (s1 = xch->i1; s1 < xch->i1 + xch->chg1; s1++)
+				if (xdl_emit_record(&xe->xdf1, s1, "-", ecb) < 0)
+					return -1;
+
+			/*
+			 * Adds lines from the second file.
+			 */
+			for (s2 = xch->i2; s2 < xch->i2 + xch->chg2; s2++)
+				if (xdl_emit_record(&xe->xdf2, s2, "+", ecb) < 0)
+					return -1;
+
+			if (xch == xche)
+				break;
+			s1 = xch->i1 + xch->chg1;
+			s2 = xch->i2 + xch->chg2;
+		}
+
+		/*
+		 * Emit post-context.
+		 */
+		for (s1 = xche->i1 + xche->chg1; s1 < e1; s1++)
+			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+				return -1;
+	}
+
+	return 0;
+}
+
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
new file mode 100644
index 0000000..e629417
--- /dev/null
+++ b/xdiff/xemit.h
@@ -0,0 +1,34 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XEMIT_H)
+#define XEMIT_H
+
+
+
+int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+		  xdemitconf_t const *xecfg);
+
+
+
+#endif /* #if !defined(XEMIT_H) */
+
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
new file mode 100644
index 0000000..9490fc5
--- /dev/null
+++ b/xdiff/xinclude.h
@@ -0,0 +1,42 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XINCLUDE_H)
+#define XINCLUDE_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+
+#include "xmacros.h"
+#include "xdiff.h"
+#include "xtypes.h"
+#include "xutils.h"
+#include "xprepare.h"
+#include "xdiffi.h"
+#include "xemit.h"
+
+
+#endif /* #if !defined(XINCLUDE_H) */
+
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
new file mode 100644
index 0000000..4c2fde8
--- /dev/null
+++ b/xdiff/xmacros.h
@@ -0,0 +1,53 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XMACROS_H)
+#define XMACROS_H
+
+
+#define GR_PRIME 0x9e370001UL
+
+
+#define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
+#define XDL_MAX(a, b) ((a) > (b) ? (a): (b))
+#define XDL_ABS(v) ((v) >= 0 ? (v): -(v))
+#define XDL_ISDIGIT(c) ((c) >= '0' && (c) <= '9')
+#define XDL_HASHLONG(v, b) (((unsigned long)(v) * GR_PRIME) >> ((CHAR_BIT * sizeof(unsigned long)) - (b)))
+#define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
+#define XDL_LE32_PUT(p, v) \
+do { \
+	unsigned char *__p = (unsigned char *) (p); \
+	*__p++ = (unsigned char) (v); \
+	*__p++ = (unsigned char) ((v) >> 8); \
+	*__p++ = (unsigned char) ((v) >> 16); \
+	*__p = (unsigned char) ((v) >> 24); \
+} while (0)
+#define XDL_LE32_GET(p, v) \
+do { \
+	unsigned char const *__p = (unsigned char const *) (p); \
+	(v) = (unsigned long) __p[0] | ((unsigned long) __p[1]) << 8 | \
+		((unsigned long) __p[2]) << 16 | ((unsigned long) __p[3]) << 24; \
+} while (0)
+
+
+#endif /* #if !defined(XMACROS_H) */
+
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
new file mode 100644
index 0000000..27a0879
--- /dev/null
+++ b/xdiff/xprepare.c
@@ -0,0 +1,436 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+
+
+#define XDL_KPDIS_RUN 4
+
+
+
+typedef struct s_xdlclass {
+	struct s_xdlclass *next;
+	unsigned long ha;
+	char const *line;
+	long size;
+	long idx;
+} xdlclass_t;
+
+typedef struct s_xdlclassifier {
+	unsigned int hbits;
+	long hsize;
+	xdlclass_t **rchash;
+	chastore_t ncha;
+	long count;
+} xdlclassifier_t;
+
+
+
+
+static int xdl_init_classifier(xdlclassifier_t *cf, long size);
+static void xdl_free_classifier(xdlclassifier_t *cf);
+static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned int hbits,
+			       xrecord_t *rec);
+static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
+			   xdlclassifier_t *cf, xdfile_t *xdf);
+static void xdl_free_ctx(xdfile_t *xdf);
+static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
+static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2);
+static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
+static int xdl_optimize_ctxs(xdfile_t *xdf1, xdfile_t *xdf2);
+
+
+
+
+static int xdl_init_classifier(xdlclassifier_t *cf, long size) {
+	long i;
+
+	cf->hbits = xdl_hashbits((unsigned int) size);
+	cf->hsize = 1 << cf->hbits;
+
+	if (xdl_cha_init(&cf->ncha, sizeof(xdlclass_t), size / 4 + 1) < 0) {
+
+		return -1;
+	}
+	if (!(cf->rchash = (xdlclass_t **) xdl_malloc(cf->hsize * sizeof(xdlclass_t *)))) {
+
+		xdl_cha_free(&cf->ncha);
+		return -1;
+	}
+	for (i = 0; i < cf->hsize; i++)
+		cf->rchash[i] = NULL;
+
+	cf->count = 0;
+
+	return 0;
+}
+
+
+static void xdl_free_classifier(xdlclassifier_t *cf) {
+
+	xdl_free(cf->rchash);
+	xdl_cha_free(&cf->ncha);
+}
+
+
+static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned int hbits,
+			       xrecord_t *rec) {
+	long hi;
+	char const *line;
+	xdlclass_t *rcrec;
+
+	line = rec->ptr;
+	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
+	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
+		if (rcrec->ha == rec->ha && rcrec->size == rec->size &&
+		    !memcmp(line, rcrec->line, rec->size))
+			break;
+
+	if (!rcrec) {
+		if (!(rcrec = xdl_cha_alloc(&cf->ncha))) {
+
+			return -1;
+		}
+		rcrec->idx = cf->count++;
+		rcrec->line = line;
+		rcrec->size = rec->size;
+		rcrec->ha = rec->ha;
+		rcrec->next = cf->rchash[hi];
+		cf->rchash[hi] = rcrec;
+	}
+
+	rec->ha = (unsigned long) rcrec->idx;
+
+	hi = (long) XDL_HASHLONG(rec->ha, hbits);
+	rec->next = rhash[hi];
+	rhash[hi] = rec;
+
+	return 0;
+}
+
+
+static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
+			   xdlclassifier_t *cf, xdfile_t *xdf) {
+	unsigned int hbits;
+	long i, nrec, hsize, bsize;
+	unsigned long hav;
+	char const *blk, *cur, *top, *prev;
+	xrecord_t *crec;
+	xrecord_t **recs, **rrecs;
+	xrecord_t **rhash;
+	unsigned long *ha;
+	char *rchg;
+	long *rindex;
+
+	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0) {
+
+		return -1;
+	}
+	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *)))) {
+
+		xdl_cha_free(&xdf->rcha);
+		return -1;
+	}
+
+	hbits = xdl_hashbits((unsigned int) narec);
+	hsize = 1 << hbits;
+	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *)))) {
+
+		xdl_free(recs);
+		xdl_cha_free(&xdf->rcha);
+		return -1;
+	}
+	for (i = 0; i < hsize; i++)
+		rhash[i] = NULL;
+
+	nrec = 0;
+	if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
+		for (top = blk + bsize;;) {
+			if (cur >= top) {
+				if (!(cur = blk = xdl_mmfile_next(mf, &bsize)))
+					break;
+				top = blk + bsize;
+			}
+			prev = cur;
+			hav = xdl_hash_record(&cur, top);
+			if (nrec >= narec) {
+				narec *= 2;
+				if (!(rrecs = (xrecord_t **) xdl_realloc(recs, narec * sizeof(xrecord_t *)))) {
+
+					xdl_free(rhash);
+					xdl_free(recs);
+					xdl_cha_free(&xdf->rcha);
+					return -1;
+				}
+				recs = rrecs;
+			}
+			if (!(crec = xdl_cha_alloc(&xdf->rcha))) {
+
+				xdl_free(rhash);
+				xdl_free(recs);
+				xdl_cha_free(&xdf->rcha);
+				return -1;
+			}
+			crec->ptr = prev;
+			crec->size = (long) (cur - prev);
+			crec->ha = hav;
+			recs[nrec++] = crec;
+
+			if (xdl_classify_record(cf, rhash, hbits, crec) < 0) {
+
+				xdl_free(rhash);
+				xdl_free(recs);
+				xdl_cha_free(&xdf->rcha);
+				return -1;
+			}
+		}
+	}
+
+	if (!(rchg = (char *) xdl_malloc((nrec + 2) * sizeof(char)))) {
+
+		xdl_free(rhash);
+		xdl_free(recs);
+		xdl_cha_free(&xdf->rcha);
+		return -1;
+	}
+	memset(rchg, 0, (nrec + 2) * sizeof(char));
+
+	if (!(rindex = (long *) xdl_malloc((nrec + 1) * sizeof(long)))) {
+
+		xdl_free(rchg);
+		xdl_free(rhash);
+		xdl_free(recs);
+		xdl_cha_free(&xdf->rcha);
+		return -1;
+	}
+	if (!(ha = (unsigned long *) xdl_malloc((nrec + 1) * sizeof(unsigned long)))) {
+
+		xdl_free(rindex);
+		xdl_free(rchg);
+		xdl_free(rhash);
+		xdl_free(recs);
+		xdl_cha_free(&xdf->rcha);
+		return -1;
+	}
+
+	xdf->nrec = nrec;
+	xdf->recs = recs;
+	xdf->hbits = hbits;
+	xdf->rhash = rhash;
+	xdf->rchg = rchg + 1;
+	xdf->rindex = rindex;
+	xdf->nreff = 0;
+	xdf->ha = ha;
+	xdf->dstart = 0;
+	xdf->dend = nrec - 1;
+
+	return 0;
+}
+
+
+static void xdl_free_ctx(xdfile_t *xdf) {
+
+	xdl_free(xdf->rhash);
+	xdl_free(xdf->rindex);
+	xdl_free(xdf->rchg - 1);
+	xdl_free(xdf->ha);
+	xdl_free(xdf->recs);
+	xdl_cha_free(&xdf->rcha);
+}
+
+
+int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		    xdfenv_t *xe) {
+	long enl1, enl2;
+	xdlclassifier_t cf;
+
+	enl1 = xdl_guess_lines(mf1) + 1;
+	enl2 = xdl_guess_lines(mf2) + 1;
+
+	if (xdl_init_classifier(&cf, enl1 + enl2 + 1) < 0) {
+
+		return -1;
+	}
+
+	if (xdl_prepare_ctx(mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
+
+		xdl_free_classifier(&cf);
+		return -1;
+	}
+	if (xdl_prepare_ctx(mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
+
+		xdl_free_ctx(&xe->xdf1);
+		xdl_free_classifier(&cf);
+		return -1;
+	}
+
+	xdl_free_classifier(&cf);
+
+	if (xdl_optimize_ctxs(&xe->xdf1, &xe->xdf2) < 0) {
+
+		xdl_free_ctx(&xe->xdf2);
+		xdl_free_ctx(&xe->xdf1);
+		return -1;
+	}
+
+	return 0;
+}
+
+
+void xdl_free_env(xdfenv_t *xe) {
+
+	xdl_free_ctx(&xe->xdf2);
+	xdl_free_ctx(&xe->xdf1);
+}
+
+
+static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
+	long r, rdis, rpdis;
+
+	for (r = 1, rdis = 0, rpdis = 1; (i - r) >= s; r++) {
+		if (!dis[i - r])
+			rdis++;
+		else if (dis[i - r] == 2)
+			rpdis++;
+		else
+			break;
+	}
+	for (r = 1; (i + r) <= e; r++) {
+		if (!dis[i + r])
+			rdis++;
+		else if (dis[i + r] == 2)
+			rpdis++;
+		else
+			break;
+	}
+
+	return rpdis * XDL_KPDIS_RUN < (rpdis + rdis);
+}
+
+
+/*
+ * Try to reduce the problem complexity, discard records that have no
+ * matches on the other file. Also, lines that have multiple matches
+ * might be potentially discarded if they happear in a run of discardable.
+ */
+static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2) {
+	long i, rhi, nreff;
+	unsigned long hav;
+	xrecord_t **recs;
+	xrecord_t *rec;
+	char *dis, *dis1, *dis2;
+
+	if (!(dis = (char *) xdl_malloc((xdf1->nrec + xdf2->nrec + 2) * sizeof(char)))) {
+
+		return -1;
+	}
+	memset(dis, 0, (xdf1->nrec + xdf2->nrec + 2) * sizeof(char));
+	dis1 = dis;
+	dis2 = dis1 + xdf1->nrec + 1;
+
+	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
+		hav = (*recs)->ha;
+		rhi = (long) XDL_HASHLONG(hav, xdf2->hbits);
+		for (rec = xdf2->rhash[rhi]; rec; rec = rec->next)
+			if (rec->ha == hav && ++dis1[i] == 2)
+				break;
+	}
+
+	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
+		hav = (*recs)->ha;
+		rhi = (long) XDL_HASHLONG(hav, xdf1->hbits);
+		for (rec = xdf1->rhash[rhi]; rec; rec = rec->next)
+			if (rec->ha == hav && ++dis2[i] == 2)
+				break;
+	}
+
+	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	     i <= xdf1->dend; i++, recs++) {
+		if (dis1[i] == 1 ||
+		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
+			xdf1->rindex[nreff] = i;
+			xdf1->ha[nreff] = (*recs)->ha;
+			nreff++;
+		} else
+			xdf1->rchg[i] = 1;
+	}
+	xdf1->nreff = nreff;
+
+	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	     i <= xdf2->dend; i++, recs++) {
+		if (dis2[i] == 1 ||
+		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
+			xdf2->rindex[nreff] = i;
+			xdf2->ha[nreff] = (*recs)->ha;
+			nreff++;
+		} else
+			xdf2->rchg[i] = 1;
+	}
+	xdf2->nreff = nreff;
+
+	xdl_free(dis);
+
+	return 0;
+}
+
+
+/*
+ * Early trim initial and terminal matching records.
+ */
+static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
+	long i, lim;
+	xrecord_t **recs1, **recs2;
+
+	recs1 = xdf1->recs;
+	recs2 = xdf2->recs;
+	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
+	     i++, recs1++, recs2++)
+		if ((*recs1)->ha != (*recs2)->ha)
+			break;
+
+	xdf1->dstart = xdf2->dstart = i;
+
+	recs1 = xdf1->recs + xdf1->nrec - 1;
+	recs2 = xdf2->recs + xdf2->nrec - 1;
+	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
+		if ((*recs1)->ha != (*recs2)->ha)
+			break;
+
+	xdf1->dend = xdf1->nrec - i - 1;
+	xdf2->dend = xdf2->nrec - i - 1;
+
+	return 0;
+}
+
+
+static int xdl_optimize_ctxs(xdfile_t *xdf1, xdfile_t *xdf2) {
+
+	if (xdl_trim_ends(xdf1, xdf2) < 0 ||
+	    xdl_cleanup_records(xdf1, xdf2) < 0) {
+
+		return -1;
+	}
+
+	return 0;
+}
+
diff --git a/xdiff/xprepare.h b/xdiff/xprepare.h
new file mode 100644
index 0000000..344c569
--- /dev/null
+++ b/xdiff/xprepare.h
@@ -0,0 +1,35 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XPREPARE_H)
+#define XPREPARE_H
+
+
+
+int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		    xdfenv_t *xe);
+void xdl_free_env(xdfenv_t *xe);
+
+
+
+#endif /* #if !defined(XPREPARE_H) */
+
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
new file mode 100644
index 0000000..3593a66
--- /dev/null
+++ b/xdiff/xtypes.h
@@ -0,0 +1,68 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XTYPES_H)
+#define XTYPES_H
+
+
+
+typedef struct s_chanode {
+	struct s_chanode *next;
+	long icurr;
+} chanode_t;
+
+typedef struct s_chastore {
+	chanode_t *head, *tail;
+	long isize, nsize;
+	chanode_t *ancur;
+	chanode_t *sncur;
+	long scurr;
+} chastore_t;
+
+typedef struct s_xrecord {
+	struct s_xrecord *next;
+	char const *ptr;
+	long size;
+	unsigned long ha;
+} xrecord_t;
+
+typedef struct s_xdfile {
+	chastore_t rcha;
+	long nrec;
+	unsigned int hbits;
+	xrecord_t **rhash;
+	long dstart, dend;
+	xrecord_t **recs;
+	char *rchg;
+	long *rindex;
+	long nreff;
+	unsigned long *ha;
+} xdfile_t;
+
+typedef struct s_xdfenv {
+	xdfile_t xdf1, xdf2;
+} xdfenv_t;
+
+
+
+#endif /* #if !defined(XTYPES_H) */
+
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
new file mode 100644
index 0000000..01e6765
--- /dev/null
+++ b/xdiff/xutils.c
@@ -0,0 +1,265 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003	Davide Libenzi
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
+
+
+#define XDL_GUESS_NLINES 256
+
+
+
+
+int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
+		     xdemitcb_t *ecb) {
+	mmbuffer_t mb[2];
+
+	mb[0].ptr = (char *) pre;
+	mb[0].size = psize;
+	mb[1].ptr = (char *) rec;
+	mb[1].size = size;
+
+	if (ecb->outf(ecb->priv, mb, 2) < 0) {
+
+		return -1;
+	}
+
+	return 0;
+}
+
+void *xdl_mmfile_first(mmfile_t *mmf, long *size)
+{
+	*size = mmf->size;
+	return mmf->ptr;
+}
+
+
+void *xdl_mmfile_next(mmfile_t *mmf, long *size)
+{
+	return NULL;
+}
+
+
+long xdl_mmfile_size(mmfile_t *mmf)
+{
+	return mmf->size;
+}
+
+
+int xdl_cha_init(chastore_t *cha, long isize, long icount) {
+
+	cha->head = cha->tail = NULL;
+	cha->isize = isize;
+	cha->nsize = icount * isize;
+	cha->ancur = cha->sncur = NULL;
+	cha->scurr = 0;
+
+	return 0;
+}
+
+
+void xdl_cha_free(chastore_t *cha) {
+	chanode_t *cur, *tmp;
+
+	for (cur = cha->head; (tmp = cur) != NULL;) {
+		cur = cur->next;
+		xdl_free(tmp);
+	}
+}
+
+
+void *xdl_cha_alloc(chastore_t *cha) {
+	chanode_t *ancur;
+	void *data;
+
+	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
+		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
+
+			return NULL;
+		}
+		ancur->icurr = 0;
+		ancur->next = NULL;
+		if (cha->tail)
+			cha->tail->next = ancur;
+		if (!cha->head)
+			cha->head = ancur;
+		cha->tail = ancur;
+		cha->ancur = ancur;
+	}
+
+	data = (char *) ancur + sizeof(chanode_t) + ancur->icurr;
+	ancur->icurr += cha->isize;
+
+	return data;
+}
+
+
+void *xdl_cha_first(chastore_t *cha) {
+	chanode_t *sncur;
+
+	if (!(cha->sncur = sncur = cha->head))
+		return NULL;
+
+	cha->scurr = 0;
+
+	return (char *) sncur + sizeof(chanode_t) + cha->scurr;
+}
+
+
+void *xdl_cha_next(chastore_t *cha) {
+	chanode_t *sncur;
+
+	if (!(sncur = cha->sncur))
+		return NULL;
+	cha->scurr += cha->isize;
+	if (cha->scurr == sncur->icurr) {
+		if (!(sncur = cha->sncur = sncur->next))
+			return NULL;
+		cha->scurr = 0;
+	}
+
+	return (char *) sncur + sizeof(chanode_t) + cha->scurr;
+}
+
+
+long xdl_guess_lines(mmfile_t *mf) {
+	long nl = 0, size, tsize = 0;
+	char const *data, *cur, *top;
+
+	if ((cur = data = xdl_mmfile_first(mf, &size)) != NULL) {
+		for (top = data + size; nl < XDL_GUESS_NLINES;) {
+			if (cur >= top) {
+				tsize += (long) (cur - data);
+				if (!(cur = data = xdl_mmfile_next(mf, &size)))
+					break;
+				top = data + size;
+			}
+			nl++;
+			if (!(cur = memchr(cur, '\n', top - cur)))
+				cur = top;
+			else
+				cur++;
+		}
+		tsize += (long) (cur - data);
+	}
+
+	if (nl && tsize)
+		nl = xdl_mmfile_size(mf) / (tsize / nl);
+
+	return nl + 1;
+}
+
+
+unsigned long xdl_hash_record(char const **data, char const *top) {
+	unsigned long ha = 5381;
+	char const *ptr = *data;
+
+	for (; ptr < top && *ptr != '\n'; ptr++) {
+		ha += (ha << 5);
+		ha ^= (unsigned long) *ptr;
+	}
+	*data = ptr < top ? ptr + 1: ptr;
+
+	return ha;
+}
+
+
+unsigned int xdl_hashbits(unsigned int size) {
+	unsigned int val = 1, bits = 0;
+
+	for (; val < size && bits < CHAR_BIT * sizeof(unsigned int); val <<= 1, bits++);
+	return bits ? bits: 1;
+}
+
+
+int xdl_num_out(char *out, long val) {
+	char *ptr, *str = out;
+	char buf[32];
+
+	ptr = buf + sizeof(buf) - 1;
+	*ptr = '\0';
+	if (val < 0) {
+		*--ptr = '-';
+		val = -val;
+	}
+	for (; val && ptr > buf; val /= 10)
+		*--ptr = "0123456789"[val % 10];
+	if (*ptr)
+		for (; *ptr; ptr++, str++)
+			*str = *ptr;
+	else
+		*str++ = '0';
+	*str = '\0';
+
+	return str - out;
+}
+
+
+long xdl_atol(char const *str, char const **next) {
+	long val, base;
+	char const *top;
+
+	for (top = str; XDL_ISDIGIT(*top); top++);
+	if (next)
+		*next = top;
+	for (val = 0, base = 1, top--; top >= str; top--, base *= 10)
+		val += base * (long)(*top - '0');
+	return val;
+}
+
+
+int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2, xdemitcb_t *ecb) {
+	int nb = 0;
+	mmbuffer_t mb;
+	char buf[128];
+
+	memcpy(buf, "@@ -", 4);
+	nb += 4;
+
+	nb += xdl_num_out(buf + nb, c1 ? s1: 0);
+
+	memcpy(buf + nb, ",", 1);
+	nb += 1;
+
+	nb += xdl_num_out(buf + nb, c1);
+
+	memcpy(buf + nb, " +", 2);
+	nb += 2;
+
+	nb += xdl_num_out(buf + nb, c2 ? s2: 0);
+
+	memcpy(buf + nb, ",", 1);
+	nb += 1;
+
+	nb += xdl_num_out(buf + nb, c2);
+
+	memcpy(buf + nb, " @@\n", 4);
+	nb += 4;
+
+	mb.ptr = buf;
+	mb.size = nb;
+	if (ecb->outf(ecb->priv, &mb, 1) < 0)
+		return -1;
+
+	return 0;
+}
+
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
new file mode 100644
index 0000000..428a4bb
--- /dev/null
+++ b/xdiff/xutils.h
@@ -0,0 +1,44 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
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
+#if !defined(XUTILS_H)
+#define XUTILS_H
+
+
+int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
+		     xdemitcb_t *ecb);
+int xdl_cha_init(chastore_t *cha, long isize, long icount);
+void xdl_cha_free(chastore_t *cha);
+void *xdl_cha_alloc(chastore_t *cha);
+void *xdl_cha_first(chastore_t *cha);
+void *xdl_cha_next(chastore_t *cha);
+long xdl_guess_lines(mmfile_t *mf);
+unsigned long xdl_hash_record(char const **data, char const *top);
+unsigned int xdl_hashbits(unsigned int size);
+int xdl_num_out(char *out, long val);
+long xdl_atol(char const *str, char const **next);
+int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2, xdemitcb_t *ecb);
+
+
+
+#endif /* #if !defined(XUTILS_H) */
+

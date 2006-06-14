From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] Teach diff about -b and -w flags
Date: Wed, 14 Jun 2006 17:40:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606141739020.18794@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jun 14 17:40:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqXTp-00031P-9C
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 17:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWFNPkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 11:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFNPkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 11:40:25 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65424 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964853AbWFNPkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 11:40:24 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 38F282093;
	Wed, 14 Jun 2006 17:40:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 2CF4C20A9;
	Wed, 14 Jun 2006 17:40:23 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 05BF0205E;
	Wed, 14 Jun 2006 17:40:23 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: davidel@xmailserver.org, git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21847>


This adds -b (--ignore-space-change) and -w (--ignore-all-space) flags to
diff. The main part of the patch is teaching libxdiff about it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Note that -b will not treat DOS and Unix line endings as equal,
	although it would be trivial. Is this desired?

	Another question: instead of checking the flags all the time,
	xdl_line_match (and possibly xdl_hash_record) could be split into
	three different functions, and a function pointer could be set
	at init time. This would be faster, but less elegant, no?

 diff.c           |   13 +++++++++----
 diff.h           |    1 +
 xdiff/xdiff.h    |    3 +++
 xdiff/xdiffi.c   |   12 ++++++------
 xdiff/xdiffi.h   |    1 -
 xdiff/xmacros.h  |    1 -
 xdiff/xprepare.c |   16 ++++++++++------
 xdiff/xutils.c   |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 xdiff/xutils.h   |    3 ++-
 9 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index bc32a4a..5b34f73 100644
--- a/diff.c
+++ b/diff.c
@@ -661,7 +661,7 @@ static void builtin_diff(const char *nam
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = o->color_diff;
-		xpp.flags = XDF_NEED_MINIMAL;
+		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (!diffopts)
@@ -686,6 +686,7 @@ static void builtin_diffstat(const char 
 			     struct diff_filespec *one,
 			     struct diff_filespec *two,
 			     struct diffstat_t *diffstat,
+			     struct diff_options *o,
 			     int complete_rewrite)
 {
 	mmfile_t mf1, mf2;
@@ -715,7 +716,7 @@ static void builtin_diffstat(const char 
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 
-		xpp.flags = XDF_NEED_MINIMAL;
+		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = 0;
 		xecfg.flags = 0;
 		ecb.outf = xdiff_outf;
@@ -1300,7 +1301,7 @@ static void run_diffstat(struct diff_fil
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		builtin_diffstat(p->one->path, NULL, NULL, NULL, diffstat, 0);
+		builtin_diffstat(p->one->path, NULL, NULL, NULL, diffstat, o, 0);
 		return;
 	}
 
@@ -1312,7 +1313,7 @@ static void run_diffstat(struct diff_fil
 
 	if (p->status == DIFF_STATUS_MODIFIED && p->score)
 		complete_rewrite = 1;
-	builtin_diffstat(name, other, p->one, p->two, diffstat, complete_rewrite);
+	builtin_diffstat(name, other, p->one, p->two, diffstat, o, complete_rewrite);
 }
 
 static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
@@ -1517,6 +1518,10 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--color"))
 		options->color_diff = 1;
+	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
+		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
+		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else
 		return 0;
 	return 1;
diff --git a/diff.h b/diff.h
index 2b821df..7d7b6cd 100644
--- a/diff.h
+++ b/diff.h
@@ -46,6 +46,7 @@ struct diff_options {
 	int setup;
 	int abbrev;
 	const char *stat_sep;
+	long xdl_opts;
 
 	int nr_paths;
 	const char **paths;
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2540e8a..2ce10b4 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -29,6 +29,9 @@ #endif /* #ifdef __cplusplus */
 
 
 #define XDF_NEED_MINIMAL (1 << 1)
+#define XDF_IGNORE_WHITESPACE (1 << 2)
+#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
+#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE)
 
 #define XDL_PATCH_NORMAL '-'
 #define XDL_PATCH_REVERSE '+'
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b95ade2..5d09a16 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -45,7 +45,7 @@ static long xdl_split(unsigned long cons
 		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
 		      xdalgoenv_t *xenv);
 static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2);
-static int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo);
+static int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags);
 
 
 
@@ -397,7 +397,7 @@ static xdchange_t *xdl_add_change(xdchan
 }
 
 
-static int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo) {
+static int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
 	xrecord_t **recs = xdf->recs;
@@ -440,7 +440,7 @@ static int xdl_change_compact(xdfile_t *
 			 * the group.
 			 */
 			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
-			       XDL_RECMATCH(recs[ixs - 1], recs[ix - 1])) {
+			       xdl_line_match(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
@@ -468,7 +468,7 @@ static int xdl_change_compact(xdfile_t *
 			 * the group.
 			 */
 			while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
-			       XDL_RECMATCH(recs[ixs], recs[ix])) {
+			       xdl_line_match(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
@@ -546,8 +546,8 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf
 
 		return -1;
 	}
-	if (xdl_change_compact(&xe.xdf1, &xe.xdf2) < 0 ||
-	    xdl_change_compact(&xe.xdf2, &xe.xdf1) < 0 ||
+	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
+	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe, &xscr) < 0) {
 
 		xdl_free_env(&xe);
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index dd8f3c9..d3b7271 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -55,6 +55,5 @@ void xdl_free_script(xdchange_t *xscr);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
 
-
 #endif /* #if !defined(XDIFFI_H) */
 
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 78f0260..4c2fde8 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -33,7 +33,6 @@ #define XDL_ABS(v) ((v) >= 0 ? (v): -(v)
 #define XDL_ISDIGIT(c) ((c) >= '0' && (c) <= '9')
 #define XDL_HASHLONG(v, b) (((unsigned long)(v) * GR_PRIME) >> ((CHAR_BIT * sizeof(unsigned long)) - (b)))
 #define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
-#define XDL_RECMATCH(r1, r2) ((r1)->size == (r2)->size && memcmp((r1)->ptr, (r2)->ptr, (r1)->size) == 0)
 #define XDL_LE32_PUT(p, v) \
 do { \
 	unsigned char *__p = (unsigned char *) (p); \
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index add5a75..f2a12ae 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -43,12 +43,13 @@ typedef struct s_xdlclassifier {
 	xdlclass_t **rchash;
 	chastore_t ncha;
 	long count;
+	long flags;
 } xdlclassifier_t;
 
 
 
 
-static int xdl_init_classifier(xdlclassifier_t *cf, long size);
+static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags);
 static void xdl_free_classifier(xdlclassifier_t *cf);
 static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned int hbits,
 			       xrecord_t *rec);
@@ -63,9 +64,11 @@ static int xdl_optimize_ctxs(xdfile_t *x
 
 
 
-static int xdl_init_classifier(xdlclassifier_t *cf, long size) {
+static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	long i;
 
+	cf->flags = flags;
+
 	cf->hbits = xdl_hashbits((unsigned int) size);
 	cf->hsize = 1 << cf->hbits;
 
@@ -103,8 +106,9 @@ static int xdl_classify_record(xdlclassi
 	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->ha == rec->ha && rcrec->size == rec->size &&
-		    !memcmp(line, rcrec->line, rec->size))
+		if (rcrec->ha == rec->ha &&
+				xdl_line_match(rcrec->line, rcrec->size,
+					rec->ptr, rec->size, cf->flags))
 			break;
 
 	if (!rcrec) {
@@ -173,7 +177,7 @@ static int xdl_prepare_ctx(mmfile_t *mf,
 				top = blk + bsize;
 			}
 			prev = cur;
-			hav = xdl_hash_record(&cur, top);
+			hav = xdl_hash_record(&cur, top, xpp->flags);
 			if (nrec >= narec) {
 				narec *= 2;
 				if (!(rrecs = (xrecord_t **) xdl_realloc(recs, narec * sizeof(xrecord_t *)))) {
@@ -268,7 +272,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfil
 	enl1 = xdl_guess_lines(mf1) + 1;
 	enl2 = xdl_guess_lines(mf2) + 1;
 
-	if (xdl_init_classifier(&cf, enl1 + enl2 + 1) < 0) {
+	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
 
 		return -1;
 	}
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 21ab8e7..3dd5fe1 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -189,12 +189,61 @@ long xdl_guess_lines(mmfile_t *mf) {
 	return nl + 1;
 }
 
+int xdl_line_match(const char *l1, long s1, const char *l2, long s2, long flags)
+{
+	int i1, i2;
+
+	if (flags & XDF_IGNORE_WHITESPACE) {
+		for (i1 = i2 = 0; i1 < s1 && i2 < s2; i1++, i2++) {
+			if (isspace(l1[i1]))
+				while (isspace(l1[i1]) && i1 < s1)
+					i1++;
+			else if (isspace(l2[i2]))
+				while (isspace(l2[i2]) && i2 < s2)
+					i2++;
+			else if (l1[i1] != l2[i2])
+				return l2[i2] - l1[i1];
+		}
+		if (i1 >= s1)
+			return 1;
+		else if (i2 >= s2)
+			return -1;
+	} else if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
+		for (i1 = i2 = 0; i1 < s1 && i2 < s2; i1++, i2++) {
+			if (isspace(l1[i1])) {
+				if (!isspace(l2[i2]))
+					return -1;
+				while (isspace(l1[i1]) && i1 < s1)
+					i1++;
+				while (isspace(l2[i2]) && i2 < s2)
+					i2++;
+			} else if (l1[i1] != l2[i2])
+				return l2[i2] - l1[i1];
+		}
+		if (i1 >= s1)
+			return 1;
+		else if (i2 >= s2)
+			return -1;
+	} else
+		return s1 == s2 && !memcmp(l1, l2, s1);
+
+	return 0;
+}
 
-unsigned long xdl_hash_record(char const **data, char const *top) {
+unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
+		if (isspace(*ptr) && (flags & XDF_WHITESPACE_FLAGS)) {
+			while (ptr < top && isspace(*ptr) && ptr[1] != '\n')
+				ptr++;
+			if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
+				ha += (ha << 5);
+				ha ^= (unsigned long) ' ';
+			}
+			continue;
+		}
 		ha += (ha << 5);
 		ha ^= (unsigned long) *ptr;
 	}
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index ea38ee9..2701eea 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -33,7 +33,8 @@ void *xdl_cha_alloc(chastore_t *cha);
 void *xdl_cha_first(chastore_t *cha);
 void *xdl_cha_next(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf);
-unsigned long xdl_hash_record(char const **data, char const *top);
+int xdl_line_match(const char *l1, long s1, const char *l2, long s2, long flags);
+unsigned long xdl_hash_record(char const **data, char const *top, long flags);
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
 long xdl_atol(char const *str, char const **next);
-- 
1.4.0.ga9a96-dirty

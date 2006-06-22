From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Teach diff about whitespace options.
Date: Thu, 22 Jun 2006 11:58:21 -0700
Message-ID: <7vwtb9kofm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 22 20:58:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUO0-0004PJ-GG
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWFVS6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWFVS6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:58:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61138 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161195AbWFVS6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 14:58:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622185822.OFOJ5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 14:58:22 -0400
To: Davide Libenzi <davidel@xmailserver.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22356>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This adds XDF_IGNORE_WHITESPACE and XDF_IGNORE_WHITESPACE_CHANGE
to the set of flags that can be passed to xdl_change_compact(),
to implement -b (--ignore-space-change) and -w (--ignore-all-space)
options.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * The original done by Johannes named a new function
   xdl_line_match(), but that collided with what is in
   xpatchi.c, so I renamed it to xdl_recmatch().

 xdiff.h    |    3 +++
 xdiffi.c   |   12 ++++++------
 xdiffi.h   |    1 -
 xmacros.h  |    1 -
 xprepare.c |   16 ++++++++++------
 xutils.c   |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 xutils.h   |    3 ++-
 7 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/xdiff.h b/xdiff.h
index f4af41b..224bd12 100644
--- a/xdiff.h
+++ b/xdiff.h
@@ -29,6 +29,9 @@ #endif /* #ifdef __cplusplus */
 
 
 #define XDF_NEED_MINIMAL (1 << 1)
+#define XDF_IGNORE_WHITESPACE (1 << 2)
+#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
+#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE)
 
 #define XDL_PATCH_NORMAL '-'
 #define XDL_PATCH_REVERSE '+'
diff --git a/xdiffi.c b/xdiffi.c
index b95ade2..ed7ad20 100644
--- a/xdiffi.c
+++ b/xdiffi.c
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
+			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
@@ -468,7 +468,7 @@ static int xdl_change_compact(xdfile_t *
 			 * the group.
 			 */
 			while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
-			       XDL_RECMATCH(recs[ixs], recs[ix])) {
+			       xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
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
diff --git a/xdiffi.h b/xdiffi.h
index dd8f3c9..d3b7271 100644
--- a/xdiffi.h
+++ b/xdiffi.h
@@ -55,6 +55,5 @@ void xdl_free_script(xdchange_t *xscr);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
 
-
 #endif /* #if !defined(XDIFFI_H) */
 
diff --git a/xmacros.h b/xmacros.h
index 78f0260..4c2fde8 100644
--- a/xmacros.h
+++ b/xmacros.h
@@ -33,7 +33,6 @@ #define XDL_ABS(v) ((v) >= 0 ? (v): -(v)
 #define XDL_ISDIGIT(c) ((c) >= '0' && (c) <= '9')
 #define XDL_HASHLONG(v, b) (((unsigned long)(v) * GR_PRIME) >> ((CHAR_BIT * sizeof(unsigned long)) - (b)))
 #define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
-#define XDL_RECMATCH(r1, r2) ((r1)->size == (r2)->size && memcmp((r1)->ptr, (r2)->ptr, (r1)->size) == 0)
 #define XDL_LE32_PUT(p, v) \
 do { \
 	unsigned char *__p = (unsigned char *) (p); \
diff --git a/xprepare.c b/xprepare.c
index add5a75..1be7b31 100644
--- a/xprepare.c
+++ b/xprepare.c
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
+				xdl_recmatch(rcrec->line, rcrec->size,
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
diff --git a/xutils.c b/xutils.c
index a776706..695a458 100644
--- a/xutils.c
+++ b/xutils.c
@@ -483,12 +483,61 @@ long xdl_guess_lines(mmfile_t *mf) {
 	return nl + 1;
 }
 
+int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
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
 
-unsigned long xdl_hash_record(char const **data, char const *top) {
+	return 0;
+}
+
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
diff --git a/xutils.h b/xutils.h
index 5a3e13b..275fa74 100644
--- a/xutils.h
+++ b/xutils.h
@@ -35,7 +35,8 @@ void *xdl_cha_alloc(chastore_t *cha);
 void *xdl_cha_first(chastore_t *cha);
 void *xdl_cha_next(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf);
-unsigned long xdl_hash_record(char const **data, char const *top);
+int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
+unsigned long xdl_hash_record(char const **data, char const *top, long flags);
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
 long xdl_atol(char const *str, char const **next);
-- 
1.4.0.gbf9e

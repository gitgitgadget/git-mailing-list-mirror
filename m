From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] xdiff: PATIENCE/HISTOGRAM are not independent option
 bits
Date: Sun, 19 Feb 2012 18:16:25 -0800
Message-ID: <1329704188-9955-3-git-send-email-gitster@pobox.com>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 03:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzInv-0007il-6a
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 03:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab2BTCQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 21:16:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2BTCQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 21:16:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C80777DC
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6V2E
	hwVlzzPDuhY9b7pqfkLSQvI=; b=RMYu8oVsXyDG29BLy6iRfGSRlRzL07UsaK3/
	q4CLD51m2JOx+8zbkjmziuJld4dPDFjo5RyK/SuS0W73Qy/bxoqFBLUYt0cKTBMV
	w0WqXEMvwzfCFWfZYk3626MCB7EeAh2AUpQ4L0+44gVlEAiWne4GFNa76M1W5JyU
	W8W8FfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PoDquA
	hi54BzVxakZFD+iL8vppECi1JJFDWr4o3iKb/BbI3SNpybG/tOPzRs+FmbxbGjt3
	5H5Zik75e6FpiEiODUbKEo8w7cFo1QzR0adsZnnh01s6hQT6G19Mh8iB0EOsyj6M
	SkgjrTjNhb7dDLL0VRRomKoijTKATCyx4Hk5o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0458977DB
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41A2E77DA for
 <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:33 -0500 (EST)
X-Mailer: git-send-email 1.7.9.1.265.g25f75
In-Reply-To: <1329704188-9955-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E878D144-5B68-11E1-87DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191038>

Because the default Myers, patience and histogram algorithms cannot be in
effect at the same time, XDL_PATIENCE_DIFF and XDL_HISTOGRAM_DIFF are not
independent bits.  Instead of wasting one bit per algorithm, define a few
macros to access the few bits they occupy and update the code that access
them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c             |    4 ++--
 diff.h             |    2 ++
 merge-recursive.c  |    4 ++--
 xdiff/xdiff.h      |    5 ++++-
 xdiff/xdiffi.c     |    4 ++--
 xdiff/xhistogram.c |    2 +-
 xdiff/xpatience.c  |    2 +-
 xdiff/xprepare.c   |   21 ++++++++++-----------
 8 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 374ecf3..52cda7a 100644
--- a/diff.c
+++ b/diff.c
@@ -3400,9 +3400,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--patience"))
-		DIFF_XDL_SET(options, PATIENCE_DIFF);
+		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
-		DIFF_XDL_SET(options, HISTOGRAM_DIFF);
+		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
diff --git a/diff.h b/diff.h
index 0c51724..e688a48 100644
--- a/diff.h
+++ b/diff.h
@@ -88,6 +88,8 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
 #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
 
+#define DIFF_WITH_ALG(opts, flag)   (((opts)->xdl_opts & ~XDF_DIFF_ALGORITHM_MASK) | XDF_##flag)
+
 enum diff_words_type {
 	DIFF_WORDS_NONE = 0,
 	DIFF_WORDS_PORCELAIN,
diff --git a/merge-recursive.c b/merge-recursive.c
index cc664c3..1d574fe 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2069,9 +2069,9 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 	else if (!prefixcmp(s, "subtree="))
 		o->subtree_shift = s + strlen("subtree=");
 	else if (!strcmp(s, "patience"))
-		o->xdl_opts |= XDF_PATIENCE_DIFF;
+		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
 	else if (!strcmp(s, "histogram"))
-		o->xdl_opts |= XDF_HISTOGRAM_DIFF;
+		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
 	else if (!strcmp(s, "ignore-space-change"))
 		o->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(s, "ignore-all-space"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 70c8b87..09215af 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -32,9 +32,12 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
+#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
+
 #define XDF_PATIENCE_DIFF (1 << 5)
 #define XDF_HISTOGRAM_DIFF (1 << 6)
-#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
+#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
+#define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 75a3922..bc889e8 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -328,10 +328,10 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	xdalgoenv_t xenv;
 	diffdata_t dd1, dd2;
 
-	if (xpp->flags & XDF_PATIENCE_DIFF)
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF)
 		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
 
-	if (xpp->flags & XDF_HISTOGRAM_DIFF)
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
 		return xdl_do_histogram_diff(mf1, mf2, xpp, xe);
 
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 18f6f99..bf99787 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -252,7 +252,7 @@ static int fall_back_to_classic_diff(struct histindex *index,
 		int line1, int count1, int line2, int count2)
 {
 	xpparam_t xpp;
-	xpp.flags = index->xpp->flags & ~XDF_HISTOGRAM_DIFF;
+	xpp.flags = index->xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
 
 	return xdl_fall_back_diff(index->env, &xpp,
 				  line1, count1, line2, count2);
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index fdd7d02..04e1a1a 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -288,7 +288,7 @@ static int fall_back_to_classic_diff(struct hashmap *map,
 		int line1, int count1, int line2, int count2)
 {
 	xpparam_t xpp;
-	xpp.flags = map->xpp->flags & ~XDF_PATIENCE_DIFF;
+	xpp.flags = map->xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
 
 	return xdl_fall_back_diff(map->env, &xpp,
 				  line1, count1, line2, count2);
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e419f4f..63a22c6 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -181,7 +181,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *))))
 		goto abort;
 
-	if (xpp->flags & XDF_HISTOGRAM_DIFF)
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
 		hbits = hsize = 0;
 	else {
 		hbits = xdl_hashbits((unsigned int) narec);
@@ -209,8 +209,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->ha = hav;
 			recs[nrec++] = crec;
 
-			if (!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
-				xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			if ((XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
+			    xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
 				goto abort;
 		}
 	}
@@ -273,16 +273,15 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	 * (nrecs) will be updated correctly anyway by
 	 * xdl_prepare_ctx().
 	 */
-	sample = xpp->flags & XDF_HISTOGRAM_DIFF ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1;
+	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
+		  ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
 
 	enl1 = xdl_guess_lines(mf1, sample) + 1;
 	enl2 = xdl_guess_lines(mf2, sample) + 1;
 
-	if (!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
-		xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
-
+	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF &&
+	    xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
 		return -1;
-	}
 
 	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
 
@@ -296,9 +295,9 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 
-	if (!(xpp->flags & XDF_PATIENCE_DIFF) &&
-			!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
-			xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
+	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
+	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
+	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
-- 
1.7.9.1.265.g25f75

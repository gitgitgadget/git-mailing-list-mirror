From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 6/8] teach --histogram to diff
Date: Mon,  1 Aug 2011 11:16:46 +0800
Message-ID: <1312168608-10828-7-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-2-git-send-email-rctay89@gmail.com>
 <1312168608-10828-3-git-send-email-rctay89@gmail.com>
 <1312168608-10828-4-git-send-email-rctay89@gmail.com>
 <1312168608-10828-5-git-send-email-rctay89@gmail.com>
 <1312168608-10828-6-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0e-00037I-9W
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab1HADRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1HADRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:34 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yJ485Mn7rwt25eRcbw8HktJ4ce1A2ILgEFrLmM7+soM=;
        b=wg4lkWwOZigbodZdIhUebu6q3JLrGmxEx1cMog+a5vb6UW9/VHw+Xp/5q7SqvqQyPo
         jJZtb6FZWK5bAuH9GHXY3NINkyxFpUgndXTbaJJz4h27dZh30tiQVFpCl4KtgNC7CqtN
         0mywKK4O83+ooSqTVCKEKapQUp09HAbIbi1S8=
Received: by 10.231.26.223 with SMTP id f31mr2514554ibc.122.1312168653742;
        Sun, 31 Jul 2011 20:17:33 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id d8sm6171754icy.9.2011.07.31.20.17.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-6-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178301>

Port JGit's HistogramDiff algorithm over to C. Rough numbers (TODO) show
that it is faster than its --patience cousin, as well as the default
Meyers algorithm.

The implementation has been reworked to use structs and pointers,
instead of bitmasks, thus doing away with JGit's 2^28 line limit.

We also use xdiff's default hash table implementation (xdl_hash_bits()
with XDL_HASHLONG()) for convenience.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changes in v2:
 - changed handling of recursed results
 - do away with reduce_common_start_end(), as use xdiff's
   xdl_trim_ends()

On Wed, Jul 13, 2011 at 3:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>[snip]
>> +     reduce_common_start_end(xpp, env, &line1, &count1, &line2, &count2);
>
> What this does is logically not specific to histogram algorithm but can be
> applied to other backends, no? And I vaguely recall that Linus did try
> something like this once, found some issues with it when context is set to
> non zero, and stopped doing it (sorry, I do not have any more details).
>
> I am not suggesting you to remove this call or hoist the call to one level
> up to xdl_do_diff(), but I do have to wonder how much of the performance
> improvement you reported is due to this common head/tail reduction.

I believe this was the patch by Linus you were referring to:

  https://lkml.org/lkml/2007/12/20/692

That is an optimization on a more aggressive level - cutting out
content so that it doesn't get hashed in the first place. The
optimization used here (reduce_common_start_end()/xdl_trim_ends())
depends on the hashed result and simply reduces the "area" on which the
algorithm is applied to.

(Actually, I do have a working patch that does content trimming that is
context-length safe. But it's not specific to histogram so I'll keep it
with me till this series gets merged.)

 Makefile                  |    2 +-
 diff.c                    |    2 +
 merge-recursive.c         |    2 +
 t/t4048-diff-histogram.sh |   12 ++
 xdiff/xdiff.h             |    1 +
 xdiff/xdiffi.c            |    3 +
 xdiff/xdiffi.h            |    2 +
 xdiff/xhistogram.c        |  360 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 383 insertions(+), 1 deletions(-)
 create mode 100755 t/t4048-diff-histogram.sh
 create mode 100644 xdiff/xhistogram.c

diff --git a/Makefile b/Makefile
index 775ee83..9930e6b 100644
--- a/Makefile
+++ b/Makefile
@@ -1836,7 +1836,7 @@ ifndef NO_CURL
 	GIT_OBJS += http.o http-walker.o remote-curl.o
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
-	xdiff/xmerge.o xdiff/xpatience.o
+	xdiff/xmerge.o xdiff/xpatience.o xdiff/xhistogram.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
 VCSSVN_TEST_OBJS = test-obj-pool.o test-string-pool.o \
diff --git a/diff.c b/diff.c
index 5422c43..a113294 100644
--- a/diff.c
+++ b/diff.c
@@ -3186,6 +3186,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--patience"))
 		DIFF_XDL_SET(options, PATIENCE_DIFF);
+	else if (!strcmp(arg, "--histogram"))
+		DIFF_XDL_SET(options, HISTOGRAM_DIFF);
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..3e8267b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1773,6 +1773,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->subtree_shift = s + strlen("subtree=");
 	else if (!strcmp(s, "patience"))
 		o->xdl_opts |= XDF_PATIENCE_DIFF;
+	else if (!strcmp(s, "histogram"))
+		o->xdl_opts |= XDF_HISTOGRAM_DIFF;
 	else if (!strcmp(s, "ignore-space-change"))
 		o->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(s, "ignore-all-space"))
diff --git a/t/t4048-diff-histogram.sh b/t/t4048-diff-histogram.sh
new file mode 100755
index 0000000..fd3e86a
--- /dev/null
+++ b/t/t4048-diff-histogram.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='histogram diff algorithm'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff-alternative.sh
+
+test_diff_frobnitz "histogram"
+
+test_diff_unique "histogram"
+
+test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 6ea1d0e..4beb10c 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -33,6 +33,7 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
 #define XDF_PATIENCE_DIFF (1 << 5)
+#define XDF_HISTOGRAM_DIFF (1 << 6)
 #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
 
 #define XDL_PATCH_NORMAL '-'
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index da67c04..75a3922 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -331,6 +331,9 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	if (xpp->flags & XDF_PATIENCE_DIFF)
 		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
 
+	if (xpp->flags & XDF_HISTOGRAM_DIFF)
+		return xdl_do_histogram_diff(mf1, mf2, xpp, xe);
+
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
 
 		return -1;
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index ad033a8..7a92ea9 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -57,5 +57,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
 int xdl_do_patience_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *env);
+int xdl_do_histogram_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		xdfenv_t *env);
 
 #endif /* #if !defined(XDIFFI_H) */
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
new file mode 100644
index 0000000..4af99f0
--- /dev/null
+++ b/xdiff/xhistogram.c
@@ -0,0 +1,360 @@
+/*
+ * Copyright (C) 2010, Google Inc.
+ * and other copyright owners as documented in JGit's IP log.
+ *
+ * This program and the accompanying materials are made available
+ * under the terms of the Eclipse Distribution License v1.0 which
+ * accompanies this distribution, is reproduced below, and is
+ * available at http://www.eclipse.org/org/documents/edl-v10.php
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Eclipse Foundation, Inc. nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "xinclude.h"
+#include "xtypes.h"
+#include "xdiff.h"
+
+#define MAX_PTR	UINT_MAX
+#define MAX_CNT	UINT_MAX
+
+#define LINE_END(n) (line##n + count##n - 1)
+#define LINE_END_PTR(n) (*line##n + *count##n - 1)
+
+struct histindex {
+	struct record {
+		unsigned int ptr, cnt;
+		struct record *next;
+	} **records, /* an ocurrence */
+	  **line_map; /* map of line to record chain */
+	chastore_t rcha;
+	unsigned int *next_ptrs;
+	unsigned int table_bits,
+		     records_size,
+		     line_map_size;
+
+	unsigned int max_chain_length,
+		     key_shift,
+		     ptr_shift;
+
+	unsigned int cnt,
+		     has_common;
+
+	xdfenv_t *env;
+	xpparam_t const *xpp;
+};
+
+struct region {
+	unsigned int begin1, end1;
+	unsigned int begin2, end2;
+};
+
+#define LINE_MAP(i, a) (i->line_map[(a) - i->ptr_shift])
+
+#define NEXT_PTR(index, ptr) \
+	(index->next_ptrs[(ptr) - index->ptr_shift])
+
+#define CNT(index, ptr) \
+	((LINE_MAP(index, ptr))->cnt)
+
+#define REC(env, s, l) \
+	(env->xdf##s.recs[l - 1])
+
+static int cmp_recs(xpparam_t const *xpp,
+	xrecord_t *r1, xrecord_t *r2)
+{
+	return r1->ha == r2->ha &&
+		xdl_recmatch(r1->ptr, r1->size, r2->ptr, r2->size,
+			    xpp->flags);
+}
+
+#define CMP_ENV(xpp, env, s1, l1, s2, l2) \
+	(cmp_recs(xpp, REC(env, s1, l1), REC(env, s2, l2)))
+
+#define CMP(i, s1, l1, s2, l2) \
+	(cmp_recs(i->xpp, REC(i->env, s1, l1), REC(i->env, s2, l2)))
+
+#define TABLE_HASH(index, side, line) \
+	XDL_HASHLONG((REC(index->env, side, line))->ha, index->table_bits)
+
+static int scanA(struct histindex *index, int line1, int count1)
+{
+	unsigned int ptr, tbl_idx;
+	unsigned int chain_len;
+	struct record **rec_chain, *rec;
+
+	for (ptr = LINE_END(1); line1 <= ptr; ptr--) {
+		tbl_idx = TABLE_HASH(index, 1, ptr);
+		rec_chain = index->records + tbl_idx;
+		rec = *rec_chain;
+
+		chain_len = 0;
+		while (rec) {
+			if (CMP(index, 1, rec->ptr, 1, ptr)) {
+				/*
+				 * ptr is identical to another element. Insert
+				 * it onto the front of the existing element
+				 * chain.
+				 */
+				NEXT_PTR(index, ptr) = rec->ptr;
+				rec->ptr = ptr;
+				/* cap rec->cnt at MAX_CNT */
+				rec->cnt = XDL_MIN(MAX_CNT, rec->cnt + 1);
+				LINE_MAP(index, ptr) = rec;
+				goto continue_scan;
+			}
+
+			rec = rec->next;
+			chain_len++;
+		}
+
+		if (chain_len == index->max_chain_length)
+			return -1;
+
+		/*
+		 * This is the first time we have ever seen this particular
+		 * element in the sequence. Construct a new chain for it.
+		 */
+		if (!(rec = xdl_cha_alloc(&index->rcha)))
+			return -1;
+		rec->ptr = ptr;
+		rec->cnt = 1;
+		rec->next = *rec_chain;
+		*rec_chain = rec;
+		LINE_MAP(index, ptr) = rec;
+
+continue_scan:
+		; /* no op */
+	}
+
+	return 0;
+}
+
+static int try_lcs(struct histindex *index, struct region *lcs, int b_ptr,
+	int line1, int count1, int line2, int count2)
+{
+	unsigned int b_next = b_ptr + 1;
+	struct record *rec = index->records[TABLE_HASH(index, 2, b_ptr)];
+	unsigned int as, ae, bs, be, np, rc;
+	int should_break;
+
+	for (; rec; rec = rec->next) {
+		if (rec->cnt > index->cnt) {
+			if (!index->has_common)
+				index->has_common = CMP(index, 1, rec->ptr, 2, b_ptr);
+			continue;
+		}
+
+		as = rec->ptr;
+		if (!CMP(index, 1, as, 2, b_ptr))
+			continue;
+
+		index->has_common = 1;
+		for (;;) {
+			should_break = 0;
+			np = NEXT_PTR(index, as);
+			bs = b_ptr;
+			ae = as;
+			be = bs;
+			rc = rec->cnt;
+
+			while (line1 < as && line2 < bs
+				&& CMP(index, 1, as - 1, 2, bs - 1)) {
+				as--;
+				bs--;
+				if (1 < rc)
+					rc = XDL_MIN(rc, CNT(index, as));
+			}
+			while (ae < LINE_END(1) && be < LINE_END(2)
+				&& CMP(index, 1, ae + 1, 2, be + 1)) {
+				ae++;
+				be++;
+				if (1 < rc)
+					rc = XDL_MIN(rc, CNT(index, ae));
+			}
+
+			if (b_next <= be)
+				b_next = be + 1;
+			if (lcs->end1 - lcs->begin1 < ae - as || rc < index->cnt) {
+				lcs->begin1 = as;
+				lcs->begin2 = bs;
+				lcs->end1 = ae;
+				lcs->end2 = be;
+				index->cnt = rc;
+			}
+
+			if (np == 0)
+				break;
+
+			while (np <= ae) {
+				np = NEXT_PTR(index, np);
+				if (np == 0) {
+					should_break = 1;
+					break;
+				}
+			}
+
+			if (should_break)
+				break;
+
+			as = np;
+		}
+	}
+	return b_next;
+}
+
+static int find_lcs(struct histindex *index, struct region *lcs,
+	int line1, int count1, int line2, int count2) {
+	int b_ptr;
+
+	if (scanA(index, line1, count1))
+		return -1;
+
+	index->cnt = index->max_chain_length + 1;
+
+	for (b_ptr = line2; b_ptr <= LINE_END(2); )
+		b_ptr = try_lcs(index, lcs, b_ptr, line1, count1, line2, count2);
+
+	return index->has_common && index->max_chain_length < index->cnt;
+}
+
+static int fall_back_to_classic_diff(struct histindex *index,
+		int line1, int count1, int line2, int count2)
+{
+	xpparam_t xpp;
+	xpp.flags = index->xpp->flags & ~XDF_HISTOGRAM_DIFF;
+
+	return xdl_fall_back_diff(index->env, &xpp,
+				  line1, count1, line2, count2);
+}
+
+static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
+	int line1, int count1, int line2, int count2)
+{
+	struct histindex index;
+	struct region lcs;
+	int sz;
+	int result = -1;
+
+	if (count1 <= 0 && count2 <= 0)
+		return 0;
+
+	if (LINE_END(1) >= MAX_PTR)
+		return -1;
+
+	if (!count1) {
+		while(count2--)
+			env->xdf2.rchg[line2++ - 1] = 1;
+		return 0;
+	} else if (!count2) {
+		while(count1--)
+			env->xdf1.rchg[line1++ - 1] = 1;
+		return 0;
+	}
+
+	memset(&index, 0, sizeof(index));
+
+	index.env = env;
+	index.xpp = xpp;
+
+	index.records = NULL;
+	index.line_map = NULL;
+	/* in case of early xdl_cha_free() */
+	index.rcha.head = NULL;
+
+	index.table_bits = xdl_hashbits(count1);
+	sz = index.records_size = 1 << index.table_bits;
+	sz *= sizeof(struct record *);
+	if (!(index.records = (struct record **) xdl_malloc(sz)))
+		goto cleanup;
+	memset(index.records, 0, sz);
+
+	sz = index.line_map_size = count1;
+	sz *= sizeof(struct record *);
+	if (!(index.line_map = (struct record **) xdl_malloc(sz)))
+		goto cleanup;
+	memset(index.line_map, 0, sz);
+
+	sz = index.line_map_size;
+	sz *= sizeof(unsigned int);
+	if (!(index.next_ptrs = (unsigned int *) xdl_malloc(sz)))
+		goto cleanup;
+	memset(index.next_ptrs, 0, sz);
+
+	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
+	if (xdl_cha_init(&index.rcha, sizeof(struct record), count1 / 4 + 1) < 0)
+		goto cleanup;
+
+	index.ptr_shift = line1;
+	index.max_chain_length = 64;
+
+	memset(&lcs, 0, sizeof(lcs));
+	if (find_lcs(&index, &lcs, line1, count1, line2, count2))
+		result = fall_back_to_classic_diff(&index, line1, count1, line2, count2);
+	else {
+		result = 0;
+		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
+			int ptr;
+			for (ptr = 0; ptr < count1; ptr++)
+				env->xdf1.rchg[line1 + ptr - 1] = 1;
+			for (ptr = 0; ptr < count2; ptr++)
+				env->xdf2.rchg[line2 + ptr - 1] = 1;
+		} else {
+			result += histogram_diff(xpp, env,
+				line1, lcs.begin1 - line1,
+				line2, lcs.begin2 - line2);
+			result += histogram_diff(xpp, env,
+				lcs.end1 + 1, LINE_END(1) - lcs.end1,
+				lcs.end2 + 1, LINE_END(2) - lcs.end2);
+		}
+	}
+
+cleanup:
+	xdl_free(index.records);
+	xdl_free(index.line_map);
+	xdl_free(index.next_ptrs);
+	xdl_cha_free(&index.rcha);
+
+	return result;
+}
+
+int xdl_do_histogram_diff(mmfile_t *file1, mmfile_t *file2,
+	xpparam_t const *xpp, xdfenv_t *env)
+{
+	if (xdl_prepare_env(file1, file2, xpp, env) < 0)
+		return -1;
+
+	return histogram_diff(xpp, env,
+		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
+		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
+}
-- 
1.7.3.4.730.g67af1.dirty

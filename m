Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 692C220193
	for <e@80x24.org>; Sat,  3 Sep 2016 03:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbcICDbl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 23:31:41 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34900 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbcICDbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 23:31:37 -0400
Received: by mail-pf0-f171.google.com with SMTP id x72so47839227pfd.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f2XlxXg3I9Bib1VtSvUE8jPErbKVdJwpidP+kf+glTA=;
        b=mae7pOYX1yMKrMJ5nzpEXHNZ+bTybrayrirr9IAIp4rmeLzJIqQwy0tH0HMXiZhbT8
         cS47hLOUAjhtA6zaDK3ggyDqpqs8QBCN6ieMDcdkKaBfJ/WzZn3UlrrLM474b//uMHey
         N+FP9VFRIOGnp8aokSHeStroDahV5VnF2U4dQkh9C0eyxRuyOdY1aWWbAX7gofRLEpxm
         Hlt/LvWR6FO9WgNcAkKwIcGtMPQBm7s2ZBCGWIs4mjxIv6KN7fJOk/GJMs5ocFCyqyEi
         SQQrrA4VrsKOIJKZYSygxzNcAycp2QVC0qFF2NE4HTIGkFKa7+1gJsA7HcwqaUM9AfD9
         XQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f2XlxXg3I9Bib1VtSvUE8jPErbKVdJwpidP+kf+glTA=;
        b=ahB/SuV769N0yUyxsl2HarGPdQx/EMbdgmYpne0AZ1jUy29BsWO3/82P7SAhD8TW9A
         1jbhjPRt4FxF5jywpv07/ouMx3ySc4IrarS3xbvqLQ5+zDYYQduqjqDdoNqFuclU8gks
         X72YnLA5r/Us4gI1i7H9v1nh5wmZac4M9Uhva0BBILHMvMSLiKc0LBJoIACWVvvV7zji
         TkfFMbKyOd+PtpNYX+4MTmA2mg6c8srmROjBYmlp4+2bYel4lo8sAaozXKRg8FRYGjGC
         2Rlyqh9x2LhKUFgzsEZHxx6BUo0jmTMD/mlAIOzbnQyiQ7StyJ6LuVDBRMh9Vk6I4wjc
         rDEw==
X-Gm-Message-State: AE9vXwOQRXXKgi0WPQ6O9+LU9GXWPDdugviahyKCMh5YhEttkMKEBZnOkT3dOOMK4ykSKyW5
X-Received: by 10.98.32.81 with SMTP id g78mr42145419pfg.20.1472873496406;
        Fri, 02 Sep 2016 20:31:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29f6:f946:ae72:afdc])
        by smtp.gmail.com with ESMTPSA id t80sm17793969pfj.38.2016.09.02.20.31.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 20:31:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 2/2] WIP xdiff: markup duplicates differently
Date:   Fri,  2 Sep 2016 20:31:20 -0700
Message-Id: <20160903033120.20511-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.rc2.23.gf336a1a.dirty
In-Reply-To: <20160903033120.20511-1-sbeller@google.com>
References: <20160903033120.20511-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When moving code (e.g. a function is moved to another part of the file or
to a different file), the review process is different than reviewing new
code. When reviewing moved code we are only interested in the diff as
where there are differences in the moved code, e.g. namespace changes.

However the inner part of these moved texts should not change.
To aid a developer reviewing such code, emit it with a different prefix
than the usual +,- to indicate it is overlapping code.

Examples from recent history:
    git show e28eae3184b26d3cf3293e69403babb5c575342c
    git show bc9204d4ef6e0672389fdfb0d398fa9a39dba3d5
    git show 8465541e8ce8eaf16e66ab847086779768c18f2d

This doesn't work yet, but we should make this patch series work
to ignore white space changes:
9d1ca1dac0ebfd6e17d73e33b2d173926c139c2d

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiff.h |   1 +
 xdiff/xemit.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 7423f77..0744e01 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -45,6 +45,7 @@ extern "C" {
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
+#define XDL_EMIT_DUPLICATE (1 << 3)
 
 #define XDL_MMB_READONLY (1 << 0)
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index b52b4b9..4abafae 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,6 +22,9 @@
 
 #include "xinclude.h"
 
+#include "git-compat-util.h"
+#include "hashmap.h"
+
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
 
 	*rec = xdf->recs[ri]->ptr;
@@ -158,12 +161,133 @@ static int is_empty_rec(xdfile_t *xdf, long ri)
 	return !len;
 }
 
+struct hashmap *duplicates_added;
+struct hashmap *duplicates_removed;
+
+struct dup_entry {
+	struct hashmap_entry ent;
+	xdfile_t *xdf;
+	long index;
+};
+
+static int dup_entry_cmp(const struct dup_entry *a,
+			   const struct dup_entry *b,
+			   const void *unused)
+{
+	int d = XDL_MIN(strcspn(a->xdf->recs[a->index]->ptr, "\n"),
+				strcspn(b->xdf->recs[b->index]->ptr, "\n"));
+
+	if (!strncmp(a->xdf->recs[a->index]->ptr,
+			b->xdf->recs[b->index]->ptr,
+			d))
+		return 0;
+	return 1;
+}
+
+struct dup_entry *prepare_entry(xdfile_t *xdf, long ri)
+{
+	long range_start = XDL_MAX(0, ri - 2);
+	long range_end = XDL_MIN(xdf->nrec, ri + 2);
+	long hash = 0;
+	int i;
+	struct dup_entry *ret = xmalloc(sizeof(*ret));
+
+	for (i = range_start; i < range_end; i++)
+		hash ^= memhash(xdf->recs[i]->ptr, xdf->recs[i]->size);
+
+	ret->ent.hash = hash;
+	ret->xdf = xdf;
+	ret->index = ri;
+	return ret;
+}
+
+int add_removal(xdfile_t *xdf, long ri)
+{
+	hashmap_add(duplicates_removed, prepare_entry(xdf, ri));
+	return 0;
+}
+
+int add_addition(xdfile_t *xdf, long ri)
+{
+	hashmap_add(duplicates_added, prepare_entry(xdf, ri));
+	return 0;
+}
+
+int xdl_markup_duplicates(xdfenv_t *xe, xdchange_t *xscr,
+			  xdemitconf_t const *xecfg)
+{
+	long s1, s2;
+	xdchange_t *xch, *xche;
+
+	duplicates_added = xmalloc(sizeof(*duplicates_added));
+	duplicates_removed = xmalloc(sizeof(*duplicates_removed));
+	hashmap_init(duplicates_added, (hashmap_cmp_fn)dup_entry_cmp, 0);
+	hashmap_init(duplicates_removed, (hashmap_cmp_fn)dup_entry_cmp, 0);
+
+	for (xch = xscr; xch; xch = xche->next) {
+		xche = xdl_get_hunk(&xch, xecfg);
+		if (!xch)
+			break;
+
+		for (s1 = xch->i1, s2 = xch->i2;; xch = xch->next) {
+
+			/*
+			 * Removes lines from the first file.
+			 */
+			for (s1 = xch->i1; s1 < xch->i1 + xch->chg1; s1++)
+				if (add_removal(&xe->xdf1, s1) < 0)
+					return -1;
+
+			/*
+			 * Adds lines from the second file.
+			 */
+			for (s2 = xch->i2; s2 < xch->i2 + xch->chg2; s2++)
+				if (add_addition(&xe->xdf2, s2) < 0)
+					return -1;
+
+			if (xch == xche)
+				break;
+			s1 = xch->i1 + xch->chg1;
+			s2 = xch->i2 + xch->chg2;
+		}
+	}
+	return 0;
+}
+
+static int xdl_check_and_emit_record(xdfile_t *xdf, long ri,
+				     char *pre, xdemitcb_t *ecb,
+				     int duplicate_handling)
+{
+	const char *hacked_pre = pre;
+
+	if (duplicate_handling) {
+		struct dup_entry *keydata = prepare_entry(xdf, ri);
+
+		if (*pre == '+' &&
+		    hashmap_get(duplicates_removed, keydata, keydata))
+				hacked_pre = "*";
+
+		if (*pre == '-' &&
+		    hashmap_get(duplicates_added, keydata, keydata))
+				hacked_pre = "~";
+		free(keydata);
+	}
+
+	return xdl_emit_record(xdf, ri, hacked_pre, ecb);
+}
+
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
 	xdchange_t *xch, *xche;
 	long funclineprev = -1;
 	struct func_line func_line = { 0 };
+	int duplicate_handling = 0;
+
+	/* for testing I added a `|| 1` */
+	duplicate_handling = xecfg->flags & XDL_EMIT_DUPLICATE || 1;
+	if (duplicate_handling)
+		xdl_markup_duplicates(xe, xscr, xecfg);
 
 	for (xch = xscr; xch; xch = xche->next) {
 		xche = xdl_get_hunk(&xch, xecfg);
@@ -279,14 +403,14 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			 * Removes lines from the first file.
 			 */
 			for (s1 = xch->i1; s1 < xch->i1 + xch->chg1; s1++)
-				if (xdl_emit_record(&xe->xdf1, s1, "-", ecb) < 0)
+				if (xdl_check_and_emit_record(&xe->xdf1, s1, "-", ecb, duplicate_handling) < 0)
 					return -1;
 
 			/*
 			 * Adds lines from the second file.
 			 */
 			for (s2 = xch->i2; s2 < xch->i2 + xch->chg2; s2++)
-				if (xdl_emit_record(&xe->xdf2, s2, "+", ecb) < 0)
+				if (xdl_check_and_emit_record(&xe->xdf2, s2, "+", ecb, duplicate_handling) < 0)
 					return -1;
 
 			if (xch == xche)
-- 
2.10.0.rc2.23.gf336a1a.dirty


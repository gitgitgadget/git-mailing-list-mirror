Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63035C35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD6A206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AiLCKzud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBVUSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727097AbgBVUSR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 485B160D00
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402692;
        bh=c5APCn/amtzYu+ssdDeA56+8O1kTE3R4inj61Hf0I2k=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=AiLCKzudu7aapJpsNHzNarfdWe3H8MVB0ukZ3OJXBQMZaMomnO5dt1N0gkwL+A0NC
         4xSwGC+1qswUyEHtXuwi0C1vW3eFToyNFNEJ/OFZi8aqqVA3RnRKRvG4xobodIzFEu
         vV2SzlS4AiOBsKIPEokZsnX2nQCbyq5oDUxv5W9VRDwamYRQvWFoSSI03Eo6OsE0O6
         md6TEujrNH2Ju0tzDwFqTl/dF+UHAhvGjQb5fgrc48XzyZiZvij93RfkUMKebB7P7K
         O4TO9wmSIxs3sOCfkbODq38xJEvdC6SMqBHEqE8GtAtWyeRQIzNi7OKO5pyMxasS4k
         zxIE9GH1hljjMC4laq4do9gvViUYuYf8SNcdfwvpmM+dkIcGJ9nCNO/OPtc0Q/1v7D
         JjNakLhFQl3P0pPb2MCqU5rUzwucAbamdw2NF5e2hrioJbb1AawaFcpDCorKbgghU2
         WLCEIYOgFOZmGSauWH7+2szkFfHdDn8OJDDF3Un2qTeYPsJnhIf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 23/24] fast-import: add a generic function to iterate over marks
Date:   Sat, 22 Feb 2020 20:17:48 +0000
Message-Id: <20200222201749.937983-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, we can iterate over marks only to dump them to a file. In the
future, we'll want to perform an arbitrary operation over the items of a
mark set. Add a function, for_each_mark, that iterates over marks in a
set and performs an arbitrary callback function for each mark. Switch
the mark dumping routine to use this function now that it's available.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8aaa7f6289..6711f71ba7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -132,6 +132,7 @@ struct recent_command {
 };
 
 typedef void (*mark_set_inserter_t)(struct mark_set *s, struct object_id *oid, uintmax_t mark);
+typedef void (*each_mark_fn_t)(uintmax_t mark, void *obj, void *cbp);
 
 /* Configured limits on output */
 static unsigned long max_depth = 50;
@@ -232,6 +233,29 @@ static void parse_get_mark(const char *p);
 static void parse_cat_blob(const char *p);
 static void parse_ls(const char *p, struct branch *b);
 
+static void for_each_mark(struct mark_set *m, uintmax_t base, each_mark_fn_t callback, void *p)
+{
+	uintmax_t k;
+	if (m->shift) {
+		for (k = 0; k < 1024; k++) {
+			if (m->data.sets[k])
+				for_each_mark(m->data.sets[k], base + (k << m->shift), callback, p);
+		}
+	} else {
+		for (k = 0; k < 1024; k++) {
+			if (m->data.marked[k])
+				callback(base + k, m->data.marked[k], p);
+		}
+	}
+}
+
+static void dump_marks_fn(uintmax_t mark, void *object, void *cbp) {
+	struct object_entry *e = object;
+	FILE *f = cbp;
+
+	fprintf(f, ":%" PRIuMAX " %s\n", mark, oid_to_hex(&e->idx.oid));
+}
+
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
 	fprintf(rpt, "%s:\n", b->name);
@@ -260,8 +284,6 @@ static void write_branch_report(FILE *rpt, struct branch *b)
 	fputc('\n', rpt);
 }
 
-static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
-
 static void write_crash_report(const char *err)
 {
 	char *loc = git_pathdup("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
@@ -340,7 +362,7 @@ static void write_crash_report(const char *err)
 	if (export_marks_file)
 		fprintf(rpt, "  exported to %s\n", export_marks_file);
 	else
-		dump_marks_helper(rpt, 0, marks);
+		for_each_mark(marks, 0, dump_marks_fn, rpt);
 
 	fputc('\n', rpt);
 	fputs("-------------------\n", rpt);
@@ -1655,26 +1677,6 @@ static void dump_tags(void)
 	strbuf_release(&err);
 }
 
-static void dump_marks_helper(FILE *f,
-	uintmax_t base,
-	struct mark_set *m)
-{
-	uintmax_t k;
-	if (m->shift) {
-		for (k = 0; k < 1024; k++) {
-			if (m->data.sets[k])
-				dump_marks_helper(f, base + (k << m->shift),
-					m->data.sets[k]);
-		}
-	} else {
-		for (k = 0; k < 1024; k++) {
-			if (m->data.marked[k])
-				fprintf(f, ":%" PRIuMAX " %s\n", base + k,
-					oid_to_hex(&m->data.marked[k]->idx.oid));
-		}
-	}
-}
-
 static void dump_marks(void)
 {
 	struct lock_file mark_lock = LOCK_INIT;
@@ -1704,7 +1706,7 @@ static void dump_marks(void)
 		return;
 	}
 
-	dump_marks_helper(f, 0, marks);
+	for_each_mark(marks, 0, dump_marks_fn, f);
 	if (commit_lock_file(&mark_lock)) {
 		failure |= error_errno("Unable to write file %s",
 				       export_marks_file);

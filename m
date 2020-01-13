Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A82C33CB0
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BD42081E
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="x8gWF6dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgAMMsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728920AbgAMMsH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9DCA0607FF
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919685;
        bh=c5APCn/amtzYu+ssdDeA56+8O1kTE3R4inj61Hf0I2k=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=x8gWF6dJmgpI2TalYc2cHcxAbJFAgitiWPFPbMlNs0dFfVuPXpwefcj8xl1ri4Wp5
         RV7g9m/NELXI8BeV6e60kzkU6YNor1gcyebp8m7MJn12fqdZWkAb8fAY0SvDvZ+Ovw
         ADJ1Atyt3AXr41ZQt5PeD8H691zUKbiewCDZ+yK7DzEpVX0nfpCmf6KrlhO6MMy6O5
         w2MXHlxanCymAXFxbbCrAK4WPb+R6ocQu5R6/9/+zcVUUlv4/bF2iHjBNNqTWkhvAi
         kXncw4WGBKYlzaVQ+vxd69HY7TBSucL6hZOX/Bupm7lg88ej4790gpVNWhMCeiACN1
         P/l3ipEq56dBBMJGP8nwVdTNhMimitUfhzJUWV6bScb6hU/Hu59aApcKa46HREHwxz
         XKMiOuE9GlpjGUWXbwh2NpOW9YvNLEnJ+WQrkPYI0/Aq0BPQHge7DxAiPRZnB+HwK/
         CHiStERDa9GVI9t2jaOJVPBQPhUdPe4DbD+yFm0H39WmDP6vvC9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 21/22] fast-import: add a generic function to iterate over marks
Date:   Mon, 13 Jan 2020 12:47:28 +0000
Message-Id: <20200113124729.3684846-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
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

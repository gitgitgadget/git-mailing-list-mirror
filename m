Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E819C35675
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229F320707
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PNxnq8fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgBVUSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39090 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgBVUSM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:12 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3568060CFE
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402691;
        bh=feuJWoLumRPYIA7lRVMbuGBg6pbFdqBHQIC6joWgx5A=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=PNxnq8fqjg/QpJBhOvLgiEJJihk11hzUQtkgReIuWuogNb/RD8ySizLGF0XcTBE/N
         PqOuawXsUDGfuQMVG4tGzzKUU1a+v3g2M0megT6FwMWE7uu78P/Pa83cdMYoAk16Ws
         f5zl/MP+HCfocO/Etvv7riqfPuKdvmtBbjvTvuCSZ4+snsIjuGE8UC1NRstqzJc/Wb
         xA4j8Taj0sfMIO/+vsURZs4aSt9U70d+EushgA0UHtiv82ds45ut4Wps0R3s6RrOsd
         ghmzCOMMyYBtKKKXl796hJ9a2NoxB5VWFfznm6avaA8Ef8cVlBvraQom0sYQn1EGq1
         dMvpyZX2fUmQq50mqEAhPifntSG7rsf8SPkzjtproanldQnN8KYxeDcPcZgpMrrrbB
         R+IvHLMXjgCLLqUOmfGe+1tZBM20H0242jVBQ2GwB9vEP0khL0O9fdNYUcieE60XJn
         eQst64vOrJmZI9cT8E+HP91BMeip9GBd76UsPt5jo9gMvUP/SQS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 20/24] fast-import: permit reading multiple marks files
Date:   Sat, 22 Feb 2020 20:17:45 +0000
Message-Id: <20200222201749.937983-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll want to read marks files for submodules as well.
Refactor the existing code to make it possible to read multiple marks
files, each into their own marks set.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b8b65a801c..b9ecd89699 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -493,9 +493,8 @@ static char *pool_strdup(const char *s)
 	return r;
 }
 
-static void insert_mark(uintmax_t idnum, struct object_entry *oe)
+static void insert_mark(struct mark_set *s, uintmax_t idnum, struct object_entry *oe)
 {
-	struct mark_set *s = marks;
 	while ((idnum >> s->shift) >= 1024) {
 		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 		s->shift = marks->shift + 10;
@@ -919,7 +918,7 @@ static int store_object(
 
 	e = insert_object(&oid);
 	if (mark)
-		insert_mark(mark, e);
+		insert_mark(marks, mark, e);
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
@@ -1117,7 +1116,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	e = insert_object(&oid);
 
 	if (mark)
-		insert_mark(mark, e);
+		insert_mark(marks, mark, e);
 
 	if (e->idx.offset) {
 		duplicate_count_by_type[OBJ_BLOB]++;
@@ -1712,16 +1711,9 @@ static void dump_marks(void)
 	}
 }
 
-static void read_marks(void)
+static void read_mark_file(struct mark_set *s, FILE *f)
 {
 	char line[512];
-	FILE *f = fopen(import_marks_file, "r");
-	if (f)
-		;
-	else if (import_marks_file_ignore_missing && errno == ENOENT)
-		goto done; /* Marks file does not exist */
-	else
-		die_errno("cannot read '%s'", import_marks_file);
 	while (fgets(line, sizeof(line), f)) {
 		uintmax_t mark;
 		char *end;
@@ -1747,8 +1739,20 @@ static void read_marks(void)
 			e->pack_id = MAX_PACK_ID;
 			e->idx.offset = 1; /* just not zero! */
 		}
-		insert_mark(mark, e);
+		insert_mark(s, mark, e);
 	}
+}
+
+static void read_marks(void)
+{
+	FILE *f = fopen(import_marks_file, "r");
+	if (f)
+		;
+	else if (import_marks_file_ignore_missing && errno == ENOENT)
+		goto done; /* Marks file does not exist */
+	else
+		die_errno("cannot read '%s'", import_marks_file);
+	read_mark_file(marks, f);
 	fclose(f);
 done:
 	import_marks_file_done = 1;
@@ -3130,7 +3134,7 @@ static void parse_alias(void)
 		die(_("Expected 'to' command, got %s"), command_buf.buf);
 	e = find_object(&b.oid);
 	assert(e);
-	insert_mark(next_mark, e);
+	insert_mark(marks, next_mark, e);
 }
 
 static char* make_fast_import_path(const char *path)

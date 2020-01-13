Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214CC33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1F82081E
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Wci9kOyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgAMMsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728916AbgAMMsF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 86C27607FC
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919684;
        bh=feuJWoLumRPYIA7lRVMbuGBg6pbFdqBHQIC6joWgx5A=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=Wci9kOyqlsiB/v+zpGLiSkzwDSj74yXZytPH3hEmrE0/3sid88orJPYfC6Jeb8Jt5
         Ett1ymOkSq8gzeRy0VC+mr8SeOcE8EJyPHw4HPeAfya73fKN3wECUnB4AsNZhcwG8b
         +pRXFdyHyGUjXPfyIvGkLvEufXfvnSmM0KAr2XKhwOSwKjg7NmvaHYp1ON2TYjDsTQ
         3HgKlNHdvJQ3YOFl6DyQfEt3gjZSzLgAyl7MuLuOwLNKtdKNYmbMJTS/cVL3MOhUWv
         nZitnMklQk7neKAb5ZV+er5bJPdTz/YrQGjVUBVzoOL8Zyjy9Eh1CZPW034/4MxlQi
         ZpCjni94kl3z3hkCWqP5Hj0Kg0jdaJudDBOoBmlIxaHSHgqozY0cPGfD5lCds2ACDm
         A036QDOJy3ZazmwAbR4+YowKBM2ND8Wrx+26RATxHCFJlU8h81DiTEdMpnBKLZQJP1
         0y9+5h8N/giP65rGTJu8Lyb1VqQ0lF1eCRbHUKq29Mxatrst1AK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 18/22] fast-import: permit reading multiple marks files
Date:   Mon, 13 Jan 2020 12:47:25 +0000
Message-Id: <20200113124729.3684846-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
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

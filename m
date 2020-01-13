Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62044C33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3941C214AF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ce0j9ZoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAMMsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37792 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728778AbgAMMsG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DFEBD607FD
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919685;
        bh=0tMGIfCMy8exMJJxkDf0EmyjqQy4fuFMPseY7orttRA=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=Ce0j9ZoCFNsWNVzSV6uiLXbjPVwQg1dr2kr2+Hpsnnxq4UujpSr/rxF8GNlJv1fXg
         KY3Pa0uVlmm9m7VVoPGdg9gWkcHxOV55cZ/zuSLNivSbsDRioM0NUNyZ2H8ANJdcvF
         9u9pM1bHukqgWbiBoWb+RWFsQPak11MeMdBNHEz7SMvAanDl0MrMlafwUU3deMVvSL
         K+8QL69UsJ6oJzHSOLOUSkESmXWusdO3uGADr5YKWfNRxejAQ8utBHoB+RRGFBYl1Q
         H0MgDgxKCLxD2ZTU5kLOqEj+EsP+Ov9WDV20WghsUIGvae+1vXeQpu0vlmzwYEB5Lz
         aawhnaG7Ogy8/Ydajmzwk9Q2Y/0vWuouggQ2BL6u/GbWe0IeEuWiD8walu3UfNTcPV
         yfvbey4Y+yilhz0e4O0vpTWtCRVUcj2ELv6CRu90ceP10a97sFihtxUn5HzaO4aaru
         9qJhtlavtf2kH9/5/ykMh99NQTxCkHDBy8N/2xpO17q5/mnVu3w
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 19/22] fast-import: add helper function for inserting mark object entries
Date:   Mon, 13 Jan 2020 12:47:26 +0000
Message-Id: <20200113124729.3684846-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, everything we want to insert into a mark set is an object
entry. However, in the future, we will want to insert objects of other
types. Teach read_mark_file to take a function pointer which helps us
insert the object we want into our mark set.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b9ecd89699..3ce4a04473 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -131,6 +131,8 @@ struct recent_command {
 	char *buf;
 };
 
+typedef void (*mark_set_inserter_t)(struct mark_set *s, struct object_id *oid, uintmax_t mark);
+
 /* Configured limits on output */
 static unsigned long max_depth = 50;
 static off_t max_packsize;
@@ -1711,14 +1713,30 @@ static void dump_marks(void)
 	}
 }
 
-static void read_mark_file(struct mark_set *s, FILE *f)
+static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
+{
+	struct object_entry *e;
+	e = find_object(oid);
+	if (!e) {
+		enum object_type type = oid_object_info(the_repository,
+							oid, NULL);
+		if (type < 0)
+			die("object not found: %s", oid_to_hex(oid));
+		e = insert_object(oid);
+		e->type = type;
+		e->pack_id = MAX_PACK_ID;
+		e->idx.offset = 1; /* just not zero! */
+	}
+	insert_mark(s, mark, e);
+}
+
+static void read_mark_file(struct mark_set *s, FILE *f, mark_set_inserter_t inserter)
 {
 	char line[512];
 	while (fgets(line, sizeof(line), f)) {
 		uintmax_t mark;
 		char *end;
 		struct object_id oid;
-		struct object_entry *e;
 
 		end = strchr(line, '\n');
 		if (line[0] != ':' || !end)
@@ -1728,18 +1746,7 @@ static void read_mark_file(struct mark_set *s, FILE *f)
 		if (!mark || end == line + 1
 			|| *end != ' ' || get_oid_hex(end + 1, &oid))
 			die("corrupt mark line: %s", line);
-		e = find_object(&oid);
-		if (!e) {
-			enum object_type type = oid_object_info(the_repository,
-								&oid, NULL);
-			if (type < 0)
-				die("object not found: %s", oid_to_hex(&oid));
-			e = insert_object(&oid);
-			e->type = type;
-			e->pack_id = MAX_PACK_ID;
-			e->idx.offset = 1; /* just not zero! */
-		}
-		insert_mark(s, mark, e);
+		inserter(s, &oid, mark);
 	}
 }
 
@@ -1752,7 +1759,7 @@ static void read_marks(void)
 		goto done; /* Marks file does not exist */
 	else
 		die_errno("cannot read '%s'", import_marks_file);
-	read_mark_file(marks, f);
+	read_mark_file(marks, f, insert_object_entry);
 	fclose(f);
 done:
 	import_marks_file_done = 1;

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591671F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfBLBXh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34286 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbfBLBX3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:29 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3D50860E56;
        Tue, 12 Feb 2019 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934606;
        bh=W+BwfM3vhYynj0RTz/3+OCP3aiC/NWJ/DDb0jzsbWEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kIxu4Hlx0dvYYoE99vokiGkVYtcADlxX+r8QKI0jSPTuT1ivNPidWylmFLbJ6vFYu
         R3fI44TEUi/aHKR7mr58ZREdDV9HuLzn2W7MI1F+a34KaWkkupugijC+L6KQoNDQaV
         Lt7XtnHUMPftXOZK3DII72S2jUfEg4gJkQe5Vi2ki9N6q5KWibu2vWP9t3JCbo4vrE
         Bcs9XWKCcMjk/XY1Q5Wo8+Q0YU0pD0wScPCiSCI8o4yD3jhxbMCdFrCg/zNGk4r3Ii
         X72gpG9rS12ItoyHPnB+22CXK9VDOZ0sY9bXS/KMpN1Pc5DQ3i0xX/msrXyfvhzmJz
         V9HVM2MNjF3a5gn4iCbu/hOsTgUHt23Z8yBp5ClBJskiDrj8yoUpVvuNfHV7pQNxfw
         AgPXusJkZALE6G596a0Txyzl3BEQzSxfiYmiPU12AtUT0+RGucLpdY0C1V7pumS3Zi
         kgrD3kLGutsovpsuP/EVUoeMo3HRuyfoiv13mMCvuS6fBLtB2RB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 12/31] fast-import: make hash-size independent
Date:   Tue, 12 Feb 2019 01:22:37 +0000
Message-Id: <20190212012256.1005924-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace several uses of GIT_SHA1_HEXSZ and 40-based constants with
references to the_hash_algo.  Update the note handling code here to
compute path sizes based on GIT_MAX_RAWSZ as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7c9a10a77b..eba8c8c919 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1241,7 +1241,7 @@ static void load_tree(struct tree_entry *root)
 		c += e->name->str_len + 1;
 		hashcpy(e->versions[0].oid.hash, (unsigned char *)c);
 		hashcpy(e->versions[1].oid.hash, (unsigned char *)c);
-		c += GIT_SHA1_RAWSZ;
+		c += the_hash_algo->rawsz;
 	}
 	free(buf);
 }
@@ -1288,7 +1288,7 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 		strbuf_addf(b, "%o %s%c",
 			(unsigned int)(e->versions[v].mode & ~NO_DELTA),
 			e->name->str_dat, '\0');
-		strbuf_add(b, e->versions[v].oid.hash, GIT_SHA1_RAWSZ);
+		strbuf_add(b, e->versions[v].oid.hash, the_hash_algo->rawsz);
 	}
 }
 
@@ -2047,7 +2047,8 @@ static uintmax_t do_change_note_fanout(
 	unsigned int i, tmp_hex_oid_len, tmp_fullpath_len;
 	uintmax_t num_notes = 0;
 	struct object_id oid;
-	char realpath[60];
+	char realpath[GIT_MAX_RAWSZ * 3];
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (!root->tree)
 		load_tree(root);
@@ -2067,7 +2068,7 @@ static uintmax_t do_change_note_fanout(
 		 * of 2 chars.
 		 */
 		if (!e->versions[1].mode ||
-		    tmp_hex_oid_len > GIT_SHA1_HEXSZ ||
+		    tmp_hex_oid_len > hexsz ||
 		    e->name->str_len % 2)
 			continue;
 
@@ -2081,7 +2082,7 @@ static uintmax_t do_change_note_fanout(
 		tmp_fullpath_len += e->name->str_len;
 		fullpath[tmp_fullpath_len] = '\0';
 
-		if (tmp_hex_oid_len == GIT_SHA1_HEXSZ && !get_oid_hex(hex_oid, &oid)) {
+		if (tmp_hex_oid_len == hexsz && !get_oid_hex(hex_oid, &oid)) {
 			/* This is a note entry */
 			if (fanout == 0xff) {
 				/* Counting mode, no rename */
@@ -2352,7 +2353,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	struct object_entry *oe;
 	struct branch *s;
 	struct object_id oid, commit_oid;
-	char path[60];
+	char path[GIT_MAX_RAWSZ * 3];
 	uint16_t inline_data = 0;
 	unsigned char new_fanout;
 
@@ -2405,7 +2406,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		char *buf = read_object_with_reference(&commit_oid,
 						       commit_type, &size,
 						       &commit_oid);
-		if (!buf || size < 46)
+		if (!buf || size < the_hash_algo->hexsz)
 			die("Not a valid commit: %s", p);
 		free(buf);
 	} else
@@ -2456,7 +2457,7 @@ static void file_change_deleteall(struct branch *b)
 
 static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 {
-	if (!buf || size < GIT_SHA1_HEXSZ + 6)
+	if (!buf || size < the_hash_algo->hexsz + 6)
 		die("Not a valid commit: %s", oid_to_hex(&b->oid));
 	if (memcmp("tree ", buf, 5)
 		|| get_oid_hex(buf + 5, &b->branch_tree.versions[1].oid))
@@ -2555,7 +2556,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			char *buf = read_object_with_reference(&n->oid,
 							       commit_type,
 							       &size, &n->oid);
-			if (!buf || size < 46)
+			if (!buf || size < the_hash_algo->hexsz)
 				die("Not a valid commit: %s", from);
 			free(buf);
 		} else
@@ -2842,7 +2843,7 @@ static void parse_get_mark(const char *p)
 		die("Unknown mark: %s", command_buf.buf);
 
 	xsnprintf(output, sizeof(output), "%s\n", oid_to_hex(&oe->idx.oid));
-	cat_blob_write(output, GIT_SHA1_HEXSZ + 1);
+	cat_blob_write(output, the_hash_algo->hexsz + 1);
 }
 
 static void parse_cat_blob(const char *p)
@@ -2872,6 +2873,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 {
 	unsigned long size;
 	char *buf = NULL;
+	const unsigned hexsz = the_hash_algo->hexsz;
+
 	if (!oe) {
 		enum object_type type = oid_object_info(the_repository, oid,
 							NULL);
@@ -2905,12 +2908,12 @@ static struct object_entry *dereference(struct object_entry *oe,
 	/* Peel one layer. */
 	switch (oe->type) {
 	case OBJ_TAG:
-		if (size < GIT_SHA1_HEXSZ + strlen("object ") ||
+		if (size < hexsz + strlen("object ") ||
 		    get_oid_hex(buf + strlen("object "), oid))
 			die("Invalid SHA1 in tag: %s", command_buf.buf);
 		break;
 	case OBJ_COMMIT:
-		if (size < GIT_SHA1_HEXSZ + strlen("tree ") ||
+		if (size < hexsz + strlen("tree ") ||
 		    get_oid_hex(buf + strlen("tree "), oid))
 			die("Invalid SHA1 in commit: %s", command_buf.buf);
 	}

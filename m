Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAD31F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbdHPUQt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:49 -0400
Received: from vie01a-dmta-pe05-1.mx.upcmail.net ([84.116.36.11]:48958 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752547AbdHPUQs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:48 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kA-0008NP-TO
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:46 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGk1v01C5BuuEg01wGlMZ; Wed, 16 Aug 2017 22:16:45 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id C681845D4622; Wed, 16 Aug 2017 22:16:44 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 13/19] Convert index-pack to size_t
Date:   Wed, 16 Aug 2017 22:16:25 +0200
Message-Id: <1502914591-26215-14-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 builtin/index-pack.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7f3ccd0..bf2d728 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -435,7 +435,7 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
-static void *unpack_entry_data(off_t offset, unsigned long size,
+static void *unpack_entry_data(off_t offset, size_t size,
 			       enum object_type type, unsigned char *sha1)
 {
 	static char fixed_buf[8192];
@@ -444,10 +444,10 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	void *buf;
 	git_SHA_CTX c;
 	char hdr[32];
-	int hdrlen;
+	size_t hdrlen;
 
 	if (!is_delta_type(type)) {
-		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
+		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX, typename(type), (uintmax_t)size) + 1;
 		git_SHA1_Init(&c);
 		git_SHA1_Update(&c, hdr, hdrlen);
 	} else
@@ -489,7 +489,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 			      unsigned char *sha1)
 {
 	unsigned char *p;
-	unsigned long size, c;
+	size_t size, c;
 	off_t base_offset;
 	unsigned shift;
 	void *data;
@@ -551,11 +551,11 @@ static void *unpack_raw_entry(struct object_entry *obj,
 }
 
 static void *unpack_data(struct object_entry *obj,
-			 int (*consume)(const unsigned char *, unsigned long, void *),
+			 int (*consume)(const unsigned char *, size_t, void *),
 			 void *cb_data)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
-	off_t len = obj[1].idx.offset - from;
+	size_t len = obj[1].idx.offset - from;
 	unsigned char *data, *inbuf;
 	git_zstream stream;
 	int status;
@@ -728,10 +728,10 @@ struct compare_data {
 	struct object_entry *entry;
 	struct git_istream *st;
 	unsigned char *buf;
-	unsigned long buf_size;
+	size_t buf_size;
 };
 
-static int compare_objects(const unsigned char *buf, unsigned long size,
+static int compare_objects(const unsigned char *buf, size_t size,
 			   void *cb_data)
 {
 	struct compare_data *data = cb_data;
@@ -783,7 +783,7 @@ static int check_collison(struct object_entry *entry)
 }
 
 static void sha1_object(const void *data, struct object_entry *obj_entry,
-			unsigned long size, enum object_type type,
+			size_t size, enum object_type type,
 			const struct object_id *oid)
 {
 	void *new_data = NULL;
@@ -1311,11 +1311,11 @@ static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 
 static struct object_entry *append_obj_to_pack(struct sha1file *f,
 			       const unsigned char *sha1, void *buf,
-			       unsigned long size, enum object_type type)
+			       size_t size, enum object_type type)
 {
 	struct object_entry *obj = &objects[nr_objects++];
 	unsigned char header[10];
-	unsigned long s = size;
+	size_t s = size;
 	int n = 0;
 	unsigned char c = (type << 4) | (s & 15);
 	s >>= 4;
@@ -1585,10 +1585,10 @@ static void show_pack_info(int stat_only)
 			chain_histogram[obj_stat[i].delta_depth - 1]++;
 		if (stat_only)
 			continue;
-		printf("%s %-6s %" PRIuMAX " %lu %" PRIuMAX,
+		printf("%s %-6s %" PRIuMAX " %" PRIuMAX " %" PRIuMAX,
 		       oid_to_hex(&obj->idx.oid),
 		       typename(obj->real_type), (uintmax_t)obj->size,
-		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
+		       (uintmax_t)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
 			struct object_entry *bobj = &objects[obj_stat[i].base_object_no];
-- 
2.1.4


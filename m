Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C831F667
	for <e@80x24.org>; Sat, 12 Aug 2017 08:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbdHLIrc (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 04:47:32 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:33575 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751016AbdHLIra (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 04:47:30 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dgS4t-0004cn-Qy
        for git@vger.kernel.org; Sat, 12 Aug 2017 10:47:27 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id w8nR1v01q5BuuEg018nSwu; Sat, 12 Aug 2017 10:47:26 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 9261B45D4514; Sat, 12 Aug 2017 10:47:25 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH 3/9] Convert unpack-objects to size_t
Date:   Sat, 12 Aug 2017 10:47:17 +0200
Message-Id: <1502527643-21944-3-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 builtin/unpack-objects.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 001dd4b..0d8b6b3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -31,7 +31,7 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
  */
 struct obj_buffer {
 	char *buffer;
-	unsigned long size;
+	size_t size;
 };
 
 static struct decoration obj_decorate;
@@ -41,7 +41,7 @@ static struct obj_buffer *lookup_object_buffer(struct object *base)
 	return lookup_decoration(&obj_decorate, base);
 }
 
-static void add_object_buffer(struct object *object, char *buffer, unsigned long size)
+static void add_object_buffer(struct object *object, char *buffer, size_t size)
 {
 	struct obj_buffer *obj;
 	obj = xcalloc(1, sizeof(struct obj_buffer));
@@ -93,7 +93,7 @@ static void use(int bytes)
 		die(_("pack exceeds maximum allowed size"));
 }
 
-static void *get_data(unsigned long size)
+static void *get_data(size_t size)
 {
 	git_zstream stream;
 	void *buf = xmallocz(size);
@@ -130,7 +130,7 @@ struct delta_info {
 	struct object_id base_oid;
 	unsigned nr;
 	off_t base_offset;
-	unsigned long size;
+	size_t size;
 	void *delta;
 	struct delta_info *next;
 };
@@ -139,7 +139,7 @@ static struct delta_info *delta_list;
 
 static void add_delta_to_list(unsigned nr, const struct object_id *base_oid,
 			      off_t base_offset,
-			      void *delta, unsigned long size)
+			      void *delta, size_t size)
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
 
@@ -226,7 +226,7 @@ static void write_rest(void)
 }
 
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size);
+			 void *data, size_t size);
 
 /*
  * Write out nr-th object from the list, now we know the contents
@@ -234,7 +234,7 @@ static void added_object(unsigned nr, enum object_type type,
  * to be checked at the end.
  */
 static void write_object(unsigned nr, enum object_type type,
-			 void *buf, unsigned long size)
+			 void *buf, size_t size)
 {
 	if (!strict) {
 		if (write_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash) < 0)
@@ -291,7 +291,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
  * resolve all the deltified objects that are based on it.
  */
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size)
+			 void *data, size_t size)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
@@ -310,7 +310,7 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
-static void unpack_non_delta_entry(enum object_type type, unsigned long size,
+static void unpack_non_delta_entry(enum object_type type, size_t size,
 				   unsigned nr)
 {
 	void *buf = get_data(size);
@@ -436,7 +436,7 @@ static void unpack_one(unsigned nr)
 {
 	unsigned shift;
 	unsigned char *pack;
-	unsigned long size, c;
+	size_t size, c;
 	enum object_type type;
 
 	obj_list[nr].offset = consumed_bytes;
-- 
2.1.4


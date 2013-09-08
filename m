From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/14] index-pack: move delta base queuing code to unpack_raw_entry
Date: Sun,  8 Sep 2013 14:22:37 +0700
Message-ID: <1378624960-8919-12-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIa-0004EQ-NY
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab3IHHUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:40 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60255 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:39 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so4843401pbc.2
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axrHY6jm/IaMmm/zyCA+s6GbzOhLaXdMfiqRT7bLprg=;
        b=zpfPFQKSU+bAQaEYhYpvdiQSr34zJ2PwUduaUW5z15EeGX+6Li59//eVzpZsEVD603
         9q6bGLaHbp9Jzd84kKWzQP85c8j8qfNt9uZdZ16ZLzNGEG4srRbD1A9iglNIoSYRAPYQ
         GkgETedA/JwqtH2eZJtReySnRxOkmJfwher1hzPnJ+e3t4B1D2PtX/QrqgyvdMAh73nb
         JJz4G4L8PPlqa0iQqvkGq4rUns9Vpj93lgr9QPVvoIiKeGSZTPJzHWKwlo6BxVenqRMJ
         NbPGRsb0/DfeGX/uJMms//rzZW1Qc0srQ43tNKYDMbfyS+U4gmYfKw8ITT8JxNJ67qex
         xKzA==
X-Received: by 10.66.156.199 with SMTP id wg7mr13105668pab.81.1378624839279;
        Sun, 08 Sep 2013 00:20:39 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id nv6sm8462952pbc.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:48 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234208>

For v2, ofs-delta and ref-delta can only have queue one delta base at
a time. A v4 tree can have more than one delta base. Move the queuing
code up to unpack_raw_entry() and give unpack_tree_v4() more
flexibility to add its bases.
---
 builtin/index-pack.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dcb6409..8f2d929 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -568,6 +568,25 @@ static void *unpack_commit_v4(unsigned int offset, unsigned long size,
 	return dst.buf;
 }
 
+static void add_sha1_delta(struct object_entry *obj,
+			   const unsigned char *sha1)
+{
+	struct delta_entry *delta = deltas + nr_deltas;
+	delta->obj_no = obj - objects;
+	hashcpy(delta->base.sha1, sha1);
+	nr_deltas++;
+}
+
+static void add_ofs_delta(struct object_entry *obj,
+			  off_t offset)
+{
+	struct delta_entry *delta = deltas + nr_deltas;
+	delta->obj_no = obj - objects;
+	memset(&delta->base, 0, sizeof(delta->base));
+	delta->base.offset = offset;
+	nr_deltas++;
+}
+
 /*
  * v4 trees are actually kind of deltas and we don't do delta in the
  * first pass. This function only walks through a tree object to find
@@ -703,17 +722,16 @@ static void read_typesize_v2(struct object_entry *obj)
 }
 
 static void *unpack_raw_entry(struct object_entry *obj,
-			      union delta_base *delta_base,
 			      unsigned char *sha1)
 {
 	void *data;
-	uintmax_t val;
+	off_t offset;
 
 	obj->idx.offset = consumed_bytes;
 	input_crc32 = crc32(0, NULL, 0);
 
 	if (packv4) {
-		val = read_varint();
+		uintmax_t val = read_varint();
 		obj->type = val & 15;
 		obj->size = val >> 4;
 	} else
@@ -722,14 +740,14 @@ static void *unpack_raw_entry(struct object_entry *obj,
 
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		hashcpy(delta_base->sha1, fill_and_use(20));
+		add_sha1_delta(obj, fill_and_use(20));
 		break;
 	case OBJ_OFS_DELTA:
-		memset(delta_base, 0, sizeof(*delta_base));
-		val = read_varint();
-		delta_base->offset = obj->idx.offset - val;
-		if (delta_base->offset <= 0 || delta_base->offset >= obj->idx.offset)
-			bad_object(obj->idx.offset, _("delta base offset is out of bound"));
+		offset = obj->idx.offset - read_varint();
+		if (offset <= 0 || offset >= obj->idx.offset)
+			bad_object(obj->idx.offset,
+				   _("delta base offset is out of bound"));
+		add_ofs_delta(obj, offset);
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -1282,7 +1300,6 @@ static void parse_dictionaries(void)
 static void parse_pack_objects(unsigned char *sha1)
 {
 	int i, nr_delays = 0;
-	struct delta_entry *delta = deltas;
 	struct stat st;
 
 	if (verbose)
@@ -1291,12 +1308,9 @@ static void parse_pack_objects(unsigned char *sha1)
 				nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
-		void *data = unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
-		if (is_delta_type(obj->type)) {
-			nr_deltas++;
-			delta->obj_no = i;
-			delta++;
-		} else if (!data && obj->type == OBJ_PV4_TREE) {
+		void *data = unpack_raw_entry(obj, obj->idx.sha1);
+		if (is_delta_type(obj->type) ||
+		    (!data && obj->type == OBJ_PV4_TREE)) {
 			/* delay sha1_object() until second pass */
 		} else if (!data) {
 			/* large blobs, check later */
-- 
1.8.2.83.gc99314b

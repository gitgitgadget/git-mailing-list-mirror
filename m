From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/14] index-pack: record all delta bases in v4 (tree and ref-delta)
Date: Sun,  8 Sep 2013 14:22:38 +0700
Message-ID: <1378624960-8919-13-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIg-0004Gf-2C
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab3IHHUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:46 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33096 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:45 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so5011773pab.26
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xepYNUuDE97ardPSqZ+Z+3BzRq429Zy/F9AOQmWQf70=;
        b=0gY/6HUtIhfdjh7p1IqP1mDGHZUx2ZhKMofIaS2I5gwnGzVlU3rI2xUMrlFb3X2/sP
         0CrBztm6gZjETGNPo6xGZGW9VfEcKczKYJSKVo1mYAAAi+5/Vfwrg7MXrXFkK6YLb5e+
         k9TkC2cdB2TYCaqnmhbcY7/j4BSHlC0mGR6q9wRlsahXGGw9PpZG+ujtKi3yj/D/o5VH
         dOQ0tbvTVE4eMbsJPssyGXP45S/+TvZQIwNyrF8sbNKZCovxRnR8hg4S0XhQ0DduUgy8
         q0eI2Zu4EN+4RacZXSHoLPs6L3enym7n/2AsxdanoDqI8y2Ac4G01pzdHE/GscnHTsh8
         apbg==
X-Received: by 10.68.76.101 with SMTP id j5mr12322548pbw.67.1378624845151;
        Sun, 08 Sep 2013 00:20:45 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id tg7sm8424903pbc.36.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:53 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234209>

---
 builtin/index-pack.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8f2d929..e903a49 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,6 +24,7 @@ struct object_entry {
 	enum object_type real_type; /* type after delta resolving */
 	unsigned delta_depth;
 	int base_object_no;
+	int nr_bases;		/* only valid for v4 trees */
 };
 
 union delta_base {
@@ -482,6 +483,11 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
+static int is_delta_tree(const struct object_entry *obj)
+{
+	return obj->type == OBJ_PV4_TREE && obj->nr_bases > 0;
+}
+
 static void read_and_inflate(unsigned long offset,
 			     void *buf, unsigned long size,
 			     unsigned long wraparound,
@@ -587,6 +593,20 @@ static void add_ofs_delta(struct object_entry *obj,
 	nr_deltas++;
 }
 
+static void add_tree_delta_base(struct object_entry *obj,
+				const unsigned char *base,
+				int delta_start)
+{
+	int i;
+
+	for (i = delta_start; i < nr_deltas; i++)
+		if (!hashcmp(base, deltas[i].base.sha1))
+			return;
+
+	add_sha1_delta(obj, base);
+	obj->nr_bases++;
+}
+
 /*
  * v4 trees are actually kind of deltas and we don't do delta in the
  * first pass. This function only walks through a tree object to find
@@ -601,12 +621,14 @@ static void *unpack_tree_v4(struct object_entry *obj,
 	unsigned int nr = read_varint();
 	const unsigned char *last_base = NULL;
 	struct strbuf sb = STRBUF_INIT;
+	int delta_start = nr_deltas;
 	while (nr) {
 		unsigned int copy_start_or_path = read_varint();
 		if (copy_start_or_path & 1) { /* copy_start */
 			unsigned int copy_count = read_varint();
 			if (copy_count & 1) { /* first delta */
 				last_base = read_sha1table_ref();
+				add_tree_delta_base(obj, last_base, delta_start);
 			} else if (!last_base)
 				bad_object(offset,
 					   _("missing delta base unpack_tree_v4"));
@@ -740,9 +762,15 @@ static void *unpack_raw_entry(struct object_entry *obj,
 
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		add_sha1_delta(obj, fill_and_use(20));
+		if (packv4)
+			add_sha1_delta(obj, read_sha1table_ref());
+		else
+			add_sha1_delta(obj, fill_and_use(20));
 		break;
 	case OBJ_OFS_DELTA:
+		if (packv4)
+			die(_("pack version 4 does not support ofs-delta type (offset %lu)"),
+			    obj->idx.offset);
 		offset = obj->idx.offset - read_varint();
 		if (offset <= 0 || offset >= obj->idx.offset)
 			bad_object(obj->idx.offset,
@@ -1309,8 +1337,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, obj->idx.sha1);
-		if (is_delta_type(obj->type) ||
-		    (!data && obj->type == OBJ_PV4_TREE)) {
+		if (is_delta_type(obj->type) || is_delta_tree(obj)) {
 			/* delay sha1_object() until second pass */
 		} else if (!data) {
 			/* large blobs, check later */
-- 
1.8.2.83.gc99314b

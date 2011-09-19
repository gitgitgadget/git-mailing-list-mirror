From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 4/8] fast-import: extract common sha1_file access functions
Date: Mon, 19 Sep 2011 07:27:33 +0600
Message-ID: <1316395657-6991-5-git-send-email-divanorama@gmail.com>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:21:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5SYF-0007cL-46
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440Ab1ISBVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:30 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34490 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab1ISBV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:26 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so7286815wwf.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xHfEa4uBIk1WNqFON3mTvxC9VyR24+oP4q/SFkJO1zQ=;
        b=SPqqDtbeKFSe/Lg+4zRla76uPdfpmQ/7GUrQ5uJhfmSA3PsYmXR89JXzCr7YXZr3+B
         I1pl2j4q5W4VtfoVt0AI61qBPbfpZs3mKuku082nZYYVzP5FAwN+34ZaxAGP92SzPqeW
         EOqWW8QAFY67YY1dNy8QZoth56QWzP0vx+9s0=
Received: by 10.216.171.3 with SMTP id q3mr2068133wel.50.1316395286008;
        Sun, 18 Sep 2011 18:21:26 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181662>

fast-import asks sha1_object_info and find_sha1_pack to initialize
struct object_entry in several codepoints.

Extract common functions doing this initialization.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   82 +++++++++++++++++++++++---------------------------------
 1 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 47c1e69..3c2a067 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -589,6 +589,28 @@ static struct object_entry *insert_object(unsigned char *sha1)
 	return e;
 }
 
+static void resolve_sha1_object(struct object_entry *oe)
+{
+	enum object_type type = sha1_object_info(oe->idx.sha1, NULL);
+	if (type < 0)
+		die("object not found: %s", sha1_to_hex(oe->idx.sha1));
+	oe->type = type;
+	oe->pack_id = MAX_PACK_ID;
+	oe->idx.offset = 1; /* nonzero */
+}
+
+static int try_resolve_sha1_pack_object(struct object_entry *e,
+						enum object_type type)
+{
+	if (!find_sha1_pack(e->idx.sha1, packed_git))
+		return 0;
+
+	e->type = type;
+	e->pack_id = MAX_PACK_ID;
+	e->idx.offset = 1; /* just not zero! */
+	return 1;
+}
+
 static unsigned int hc_str(const char *s, size_t len)
 {
 	unsigned int r = 0;
@@ -1042,10 +1064,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_sha1_pack(sha1, packed_git)) {
-		e->type = type;
-		e->pack_id = MAX_PACK_ID;
-		e->idx.offset = 1; /* just not zero! */
+	} else if (try_resolve_sha1_pack_object(e, type)) {
 		duplicate_count_by_type[type]++;
 		return 1;
 	}
@@ -1252,10 +1271,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(offset, &pack_file_ctx);
 
-	} else if (find_sha1_pack(sha1, packed_git)) {
-		e->type = OBJ_BLOB;
-		e->pack_id = MAX_PACK_ID;
-		e->idx.offset = 1; /* just not zero! */
+	} else if (try_resolve_sha1_pack_object(e, OBJ_BLOB)) {
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(offset, &pack_file_ctx);
 
@@ -1838,13 +1854,8 @@ static void read_marks(void)
 			die("corrupt mark line: %s", line);
 		e = find_object(sha1);
 		if (!e) {
-			enum object_type type = sha1_object_info(sha1, NULL);
-			if (type < 0)
-				die("object not found: %s", sha1_to_hex(sha1));
 			e = insert_object(sha1);
-			e->type = type;
-			e->pack_id = MAX_PACK_ID;
-			e->idx.offset = 1; /* just not zero! */
+			resolve_sha1_object(e);
 		}
 		insert_mark(mark, e);
 	}
@@ -2299,16 +2310,8 @@ static void file_change_m(struct branch *b)
 						OBJ_TREE: OBJ_BLOB;
 		if (!oe)
 			oe = insert_object(sha1);
-		if (!oe->idx.offset) {
-			enum object_type type = sha1_object_info(oe->idx.sha1, NULL);
-			if (type < 0)
-				die("%s not found: %s",
-						S_ISDIR(mode) ?  "Tree" : "Blob",
-						command_buf.buf);
-			oe->type = type;
-			oe->pack_id = MAX_PACK_ID;
-			oe->idx.offset = 1; /* nonzero */
-		}
+		if (!oe->idx.offset)
+			resolve_sha1_object(oe);
 		if (oe->type != expected)
 			die("Not a %s (actually a %s): %s",
 				typename(expected), typename(oe->type),
@@ -2450,14 +2453,8 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 		parse_and_store_blob(&last_blob, sha1, 0);
 		oe = find_object(sha1);
 	} else if (oe) {
-		if (!oe->idx.offset) {
-			enum object_type type = sha1_object_info(oe->idx.sha1, NULL);
-			if (type < 0)
-				die("Blob not found: %s", command_buf.buf);
-			oe->type = type;
-			oe->pack_id = MAX_PACK_ID;
-			oe->idx.offset = 1; /* nonzero */
-		}
+		if (!oe->idx.offset)
+			resolve_sha1_object(oe);
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
 				typename(oe->type), command_buf.buf);
@@ -2737,15 +2734,10 @@ static void parse_new_tag(void)
 		hashcpy(sha1, oe->idx.sha1);
 	} else if (!get_sha1(from, sha1)) {
 		struct object_entry *oe = insert_object(sha1);
-		if (!oe->idx.offset) {
-			type = sha1_object_info(sha1, NULL);
-			if (type < 0)
-				die("Not a valid object: %s", from);
-			oe->type = type;
-			oe->pack_id = MAX_PACK_ID;
-			oe->idx.offset = 1; /* nonzero */
-		} else
-			type = oe->type;
+		if (!oe->idx.offset)
+			resolve_sha1_object(oe);
+
+		type = oe->type;
 	} else
 		die("Invalid ref name or SHA1 expression: %s", from);
 	read_next_command();
@@ -2892,14 +2884,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 	unsigned long size;
 	char *buf = NULL;
 	if (!oe) {
-		enum object_type type = sha1_object_info(sha1, NULL);
-		if (type < 0)
-			die("object not found: %s", sha1_to_hex(sha1));
-		/* cache it! */
 		oe = insert_object(sha1);
-		oe->type = type;
-		oe->pack_id = MAX_PACK_ID;
-		oe->idx.offset = 1;
+		resolve_sha1_object(oe);
 	}
 	switch (oe->type) {
 	case OBJ_TREE:	/* easy case. */
-- 
1.7.3.4

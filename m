From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 8/8] fast-import: cache objects while dereferencing
Date: Mon, 19 Sep 2011 07:27:37 +0600
Message-ID: <1316395657-6991-9-git-send-email-divanorama@gmail.com>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:21:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5SYW-0007it-GM
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab1ISBVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:37 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:46718 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab1ISBVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:35 -0400
Received: by mail-wy0-f170.google.com with SMTP id 8so8452393wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QIyoVE3aiQJOhonVbeB/FV7VL6Ix/flL4cTTxYz0Rw4=;
        b=ksoitYgUZyOs0sdPSUZo4pnpyzZ3Q6EGAMhDWK36cv4Ty06CnQLjVNoU1UyV1vivh5
         f8+yd7JQptrQBYSeXdaweDUINGfMD87QKUFv1ERHIn4w1RMh8Lv+nezoozD3oHIpe/1X
         ijIeX9ExCmBAnS5+dRVJS4w2w0zpfRS50ObWk=
Received: by 10.227.57.77 with SMTP id b13mr2052452wbh.96.1316395294860;
        Sun, 18 Sep 2011 18:21:34 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181663>

dereference() reads objects with read_sha1_file, and reads types
of objects with sha1_object_info. But doesn't cache the result in
struct object_entry.

Make these calls to read_sha1_file and sha1_object_info cached in
struct object_entry.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3c4c998..43158c8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2891,15 +2891,11 @@ static void parse_cat_blob(void)
 	cat_blob(oe);
 }
 
-static struct object_entry *dereference(struct object_entry *oe,
-					unsigned char sha1[20])
+static struct object_entry *dereference(struct object_entry *oe)
 {
+	unsigned char next_sha1[20];
 	unsigned long size;
 	char *buf = NULL;
-	if (!oe) {
-		oe = insert_object(sha1);
-		resolve_sha1_object(oe);
-	}
 	switch (oe->type) {
 	case OBJ_TREE:	/* easy case. */
 		return oe;
@@ -2914,26 +2910,31 @@ static struct object_entry *dereference(struct object_entry *oe,
 		buf = gfi_unpack_entry(oe, &size);
 	} else {
 		enum object_type unused;
-		buf = read_sha1_file(sha1, &unused, &size);
+		buf = read_sha1_file(oe->idx.sha1, &unused, &size);
 	}
 	if (!buf)
-		die("Can't load object %s", sha1_to_hex(sha1));
+		die("Can't load object %s", sha1_to_hex(oe->idx.sha1));
 
 	/* Peel one layer. */
 	switch (oe->type) {
 	case OBJ_TAG:
 		if (size < 40 + strlen("object ") ||
-		    get_sha1_hex(buf + strlen("object "), sha1))
+		    get_sha1_hex(buf + strlen("object "), next_sha1))
 			die("Invalid SHA1 in tag: %s", command_buf.buf);
 		break;
 	case OBJ_COMMIT:
 		if (size < 40 + strlen("tree ") ||
-		    get_sha1_hex(buf + strlen("tree "), sha1))
+		    get_sha1_hex(buf + strlen("tree "), next_sha1))
 			die("Invalid SHA1 in commit: %s", command_buf.buf);
 	}
 
 	free(buf);
-	return find_object(sha1);
+
+	oe = insert_object(next_sha1);
+	if (!oe->idx.offset)
+		resolve_sha1_object(oe);
+
+	return oe;
 }
 
 static struct object_entry *parse_treeish_dataref(const char **p)
@@ -2953,12 +2954,14 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	} else {	/* <sha1> */
 		if (get_sha1_hex(*p, sha1))
 			die("Invalid SHA1: %s", command_buf.buf);
-		e = find_object(sha1);
+		e = insert_object(sha1);
+		if (!e->idx.offset)
+			resolve_sha1_object(e);
 		*p += 40;
 	}
 
-	while (!e || e->type != OBJ_TREE)
-		e = dereference(e, sha1);
+	while (e->type != OBJ_TREE)
+		e = dereference(e);
 	return e;
 }
 
-- 
1.7.3.4

From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 6/8] fast-import: cache oe in load_tree
Date: Mon, 19 Sep 2011 07:27:35 +0600
Message-ID: <1316395657-6991-7-git-send-email-divanorama@gmail.com>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:21:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5SYF-0007cL-KP
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab1ISBVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:34 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:46718 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab1ISBVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:31 -0400
Received: by mail-wy0-f170.google.com with SMTP id 8so8452393wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1eLyt9QvjYtmyk1u85y7TDluJulddptVadV5ZId+ifY=;
        b=uva5+gqeX3bwzogp8231MoS++08OeULrUSbgA6g0cLz4Gcyoel0uCI2u1BTe17gavn
         LSvgoVg7/erSiddUUp53KfwgcJlXjyrESPlD2vpZnlMH7Qhsr/VL83OZtIgg7dhH9zG4
         WzKyyWbto7nc9vdhNr8VxeOs3nqocSNspri80=
Received: by 10.216.178.144 with SMTP id f16mr1932552wem.104.1316395290447;
        Sun, 18 Sep 2011 18:21:30 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181660>

load_tree reads a tree object given it's sha1. If there was no
struct object_entry allocated for this sha1, load_tree doesn't
allocate it and thus doesn't cache it's struct object_entry.

Make this read_sha1_file cached in struct object_entry.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index dd3dcd5..1c0716b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -599,6 +599,17 @@ static void resolve_sha1_object(struct object_entry *oe)
 	oe->idx.offset = 1; /* nonzero */
 }
 
+static void *resolve_sha1_object_read(struct object_entry *oe, enum object_type *type, unsigned long *size)
+{
+	void *ret = read_sha1_file(oe->idx.sha1, type, size);
+	if (!ret)
+		return ret;
+	oe->type = *type;
+	oe->pack_id = MAX_PACK_ID;
+	oe->idx.offset = 1; /* nonzero */
+	return ret;
+}
+
 static int try_resolve_sha1_pack_object(struct object_entry *e,
 						enum object_type type)
 {
@@ -1363,8 +1374,8 @@ static void load_tree(struct tree_entry *root)
 	if (is_null_sha1(sha1))
 		return;
 
-	myoe = find_object(sha1);
-	if (myoe && myoe->pack_id != MAX_PACK_ID) {
+	myoe = insert_object(sha1);
+	if (myoe->idx.offset && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
 			die("Not a tree: %s", sha1_to_hex(sha1));
 		t->delta_depth = myoe->depth;
@@ -1373,7 +1384,10 @@ static void load_tree(struct tree_entry *root)
 			die("Can't load tree %s", sha1_to_hex(sha1));
 	} else {
 		enum object_type type;
-		buf = read_sha1_file(sha1, &type, &size);
+		if (!myoe->idx.offset)
+			buf = resolve_sha1_object_read(myoe, &type, &size);
+		else
+			buf = read_sha1_file(sha1, &type, &size);
 		if (!buf || type != OBJ_TREE)
 			die("Can't load tree %s", sha1_to_hex(sha1));
 	}
-- 
1.7.3.4

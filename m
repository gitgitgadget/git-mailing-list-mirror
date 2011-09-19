From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 7/8] fast-import: cache oe in cat_blob
Date: Mon, 19 Sep 2011 07:27:36 +0600
Message-ID: <1316395657-6991-8-git-send-email-divanorama@gmail.com>
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
	id 1R5SYG-0007cL-4r
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab1ISBVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34490 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681Ab1ISBVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:33 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so7286815wwf.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YnlP1w7bEBC7lwOfB3cJ71lsL7l1TBAXU0G4r4dM7nY=;
        b=np710jO1CnDaV0euGg9yXPlaGGtAjcTTpC9crxXGI/o0kXFBguuSSdAMs4p1gwAutE
         61558O0N/gwD1p/IOkoQA5TTrK8Ko2lqaOwdF0LPuH5ifPRih++MqdoQhs3cGZSBYf10
         AgyN/S9rkQGz8PeI8HNKtirSVoW9u9khLPLy0=
Received: by 10.227.157.149 with SMTP id b21mr2002878wbx.95.1316395292687;
        Sun, 18 Sep 2011 18:21:32 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181661>

cat_blob read_sha1_file's the blob object and doesn't cache
it in struct object_entry.

Make this call to read_sha1_file cached in struct object_entry.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1c0716b..3c4c998 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2816,16 +2816,18 @@ static void cat_blob_write(const char *buf, unsigned long size)
 		die_errno("Write to frontend failed");
 }
 
-static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
+static void cat_blob(struct object_entry *oe)
 {
 	struct strbuf line = STRBUF_INIT;
 	unsigned long size;
 	enum object_type type = 0;
 	char *buf;
 
-	if (!oe || oe->pack_id == MAX_PACK_ID) {
-		buf = read_sha1_file(sha1, &type, &size);
-	} else {
+	if (!oe->idx.offset)
+		buf = resolve_sha1_object_read(oe, &type, &size);
+	else if (oe->pack_id == MAX_PACK_ID)
+		buf = read_sha1_file(oe->idx.sha1, &type, &size);
+	else {
 		type = oe->type;
 		buf = gfi_unpack_entry(oe, &size);
 	}
@@ -2835,25 +2837,25 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	 */
 	if (type <= 0) {
 		strbuf_reset(&line);
-		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
+		strbuf_addf(&line, "%s missing\n", sha1_to_hex(oe->idx.sha1));
 		cat_blob_write(line.buf, line.len);
 		strbuf_release(&line);
 		free(buf);
 		return;
 	}
 	if (!buf)
-		die("Can't read object %s", sha1_to_hex(sha1));
+		die("Can't read object %s", sha1_to_hex(oe->idx.sha1));
 	if (type != OBJ_BLOB)
 		die("Object %s is a %s but a blob was expected.",
-		    sha1_to_hex(sha1), typename(type));
+		    sha1_to_hex(oe->idx.sha1), typename(type));
 	strbuf_reset(&line);
-	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(oe->idx.sha1),
 						typename(type), size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
 	cat_blob_write(buf, size);
 	cat_blob_write("\n", 1);
-	if (oe && oe->pack_id == pack_id) {
+	if (oe->pack_id == pack_id) {
 		last_blob.offset = oe->idx.offset;
 		strbuf_attach(&last_blob.data, buf, size, size);
 		last_blob.depth = oe->depth;
@@ -2878,16 +2880,15 @@ static void parse_cat_blob(void)
 			die("Unknown mark: %s", command_buf.buf);
 		if (*x)
 			die("Garbage after mark: %s", command_buf.buf);
-		hashcpy(sha1, oe->idx.sha1);
 	} else {
 		if (get_sha1_hex(p, sha1))
 			die("Invalid SHA1: %s", command_buf.buf);
 		if (p[40])
 			die("Garbage after SHA1: %s", command_buf.buf);
-		oe = find_object(sha1);
+		oe = insert_object(sha1);
 	}
 
-	cat_blob(oe, sha1);
+	cat_blob(oe);
 }
 
 static struct object_entry *dereference(struct object_entry *oe,
-- 
1.7.3.4

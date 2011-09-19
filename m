From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/8] fast-import: cache oe in note_change_n
Date: Mon, 19 Sep 2011 07:27:32 +0600
Message-ID: <1316395657-6991-4-git-send-email-divanorama@gmail.com>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:21:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5SYE-0007cL-K3
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab1ISBV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:29 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:46718 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab1ISBVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:24 -0400
Received: by mail-wy0-f170.google.com with SMTP id 8so8452393wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mf8LxZ9sD63DL2hRTMCGAsFfHZcPxT+1m9k9JG6E1wE=;
        b=v8lJRZSLN/l9ZVF2FxNtDYr0TjyKggPcpDaHbCCGmfPHsiNPVtRxbMDSPvhPLrdlmM
         JVtOlV200isy8Nk9FX1+qoOi/cYy+exIHK8KMWeI9ix7b6Px0rooDLQ/WhnLCUNh2Eg5
         LAnDL1vGh5AcSMHfYZB9+q96bc4fRYR9ne4vs=
Received: by 10.227.68.202 with SMTP id w10mr2149553wbi.71.1316395283713;
        Sun, 18 Sep 2011 18:21:23 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181659>

note_change_n checks the type of annotating data object to be Blob.
For objects given by sha1 it does so via sha1_object_info and does not
cache the result in struct object_entry.

Make this call to sha1_object_info cached in struct object_entry. Also
make note_change_n operate on oe rather than on sha1 - no functional
change, just a purification.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2b049f7..47c1e69 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2394,9 +2394,9 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
-	struct object_entry *oe = oe;
+	struct object_entry *oe = NULL;
 	struct branch *s;
-	unsigned char sha1[20], commit_sha1[20];
+	unsigned char commit_sha1[20];
 	char path[60];
 	uint16_t inline_data = 0;
 	unsigned char new_fanout;
@@ -2405,15 +2405,16 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 	if (*p == ':') {
 		char *x;
 		oe = find_mark(strtoumax(p + 1, &x, 10));
-		hashcpy(sha1, oe->idx.sha1);
 		p = x;
 	} else if (!prefixcmp(p, "inline")) {
 		inline_data = 1;
 		p += 6;
 	} else {
+		unsigned char sha1[20];
 		if (get_sha1_hex(p, sha1))
 			die("Invalid SHA1: %s", command_buf.buf);
-		oe = find_object(sha1);
+		if (!is_null_sha1(sha1))
+			oe = insert_object(sha1);
 		p += 40;
 	}
 	if (*p++ != ' ')
@@ -2440,36 +2441,39 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 		die("Invalid ref name or SHA1 expression: %s", p);
 
 	if (inline_data) {
+		unsigned char sha1[20];
 		if (p != uq.buf) {
 			strbuf_addstr(&uq, p);
 			p = uq.buf;
 		}
 		read_next_command();
 		parse_and_store_blob(&last_blob, sha1, 0);
+		oe = find_object(sha1);
 	} else if (oe) {
+		if (!oe->idx.offset) {
+			enum object_type type = sha1_object_info(oe->idx.sha1, NULL);
+			if (type < 0)
+				die("Blob not found: %s", command_buf.buf);
+			oe->type = type;
+			oe->pack_id = MAX_PACK_ID;
+			oe->idx.offset = 1; /* nonzero */
+		}
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
 				typename(oe->type), command_buf.buf);
-	} else if (!is_null_sha1(sha1)) {
-		enum object_type type = sha1_object_info(sha1, NULL);
-		if (type < 0)
-			die("Blob not found: %s", command_buf.buf);
-		if (type != OBJ_BLOB)
-			die("Not a blob (actually a %s): %s",
-			    typename(type), command_buf.buf);
 	}
 
 	construct_path_with_fanout(sha1_to_hex(commit_sha1), old_fanout, path);
 	if (tree_content_remove(&b->branch_tree, path, NULL))
 		b->num_notes--;
 
-	if (is_null_sha1(sha1))
+	if (!oe)
 		return; /* nothing to insert */
 
 	b->num_notes++;
 	new_fanout = convert_num_notes_to_fanout(b->num_notes);
 	construct_path_with_fanout(sha1_to_hex(commit_sha1), new_fanout, path);
-	tree_content_set(&b->branch_tree, path, sha1, S_IFREG | 0644, NULL);
+	tree_content_set(&b->branch_tree, path, oe->idx.sha1, S_IFREG | 0644, NULL);
 }
 
 static void file_change_deleteall(struct branch *b)
-- 
1.7.3.4

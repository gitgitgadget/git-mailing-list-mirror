From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/3] fast-import: rename object_count to pack_object_count
Date: Mon, 19 Sep 2011 01:01:48 +0600
Message-ID: <1316372508-7173-4-git-send-email-divanorama@gmail.com>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 20:55:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MWr-0006E5-QD
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab1IRSzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 14:55:47 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65049 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab1IRSzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 14:55:41 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so7083549wwf.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YqQKJVnKegxCtrbzuyDJay8xXuuXdPjESVCgWXvz20o=;
        b=cWXyvVy9Cc7qW2aVbAuMMN08lemJGtVtLOjub288W1OggETeiO9oe375zoO4jzI5SK
         /T9YUg+hKAIuKBlLAVP+xaH9vNfgG+VscoxeDfkkv1z0NBQQHRVD/1Fk9kBse8XvdiDc
         g6MxHG2cA90sR2zqNKrh0gPdiWFcR+BEWXs5w=
Received: by 10.227.157.149 with SMTP id b21mr1755511wbx.95.1316372140870;
        Sun, 18 Sep 2011 11:55:40 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id h20sm16877374wbo.22.2011.09.18.11.55.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 11:55:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181624>

object_count is used to count objects that'll go to the current pack.
While object_count_by_* are used to count total amount of objects and
are not used to determine if current packfile is empty.

Rename (and move declaration) object_count to pack_object_count to
avoid possible confusion.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 014a807..8f2411b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -290,7 +290,6 @@ static uintmax_t object_count_by_type[1 << TYPE_BITS];
 static uintmax_t duplicate_count_by_type[1 << TYPE_BITS];
 static uintmax_t delta_count_by_type[1 << TYPE_BITS];
 static uintmax_t delta_count_attempts_by_type[1 << TYPE_BITS];
-static unsigned long object_count;
 static unsigned long branch_count;
 static unsigned long branch_load_count;
 static int failure;
@@ -316,6 +315,7 @@ static struct sha1file *pack_file;
 static struct packed_git *pack_data;
 static struct packed_git **all_packs;
 static off_t pack_size;
+static unsigned long pack_object_count;
 
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
@@ -880,7 +880,7 @@ static void start_packfile(void)
 
 	pack_data = p;
 	pack_size = sizeof(hdr);
-	object_count = 0;
+	pack_object_count = 0;
 
 	all_packs = xrealloc(all_packs, sizeof(*all_packs) * (pack_id + 1));
 	all_packs[pack_id] = p;
@@ -894,17 +894,17 @@ static const char *create_index(void)
 	struct object_entry_pool *o;
 
 	/* Build the table of object IDs. */
-	idx = xmalloc(object_count * sizeof(*idx));
+	idx = xmalloc(pack_object_count * sizeof(*idx));
 	c = idx;
 	for (o = blocks; o; o = o->next_pool)
 		for (e = o->next_free; e-- != o->entries;)
 			if (pack_id == e->pack_id)
 				*c++ = &e->idx;
-	last = idx + object_count;
+	last = idx + pack_object_count;
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts, pack_data->sha1);
+	tmpfile = write_idx_file(NULL, idx, pack_object_count, &pack_idx_opts, pack_data->sha1);
 	free(idx);
 	return tmpfile;
 }
@@ -953,7 +953,7 @@ static void end_packfile(void)
 	struct packed_git *old_p = pack_data, *new_p;
 
 	clear_delta_base_cache();
-	if (object_count) {
+	if (pack_object_count) {
 		unsigned char cur_pack_sha1[20];
 		char *idx_name;
 		int i;
@@ -963,7 +963,7 @@ static void end_packfile(void)
 		close_pack_windows(pack_data);
 		sha1close(pack_file, cur_pack_sha1, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
-				    pack_data->pack_name, object_count,
+				    pack_data->pack_name, pack_object_count,
 				    cur_pack_sha1, pack_size);
 		close(pack_data->pack_fd);
 		idx_name = keep_pack(create_index());
@@ -1103,7 +1103,7 @@ static int store_object(
 	e->type = type;
 	e->pack_id = pack_id;
 	e->idx.offset = pack_size;
-	object_count++;
+	pack_object_count++;
 	object_count_by_type[type]++;
 
 	crc32_begin(pack_file);
@@ -1267,7 +1267,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		e->pack_id = pack_id;
 		e->idx.offset = offset;
 		e->idx.crc32 = crc32_end(pack_file);
-		object_count++;
+		pack_object_count++;
 		object_count_by_type[OBJ_BLOB]++;
 	}
 
@@ -3025,7 +3025,7 @@ static void parse_ls(struct branch *b)
 static void checkpoint(void)
 {
 	checkpoint_requested = 0;
-	if (object_count)
+	if (pack_object_count)
 		cycle_packfile();
 	dump_branches();
 	dump_tags();
-- 
1.7.3.4

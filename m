From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 03/10] add overflow tests on pack offset variables
Date: Mon, 09 Apr 2007 01:06:30 -0400
Message-ID: <11760951993225-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5u-00038I-7z
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbXDIFGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbXDIFGu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbXDIFGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:41 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:39 -0400 (EDT)
In-reply-to: <11760951993458-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44036>

Change a few size and offset variables to more appropriate type, then
add overflow tests on those offsets.  This prevents any bad data to be
generated/processed if off_t happens to not be large enough to handle
some big packs.

Better be safe than sorry.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c   |   19 +++++++++++++------
 builtin-unpack-objects.c |   17 +++++++++++------
 index-pack.c             |   14 ++++++++++----
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ee607a0..d0be879 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -369,7 +369,7 @@ static int revalidate_loose_object(struct object_entry *entry,
 	return check_loose_inflate(map, mapsize, size);
 }
 
-static off_t write_object(struct sha1file *f,
+static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry)
 {
 	unsigned long size;
@@ -503,16 +503,23 @@ static off_t write_one(struct sha1file *f,
 			       struct object_entry *e,
 			       off_t offset)
 {
+	unsigned long size;
+
+	/* offset is non zero if object is written already. */
 	if (e->offset || e->preferred_base)
-		/* offset starts from header size and cannot be zero
-		 * if it is written already.
-		 */
 		return offset;
-	/* if we are deltified, write out its base object first. */
+
+	/* if we are deltified, write out base object first. */
 	if (e->delta)
 		offset = write_one(f, e->delta, offset);
+
 	e->offset = offset;
-	return offset + write_object(f, e);
+	size = write_object(f, e);
+
+	/* make sure off_t is sufficiently large not to wrap */
+	if (offset > offset + size)
+		die("pack too large for current definition of off_t");
+	return offset + size;
 }
 
 static void write_pack_file(void)
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 63f7db6..f821906 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -13,7 +13,8 @@ static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-fil
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
-static unsigned long offset, len, consumed_bytes;
+static unsigned int offset, len;
+static off_t consumed_bytes;
 static SHA_CTX ctx;
 
 /*
@@ -49,6 +50,10 @@ static void use(int bytes)
 		die("used more bytes than were available");
 	len -= bytes;
 	offset += bytes;
+
+	/* make sure off_t is sufficiently large not to wrap */
+	if (consumed_bytes > consumed_bytes + bytes)
+		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
 }
 
@@ -88,17 +93,17 @@ static void *get_data(unsigned long size)
 
 struct delta_info {
 	unsigned char base_sha1[20];
-	unsigned long base_offset;
+	unsigned nr;
+	off_t base_offset;
 	unsigned long size;
 	void *delta;
-	unsigned nr;
 	struct delta_info *next;
 };
 
 static struct delta_info *delta_list;
 
 static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
-			      unsigned long base_offset,
+			      off_t base_offset,
 			      void *delta, unsigned long size)
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
@@ -113,7 +118,7 @@ static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
 }
 
 struct obj_info {
-	unsigned long offset;
+	off_t offset;
 	unsigned char sha1[20];
 };
 
@@ -200,7 +205,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	} else {
 		unsigned base_found = 0;
 		unsigned char *pack, c;
-		unsigned long base_offset;
+		off_t base_offset;
 		unsigned lo, mid, hi;
 
 		pack = fill(1);
diff --git a/index-pack.c b/index-pack.c
index 0e54aa6..66fb0bc 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -12,7 +12,7 @@ static const char index_pack_usage[] =
 
 struct object_entry
 {
-	unsigned long offset;
+	off_t offset;
 	unsigned long size;
 	unsigned int hdr_size;
 	enum object_type type;
@@ -22,7 +22,7 @@ struct object_entry
 
 union delta_base {
 	unsigned char sha1[20];
-	unsigned long offset;
+	off_t offset;
 };
 
 /*
@@ -83,7 +83,8 @@ static unsigned display_progress(unsigned n, unsigned total, unsigned last_pc)
 
 /* We always read in 4kB chunks. */
 static unsigned char input_buffer[4096];
-static unsigned long input_offset, input_len, consumed_bytes;
+static unsigned int input_offset, input_len;
+static off_t consumed_bytes;
 static SHA_CTX input_ctx;
 static int input_fd, output_fd, pack_fd;
 
@@ -129,6 +130,10 @@ static void use(int bytes)
 		die("used more bytes than were available");
 	input_len -= bytes;
 	input_offset += bytes;
+
+	/* make sure off_t is sufficiently large not to wrap */
+	if (consumed_bytes > consumed_bytes + bytes)
+		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
 }
 
@@ -216,7 +221,8 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_base)
 {
 	unsigned char *p, c;
-	unsigned long size, base_offset;
+	unsigned long size;
+	off_t base_offset;
 	unsigned shift;
 
 	obj->offset = consumed_bytes;
-- 
1.5.1.696.g6d352-dirty

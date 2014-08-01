From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Fri, 1 Aug 2014 19:10:44 -0400
Message-ID: <20140801231044.GA17960@peff.net>
References: <20140728171743.GA1927@peff.net>
 <53D806AC.3070806@gmail.com>
 <20140801223739.GA15649@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLyR-0004cm-NE
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 01:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbaHAXKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 19:10:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:44525 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754620AbaHAXKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 19:10:50 -0400
Received: (qmail 16013 invoked by uid 102); 1 Aug 2014 23:10:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Aug 2014 18:10:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2014 19:10:44 -0400
Content-Disposition: inline
In-Reply-To: <20140801223739.GA15649@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254681>

On Fri, Aug 01, 2014 at 06:37:39PM -0400, Jeff King wrote:

> > Btw.: Using struct-packing on 'struct bitmap_disk_entry' means that the
> > binary format of .bitmap files is incompatible between GCC and other
> > builds, correct?
> 
> The on-disk format is defined by JGit; if there are differences between
> the builds, that's a bug (and I would not be too surprised if there is
> one, as bitmaps have gotten very extensive testing on 32- and 64-bit
> gcc, but probably not much elsewhere).
> 
> We do use structs to represent disk structures in other bits of the
> packfile code (e.g., struct pack_idx_header), but the struct is vanilla
> enough that we assume every compiler gives us two tightly-packed 32-bit
> integers without having to bother with the "packed" attribute (and it
> seems to have worked in practice).
> 
> We should probably be more careful with that bitmap code. It looks like
> it wouldn't be too bad to drop it. I'll see if I can come up with a
> patch.

I confirmed that this does break horribly without the packed attribute
(as you'd expect; it's asking for 48-bit alignment!). p5310 notices it,
_if_ you have jgit installed to check against.

Here's a fix.

-- >8 --
Subject: pack-bitmap: do not use gcc packed attribute

The "__attribute__" flag may be a noop on some compilers.
That's OK as long as the code is correct without the
attribute, but in this case it is not. We would typically
end up with a struct that is 2 bytes too long due to struct
padding, breaking both reading and writing of bitmaps.

We can work around this by using an array of unsigned char
to represent the data, and relying on get/put_be32 to handle
alignment issues as we interact with the array.

Signed-off-by: Jeff King <peff@peff.net>
---
The accessors may be overkill; each function is called only a single
time in the whole codebase. But doing it this way rather than accessing
entry[4] inline at least puts the magic constants all in one place.

 pack-bitmap-write.c | 10 ++++------
 pack-bitmap.c       | 12 ++++++------
 pack-bitmap.h       | 42 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5f1791a..f885a7a 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -473,7 +473,7 @@ static void write_selected_commits_v1(struct sha1file *f,
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
-		struct bitmap_disk_entry on_disk;
+		unsigned char on_disk[BITMAP_DISK_ENTRY_LEN];
 
 		int commit_pos =
 			sha1_pos(stored->commit->object.sha1, index, index_nr, sha1_access);
@@ -481,11 +481,9 @@ static void write_selected_commits_v1(struct sha1file *f,
 		if (commit_pos < 0)
 			die("BUG: trying to write commit not in index");
 
-		on_disk.object_pos = htonl(commit_pos);
-		on_disk.xor_offset = stored->xor_offset;
-		on_disk.flags = stored->flags;
-
-		sha1write(f, &on_disk, sizeof(on_disk));
+		bitmap_disk_entry_create(on_disk, commit_pos,
+					 stored->xor_offset, stored->flags);
+		sha1write(f, on_disk, sizeof(on_disk));
 		dump_bitmap(f, stored->write_as);
 	}
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 91e4101..1b2a473 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -203,7 +203,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 
 	uint32_t i;
 	struct stored_bitmap **recent_bitmaps;
-	struct bitmap_disk_entry *entry;
+	unsigned char *entry;
 
 	recent_bitmaps = xcalloc(MAX_XOR_OFFSET, sizeof(struct stored_bitmap));
 
@@ -214,14 +214,14 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		uint32_t commit_idx_pos;
 		const unsigned char *sha1;
 
-		entry = (struct bitmap_disk_entry *)(index->map + index->map_pos);
-		index->map_pos += sizeof(struct bitmap_disk_entry);
+		entry = index->map + index->map_pos;
+		index->map_pos += BITMAP_DISK_ENTRY_LEN;
 
-		commit_idx_pos = ntohl(entry->object_pos);
+		commit_idx_pos = bitmap_disk_entry_object_pos(entry);
 		sha1 = nth_packed_object_sha1(index->pack, commit_idx_pos);
 
-		xor_offset = (int)entry->xor_offset;
-		flags = (int)entry->flags;
+		xor_offset = (int)bitmap_disk_entry_xor_offset(entry);
+		flags = (int)bitmap_disk_entry_flags(entry);
 
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8b7f4e9..0d57706 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -5,11 +5,43 @@
 #include "khash.h"
 #include "pack-objects.h"
 
-struct bitmap_disk_entry {
-	uint32_t object_pos;
-	uint8_t xor_offset;
-	uint8_t flags;
-} __attribute__((packed));
+/*
+ * This is the equivalent of:
+ *
+ *	uint32_t object_pos;
+ *	uint8_t xor_offset;
+ *	uint8_t flags;
+ *
+ * but due to the funny sizing, we cannot rely on the compiler to give us the
+ * exact struct packing we want. So let's treat it as an array and just provide
+ * a few helpers for accessing the components.
+ */
+#define BITMAP_DISK_ENTRY_LEN 6
+
+static inline void bitmap_disk_entry_create(unsigned char *on_disk,
+					    uint32_t object_pos,
+					    uint8_t xor_offset,
+					    uint8_t flags)
+{
+	put_be32(on_disk, object_pos);
+	on_disk[4] = xor_offset;
+	on_disk[5] = flags;
+}
+
+static inline uint32_t bitmap_disk_entry_object_pos(unsigned char *on_disk)
+{
+	return get_be32(on_disk);
+}
+
+static inline uint8_t bitmap_disk_entry_xor_offset(unsigned char *on_disk)
+{
+	return on_disk[4];
+}
+
+static inline uint8_t bitmap_disk_entry_flags(unsigned char *on_disk)
+{
+	return on_disk[5];
+}
 
 struct bitmap_disk_header {
 	char magic[4];
-- 
2.1.0.rc0.286.g5c67d74

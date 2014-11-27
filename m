From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Thu, 27 Nov 2014 00:24:01 -0500
Message-ID: <20141127052400.GA16211@peff.net>
References: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 06:24:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtrYm-0002DG-5r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 06:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbaK0FYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 00:24:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:45658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751476AbaK0FYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 00:24:02 -0500
Received: (qmail 24413 invoked by uid 102); 27 Nov 2014 05:24:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Nov 2014 23:24:01 -0600
Received: (qmail 14148 invoked by uid 107); 27 Nov 2014 05:24:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Nov 2014 00:24:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Nov 2014 00:24:01 -0500
Content-Disposition: inline
In-Reply-To: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260334>

On Wed, Nov 26, 2014 at 03:09:45PM -0800, Junio C Hamano wrote:

> * jk/pack-bitmap (2014-08-04) 1 commit
>  - pack-bitmap: do not use gcc packed attribute
> 
>  Hold, waiting for Karsten's replacement.

I got tired of waiting, so here it is, I hope good enough for inclusion.

-- >8 --
From: Karsten Blees <blees@dcon.de>
Subject: pack-bitmap: do not use gcc packed attribute

The "__attribute__" flag may be a noop on some compilers.
That's OK as long as the code is correct without the
attribute, but in this case it is not. We would typically
end up with a struct that is 2 bytes too long due to struct
padding, breaking both reading and writing of bitmaps.

Instead of marshalling the data in a struct, let's just
provide helpers for reading and writing the appropriate
types. Besides being correct on all platforms, the result is
more efficient and simpler to read.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Jeff King <peff@peff.net>
---
From Karsten's original, the three changes I made (aside from the commit
message) were:

  1. The _u32 helpers are now _be32, to make it clear that they are
     dealing with big-endian integers (and it matches get/put_be32;
     dropping the "u" is OK as it is implied by dealing with byte
     ordering). I left the _u8 variants as-is; I do not think there is
     precedent for a similar name for single bytes (and the "u" is
     meaningful there). Technically you can accomplish the same thing
     with a single call to sha1write, but I think the helper makes the
     calling code flow better.

  2. I moved the sha1write_* helpers into csum-file.h. It's possible
     we will find other callers. I left the read_* variants as local
     to pack-bitmap.c. In theory we could use them elsewhere, but I
     could not find any other location that used the same "mmap base +
     pos" pattern. Some similar code uses a simple pointer which is
     updated, which would yield something like:

       uint32_t read_be32(unsigned char **data)
       {
               uint32_t ret = get_be32(*data);
               (*data) += sizeof(ret);
               return ret;
       }

     In theory we could adapt the bitmap code here to use a similar
     system, but it would involve a bit of surgery (we push the "pos"
     pointer forward in a lot of places, not just here, and they would
     all need to be converted). I don't think it's worth the trouble.

     The original discussion also raised the question of whether we
     could do a straight open/read on the bitmap file rather than
     mmap-ing it. The answer is yes, though it would similarly involve a
     lot of surgery. Moreover, it's possible that future versions of the
     bitmap format would benefit from being mmap'd (this one does not).
     So unless there is a compelling reason to switch away from mmap,
     I think it makes sense to keep the code as-is.

  3. I dropped casts from uint8_t to int in the assignment of
     xor_offset, etc.  These aren't doing anything (the compiler knows
     both types and handles the conversion fine, and we know that a
     uint8_t will always fit into an int on any sane platform).

 csum-file.h         | 11 +++++++++++
 pack-bitmap-write.c |  8 +++-----
 pack-bitmap.c       | 22 +++++++++++++++-------
 pack-bitmap.h       |  6 ------
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/csum-file.h b/csum-file.h
index bb543d5..7530927 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -39,4 +39,15 @@ extern void sha1flush(struct sha1file *f);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);
 
+static inline void sha1write_u8(struct sha1file *f, uint8_t data)
+{
+	sha1write(f, &data, sizeof(data));
+}
+
+static inline void sha1write_be32(struct sha1file *f, uint32_t data)
+{
+	data = htonl(data);
+	sha1write(f, &data, sizeof(data));
+}
+
 #endif
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 8029ae3..c05d138 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -472,7 +472,6 @@ static void write_selected_commits_v1(struct sha1file *f,
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
-		struct bitmap_disk_entry on_disk;
 
 		int commit_pos =
 			sha1_pos(stored->commit->object.sha1, index, index_nr, sha1_access);
@@ -480,11 +479,10 @@ static void write_selected_commits_v1(struct sha1file *f,
 		if (commit_pos < 0)
 			die("BUG: trying to write commit not in index");
 
-		on_disk.object_pos = htonl(commit_pos);
-		on_disk.xor_offset = stored->xor_offset;
-		on_disk.flags = stored->flags;
+		sha1write_be32(f, commit_pos);
+		sha1write_u8(f, stored->xor_offset);
+		sha1write_u8(f, stored->flags);
 
-		sha1write(f, &on_disk, sizeof(on_disk));
 		dump_bitmap(f, stored->write_as);
 	}
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index a1f3c0d..6a81841 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -197,13 +197,24 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	return stored;
 }
 
+static inline uint32_t read_be32(const unsigned char *buffer, size_t *pos)
+{
+	uint32_t result = get_be32(buffer + *pos);
+	(*pos) += sizeof(result);
+	return result;
+}
+
+static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
+{
+	return buffer[(*pos)++];
+}
+
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
 	static const size_t MAX_XOR_OFFSET = 160;
 
 	uint32_t i;
 	struct stored_bitmap **recent_bitmaps;
-	struct bitmap_disk_entry *entry;
 
 	recent_bitmaps = xcalloc(MAX_XOR_OFFSET, sizeof(struct stored_bitmap));
 
@@ -214,15 +225,12 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		uint32_t commit_idx_pos;
 		const unsigned char *sha1;
 
-		entry = (struct bitmap_disk_entry *)(index->map + index->map_pos);
-		index->map_pos += sizeof(struct bitmap_disk_entry);
+		commit_idx_pos = read_be32(index->map, &index->map_pos);
+		xor_offset = read_u8(index->map, &index->map_pos);
+		flags = read_u8(index->map, &index->map_pos);
 
-		commit_idx_pos = ntohl(entry->object_pos);
 		sha1 = nth_packed_object_sha1(index->pack, commit_idx_pos);
 
-		xor_offset = (int)entry->xor_offset;
-		flags = (int)entry->flags;
-
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
 			return -1;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8b7f4e9..487600b 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -5,12 +5,6 @@
 #include "khash.h"
 #include "pack-objects.h"
 
-struct bitmap_disk_entry {
-	uint32_t object_pos;
-	uint8_t xor_offset;
-	uint8_t flags;
-} __attribute__((packed));
-
 struct bitmap_disk_header {
 	char magic[4];
 	uint16_t version;
-- 
2.2.0.rc2.402.g4519813

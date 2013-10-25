From: Jeff King <peff@peff.net>
Subject: [PATCH v2 19/19] pack-bitmap: implement optional name_hash cache
Date: Fri, 25 Oct 2013 02:04:42 -0400
Message-ID: <20131025060442.GQ23098@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 08:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaVu-0007Ce-J7
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3JYGEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:04:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:55333 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182Ab3JYGEp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:04:45 -0400
Received: (qmail 3622 invoked by uid 102); 25 Oct 2013 06:04:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:04:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:04:42 -0400
Content-Disposition: inline
In-Reply-To: <20131025055521.GD11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236680>

From: Vicent Marti <tanoku@gmail.com>

When we use pack bitmaps rather than walking the object
graph, we end up with the list of objects to include in the
packfile, but we do not know the path at which any tree or
blob objects would be found.

In a recently packed repository, this is fine. A fetch would
use the paths only as a heuristic in the delta compression
phase, and a fully packed repository should not need to do
much delta compression.

As time passes, though, we may acquire more objects on top
of our large bitmapped pack. If clients fetch frequently,
then they never even look at the bitmapped history, and all
works as usual. However, a client who has not fetched since
the last bitmap repack will have "have" tips in the
bitmapped history, but "want" newer objects.

The bitmaps themselves degrade gracefully in this
circumstance. We manually walk the more recent bits of
history, and then use bitmaps when we hit them.

But we would also like to perform delta compression between
the newer objects and the bitmapped objects (both to delta
against what we know the user already has, but also between
"new" and "old" objects that the user is fetching). The lack
of pathnames makes our delta heuristics much less effective.

This patch adds an optional cache of the 32-bit name_hash
values to the end of the bitmap file. If present, a reader
can use it to match bitmapped and non-bitmapped names during
delta compression.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/bitmap-format.txt | 33 +++++++++++++++++++++++++++++++
 pack-bitmap-write.c                       | 18 ++++++++++++++++-
 pack-bitmap.c                             | 11 +++++++++++
 pack-bitmap.h                             |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 7a86bd7..f8c18a0 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -21,6 +21,12 @@ GIT bitmap v1 format
 			requirement for the bitmap index format, also present in JGit,
 			that greatly reduces the complexity of the implementation.
 
+			- BITMAP_OPT_HASH_CACHE (0x4)
+			If present, the end of the bitmap file contains
+			`N` 32-bit name-hash values, one per object in the
+			pack. The format and meaning of the name-hash is
+			described below.
+
 		4-byte entry count (network byte order)
 
 			The total count of entries (bitmapped commits) in this bitmap index.
@@ -129,3 +135,30 @@ The bitstream represented by the above chunk is then:
 The next word after `L_M` (if any) must again be a RLW, for the next
 chunk.  For efficient appending to the bitstream, the EWAH stores a
 pointer to the last RLW in the stream.
+
+
+== Appendix B: Optional Bitmap Sections
+
+These sections may or may not be present in the `.bitmap` file; their
+presence is indicated by the header flags section described above.
+
+Name-hash cache
+---------------
+
+If the BITMAP_OPT_HASH_CACHE flag is set, the end of the bitmap contains
+a cache of 32-bit values, one per object in the pack. The value at
+position `i` is the hash of the pathname at which the `i`th object
+(counting in index order) in the pack can be found.  This can be fed
+into the delta heuristics to compare objects with similar pathnames.
+
+The hash algorithm used is:
+
+    hash = 0;
+    while ((c = *name++))
+	    if (!isspace(c))
+		    hash = (hash >> 2) + (c << 24);
+
+Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
+If implementations want to choose a different hashing scheme, they are
+free to do so, but MUST allocate a new header flag (because comparing
+hashes made under two different schemes would be pointless).
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 954a74d..48087f1 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -490,6 +490,19 @@ static void write_selected_commits_v1(struct sha1file *f,
 	}
 }
 
+static void write_hash_cache(struct sha1file *f,
+			     struct pack_idx_entry **index,
+			     uint32_t index_nr)
+{
+	uint32_t i;
+
+	for (i = 0; i < index_nr; ++i) {
+		struct object_entry *entry = (struct object_entry *)index[i];
+		uint32_t hash_value = htonl(entry->hash);
+		sha1write(f, &hash_value, sizeof(hash_value));
+	}
+}
+
 void bitmap_writer_set_checksum(unsigned char *sha1)
 {
 	hashcpy(writer.pack_checksum, sha1);
@@ -501,7 +514,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 {
 	static char tmp_file[PATH_MAX];
 	static uint16_t default_version = 1;
-	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	static uint16_t flags = BITMAP_OPT_FULL_DAG | BITMAP_OPT_HASH_CACHE;
 	struct sha1file *f;
 
 	struct bitmap_disk_header header;
@@ -525,6 +538,9 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.tags);
 	write_selected_commits_v1(f, index, index_nr);
 
+	if (flags & BITMAP_OPT_HASH_CACHE)
+		write_hash_cache(f, index, index_nr);
+
 	sha1close(f, NULL, CSUM_FSYNC);
 
 	if (adjust_shared_perm(tmp_file))
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0044ecc..1fe2688 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -68,6 +68,9 @@ static struct bitmap_index {
 	/* Number of bitmapped commits */
 	uint32_t entry_count;
 
+	/* Name-hash cache (or NULL if not present). */
+	uint32_t *hashes;
+
 	/*
 	 * Extended index.
 	 *
@@ -154,6 +157,11 @@ static int load_bitmap_header(struct bitmap_index *index)
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
 			return error("Unsupported options for bitmap index file "
 				"(Git requires BITMAP_OPT_FULL_DAG)");
+
+		if (flags & BITMAP_OPT_HASH_CACHE) {
+			unsigned char *end = index->map + index->map_size - 20;
+			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
+		}
 	}
 
 	index->entry_count = ntohl(header->entry_count);
@@ -621,6 +629,9 @@ static void show_objects_for_type(
 			entry = &bitmap_git.reverse_index->revindex[pos + offset];
 			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
 
+			if (bitmap_git.hashes)
+				hash = ntohl(bitmap_git.hashes[entry->nr]);
+
 			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
 		}
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 18f4d4c..6053453 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -28,6 +28,7 @@ static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};;
 
 enum pack_bitmap_opts {
 	BITMAP_OPT_FULL_DAG = 1,
+	BITMAP_OPT_HASH_CACHE = 4,
 };
 
 enum pack_bitmap_flags {
-- 
1.8.4.1.898.g8bf8a41.dirty

From: Jeff King <peff@peff.net>
Subject: [PATCH v4 22/23] pack-bitmap: implement optional name_hash cache
Date: Sat, 21 Dec 2013 09:00:45 -0500
Message-ID: <20131221140045.GV21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:01:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6s-0005yh-4l
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab3LUOAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:00:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:48505 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755610Ab3LUOAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:47 -0500
Received: (qmail 7584 invoked by uid 102); 21 Dec 2013 14:00:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:45 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239615>

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

Here are perf results for p5310:

Test                      origin/master       HEAD^                      HEAD
-------------------------------------------------------------------------------------------------
5310.2: repack to disk    36.81(37.82+1.43)   47.70(48.74+1.41) +29.6%   47.75(48.70+1.51) +29.7%
5310.3: simulated clone   30.78(29.70+2.14)   1.08(0.97+0.10) -96.5%     1.07(0.94+0.12) -96.5%
5310.4: simulated fetch   3.16(6.10+0.08)     3.54(10.65+0.06) +12.0%    1.70(3.07+0.06) -46.2%
5310.6: partial bitmap    36.76(43.19+1.81)   6.71(11.25+0.76) -81.7%    4.08(6.26+0.46) -88.9%

You can see that the time spent on an incremental fetch goes
down, as our delta heuristics are able to do their work.
And we save time on the partial bitmap clone for the same
reason.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt                  | 11 +++++++++++
 Documentation/technical/bitmap-format.txt | 33 +++++++++++++++++++++++++++++++
 builtin/pack-objects.c                    | 10 +++++++++-
 pack-bitmap-write.c                       | 21 ++++++++++++++++++--
 pack-bitmap.c                             | 11 +++++++++++
 pack-bitmap.h                             |  6 ++++--
 t/perf/p5310-pack-bitmaps.sh              |  3 ++-
 t/t5310-pack-bitmaps.sh                   |  3 ++-
 8 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4b0c368..499a3c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1872,6 +1872,17 @@ pack.writebitmaps::
 	space and extra time spent on the initial repack.  Defaults to
 	false.
 
+pack.writeBitmapHashCache::
+	When true, git will include a "hash cache" section in the bitmap
+	index (if one is written). This cache can be used to feed git's
+	delta heuristics, potentially leading to better deltas between
+	bitmapped and non-bitmapped objects (e.g., when serving a fetch
+	between an older, bitmapped pack and objects that have been
+	pushed since the last gc). The downside is that it consumes 4
+	bytes per object of disk space, and that JGit's bitmap
+	implementation does not understand it, causing it to complain if
+	Git and JGit are used on the same repository. Defaults to false.
+
 pager.<cmd>::
 	If the value is boolean, turns on or off pagination of the
 	output of a particular Git subcommand when writing to a tty.
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
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fd6ae01..fd74197 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -64,6 +64,7 @@ static off_t reuse_packfile_offset;
 
 static int use_bitmap_index = 1;
 static int write_bitmap_index;
+static uint16_t write_bitmap_options;
 
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
@@ -851,7 +852,8 @@ static void write_pack_file(void)
 				bitmap_writer_reuse_bitmaps(&to_pack);
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
 				bitmap_writer_build(&to_pack);
-				bitmap_writer_finish(written_list, nr_written, tmpname);
+				bitmap_writer_finish(written_list, nr_written,
+						     tmpname, write_bitmap_options);
 				write_bitmap_index = 0;
 			}
 
@@ -2201,6 +2203,12 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		write_bitmap_index = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.writebitmaphashcache")) {
+		if (git_config_bool(k, v))
+			write_bitmap_options |= BITMAP_OPT_HASH_CACHE;
+		else
+			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
+	}
 	if (!strcmp(k, "pack.usebitmaps")) {
 		use_bitmap_index = git_config_bool(k, v);
 		return 0;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 954a74d..1218bef 100644
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
@@ -497,7 +510,8 @@ void bitmap_writer_set_checksum(unsigned char *sha1)
 
 void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
-			  const char *filename)
+			  const char *filename,
+			  uint16_t options)
 {
 	static char tmp_file[PATH_MAX];
 	static uint16_t default_version = 1;
@@ -514,7 +528,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
-	header.options = htons(flags);
+	header.options = htons(flags | options);
 	header.entry_count = htonl(writer.selected_nr);
 	memcpy(header.checksum, writer.pack_checksum, 20);
 
@@ -525,6 +539,9 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.tags);
 	write_selected_commits_v1(f, index, index_nr);
 
+	if (options & BITMAP_OPT_HASH_CACHE)
+		write_hash_cache(f, index, index_nr);
+
 	sha1close(f, NULL, CSUM_FSYNC);
 
 	if (adjust_shared_perm(tmp_file))
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 82090a6..ae0b57b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -66,6 +66,9 @@ static struct bitmap_index {
 	/* Number of bitmapped commits */
 	uint32_t entry_count;
 
+	/* Name-hash cache (or NULL if not present). */
+	uint32_t *hashes;
+
 	/*
 	 * Extended index.
 	 *
@@ -152,6 +155,11 @@ static int load_bitmap_header(struct bitmap_index *index)
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
@@ -626,6 +634,9 @@ static void show_objects_for_type(
 			entry = &bitmap_git.reverse_index->revindex[pos + offset];
 			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
 
+			if (bitmap_git.hashes)
+				hash = ntohl(bitmap_git.hashes[entry->nr]);
+
 			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
 		}
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 09acf02..8b7f4e9 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -24,7 +24,8 @@ static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
 #define NEEDS_BITMAP (1u<<22)
 
 enum pack_bitmap_opts {
-	BITMAP_OPT_FULL_DAG = 1
+	BITMAP_OPT_FULL_DAG = 1,
+	BITMAP_OPT_HASH_CACHE = 4,
 };
 
 enum pack_bitmap_flags {
@@ -57,6 +58,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 void bitmap_writer_build(struct packing_data *to_pack);
 void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
-			  const char *filename);
+			  const char *filename,
+			  uint16_t options);
 
 #endif
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 8c6ae45..685d46f 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -9,7 +9,8 @@ test_perf_large_repo
 # since we want to be able to compare bitmap-aware
 # git versus non-bitmap git
 test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true
+	git config pack.writebitmaps true &&
+	git config pack.writebitmaphashcache true
 '
 
 test_perf 'repack to disk' '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index d2b0c45..d3a3afa 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -14,7 +14,8 @@ test_expect_success 'setup repo with moderate-sized history' '
 	git checkout master &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
-	git config pack.writebitmaps true
+	git config pack.writebitmaps true &&
+	git config pack.writebitmaphashcache true
 '
 
 test_expect_success 'full repack creates bitmaps' '
-- 
1.8.5.1.399.g900e7cd

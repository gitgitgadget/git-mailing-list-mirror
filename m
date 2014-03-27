From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Wed, 26 Mar 2014 21:13:23 -0400
Message-ID: <20140327011323.GA9266@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
 <xmqq7g7gkgp6.fsf@gitster.dls.corp.google.com>
 <20140326181300.GA7087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 02:13:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSyst-0004iK-CD
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 02:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbaC0BN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 21:13:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:48173 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754369AbaC0BN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 21:13:26 -0400
Received: (qmail 5950 invoked by uid 102); 27 Mar 2014 01:13:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 20:13:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 21:13:23 -0400
Content-Disposition: inline
In-Reply-To: <20140326181300.GA7087@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245259>

On Wed, Mar 26, 2014 at 02:13:00PM -0400, Jeff King wrote:

> So I think the next steps are probably:
> 
>   1. Measure the "all objects are preferred bases" approach and confirm
>      that it is bad.

Below is a very rough patch to accomplish this. It just traverses the
"have" bitmap and adds every object with the "exclude" flag. The result
is as comically bad as I expected.

For a big fetch, it seems like it's working (numbers against v1.9.0):

  5311.31: server (128 days)   4.49(7.35+0.23)   4.98(6.82+3.31) +10.9%
  5311.32: size   (128 days)             25.8M             32.0M +24.2%
  5311.33: client (128 days)   7.17(7.38+0.20)   7.33(7.90+0.20) +2.2%

A modest increase in CPU time, and we get back most of our size
(remember that our "bad" case here is ~80M).

But for a small fetch...

  5311.3: server   (1 days)    0.20(0.17+0.03)   4.39(4.03+6.59) +2095.0%
  5311.4: size     (1 days)              57.2K             59.5K +4.1%
  5311.5: client   (1 days)    0.08(0.08+0.00)   0.08(0.08+0.00) +0.0%

Yikes. Besides spending lots of CPU on handling the enlarged object
list, notice that we still only dropped the size in the 128-day case to
32M. Which is almost exactly what the earlier "reuse on-disk deltas"
patch achieved.

What I think is happening is that we manage to reuse those on-disk
deltas (since they are now preferred bases, and we know we can). But we
never actually come up with any _new_ deltas, because the search window
is overwhelmed with candidates. So not only do we waste a huge amount of
CPU, but we just end up at the same not-quite-optimal result as before.

So this is a dead end, but I think it was good to double-check that.

The patch below is messy and would probably be better split into a few
patches, but I don't expect anyone to apply it (or even read it,
really). It's just for reference.

---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0ee5f1f..1a5d401 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1026,7 +1026,7 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
-	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
+	create_object_entry(sha1, type, name_hash, flags, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, to_pack.nr_objects);
 	return 1;
@@ -2436,6 +2436,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	}
 
 	traverse_bitmap_commit_list(&add_object_entry_from_bitmap);
+	bitmap_have_foreach(&add_object_entry_from_bitmap);
 	return 0;
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1bae7e8..f4e30f5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -605,6 +605,7 @@ static void show_objects_for_type(
 	struct bitmap *objects,
 	struct ewah_bitmap *type_filter,
 	enum object_type object_type,
+	int flags,
 	show_reachable_fn show_reach)
 {
 	size_t pos = 0, i = 0;
@@ -613,9 +614,6 @@ static void show_objects_for_type(
 	struct ewah_iterator it;
 	eword_t filter;
 
-	if (bitmap_git.reuse_objects == bitmap_git.pack->num_objects)
-		return;
-
 	ewah_iterator_init(&it, type_filter);
 
 	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
@@ -640,7 +638,7 @@ static void show_objects_for_type(
 			if (bitmap_git.hashes)
 				hash = ntohl(bitmap_git.hashes[entry->nr]);
 
-			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
+			show_reach(sha1, object_type, flags, hash, bitmap_git.pack, entry->offset);
 		}
 
 		pos += BITS_IN_WORD;
@@ -816,14 +814,17 @@ void traverse_bitmap_commit_list(show_reachable_fn show_reachable)
 {
 	assert(bitmap_git.result);
 
+	if (bitmap_git.reuse_objects == bitmap_git.pack->num_objects)
+		return;
+
 	show_objects_for_type(bitmap_git.result, bitmap_git.commits,
-		OBJ_COMMIT, show_reachable);
+		OBJ_COMMIT, 0, show_reachable);
 	show_objects_for_type(bitmap_git.result, bitmap_git.trees,
-		OBJ_TREE, show_reachable);
+		OBJ_TREE, 0, show_reachable);
 	show_objects_for_type(bitmap_git.result, bitmap_git.blobs,
-		OBJ_BLOB, show_reachable);
+		OBJ_BLOB, 0, show_reachable);
 	show_objects_for_type(bitmap_git.result, bitmap_git.tags,
-		OBJ_TAG, show_reachable);
+		OBJ_TAG, 0, show_reachable);
 
 	show_extended_objects(bitmap_git.result, show_reachable);
 
@@ -1090,3 +1091,18 @@ int bitmap_have(const unsigned char *sha1)
 
 	return bitmap_get(bitmap_git.haves, pos);
 }
+
+void bitmap_have_foreach(show_reachable_fn show_reachable)
+{
+	if (!bitmap_git.haves)
+		return;
+
+	show_objects_for_type(bitmap_git.haves, bitmap_git.commits,
+		OBJ_COMMIT, 1, show_reachable);
+	show_objects_for_type(bitmap_git.haves, bitmap_git.trees,
+		OBJ_TREE, 1, show_reachable);
+	show_objects_for_type(bitmap_git.haves, bitmap_git.blobs,
+		OBJ_BLOB, 1, show_reachable);
+	show_objects_for_type(bitmap_git.haves, bitmap_git.tags,
+		OBJ_TAG, 1, show_reachable);
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index a63ee6b..02c08f8 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -50,6 +50,7 @@ int reuse_partial_packfile_from_bitmap(struct packed_git **packfile, uint32_t *e
 int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bitmaps, int show_progress);
 
 int bitmap_have(const unsigned char *sha1);
+void bitmap_have_foreach(show_reachable_fn);
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);

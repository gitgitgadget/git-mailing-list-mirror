From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 6 Jan 2014 09:57:24 -0500
Message-ID: <20140106145723.GA15489@sigill.intra.peff.net>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Maurer <bmaurer@fb.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 15:57:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0BcT-0001aI-Mz
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 15:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbaAFO53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 09:57:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:55899 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751341AbaAFO52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 09:57:28 -0500
Received: (qmail 31888 invoked by uid 102); 6 Jan 2014 14:57:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 08:57:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 09:57:24 -0500
Content-Disposition: inline
In-Reply-To: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240014>

On Sun, Dec 22, 2013 at 11:47:34AM -0800, Ben Maurer wrote:

> Jeff King's bitmap branch appears to give a very substantial speedup.
> After applying this branch, the "counting objects" phase is basically
> free. However, I found that the compression phase still takes a
> non-trivial amount of time.

Sorry for the slow reply; I've been on vacation.

First off, I'm excited that you're looking into using bitmaps. We've
been using them for a while at GitHub, but more testing is definitely
appreciated. :)

When you build your bitmaps, do you set the pack.writeBitmapHashCache
option? We found that it makes a significant difference during the
compression phase, as otherwise git attempts deltas between random files
based on size. Here are some numbers for a simulated fetch from
torvalds/linux, representing about 7 weeks of history. Running:

  from=2d3c627502f2a9b0a7de06a5a2df2365542a72c9
  to=f0a679afefc0b6288310f88606b4bb1f243f1aa9
  run() {
    (echo $to && echo ^$from) |
    git pack-objects --stdout --all-progress --revs >/dev/null
  }

  echo "==> no hash cache"
  git repack -adb 2>/dev/null
  time run

  echo "==> with hash cache"
  git -c pack.writebitmaphashcache=1 repack -adb 2>/dev/null
  time run

produces:

  ==> no hash cache
  Counting objects: 20661, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (7700/7700), done.
  Writing objects: 100% (20661/20661), 23.23 MiB | 11.13 MiB/s, done.
  Total 20661 (delta 13884), reused 16638 (delta 12940)

  real    0m3.626s
  user    0m10.760s
  sys     0m0.060s

  ==> with hash cache
  Counting objects: 20661, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (7700/7700), done.
  Writing objects: 100% (20661/20661), 22.64 MiB | 10.82 MiB/s, done.
  Total 20661 (delta 14038), reused 16638 (delta 12940)

  real    0m3.072s
  user    0m6.168s
  sys     0m0.100s

So our resulting pack shrinks a little because we find better deltas,
but note that we save a fair bit of CPU time (the wall clock time ends
up not all that different, because the single-threaded writing phase
represents a big chunk of that).

> It looks like most of the time spent compressing objects was in cases
> where the object was already compressed in the packfile, but the delta
> was based on an object that the client already had. For some reason,
> --thin wasn't enabling reuse of these deltas.

I'm not too surprised. The long-time strategy for a fetch has been to
walk down the "haves" and "wants" to their merge base. That boundary
commit is marked as a "preferred base", meaning we won't send it, but
it's a good base for other objects, since we know the client has it.

Technically _all_ of the history reachable from that merge base could be
marked as a preferred base, but we don't do so for efficiency reasons:

  1. It's expensive to walk the full object graph for a small fetch, and

  2. You would clog the delta-search algorithm if you had a very large
     number of preferred-base objects.

With bitmaps, though, the history walk is free (we just check each
object against our "have" bitmap), so (1) is a non-issue. For (2), we
probably don't want to stick each object into the preferred-base list,
but we do want to reuse on-disk deltas we have, if we know the other
side has the base.

I don't know if you went through the same line of thinking, but that
matches your proposed solution. :)

> This is a hacky, poorly styled attempt to figure how how much better
> performance could be. With the bitmap branch, git should know what
> objects the client has already and can easily test if an existing delta
> can be reused. I don't know the branch well enough to code this, so
> as a hack, I just assumed the client has any delta base that is in
> the pack file (for our repo, this is always true, because we have a
> linear history)

Even without a linear history, it mostly works. If you are fetching all
of the branches from the other side, then you will end up with all of
the objects that the remote has. Which means that either you already
have the base, or the remote is about to send it to you.

It will break down, though, whenever the other side has something you're
not fetching. For that you really need to do the "have" bitmap check.

> This greatly reduces the time:
> 
> $ { echo HEAD && echo ^$have; } | time ../git-bitmap/install/bin/git pack-objects --use-bitmap-index --revs --stdout --thin  >/dev/null
> Counting objects: 220909, done.
> Compressing objects: 100% (14203/14203), done.
> Total 220909 (delta 194050), reused 220909 (delta 199885)
> 3.57user 1.28system 0:04.59elapsed 105%CPU (0avgtext+0avgdata 2007296maxresident)k
> 0inputs+0outputs (0major+416243minor)pagefaults 0swaps

You might try with "--all-progress" (or pipe to "wc -c"), as this should
be reducing the output size, too.

Here's my same torvalds/linux test, run with the patch I'm including
below:

  Counting objects: 20661, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (3677/3677), done.
  Writing objects: 100% (20661/20661), 5.17 MiB | 0 bytes/s, done.
  Total 20661 (delta 16963), reused 20661 (delta 16963)

  real    0m0.355s
  user    0m0.312s
  sys     0m0.044s

We dropped an order of magnitude in time, but we also shrunk the
packfile from 22MiB to 5MiB! That's good enough to make me assume
there's a bug in my code. :)

> I'd appreciate feedback here, if this is a valid approach, maybe
> somebody more involved in the bitmap branch would be interested
> in implementing the actual logic to figure out if the thin
> revision is valid

It's definitely a valid approach. I'm not sure if JGit is doing this
optimization itself already, but it was something we were already
considering for C git.

>  * I was rather confused as to how --thin works today. I could
>    not figure out how the choice was made to reuse a thin delta
>    in the existing code base.

Having been confused by it myself before, I think the magic keyword is
"preferred base". Once you know that, the code makes more sense. :)

>  * I had a very hacky way of communicating to the pack writing code
>    that there was a delta, but that it need not take that into
>    account for the pruposes of sorting the file. Does anybody have
>    a better suggestion here?

Yes. Your approach writes the thin-sha1 into a special field in the
object_entry. This has two downsides:

  1. It bloats the object_entry by 20 bytes. Given that a full repack of
     the kernel has over 4 million of these, that's 80MB.

  2. You have to special-case many sites which are expecting to find
     delta information in entry->delta.

We can solve both by storing the information in entry->delta.  Usually
that field points to another object_entry in the main "to-pack" list,
either for an object we are sending or for a preferred base. But since
we don't want to clog the list, we can just allocate a one-off
object_entry to use as the base.

I came up with the patch below. We _may_ need to allocate the "fake"
object_entry bases in a separate list, and actually connect them
correctly via the delta_child/delta_sibling pointers, but I haven't
looked carefully yet at how those fields are used (I think it is mostly
for write order, but we don't care here since the base objects aren't
being written at all).

Let me know how this patch does for you. My testing has been fairly
limited so far.

---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..0cff874 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1402,6 +1402,19 @@ static void check_object(struct object_entry *entry)
 			base_entry->delta_child = entry;
 			unuse_pack(&w_curs);
 			return;
+		} else if(base_ref && bitmap_have(base_ref)) {
+			entry->type = entry->in_pack_type;
+			entry->delta_size = entry->size;
+			/*
+			 * XXX we'll leak this, but it's probably OK
+			 * since we'll exit immediately after the packing
+			 * is done
+			 */
+			entry->delta = xcalloc(1, sizeof(*entry->delta));
+			hashcpy(entry->delta->idx.sha1, base_ref);
+			entry->delta->preferred_base = 1;
+			unuse_pack(&w_curs);
+			return;
 		}
 
 		if (entry->type) {
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ae0b57b..1bae7e8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -86,6 +86,9 @@ static struct bitmap_index {
 	/* Bitmap result of the last performed walk */
 	struct bitmap *result;
 
+	/* "have" bitmap from the last performed walk */
+	struct bitmap *haves;
+
 	/* Version of the bitmap index */
 	unsigned int version;
 
@@ -743,8 +746,8 @@ int prepare_bitmap_walk(struct rev_info *revs)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
 
 	bitmap_git.result = wants_bitmap;
+	bitmap_git.haves = haves_bitmap;
 
-	bitmap_free(haves_bitmap);
 	return 0;
 }
 
@@ -1071,3 +1074,19 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 	bitmap_free(rebuild);
 	return 0;
 }
+
+int bitmap_have(const unsigned char *sha1)
+{
+	int pos;
+
+	if (!bitmap_git.loaded)
+		return 0; /* no bitmap loaded */
+	if (!bitmap_git.haves)
+		return 0; /* walk had no "haves" */
+
+	pos = bitmap_position_packfile(sha1);
+	if (pos < 0)
+		return 0;
+
+	return bitmap_get(bitmap_git.haves, pos);
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8b7f4e9..a63ee6b 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -49,6 +49,8 @@ int prepare_bitmap_walk(struct rev_info *revs);
 int reuse_partial_packfile_from_bitmap(struct packed_git **packfile, uint32_t *entries, off_t *up_to);
 int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bitmaps, int show_progress);
 
+int bitmap_have(const unsigned char *sha1);
+
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
 void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);

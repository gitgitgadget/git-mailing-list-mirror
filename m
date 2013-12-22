From: Ben Maurer <bmaurer@fb.com>
Subject: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Sun, 22 Dec 2013 11:47:34 -0800
Message-ID: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
Cc: Ben Maurer <bmaurer@fb.com>, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 22 20:52:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vup54-0008Hg-4j
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 20:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab3LVTwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 14:52:50 -0500
Received: from intmgw001.ash2.facebook.com ([66.220.155.178]:49423 "EHLO
	mx-out.facebook.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755542Ab3LVTwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 14:52:49 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2013 14:52:48 EST
Received: from [10.5.172.27] ([10.5.172.27:50498] helo=facebook.com)
	by 10.8.151.29 (envelope-from <bmaurer@fb.com>)
	(ecelerity 3.6.0.39694 r(Platform:3.6.0.0)) with ESMTP
	id 31/B3-19777-2E147B25; Sun, 22 Dec 2013 11:47:46 -0800
Received: by devbig008.prn2.facebook.com (Postfix, from userid 2726)
	id E17081062E4; Sun, 22 Dec 2013 11:47:46 -0800 (PST)
X-Mailer: git-send-email 1.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239647>

I've been hacking with the performance of git on a large, quickly
changing git repo used inside Facebook. Pulling a week of changes
from this repo can be quite painful.

$ { echo HEAD && echo ^$have; } | time git pack-objects --no-use-bitmap-index --revs --stdout  >/dev/null
Counting objects: 221082, done.
Compressing objects: 100% (20174/20174), done.
Total 221082 (delta 197889), reused 215144 (delta 194084)
86.53user 7.89system 1:12.76elapsed 129%CPU (0avgtext+0avgdata 5746608maxresident)k
0inputs+0outputs (0major+3177262minor)pagefaults 0swaps

Jeff King's bitmap branch appears to give a very substantial speedup.
After applying this branch, the "counting objects" phase is basically
free. However, I found that the compression phase still takes a
non-trivial amount of time.

$ { echo HEAD && echo ^$have; } | time ../git-bitmap/install/bin/git pack-objects --use-bitmap-index --revs --stdout  >/dev/null
Counting objects: 220909, done.
Compressing objects: 100% (20038/20038), done.
Total 220909 (delta 197794), reused 215074 (delta 194050)
47.96user 2.45system 0:28.39elapsed 177%CPU (0avgtext+0avgdata 5890768maxresident)k
0inputs+0outputs (0major+984875minor)pagefaults 0swaps

It looks like most of the time spent compressing objects was in cases
where the object was already compressed in the packfile, but the delta
was based on an object that the client already had. For some reason,
--thin wasn't enabling reuse of these deltas.

This is a hacky, poorly styled attempt to figure how how much better
performance could be. With the bitmap branch, git should know what
objects the client has already and can easily test if an existing delta
can be reused. I don't know the branch well enough to code this, so
as a hack, I just assumed the client has any delta base that is in
the pack file (for our repo, this is always true, because we have a
linear history)

This greatly reduces the time:

$ { echo HEAD && echo ^$have; } | time ../git-bitmap/install/bin/git pack-objects --use-bitmap-index --revs --stdout --thin  >/dev/null
Counting objects: 220909, done.
Compressing objects: 100% (14203/14203), done.
Total 220909 (delta 194050), reused 220909 (delta 199885)
3.57user 1.28system 0:04.59elapsed 105%CPU (0avgtext+0avgdata 2007296maxresident)k
0inputs+0outputs (0major+416243minor)pagefaults 0swaps

I didn't do much testing here, I did run git-index-pack --fix-thin
then git fsck, as a sanity check.

I'd appreciate feedback here, if this is a valid approach, maybe
somebody more involved in the bitmap branch would be interested
in implementing the actual logic to figure out if the thin
revision is valid

 * I was rather confused as to how --thin works today. I could
   not figure out how the choice was made to reuse a thin delta
   in the existing code base.
 * I had a very hacky way of communicating to the pack writing code
   that there was a delta, but that it need not take that into
   account for the pruposes of sorting the file. Does anybody have
   a better suggestion here?

Signed-off-by: Ben Maurer <bmaurer@fb.com>
---
 builtin/pack-objects.c | 26 +++++++++++++++++++-------
 pack-objects.h         |  1 +
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c2f2847..3dc4411 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -53,6 +53,7 @@ static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
+static int thin = 0;
 static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
@@ -347,7 +348,8 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent

 /* Return 0 if we will bust the pack-size limit */
 static unsigned long write_reuse_object(struct sha1file *f, struct object_entry *entry,
-					unsigned long limit, int usable_delta)
+					unsigned long limit, int usable_delta,
+					const unsigned char* thin_delta_sha1)
 {
 	struct packed_git *p = entry->in_pack;
 	struct pack_window *w_curs = NULL;
@@ -361,7 +363,11 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
 	if (entry->delta)
 		type = (allow_ofs_delta && entry->delta->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
-	hdrlen = encode_in_pack_object_header(type, entry->size, header);
+
+	if (thin_delta_sha1)
+		type = OBJ_REF_DELTA;
+
+	hdrlen = encode_in_pack_object_header(type, thin_delta_sha1 ? entry->delta_size : entry->size, header);

 	offset = entry->in_pack_offset;
 	revidx = find_pack_revindex(p, offset);
@@ -403,7 +409,7 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
 			return 0;
 		}
 		sha1write(f, header, hdrlen);
-		sha1write(f, entry->delta->idx.sha1, 20);
+		sha1write(f, thin_delta_sha1 ? thin_delta_sha1 : entry->delta->idx.sha1, 20);
 		hdrlen += 20;
 		reused_delta++;
 	} else {
@@ -469,11 +475,13 @@ static unsigned long write_object(struct sha1file *f,
 		to_reuse = 1;	/* we have it in-pack undeltified,
 				 * and we do not need to deltify it.
 				 */
-
-	if (!to_reuse)
+	if (!is_null_sha1(entry->thin_delta_ref))
+		len = write_reuse_object(f, entry, limit, usable_delta,
+					 entry->thin_delta_ref);
+	else if (!to_reuse)
 		len = write_no_reuse_object(f, entry, limit, usable_delta);
 	else
-		len = write_reuse_object(f, entry, limit, usable_delta);
+		len = write_reuse_object(f, entry, limit, usable_delta, NULL);
 	if (!len)
 		return 0;

@@ -1358,6 +1366,9 @@ static void check_object(struct object_entry *entry)
 			base_entry->delta_child = entry;
 			unuse_pack(&w_curs);
 			return;
+		} else if (base_ref && pack_to_stdout && thin) {
+			hashcpy(entry->thin_delta_ref, base_ref);
+			entry->delta_size = entry->size;
 		}

 		if (entry->type) {
@@ -2088,6 +2099,8 @@ static void prepare_pack(int window, int depth)

 		if (entry->no_try_delta)
 			continue;
+		if (!is_null_sha1(entry->thin_delta_ref))
+			continue;

 		if (!entry->preferred_base) {
 			nr_deltas++;
@@ -2493,7 +2506,6 @@ static int option_parse_ulong(const struct option *opt,
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
-	int thin = 0;
 	int all_progress_implied = 0;
 	const char *rp_av[6];
 	int rp_ac = 0;
diff --git a/pack-objects.h b/pack-objects.h
index d1b98b3..a973bc5 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -27,6 +27,7 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+	unsigned char thin_delta_ref[20];
 };

 struct packing_data {
--
1.8.1

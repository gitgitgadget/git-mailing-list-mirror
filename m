From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/7] pack-objects: allow for early delta deflating
Date: Fri, 02 May 2008 15:11:50 -0400
Message-ID: <1209755511-7840-7-git-send-email-nico@cam.org>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
 <1209755511-7840-2-git-send-email-nico@cam.org>
 <1209755511-7840-3-git-send-email-nico@cam.org>
 <1209755511-7840-4-git-send-email-nico@cam.org>
 <1209755511-7840-5-git-send-email-nico@cam.org>
 <1209755511-7840-6-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:14:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0ha-00058j-Mm
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936600AbYEBTMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936508AbYEBTMS
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:12:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936562AbYEBTMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:12:09 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
In-reply-to: <1209755511-7840-6-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81025>

When the delta data is cached in memory until it is written to a pack
file on disk, it is best to compress it right away in find_deltas() for
the following reasons:

  - we have to compress that data anyway;

  - this allows for caching more deltas with the same cache size limit;

  - compression is potentially threaded.

This last point is especially relevant for SMP run time.  For example,
repacking the Linux repo on a quad core processor using 4 threads with
all default settings produce the following results before this change:

	real    2m27.929s
	user    4m36.492s
	sys     0m3.091s

And with this change applied:

	real    2m13.787s
	user    4m37.486s
	sys     0m3.159s

So the actual execution time stayed more or less the same but the
wall clock time is shorter.

This is however not a good thing to do when generating a pack for
network transmission.  In that case, the network is most likely to
throttle the data throughput, so it is best to make find_deltas()
faster in order to start writing data ASAP since we can afford
spending more time between writes to compress the data
at that point.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4319e7b..f5dcd20 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -43,6 +43,7 @@ struct object_entry {
 					     */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
+	unsigned long z_delta_size;	/* delta data size (compressed) */
 	unsigned int hash;	/* name hint hash */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
@@ -301,6 +302,11 @@ static unsigned long write_object(struct sha1file *f,
 			buf = read_sha1_file(entry->idx.sha1, &type, &size);
 			if (!buf)
 				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
+			/* make sure no cached delta data remains from a
+			   previous attempt before a pack split occured */
+			free(entry->delta_data);
+			entry->delta_data = NULL;
+			entry->z_delta_size = 0;
 		} else if (entry->delta_data) {
 			size = entry->delta_size;
 			buf = entry->delta_data;
@@ -313,7 +319,11 @@ static unsigned long write_object(struct sha1file *f,
 			type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
-		datalen = do_compress(&buf, size);
+
+		if (entry->z_delta_size)
+			datalen = entry->z_delta_size;
+		else
+			datalen = do_compress(&buf, size);
 
 		/*
 		 * The object header is a byte of 'type' followed by zero or
@@ -1447,6 +1457,29 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 				best_base = other_idx;
 		}
 
+		/*
+		 * If we decided to cache the delta data, then it is best
+		 * to compress it right away.  First because we have to do
+		 * it anyway, and doing it here while we're threaded will
+		 * save a lot of time in the non threaded write phase,
+		 * as well as allow for caching more deltas within
+		 * the same cache size limit.
+		 * ...
+		 * But only if not writing to stdout, since in that case
+		 * the network is most likely throttling writes anyway,
+		 * and therefore it is best to go to the write phase ASAP
+		 * instead, as we can afford spending more time compressing
+		 * between writes at that moment.
+		 */
+		if (entry->delta_data && !pack_to_stdout) {
+			entry->z_delta_size = do_compress(&entry->delta_data,
+							  entry->delta_size);
+			cache_lock();
+			delta_cache_size -= entry->delta_size;
+			delta_cache_size += entry->z_delta_size;
+			cache_unlock();
+		}
+
 		/* if we made n a delta, and if n is already at max
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
-- 
1.5.5.1.226.g6f6e8

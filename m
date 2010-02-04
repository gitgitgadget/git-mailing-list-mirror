From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 2/3] pack-objects: fix pack generation when using
 pack_size_limit
Date: Wed, 03 Feb 2010 22:48:27 -0500
Message-ID: <1265255308-20514-2-git-send-email-nico@fluxnic.net>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 04:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncsho-00058V-1Y
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 04:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab0BDDsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 22:48:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38281 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756497Ab0BDDsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 22:48:30 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXA000WCT8S3332@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 22:48:29 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.149.g0b0b7
In-reply-to: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138942>

Current handling of pack_size_limit is quite suboptimal.  Let's consider
a list of objects to pack which contain alternatively big and small
objects (which pretty matches reality when big blobs are interlaced
with tree objects).  Currently, the code simply close the pack and opens
a new one when the next object in line breaks the size limit.

The current code may degenerate into:

  - small tree object => store into pack #1
  - big blob object busting the pack size limit => store into pack #2
  - small blob but pack #2 is over the limit already => pack #3
  - big blob busting the size limit => pack #4
  - small tree but pack #4 is over the limit => pack #5
  - big blob => pack #6
  - small tree => pack #7
  - ... and so on.

The reality is that the content of packs 1, 3, 5 and 7 could well be
stored more efficiently (and delta compressed) together in pack #1 if
the big blobs were not forcing an immediate transition to a new pack.

Incidentally this can be fixed pretty easily by simply skipping over
those objects that are too big to fit in the current pack while trying
the whole list of unwritten objects, and then that list considered from
the beginning again when a new pack is opened.  This creates much fewer
smallish pack files and help making more predictable test cases for the
test suite.

This change made one of the self sanity checks useless so it is removed
as well. That check was rather redundant already anyway.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 builtin-pack-objects.c |   37 +++++++++++++------------------------
 1 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4a41547..3186035 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -246,7 +246,7 @@ static unsigned long write_object(struct sha1file *f,
 
 	type = entry->type;
 
-	/* write limit if limited packsize and not first object */
+	/* apply size limit if limited packsize and not first object */
 	if (!pack_size_limit || !nr_written)
 		limit = 0;
 	else if (pack_size_limit <= write_offset)
@@ -443,11 +443,15 @@ static int write_one(struct sha1file *f,
 
 	/* offset is non zero if object is written already. */
 	if (e->idx.offset || e->preferred_base)
-		return 1;
+		return -1;
 
-	/* if we are deltified, write out base object first. */
-	if (e->delta && !write_one(f, e->delta, offset))
-		return 0;
+	/*
+	 * If we are deltified, attempt to write out base object first.
+	 * If that fails due to the pack size limit then the current
+	 * object might still possibly fit undeltified within that limit.
+	 */
+	if (e->delta)
+	       write_one(f, e->delta, offset);
 
 	e->idx.offset = *offset;
 	size = write_object(f, e, *offset);
@@ -501,11 +505,9 @@ static void write_pack_file(void)
 		sha1write(f, &hdr, sizeof(hdr));
 		offset = sizeof(hdr);
 		nr_written = 0;
-		for (; i < nr_objects; i++) {
-			if (!write_one(f, objects + i, &offset))
-				break;
-			display_progress(progress_state, written);
-		}
+		for (i = 0; i < nr_objects; i++)
+			if (write_one(f, objects + i, &offset) == 1)
+				display_progress(progress_state, written);
 
 		/*
 		 * Did we write the wrong # entries in the header?
@@ -580,26 +582,13 @@ static void write_pack_file(void)
 			written_list[j]->offset = (off_t)-1;
 		}
 		nr_remaining -= nr_written;
-	} while (nr_remaining && i < nr_objects);
+	} while (nr_remaining);
 
 	free(written_list);
 	stop_progress(&progress_state);
 	if (written != nr_result)
 		die("wrote %"PRIu32" objects while expecting %"PRIu32,
 			written, nr_result);
-	/*
-	 * We have scanned through [0 ... i).  Since we have written
-	 * the correct number of objects,  the remaining [i ... nr_objects)
-	 * items must be either already written (due to out-of-order delta base)
-	 * or a preferred base.  Count those which are neither and complain if any.
-	 */
-	for (j = 0; i < nr_objects; i++) {
-		struct object_entry *e = objects + i;
-		j += !e->idx.offset && !e->preferred_base;
-	}
-	if (j)
-		die("wrote %"PRIu32" objects as expected but %"PRIu32
-			" unwritten", written, j);
 }
 
 static int locate_object_entry_hash(const unsigned char *sha1)
-- 
1.7.0.rc1.149.g0b0b7

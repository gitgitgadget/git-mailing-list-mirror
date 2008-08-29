From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/5] pack-objects: improve returned information from write_one()
Date: Fri, 29 Aug 2008 16:07:58 -0400
Message-ID: <1220040482-10108-2-git-send-email-nico@cam.org>
References: <20080829143023.GA7403@spearce.org>
 <1220040482-10108-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:09:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZAHh-0006S2-7z
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 22:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbYH2UIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbYH2UIO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 16:08:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15047 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbYH2UIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 16:08:13 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D007OOP8J18A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 16:07:32 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.212.g35f9f
In-reply-to: <1220040482-10108-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94322>

This function returns 0 when the current object couldn't be written
due to the pack size limit, otherwise the current offset in the pack.
There is a problem with this approach however, since current object
could be a delta and its delta base might just have been written in
the same write_one() call, but those successfully written objects are
not accounted in the offset variable tracked by the caller. Currently
this is not an issue but a subsequent patch will need this.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ef3befe..a615fcc 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -410,25 +410,22 @@ static unsigned long write_object(struct sha1file *f,
 	return hdrlen + datalen;
 }
 
-static off_t write_one(struct sha1file *f,
+static int write_one(struct sha1file *f,
 			       struct object_entry *e,
-			       off_t offset)
+			       off_t *offset)
 {
 	unsigned long size;
 
 	/* offset is non zero if object is written already. */
 	if (e->idx.offset || e->preferred_base)
-		return offset;
+		return 1;
 
 	/* if we are deltified, write out base object first. */
-	if (e->delta) {
-		offset = write_one(f, e->delta, offset);
-		if (!offset)
-			return 0;
-	}
+	if (e->delta && !write_one(f, e->delta, offset))
+		return 0;
 
-	e->idx.offset = offset;
-	size = write_object(f, e, offset);
+	e->idx.offset = *offset;
+	size = write_object(f, e, *offset);
 	if (!size) {
 		e->idx.offset = 0;
 		return 0;
@@ -436,9 +433,10 @@ static off_t write_one(struct sha1file *f,
 	written_list[nr_written++] = &e->idx;
 
 	/* make sure off_t is sufficiently large not to wrap */
-	if (offset > offset + size)
+	if (*offset > *offset + size)
 		die("pack too large for current definition of off_t");
-	return offset + size;
+	*offset += size;
+	return 1;
 }
 
 /* forward declaration for write_pack_file */
@@ -448,7 +446,7 @@ static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
 	struct sha1file *f;
-	off_t offset, offset_one, last_obj_offset = 0;
+	off_t offset;
 	struct pack_header hdr;
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
@@ -480,11 +478,8 @@ static void write_pack_file(void)
 		offset = sizeof(hdr);
 		nr_written = 0;
 		for (; i < nr_objects; i++) {
-			last_obj_offset = offset;
-			offset_one = write_one(f, objects + i, offset);
-			if (!offset_one)
+			if (!write_one(f, objects + i, &offset))
 				break;
-			offset = offset_one;
 			display_progress(progress_state, written);
 		}
 
-- 
1.6.0.1.212.g35f9f

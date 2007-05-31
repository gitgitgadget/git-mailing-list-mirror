From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix repack with --max-pack-size
Date: Wed, 30 May 2007 21:43:12 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705302114430.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 31 03:43:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtZhH-0007Sz-M5
	for gcvg-git@gmane.org; Thu, 31 May 2007 03:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264AbXEaBnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 21:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432AbXEaBnS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 21:43:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17499 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbXEaBnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 21:43:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIV0043RU43LEB0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 30 May 2007 21:43:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48796>

Two issues here:

1) git-repack -a --max-pack-size=10 on the GIT repo dies pretty quick.
   There is a lot of confusion about deltas that were suposed to be 
   reused from another pack but that get stored undeltified due to pack
   limit and object size doesn't match entry->size anymore.  This test 
   is not really worth the complexity for determining when it is valid
   so get rid of it.

2) If pack limit is reached, the object buffer is freed, including when 
   it comes from a cached delta data.  In practice the object will be 
   stored in a subsequent pack undeltified, but let's make sure no 
   pointer to freed data subsists by clearing entry->delta_data.

I also reorganized that code a bit to make it more readable.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 41472fc..ccb25f6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -410,31 +410,24 @@ static unsigned long write_object(struct sha1file *f,
 		z_stream stream;
 		unsigned long maxsize;
 		void *out;
-		if (entry->delta_data && usable_delta) {
-			buf = entry->delta_data;
+		if (!usable_delta) {
+			buf = read_sha1_file(entry->sha1, &obj_type, &size);
+			if (!buf)
+				die("unable to read %s", sha1_to_hex(entry->sha1));
+		} else if (entry->delta_data) {
 			size = entry->delta_size;
+			buf = entry->delta_data;
+			entry->delta_data = NULL;
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		} else {
 			buf = read_sha1_file(entry->sha1, &type, &size);
 			if (!buf)
 				die("unable to read %s", sha1_to_hex(entry->sha1));
-			if (size != entry->size)
-				die("object %s size inconsistency (%lu vs %lu)",
-				    sha1_to_hex(entry->sha1), size, entry->size);
-			if (usable_delta) {
-				buf = delta_against(buf, size, entry);
-				size = entry->delta_size;
-				obj_type = (allow_ofs_delta && entry->delta->offset) ?
-					OBJ_OFS_DELTA : OBJ_REF_DELTA;
-			} else {
-				/*
-				 * recover real object type in case
-				 * check_object() wanted to re-use a delta,
-				 * but we couldn't since base was in previous split pack
-				 */
-				obj_type = type;
-			}
+			buf = delta_against(buf, size, entry);
+			size = entry->delta_size;
+			obj_type = (allow_ofs_delta && entry->delta->offset) ?
+				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
 		/* compress the data to store and put compressed length in datalen */
 		memset(&stream, 0, sizeof(stream));

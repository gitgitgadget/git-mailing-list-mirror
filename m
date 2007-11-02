From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: get rid of an ugly cast
Date: Thu, 01 Nov 2007 23:43:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711012340330.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 04:44:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnRs-0000Ey-FS
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbXKBDn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbXKBDn1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:43:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42498 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbXKBDnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:43:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQV00IGO10CSYF0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 23:43:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63057>

... when calling write_idx_file().

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 25ec65d..a9d7633 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -57,7 +57,7 @@ struct object_entry {
  * nice "minimum seek" order.
  */
 static struct object_entry *objects;
-static struct object_entry **written_list;
+static struct pack_idx_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
@@ -577,7 +577,7 @@ static off_t write_one(struct sha1file *f,
 		e->idx.offset = 0;
 		return 0;
 	}
-	written_list[nr_written++] = e;
+	written_list[nr_written++] = &e->idx;
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
@@ -599,7 +599,7 @@ static void write_pack_file(void)
 
 	if (do_progress)
 		progress_state = start_progress("Writing objects", nr_result);
-	written_list = xmalloc(nr_objects * sizeof(struct object_entry *));
+	written_list = xmalloc(nr_objects * sizeof(*written_list));
 
 	do {
 		unsigned char sha1[20];
@@ -651,9 +651,8 @@ static void write_pack_file(void)
 			umask(mode);
 			mode = 0444 & ~mode;
 
-			idx_tmp_name = write_idx_file(NULL,
-					(struct pack_idx_entry **) written_list,
-					nr_written, sha1);
+			idx_tmp_name = write_idx_file(NULL, written_list,
+						      nr_written, sha1);
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(pack_tmp_name, mode))
@@ -677,7 +676,7 @@ static void write_pack_file(void)
 
 		/* mark written objects as written to previous pack */
 		for (j = 0; j < nr_written; j++) {
-			written_list[j]->idx.offset = (off_t)-1;
+			written_list[j]->offset = (off_t)-1;
 		}
 		nr_remaining -= nr_written;
 	} while (nr_remaining && i < nr_objects);

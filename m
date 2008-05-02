From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/7] pack-objects: small cleanup
Date: Fri, 02 May 2008 15:11:45 -0400
Message-ID: <1209755511-7840-2-git-send-email-nico@cam.org>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0gZ-0004c8-KE
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936497AbYEBTMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936492AbYEBTL5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:11:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936116AbYEBTLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:11:55 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
In-reply-to: <1209755511-7840-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81022>

Better encapsulate delta creation for writing.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 777f272..8691c99 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -102,21 +102,24 @@ static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
 
 
-static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
+static void *get_delta(struct object_entry *entry)
 {
-	unsigned long othersize, delta_size;
+	unsigned long size, base_size, delta_size;
+	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
-	void *otherbuf = read_sha1_file(entry->delta->idx.sha1, &type, &othersize);
-	void *delta_buf;
 
-	if (!otherbuf)
+	buf = read_sha1_file(entry->idx.sha1, &type, &size);
+	if (!buf)
+		die("unable to read %s", sha1_to_hex(entry->idx.sha1));
+	base_buf = read_sha1_file(entry->delta->idx.sha1, &type, &base_size);
+	if (!base_buf)
 		die("unable to read %s", sha1_to_hex(entry->delta->idx.sha1));
-        delta_buf = diff_delta(otherbuf, othersize,
+	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
-        if (!delta_buf || delta_size != entry->delta_size)
+	if (!delta_buf || delta_size != entry->delta_size)
 		die("delta size changed");
-        free(buf);
-        free(otherbuf);
+	free(buf);
+	free(base_buf);
 	return delta_buf;
 }
 
@@ -223,7 +226,6 @@ static unsigned long write_object(struct sha1file *f,
 				  off_t write_offset)
 {
 	unsigned long size;
-	enum object_type type;
 	void *buf;
 	unsigned char header[10];
 	unsigned char dheader[10];
@@ -281,10 +283,7 @@ static unsigned long write_object(struct sha1file *f,
 			obj_type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		} else {
-			buf = read_sha1_file(entry->idx.sha1, &type, &size);
-			if (!buf)
-				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
-			buf = delta_against(buf, size, entry);
+			buf = get_delta(entry);
 			size = entry->delta_size;
 			obj_type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
-- 
1.5.5.1.226.g6f6e8

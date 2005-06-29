From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] assorted delta code cleanup
Date: Wed, 29 Jun 2005 02:49:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506290246130.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 08:43:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnWIA-0007Po-Vz
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 08:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVF2GuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 02:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVF2GuX
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 02:50:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:829 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262444AbVF2Gt5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 02:49:57 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIU00IMJ2Z8HF@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Jun 2005 02:49:56 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This is a wrap-up patch including all the cleanups I've done to the
delta code and its usage.  The most important change is the 
factorization of the delta header handling code.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/count-delta.c b/count-delta.c
--- a/count-delta.c
+++ b/count-delta.c
@@ -6,23 +6,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <limits.h>
+#include "delta.h"
 #include "count-delta.h"
 
-static unsigned long get_hdr_size(const unsigned char **datap)
-{
-	const unsigned char *data = *datap;
-	unsigned char cmd = *data++;
-	unsigned long size = cmd & ~0x80;
-	int i = 7;
-	while (cmd & 0x80) {
-		cmd = *data++;
-		size |= (cmd & ~0x80) << i;
-		i += 7;
-	}
-	*datap = data;
-	return size;
-}
-
 /*
  * NOTE.  We do not _interpret_ delta fully.  As an approximation, we
  * just count the number of bytes that are copied from the source, and
@@ -44,15 +30,14 @@ int count_delta(void *delta_buf, unsigne
 	unsigned char cmd;
 	unsigned long src_size, dst_size, out;
 
-	/* the smallest delta size possible is 4 bytes */
-	if (delta_size < 4)
+	if (delta_size < DELTA_SIZE_MIN)
 		return -1;
 
 	data = delta_buf;
 	top = delta_buf + delta_size;
 
-	src_size = get_hdr_size(&data);
-	dst_size = get_hdr_size(&data);
+	src_size = get_delta_hdr_size(&data);
+	dst_size = get_delta_hdr_size(&data);
 
 	added_literal = copied_from_source = out = 0;
 	while (data < top) {
diff --git a/delta.h b/delta.h
--- a/delta.h
+++ b/delta.h
@@ -9,4 +9,26 @@ extern void *patch_delta(void *src_buf, 
 			 void *delta_buf, unsigned long delta_size,
 			 unsigned long *dst_size);
 
+/* the smallest possible delta size is 4 bytes */
+#define DELTA_SIZE_MIN	4
+
+/*
+ * This must be called twice on the delta data buffer, first to get the
+ * expected reference buffer size, and again to get the result buffer size.
+ */
+static inline unsigned long get_delta_hdr_size(const unsigned char **datap)
+{
+	const unsigned char *data = *datap;
+	unsigned char cmd = *data++;
+	unsigned long size = cmd & ~0x80;
+	int i = 7;
+	while (cmd & 0x80) {
+		cmd = *data++;
+		size |= (cmd & ~0x80) << i;
+		i += 7;
+	}
+	*datap = data;
+	return size;
+}
+
 #endif
diff --git a/diff-delta.c b/diff-delta.c
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -306,12 +306,13 @@ void *diff_delta(void *from_buf, unsigne
 			*orig = i;
 		}
 
-		/* next time around the largest possible output is 1 + 4 + 3 */
 		if (max_size && outpos > max_size) {
 			free(out);
 			delta_cleanup(&bdf);
 			return NULL;
 		}
+
+		/* next time around the largest possible output is 1 + 4 + 3 */
 		if (outpos > outsize - 8) {
 			void *tmp = out;
 			outsize = outsize * 3 / 2;
diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -34,7 +34,7 @@ static void *delta_against(void *buf, un
 	if (!otherbuf)
 		die("unable to read %s", sha1_to_hex(entry->delta->sha1));
         delta_buf = diff_delta(otherbuf, othersize,
-			       buf, size, &delta_size, ~0UL);
+			       buf, size, &delta_size, 0);
         if (!delta_buf || delta_size != entry->delta_size)
         	die("delta size changed");
         free(buf);
diff --git a/patch-delta.c b/patch-delta.c
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -20,36 +20,20 @@ void *patch_delta(void *src_buf, unsigne
 	const unsigned char *data, *top;
 	unsigned char *dst_buf, *out, cmd;
 	unsigned long size;
-	int i;
 
-	/* the smallest delta size possible is 4 bytes */
-	if (delta_size < 4)
+	if (delta_size < DELTA_SIZE_MIN)
 		return NULL;
 
 	data = delta_buf;
 	top = delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
-	cmd = *data++;
-	size = cmd & ~0x80;
-	i = 7;
-	while (cmd & 0x80) {
-		cmd = *data++;
-		size |= (cmd & ~0x80) << i;
-		i += 7;
-	}
+	size = get_delta_hdr_size(&data);
 	if (size != src_size)
 		return NULL;
 
 	/* now the result size */
-	cmd = *data++;
-	size = cmd & ~0x80;
-	i = 7;
-	while (cmd & 0x80) {
-		cmd = *data++;
-		size |= (cmd & ~0x80) << i;
-		i += 7;
-	}
+	size = get_delta_hdr_size(&data);
 	dst_buf = malloc(size);
 	if (!dst_buf)
 		return NULL;
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -592,22 +592,6 @@ void * unpack_sha1_file(void *map, unsig
 	return unpack_sha1_rest(&stream, hdr, *size);
 }
 
-static unsigned long parse_delta_size(unsigned char **p)
-{
-	unsigned char c;
-	unsigned long size = 0;
-	unsigned shift = 0;
-	unsigned char *data = *p;
-
-	do {
-		c = *data++;
-		size += (c & 0x7f) << shift;
-		shift += 7;
-	} while (c & 0x80);
-	*p = data;
-	return size;
-}
-
 static int packed_delta_info(unsigned char *base_sha1,
 			     unsigned long delta_size,
 			     unsigned long left,
@@ -645,11 +629,12 @@ static int packed_delta_info(unsigned ch
 	 * the result size.  Verify the base size while we are at it.
 	 */
 	data = delta_head;
-	verify_base_size = parse_delta_size(&data);
-	result_size = parse_delta_size(&data);
+	verify_base_size = get_delta_hdr_size(&data);
 	if (verify_base_size != base_size)
 		die("delta base size mismatch");
 
+	/* Read the result size */
+	result_size = get_delta_hdr_size(&data);
 	*sizep = result_size;
 	return 0;
 }

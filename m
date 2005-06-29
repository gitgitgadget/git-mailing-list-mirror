From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] denser delta header encoding
Date: Wed, 29 Jun 2005 00:27:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 06:21:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnU4k-00064i-SO
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 06:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVF2E2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 00:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVF2E2T
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 00:28:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18892 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262270AbVF2E1v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 00:27:51 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIT00FNXWE97W@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Jun 2005 00:27:45 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Since the delta data format is not tied to any actual git object 
anymore, now is the time to add a small improvement to the delta data 
header as it is been done for packed object header.  This patch allows 
for reducing the delta header of about 2 bytes and makes for simpler 
code.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/count-delta.c b/count-delta.c
--- a/count-delta.c
+++ b/count-delta.c
@@ -11,16 +11,13 @@
 static unsigned long get_hdr_size(const unsigned char **datap)
 {
 	const unsigned char *data = *datap;
-	unsigned long size;
-	unsigned char cmd;
-	int i;
-	size = i = 0;
-	cmd = *data++;
-	while (cmd) {
-		if (cmd & 1)
-			size |= *data++ << i;
-		i += 8;
-		cmd >>= 1;
+	unsigned char cmd = *data++;
+	unsigned long size = cmd & ~0x80;
+	int i = 7;
+	while (cmd & 0x80) {
+		cmd = *data++;
+		size |= (cmd & ~0x80) << i;
+		i += 7;
 	}
 	*datap = data;
 	return size;
@@ -47,8 +44,8 @@ int count_delta(void *delta_buf, unsigne
 	unsigned char cmd;
 	unsigned long src_size, dst_size, out;
 
-	/* the smallest delta size possible is 6 bytes */
-	if (delta_size < 6)
+	/* the smallest delta size possible is 4 bytes */
+	if (delta_size < 4)
 		return -1;
 
 	data = delta_buf;
diff --git a/diff-delta.c b/diff-delta.c
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -228,28 +228,22 @@ void *diff_delta(void *from_buf, unsigne
 	top = to_buf + to_size;
 
 	/* store reference buffer size */
-	orig = out + outpos++;
-	*orig = i = 0;
-	do {
-		if (from_size & 0xff) {
-			*orig |= (1 << i);
-			out[outpos++] = from_size;
-		}
-		i++;
-		from_size >>= 8;
-	} while (from_size);
+	out[outpos++] = from_size;
+	from_size >>= 7;
+	while (from_size) {
+		out[outpos - 1] |= 0x80;
+		out[outpos++] = from_size;
+		from_size >>= 7;
+	}
 
 	/* store target buffer size */
-	orig = out + outpos++;
-	*orig = i = 0;
-	do {
-		if (to_size & 0xff) {
-			*orig |= (1 << i);
-			out[outpos++] = to_size;
-		}
-		i++;
-		to_size >>= 8;
-	} while (to_size);
+	out[outpos++] = to_size;
+	to_size >>= 7;
+	while (to_size) {
+		out[outpos - 1] |= 0x80;
+		out[outpos++] = to_size;
+		to_size >>= 7;
+	}
 
 	inscnt = 0;
 	moff = 0;
diff --git a/patch-delta.c b/patch-delta.c
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -22,33 +22,33 @@ void *patch_delta(void *src_buf, unsigne
 	unsigned long size;
 	int i;
 
-	/* the smallest delta size possible is 6 bytes */
-	if (delta_size < 6)
+	/* the smallest delta size possible is 4 bytes */
+	if (delta_size < 4)
 		return NULL;
 
 	data = delta_buf;
 	top = delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
-	size = i = 0;
 	cmd = *data++;
-	while (cmd) {
-		if (cmd & 1)
-			size |= *data++ << i;
-		i += 8;
-		cmd >>= 1;
+	size = cmd & ~0x80;
+	i = 7;
+	while (cmd & 0x80) {
+		cmd = *data++;
+		size |= (cmd & ~0x80) << i;
+		i += 7;
 	}
 	if (size != src_size)
 		return NULL;
 
 	/* now the result size */
-	size = i = 0;
 	cmd = *data++;
-	while (cmd) {
-		if (cmd & 1)
-			size |= *data++ << i;
-		i += 8;
-		cmd >>= 1;
+	size = cmd & ~0x80;
+	i = 7;
+	while (cmd & 0x80) {
+		cmd = *data++;
+		size |= (cmd & ~0x80) << i;
+		i += 7;
 	}
 	dst_buf = malloc(size);
 	if (!dst_buf)

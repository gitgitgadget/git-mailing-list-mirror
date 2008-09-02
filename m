From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] sha1write: don't copy full sized buffers
Date: Tue, 02 Sep 2008 10:22:20 -0400
Message-ID: <1220365342-21308-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 16:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaWnD-0006X9-Od
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 16:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbYIBOWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYIBOWa
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 10:22:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46761 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbYIBOW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 10:22:29 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6K00ILVNXAG9W9@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 10:22:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.276.g59b81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94674>

No need to memcpy() source buffer data when we might just process the
data in place instead of accumulating it into a separate buffer.
This is the case when a whole buffer would have been copied, summed,
written out and then discarded right away.

Also move the CRC32 processing within the loop so the data is more likely
to remain in the L1 CPU cache between the CRC32 sum, SHA1 sum and the
write call.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 csum-file.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 2838954..bb70c75 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,10 +11,8 @@
 #include "progress.h"
 #include "csum-file.h"
 
-static void sha1flush(struct sha1file *f, unsigned int count)
+static void sha1flush(struct sha1file *f, void *buf, unsigned int count)
 {
-	void *buf = f->buffer;
-
 	for (;;) {
 		int ret = xwrite(f->fd, buf, count);
 		if (ret > 0) {
@@ -39,7 +37,7 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
-		sha1flush(f, offset);
+		sha1flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
 	SHA1_Final(f->buffer, &f->ctx);
@@ -47,7 +45,7 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 		hashcpy(result, f->buffer);
 	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
 		/* write checksum and close fd */
-		sha1flush(f, 20);
+		sha1flush(f, f->buffer, 20);
 		if (flags & CSUM_FSYNC)
 			fsync_or_die(f->fd, f->name);
 		if (close(f->fd))
@@ -62,21 +60,30 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 
 int sha1write(struct sha1file *f, void *buf, unsigned int count)
 {
-	if (f->do_crc)
-		f->crc32 = crc32(f->crc32, buf, count);
 	while (count) {
 		unsigned offset = f->offset;
 		unsigned left = sizeof(f->buffer) - offset;
 		unsigned nr = count > left ? left : count;
+		void *data;
+
+		if (f->do_crc)
+			f->crc32 = crc32(f->crc32, buf, nr);
+
+		if (nr == sizeof(f->buffer)) {
+			/* process full buffer directly without copy */
+			data = buf;
+		} else {
+			memcpy(f->buffer + offset, buf, nr);
+			data = f->buffer;
+		}
 
-		memcpy(f->buffer + offset, buf, nr);
 		count -= nr;
 		offset += nr;
 		buf = (char *) buf + nr;
 		left -= nr;
 		if (!left) {
-			SHA1_Update(&f->ctx, f->buffer, offset);
-			sha1flush(f, offset);
+			SHA1_Update(&f->ctx, data, offset);
+			sha1flush(f, data, offset);
 			offset = 0;
 		}
 		f->offset = offset;
-- 
1.6.0.1.276.g59b81

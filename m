From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] diff-delta: fold two special tests into one plus cleanups
Date: Tue, 21 Feb 2006 20:41:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602212039350.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBj17-0001gt-Tp
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWBVBln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWBVBln
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:41:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38356 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932472AbWBVBlm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:41:42 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV200J1AFDHAH80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Feb 2006 20:41:42 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16580>


Testing for realloc and size limit can be done with only one test per 
loop. Make it so and fix a theoretical off-by-one comparison error in 
the process.

The output buffer memory allocation is also bounded by max_size when 
specified.

Finally make some variable unsigned to allow the handling of files up to 
4GB in size instead of 2GB.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

 diff-delta.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

95c1d1f82a8e36ab1e46b8186ecb34f441914961
diff --git a/diff-delta.c b/diff-delta.c
index c2f656a..ac992e2 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -148,16 +148,20 @@ static void delta_cleanup(bdfile_t *bdf)
 	cha_free(&bdf->cha);
 }
 
+/* provide the size of the copy opcode given the block offset and size */
 #define COPYOP_SIZE(o, s) \
     (!!(o & 0xff) + !!(o & 0xff00) + !!(o & 0xff0000) + !!(o & 0xff000000) + \
      !!(s & 0xff) + !!(s & 0xff00) + 1)
 
+/* the maximum size for any opcode */
+#define MAX_OP_SIZE COPYOP_SIZE(0xffffffff, 0xffffffff)
+
 void *diff_delta(void *from_buf, unsigned long from_size,
 		 void *to_buf, unsigned long to_size,
 		 unsigned long *delta_size,
 		 unsigned long max_size)
 {
-	int i, outpos, outsize, inscnt, csize, msize, moff;
+	unsigned int i, outpos, outsize, inscnt, csize, msize, moff;
 	unsigned int fp;
 	const unsigned char *ref_data, *ref_top, *data, *top, *ptr1, *ptr2;
 	unsigned char *out, *orig;
@@ -169,6 +173,8 @@ void *diff_delta(void *from_buf, unsigne
 	
 	outpos = 0;
 	outsize = 8192;
+	if (max_size && outsize >= max_size)
+		outsize = max_size + MAX_OP_SIZE + 1;
 	out = malloc(outsize);
 	if (!out) {
 		delta_cleanup(&bdf);
@@ -259,17 +265,15 @@ void *diff_delta(void *from_buf, unsigne
 			*orig = i;
 		}
 
-		if (max_size && outpos > max_size) {
-			free(out);
-			delta_cleanup(&bdf);
-			return NULL;
-		}
-
-		/* next time around the largest possible output is 1 + 4 + 3 */
-		if (outpos > outsize - 8) {
+		if (outpos >= outsize - MAX_OP_SIZE) {
 			void *tmp = out;
 			outsize = outsize * 3 / 2;
-			out = realloc(out, outsize);
+			if (max_size && outsize >= max_size)
+				outsize = max_size + MAX_OP_SIZE + 1;
+			if (max_size && outpos > max_size)
+				out = NULL;
+			else
+				out = realloc(out, outsize);
 			if (!out) {
 				free(tmp);
 				delta_cleanup(&bdf);
-- 
1.2.2.g6643-dirty

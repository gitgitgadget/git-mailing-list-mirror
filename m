From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 19/38] packv4-create: optimize delta encoding
Date: Thu, 05 Sep 2013 02:19:42 -0400
Message-ID: <1378362001-1738-20-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwm-0008OR-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab3IEGV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756957Ab3IEGUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:19 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G402XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 617392DA05D6	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233920>

Make sure the copy sequence is smaller than the list of tree entries it
is meant to replace.  We do so by encoding tree entries in parallel with
the delta entry comparison, and then comparing the length of both
sequences.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 65 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 15c5959..c8d3053 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -433,7 +433,8 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 	struct tree_desc desc, delta_desc;
 	struct name_entry name_entry, delta_entry;
 	int nb_entries;
-	unsigned int copy_start, copy_count = 0, delta_pos = 0, first_delta = 1;
+	unsigned int copy_start = 0, copy_count = 0, copy_pos = 0, copy_end = 0;
+	unsigned int delta_pos = 0, first_delta = 1;
 
 	if (!size)
 		return NULL;
@@ -489,24 +490,23 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 
 			if (ret == 0 && name_entry.mode == delta_entry.mode &&
 			    hashcmp(name_entry.sha1, delta_entry.sha1) == 0) {
-				if (!copy_count)
+				if (!copy_count) {
 					copy_start = delta_pos;
+					copy_pos = out - buffer;
+					copy_end = 0;
+				}
 				copy_count++;
 				delta_pos++;
 				if (!tree_entry(&delta_desc, &delta_entry))
 					delta = NULL;
-				continue;
-			}
-		}
+			} else
+				copy_end = 1;
+		} else
+			copy_end = 1;
 
-		if (end - out < 48) {
-			unsigned long sofar = out - buffer;
-			buffer = xrealloc(buffer, (sofar + 48)*2);
-			end = buffer + (sofar + 48)*2;
-			out = buffer + sofar;
-		}
+		if (copy_count && copy_end) {
+			unsigned char copy_buf[48], *cp = copy_buf;
 
-		if (copy_count) {
 			/*
 			 * Let's write a sequence indicating we're copying
 			 * entries from another object:
@@ -524,12 +524,31 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 			 */
 			copy_start = (copy_start << 1) | 1;
 			copy_count = (copy_count << 1) | first_delta;
-			out += encode_varint(copy_start, out);
-			out += encode_varint(copy_count, out);
+			cp += encode_varint(copy_start, cp);
+			cp += encode_varint(copy_count, cp);
 			if (first_delta)
-				out += encode_sha1ref(delta_sha1, out);
+				cp += encode_sha1ref(delta_sha1, cp);
 			copy_count = 0;
-			first_delta = 0;
+
+			/*
+			 * Now let's make sure this is going to take less
+			 * space than the corresponding direct entries we've
+			 * created in parallel.  If so we dump the copy
+			 * sequence over those entries in the output buffer.
+			 */
+			if (cp - copy_buf < out - &buffer[copy_pos]) {
+				out = buffer + copy_pos;
+				memcpy(out, copy_buf, cp - copy_buf);
+				out += cp - copy_buf;
+				first_delta = 0;
+			}
+		}
+
+		if (end - out < 48) {
+			unsigned long sofar = out - buffer;
+			buffer = xrealloc(buffer, (sofar + 48)*2);
+			end = buffer + (sofar + 48)*2;
+			out = buffer + sofar;
 		}
 
 		pathlen = tree_entry_len(&name_entry);
@@ -545,13 +564,19 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 	}
 
 	if (copy_count) {
-		/* flush the trailing copy */
+		/* process the trailing copy */
+		unsigned char copy_buf[48], *cp = copy_buf;
 		copy_start = (copy_start << 1) | 1;
 		copy_count = (copy_count << 1) | first_delta;
-		out += encode_varint(copy_start, out);
-		out += encode_varint(copy_count, out);
+		cp += encode_varint(copy_start, cp);
+		cp += encode_varint(copy_count, cp);
 		if (first_delta)
-			out += encode_sha1ref(delta_sha1, out);
+			cp += encode_sha1ref(delta_sha1, cp);
+		if (cp - copy_buf < out - &buffer[copy_pos]) {
+			out = buffer + copy_pos;
+			memcpy(out, copy_buf, cp - copy_buf);
+			out += cp - copy_buf;
+		}
 	}
 
 	*sizep = out - buffer;
-- 
1.8.4.38.g317e65b

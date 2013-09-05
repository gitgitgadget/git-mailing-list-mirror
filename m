From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 38/38] packv4-create: add a command line argument to limit tree
 copy sequences
Date: Thu, 05 Sep 2013 02:20:01 -0400
Message-ID: <1378362001-1738-39-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvk-0007oz-PD
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471Ab3IEGUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab3IEGUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:23 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00ANX2XQCY00@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 67FA62DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233899>

Because there is no delta object cache for tree objects yet, walking
tree entries may result in a lot of recursion.

Let's add --min-tree-copy=N where N is the minimum number of copied
entries in a single copy sequence allowed for encoding tree deltas.
The default is 1. Specifying 0 disables tree deltas entirely.

This allows for experiments with the delta width and see the influence
on pack size vs runtime access cost.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 9d6ffc0..34dcebf 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -19,6 +19,7 @@
 
 static int pack_compression_seen;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+static int min_tree_copy = 1;
 
 struct data_entry {
 	unsigned offset;
@@ -441,7 +442,7 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 	if (!size)
 		return NULL;
 
-	if (!delta_size)
+	if (!delta_size || !min_tree_copy)
 		delta = NULL;
 
 	/*
@@ -530,7 +531,6 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 			cp += encode_varint(copy_count, cp);
 			if (first_delta)
 				cp += encode_sha1ref(delta_sha1, cp);
-			copy_count = 0;
 
 			/*
 			 * Now let's make sure this is going to take less
@@ -538,12 +538,14 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 			 * created in parallel.  If so we dump the copy
 			 * sequence over those entries in the output buffer.
 			 */
-			if (cp - copy_buf < out - &buffer[copy_pos]) {
+			if (copy_count >= min_tree_copy &&
+			    cp - copy_buf < out - &buffer[copy_pos]) {
 				out = buffer + copy_pos;
 				memcpy(out, copy_buf, cp - copy_buf);
 				out += cp - copy_buf;
 				first_delta = 0;
 			}
+			copy_count = 0;
 		}
 
 		if (end - out < 48) {
@@ -574,7 +576,8 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 		cp += encode_varint(copy_count, cp);
 		if (first_delta)
 			cp += encode_sha1ref(delta_sha1, cp);
-		if (cp - copy_buf < out - &buffer[copy_pos]) {
+		if (copy_count >= min_tree_copy &&
+		    cp - copy_buf < out - &buffer[copy_pos]) {
 			out = buffer + copy_pos;
 			memcpy(out, copy_buf, cp - copy_buf);
 			out += cp - copy_buf;
@@ -1078,14 +1081,24 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 
 int main(int argc, char *argv[])
 {
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s <src_packfile> <dst_packfile>\n", argv[0]);
+	char *src_pack, *dst_pack;
+
+	if (argc == 3) {
+		src_pack = argv[1];
+		dst_pack = argv[2];
+	} else if (argc == 4 && !prefixcmp(argv[1], "--min-tree-copy=")) {
+		min_tree_copy = atoi(argv[1] + strlen("--min-tree-copy="));
+		src_pack = argv[2];
+		dst_pack = argv[3];
+	} else {
+		fprintf(stderr, "Usage: %s [--min-tree-copy=<n>] <src_packfile> <dst_packfile>\n", argv[0]);
 		exit(1);
 	}
+
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
-	process_one_pack(argv[1], argv[2]);
+	process_one_pack(src_pack, dst_pack);
 	if (0)
 		dict_dump();
 	return 0;
-- 
1.8.4.38.g317e65b

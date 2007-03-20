From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] index-pack: more validation checks and cleanups
Date: Tue, 20 Mar 2007 17:07:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703201659530.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 22:08:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTlYl-0008AE-84
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 22:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbXCTVHv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 17:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbXCTVHv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 17:07:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56108 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbXCTVHt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 17:07:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF8009EC010PK60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 17:07:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42761>

When appending objects to a pack, make sure the appended data is really 
what we expect instead of simply loading potentially corrupted objects 
and legitimating them by computing a SHA1 of that corrupt data.

With this the sha1_object() can lose its test_for_collision parameter 
which is now redundent.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Again on top of my latest patch.

diff --git a/index-pack.c b/index-pack.c
index f314937..61eb20e 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -345,12 +345,10 @@ static int find_delta_children(const union delta_base *base,
 }
 
 static void sha1_object(const void *data, unsigned long size,
-			enum object_type type, unsigned char *sha1,
-			int test_for_collision)
+			enum object_type type, unsigned char *sha1)
 {
 	hash_sha1_file(data, size, typename(type), sha1);
-
-	if (test_for_collision && has_sha1_file(sha1)) {
+	if (has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
@@ -381,7 +379,7 @@ static void resolve_delta(struct object_entry *delta_obj, void *base_data,
 	free(delta_data);
 	if (!result)
 		bad_object(delta_obj->offset, "failed to apply delta");
-	sha1_object(result, result_size, type, delta_obj->sha1, 1);
+	sha1_object(result, result_size, type, delta_obj->sha1);
 	nr_resolved_deltas++;
 
 	hashcpy(delta_base.sha1, delta_obj->sha1);
@@ -438,7 +436,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			delta->obj_no = i;
 			delta++;
 		} else
-			sha1_object(data, obj->size, obj->type, obj->sha1, 1);
+			sha1_object(data, obj->size, obj->type, obj->sha1);
 		free(data);
 		if (verbose)
 			percent = display_progress(i+1, nr_objects, percent);
@@ -541,7 +539,7 @@ static int write_compressed(int fd, void *in, unsigned int size)
 	return size;
 }
 
-static void append_obj_to_pack(void *buf,
+static void append_obj_to_pack(const unsigned char *sha1, void *buf,
 			       unsigned long size, enum object_type type)
 {
 	struct object_entry *obj = &objects[nr_objects++];
@@ -559,7 +557,7 @@ static void append_obj_to_pack(void *buf,
 	write_or_die(output_fd, header, n);
 	obj[1].offset = obj[0].offset + n;
 	obj[1].offset += write_compressed(output_fd, buf, size);
-	sha1_object(buf, size, type, obj->sha1, 0);
+	hashcpy(obj->sha1, sha1);
 }
 
 static int delta_pos_compare(const void *_a, const void *_b)
@@ -612,7 +610,9 @@ static void fix_unresolved_deltas(int nr_unresolved)
 				resolve_delta(child, data, size, type);
 		}
 
-		append_obj_to_pack(data, size, type);
+		if (check_sha1_signature(d->base.sha1, data, size, typename(type)))
+			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
+		append_obj_to_pack(d->base.sha1, data, size, type);
 		free(data);
 		if (verbose)
 			percent = display_progress(nr_resolved_deltas,

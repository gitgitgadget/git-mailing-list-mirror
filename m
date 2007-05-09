From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] allow for undeltified objects not to be reused
Date: Wed, 09 May 2007 12:31:28 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705091219240.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Dana How <danahow@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 18:31:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlp4k-0002rp-2q
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbXEIQbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756155AbXEIQbd
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:31:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55327 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029AbXEIQbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:31:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHS00N208KG26D0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 May 2007 12:31:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46745>

Currently non deltified object data is always reused when possible.  
This means that any change to core.compression has no effect on those
objects as they don't get recompressed when repacking them.

Let's add a --no-reuse-object flag to git-repack in order to force 
recompression of all objects when desired.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index bd3ee45..ce89214 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -127,6 +127,13 @@ base-name::
 	This flag tells the command not to reuse existing deltas
 	but compute them from scratch.
 
+--no-reuse-object::
+	This flag tells the command not to reuse existing object data at all,
+	including non deltified object, forcing recompression of everything.
+	This implies --no-reuse-delta. Useful only in the obscur case where
+	wholesale enforcement of a different compression level on the
+	packed data is desired.
+
 --delta-base-offset::
 	A packed archive can express base object of a delta as
 	either 20-byte object name or as an offset in the
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 966f843..d94c79a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -17,9 +17,9 @@
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--local] [--incremental] [--window=N] [--depth=N] \n\
-	[--no-reuse-delta] [--delta-base-offset] [--non-empty] \n\
-	[--revs [--unpacked | --all]*] [--reflog] [--stdout | base-name] \n\
-	[<ref-list | <object-list]";
+	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
+	[--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
+	[--stdout | base-name] [<ref-list | <object-list]";
 
 struct object_entry {
 	unsigned char sha1[20];
@@ -55,7 +55,7 @@ static struct object_entry *objects;
 static uint32_t nr_objects, nr_alloc, nr_result;
 
 static int non_empty;
-static int no_reuse_delta;
+static int no_reuse_delta, no_reuse_object;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
@@ -412,7 +412,9 @@ static unsigned long write_object(struct sha1file *f,
 		crc32_begin(f);
 
 	obj_type = entry->type;
-	if (! entry->in_pack)
+	if (no_reuse_object)
+		to_reuse = 0;	/* explicit */
+	else if (!entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (obj_type == OBJ_REF_DELTA || obj_type == OBJ_OFS_DELTA)
 		to_reuse = 1;	/* check_object() decided it for us */
@@ -425,7 +427,7 @@ static unsigned long write_object(struct sha1file *f,
 				 * and we do not need to deltify it.
 				 */
 
-	if (!entry->in_pack && !entry->delta) {
+	if (!no_reuse_object && !entry->in_pack && !entry->delta) {
 		unsigned char *map;
 		unsigned long mapsize;
 		map = map_sha1_file(entry->sha1, &mapsize);
@@ -1125,8 +1127,8 @@ static void check_object(struct object_entry *entry)
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
 		/*
-		 * We want in_pack_type even if we do not reuse delta.
-		 * There is no point not reusing non-delta representations.
+		 * We want in_pack_type even if we do not reuse delta
+		 * since non-delta representations could still be reused.
 		 */
 		used = unpack_object_header_gently(buf, avail,
 						   &entry->in_pack_type,
@@ -1655,6 +1657,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			no_reuse_delta = 1;
 			continue;
 		}
+		if (!strcmp("--no-reuse-object", arg)) {
+			no_reuse_object = no_reuse_delta = 1;
+			continue;
+		}
 		if (!strcmp("--delta-base-offset", arg)) {
 			allow_ofs_delta = 1;
 			continue;

From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 11/10] allow forcing index v2 and 64-bit offset treshold
Date: Mon, 09 Apr 2007 17:32:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091727300.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb1bT-0003e6-Co
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 23:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbXDIVji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966040AbXDIVcj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 17:32:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52011 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030295AbXDIVcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 17:32:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG900FAK2HFLQ80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 17:32:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44074>

This is necessary for testing the new capabilities in some automated 
way without having an actual 4GB+ pack.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

I should write some tests... when I have more time.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8cf2871..099dea0 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -597,6 +597,9 @@ static off_t write_pack_file(void)
 	return last_obj_offset;
 }
 
+static uint32_t index_default_version = 1;
+static uint32_t index_off32_limit = 0x7fffffff;
+
 static void write_index_file(off_t last_obj_offset)
 {
 	uint32_t i;
@@ -608,7 +611,7 @@ static void write_index_file(off_t last_obj_offset)
 	uint32_t index_version;
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (last_obj_offset >> 31) ? 2 : 1;
+	index_version = (last_obj_offset >> 31) ? 2 : index_default_version;
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -664,7 +667,7 @@ static void write_index_file(off_t last_obj_offset)
 		list = sorted_by_sha;
 		for (i = 0; i < nr_objects; i++) {
 			struct object_entry *entry = *list++;
-			uint32_t offset = (entry->offset <= 0x7fffffff) ?
+			uint32_t offset = (entry->offset <= index_off32_limit) ?
 				entry->offset : (0x80000000 | nr_large_offset++);
 			offset = htonl(offset);
 			sha1write(f, &offset, 4);
@@ -675,7 +678,7 @@ static void write_index_file(off_t last_obj_offset)
 		while (nr_large_offset) {
 			struct object_entry *entry = *list++;
 			uint64_t offset = entry->offset;
-			if (offset > 0x7fffffff) {
+			if (offset > index_off32_limit) {
 				uint32_t split[2];
 				split[0]        = htonl(offset >> 32);
 				split[1] = htonl(offset & 0xffffffff);
@@ -1714,6 +1717,17 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			rp_av[1] = "--objects-edge";
 			continue;
 		}
+		if (!prefixcmp(arg, "--index-version=")) {
+			char *c;
+			index_default_version = strtoul(arg + 16, &c, 10);
+			if (index_default_version > 2)
+				die("bad %s", arg);
+			if (*c == ',')
+				index_off32_limit = strtoul(c+1, &c, 0);
+			if (*c || index_off32_limit & 0x80000000)
+				die("bad %s", arg);
+			continue;
+		}
 		usage(pack_usage);
 	}
 
diff --git a/index-pack.c b/index-pack.c
index a833f64..7aad261 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -671,6 +671,9 @@ static void readjust_pack_header_and_sha1(unsigned char *sha1)
 	write_or_die(output_fd, sha1, 20);
 }
 
+static uint32_t index_default_version = 1;
+static uint32_t index_off32_limit = 0x7fffffff;
+
 static int sha1_compare(const void *_a, const void *_b)
 {
 	struct object_entry *a = *(struct object_entry **)_a;
@@ -719,7 +722,7 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 	f = sha1fd(fd, index_name);
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (objects[nr_objects-1].offset >> 31) ? 2 : 1;
+	index_version = (objects[nr_objects-1].offset >> 31) ? 2 : index_default_version;
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -779,7 +782,7 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		list = sorted_by_sha;
 		for (i = 0; i < nr_objects; i++) {
 			struct object_entry *obj = *list++;
-			uint32_t offset = (obj->offset <= 0x7fffffff) ?
+			uint32_t offset = (obj->offset <= index_off32_limit) ?
 				obj->offset : (0x80000000 | nr_large_offset++);
 			offset = htonl(offset);
 			sha1write(f, &offset, 4);
@@ -790,7 +793,7 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		while (nr_large_offset) {
 			struct object_entry *obj = *list++;
 			uint64_t offset = obj->offset;
-			if (offset > 0x7fffffff) {
+			if (offset > index_off32_limit) {
 				uint32_t split[2];
 				split[0]	= htonl(offset >> 32);
 				split[1] = htonl(offset & 0xffffffff);
@@ -929,6 +932,15 @@ int main(int argc, char **argv)
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
 				index_name = argv[++i];
+			} else if (!prefixcmp(arg, "--index-version=")) {
+				char *c;
+				index_default_version = strtoul(arg + 16, &c, 10);
+				if (index_default_version > 2)
+					die("bad %s", arg);
+				if (*c == ',')
+					index_off32_limit = strtoul(c+1, &c, 0);
+				if (*c || index_off32_limit & 0x80000000)
+					die("bad %s", arg);
 			} else
 				usage(index_pack_usage);
 			continue;
ddiff --git a/t/Makefile b/t/Makefile

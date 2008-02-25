From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 08/10] unpack-objects: prevent writing of inconsistent objects
Date: Mon, 25 Feb 2008 22:54:58 +0100
Message-ID: <12039765003644-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765001192-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002534-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlKl-0007Dt-PG
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166AbYBYVzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759606AbYBYVzb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:31 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55613 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659AbYBYVzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3B647680BF99;
	Mon, 25 Feb 2008 22:55:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JcUAgkcJqVcb; Mon, 25 Feb 2008 22:55:01 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 74EB6680B59A; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765002534-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75080>

This patch introduces a strict mode, which ensures that:
- no malformed object will be written
- no object with broken links will be written

The patch ensures this by delaying the write of all non blob object.
These object are written, after all objects they link to are written.

An error can only result in unreferenced objects.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Documentation/git-unpack-objects.txt |    3 +
 builtin-unpack-objects.c             |  100 +++++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index b79be3f..3697896 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -40,6 +40,9 @@ OPTIONS
 	and make the best effort to recover as many objects as
 	possible.
 
+--strict::
+	Don't write objects with broken content or links.
+
 
 Author
 ------
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index f18c7e8..ec262d5 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -7,11 +7,13 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "progress.h"
 #include "decorate.h"
+#include "fsck.h"
 
-static int dry_run, quiet, recover, has_errors;
-static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
+static int dry_run, quiet, recover, has_errors, strict;
+static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
@@ -144,9 +146,58 @@ static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
 struct obj_info {
 	off_t offset;
 	unsigned char sha1[20];
+	struct object * obj;
 };
 
+#define FLAG_OPEN (1u<<20)
+#define FLAG_WRITTEN (1u<<21)
+
 static struct obj_info *obj_list;
+unsigned nr_objects;
+
+static void write_cached_object(struct object* obj)
+{
+	unsigned char sha1[20];
+	struct obj_buffer *obj_buf = lookup_object_buffer(obj);
+	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), sha1) < 0)
+		die("failed to write object %s", sha1_to_hex(obj->sha1));
+	obj->flags |= FLAG_WRITTEN;
+}
+
+static int check_object(struct object *obj, int type, void *data)
+{
+	if (!obj)
+		return 0;
+	
+	if (obj->flags & FLAG_WRITTEN)
+		return 1;
+	
+	if (type != OBJ_ANY && obj->type != type)
+		die("object type mismatch");
+	
+	if (!(obj->flags & FLAG_OPEN)) {
+		unsigned long size;
+		int type = sha1_object_info (obj->sha1, &size);
+		if (type != obj->type || type <= 0)
+			die("object of unexpected type");
+		obj->flags |= FLAG_WRITTEN;
+		return 1;
+	}
+	
+	if (fsck_object(obj, 1, fsck_error_function))
+		die("Error in object");
+	if (!fsck_walk(obj, check_object, 0))
+		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
+	write_cached_object(obj);
+	return 1;
+}
+
+static void write_rest()
+{
+	unsigned i;
+	for (i = 0; i < nr_objects; i++)
+		check_object(obj_list[i].obj, OBJ_ANY, 0);
+}
 
 static void added_object(unsigned nr, enum object_type type,
 			 void *data, unsigned long size);
@@ -154,9 +205,36 @@ static void added_object(unsigned nr, enum object_type type,
 static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
-	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
-		die("failed to write object");
 	added_object(nr, type, buf, size);
+	if (!strict) {
+		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
+			die("failed to write object");
+		free(buf);
+		obj_list[nr].obj = 0;
+	} else if (type == OBJ_BLOB) {
+		struct blob * blob;
+		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
+			die("failed to write object");
+		free(buf);
+
+		blob = lookup_blob (obj_list[nr].sha1);
+		if (blob)
+			blob->object.flags |= FLAG_WRITTEN;
+		else
+			die("invalid blob object");
+		obj_list[nr].obj = 0;
+	} else {
+		struct object * obj;
+		int eaten;
+		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
+		obj = parse_object_buffer(obj_list[nr].sha1, type, size, buf, &eaten);
+		if (!obj)
+			die ("invalid %s", typename(type));
+		/* buf is stored via add_object_buffer and in obj, if its a tree or commit */
+		add_object_buffer (obj, buf, size);
+		obj->flags |= FLAG_OPEN;
+		obj_list[nr].obj = obj;
+	}
 }
 
 static void resolve_delta(unsigned nr, enum object_type type,
@@ -173,7 +251,6 @@ static void resolve_delta(unsigned nr, enum object_type type,
 		die("failed to apply delta");
 	free(delta);
 	write_object(nr, type, result, result_size);
-	free(result);
 }
 
 static void added_object(unsigned nr, enum object_type type,
@@ -203,7 +280,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
-	free(buf);
+	else
+		free(buf);
 }
 
 static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
@@ -345,7 +423,8 @@ static void unpack_all(void)
 	int i;
 	struct progress *progress = NULL;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
-	unsigned nr_objects = ntohl(hdr->hdr_entries);
+
+	nr_objects = ntohl(hdr->hdr_entries);
 
 	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
 		die("bad pack file");
@@ -356,6 +435,7 @@ static void unpack_all(void)
 	if (!quiet)
 		progress = start_progress("Unpacking objects", nr_objects);
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
+	memset(obj_list, 0, nr_objects * sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
@@ -391,6 +471,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				recover = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--strict")) {
+				strict = 1;
+				continue;
+			}
 			if (!prefixcmp(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
@@ -416,6 +500,8 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	unpack_all();
 	SHA1_Update(&ctx, buffer, offset);
 	SHA1_Final(sha1, &ctx);
+	if (strict)
+		write_rest();
 	if (hashcmp(fill(20), sha1))
 		die("final sha1 did not match");
 	use(20);
-- 
1.5.4.3.g3c5f

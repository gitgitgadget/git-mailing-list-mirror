From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] unpack-objects: prevent writing of inconsistent objects
Date: Wed,  5 Mar 2008 02:09:06 -0800
Message-ID: <1204711748-10044-1-git-send-email-gitster@pobox.com>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 11:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWqZY-0006Hs-CU
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 11:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760953AbYCEKJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 05:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760757AbYCEKJ0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 05:09:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759987AbYCEKJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 05:09:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE0BB243B;
	Wed,  5 Mar 2008 05:09:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 71BC5243A; Wed,  5 Mar 2008 05:09:20 -0500 (EST)
X-Mailer: git-send-email 1.5.4.3.529.gb25fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76206>

From: Martin Koegler <mkoegler@auto.tuwien.ac.at>

This patch introduces a strict mode, which ensures that:
- no malformed object will be written
- no object with broken links will be written

The patch ensures this by delaying the write of all non blob object.
These object are written, after all objects they link to are written.

An error can only result in unreferenced objects.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is resurrection of the reverted patch, as-is.

 Documentation/git-unpack-objects.txt |    3 +
 builtin-unpack-objects.c             |  110 +++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 7 deletions(-)

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
index 50e07fa..9d2a854 100644
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
@@ -31,6 +33,16 @@ static struct obj_buffer *lookup_object_buffer(struct object *base)
 	return lookup_decoration(&obj_decorate, base);
 }
 
+static void add_object_buffer(struct object *object, char *buffer, unsigned long size)
+{
+	struct obj_buffer *obj;
+	obj = xcalloc(1, sizeof(struct obj_buffer));
+	obj->buffer = buffer;
+	obj->size = size;
+	if (add_decoration(&obj_decorate, object, obj))
+		die("object %s tried to add buffer twice!", sha1_to_hex(object->sha1));
+}
+
 /*
  * Make sure at least "min" bytes are available in the buffer, and
  * return the pointer to the buffer.
@@ -134,9 +146,58 @@ static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
 struct obj_info {
 	off_t offset;
 	unsigned char sha1[20];
+	struct object *obj;
 };
 
+#define FLAG_OPEN (1u<<20)
+#define FLAG_WRITTEN (1u<<21)
+
 static struct obj_info *obj_list;
+unsigned nr_objects;
+
+static void write_cached_object(struct object *obj)
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
+		int type = sha1_object_info(obj->sha1, &size);
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
+static void write_rest(void)
+{
+	unsigned i;
+	for (i = 0; i < nr_objects; i++)
+		check_object(obj_list[i].obj, OBJ_ANY, 0);
+}
 
 static void added_object(unsigned nr, enum object_type type,
 			 void *data, unsigned long size);
@@ -144,9 +205,36 @@ static void added_object(unsigned nr, enum object_type type,
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
+		struct blob *blob;
+		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
+			die("failed to write object");
+		free(buf);
+
+		blob = lookup_blob(obj_list[nr].sha1);
+		if (blob)
+			blob->object.flags |= FLAG_WRITTEN;
+		else
+			die("invalid blob object");
+		obj_list[nr].obj = 0;
+	} else {
+		struct object *obj;
+		int eaten;
+		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
+		obj = parse_object_buffer(obj_list[nr].sha1, type, size, buf, &eaten);
+		if (!obj)
+			die("invalid %s", typename(type));
+		/* buf is stored via add_object_buffer and in obj, if its a tree or commit */
+		add_object_buffer(obj, buf, size);
+		obj->flags |= FLAG_OPEN;
+		obj_list[nr].obj = obj;
+	}
 }
 
 static void resolve_delta(unsigned nr, enum object_type type,
@@ -163,7 +251,6 @@ static void resolve_delta(unsigned nr, enum object_type type,
 		die("failed to apply delta");
 	free(delta);
 	write_object(nr, type, result, result_size);
-	free(result);
 }
 
 static void added_object(unsigned nr, enum object_type type,
@@ -193,7 +280,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
-	free(buf);
+	else
+		free(buf);
 }
 
 static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
@@ -336,7 +424,8 @@ static void unpack_all(void)
 	int i;
 	struct progress *progress = NULL;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
-	unsigned nr_objects = ntohl(hdr->hdr_entries);
+
+	nr_objects = ntohl(hdr->hdr_entries);
 
 	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
 		die("bad pack file");
@@ -347,6 +436,7 @@ static void unpack_all(void)
 	if (!quiet)
 		progress = start_progress("Unpacking objects", nr_objects);
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
+	memset(obj_list, 0, nr_objects * sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
@@ -382,6 +472,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
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
@@ -407,6 +501,8 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	unpack_all();
 	SHA1_Update(&ctx, buffer, offset);
 	SHA1_Final(sha1, &ctx);
+	if (strict)
+		write_rest();
 	if (hashcmp(fill(20), sha1))
 		die("final sha1 did not match");
 	use(20);
-- 
1.5.4.3.529.gb25fb


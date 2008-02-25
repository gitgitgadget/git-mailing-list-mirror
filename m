From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 09/10] index-pack: introduce checking mode
Date: Mon, 25 Feb 2008 22:54:59 +0100
Message-ID: <12039765001906-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765001192-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002534-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003644-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:58:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlKm-0007Dt-KY
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759608AbYBYVzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759032AbYBYVze
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:34 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55614 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759608AbYBYVzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4287F6870AA0;
	Mon, 25 Feb 2008 22:55:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEBRYO97giBx; Mon, 25 Feb 2008 22:55:01 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 85FF7680B59E; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765003644-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75081>

Adds strict option, which bails out if the pack would
introduces broken object or links in the repository.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
The resource usage for (!strict) is the same.
For (strict) we need the struct blob/tree/commit/tag for
each object (without any data).

 Documentation/git-index-pack.txt |    3 +
 index-pack.c                     |   86 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 72b5d00..a7825b6 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -75,6 +75,9 @@ OPTIONS
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
+--strict::
+	Die, if the pack contains broken objects or links.
+
 
 Note
 ----
diff --git a/index-pack.c b/index-pack.c
index 9fd6982..0bbf42e 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -7,9 +7,10 @@
 #include "tag.h"
 #include "tree.h"
 #include "progress.h"
+#include "fsck.h"
 
 static const char index_pack_usage[] =
-"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
 {
@@ -31,6 +32,9 @@ union delta_base {
  */
 #define UNION_BASE_SZ	20
 
+#define FLAG_LINK (1u<<20)
+#define FLAG_CHECKED (1u<<21)
+
 struct delta_entry
 {
 	union delta_base base;
@@ -44,6 +48,7 @@ static int nr_deltas;
 static int nr_resolved_deltas;
 
 static int from_stdin;
+static int strict;
 static int verbose;
 
 static struct progress *progress;
@@ -56,6 +61,48 @@ static SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
 
+static int mark_link(struct object* obj, int type, void *data)
+{
+	if (!obj)
+		return -1;
+
+	if (type != OBJ_ANY && obj->type != type)
+		die("object type mismatch at %s", sha1_to_hex(obj->sha1));
+
+	obj->flags |= FLAG_LINK;
+	return 0;
+}
+
+/* The content of each linked object must have been checked
+   or it must be already present in the object database */
+static void check_object(struct object* obj)
+{
+	if (!obj)
+		return;
+	
+	if (!(obj->flags & FLAG_LINK))
+		return;
+	
+	if (!(obj->flags & FLAG_CHECKED)) {
+		unsigned long size;
+		int type = sha1_object_info (obj->sha1, &size);
+		if (type != obj->type || type <= 0)
+			die("object of unexpected type");
+		obj->flags |= FLAG_CHECKED;
+		return;
+	}
+}
+
+static void check_objects()
+{
+	unsigned i, max;
+
+	max = get_max_object_index();
+	for (i = 0; i < max; i++)
+		check_object(get_indexed_object(i));
+}
+
+
 /* Discard current buffer used content. */
 static void flush(void)
 {
@@ -341,6 +388,39 @@ static void sha1_object(const void *data, unsigned long size,
 			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
 		free(has_data);
 	}
+	if (strict) {
+		if (type == OBJ_BLOB) {
+			struct blob * blob = lookup_blob(sha1);
+			if (blob)
+				blob->object.flags |= FLAG_CHECKED;
+			else
+				die("invalid blob object %s", sha1_to_hex(sha1));
+		} else {
+			struct object * obj;
+			int eaten;
+			void *buf = data;
+			
+			/* we do not need to free the memory here, as the buf is deleted
+			   by the caller */
+			obj = parse_object_buffer(sha1, type, size, buf, &eaten);
+			if (!obj)
+				die("invalid %s", typename(type));
+		        if (fsck_object(obj, 1, fsck_error_function))
+				die("Error in object");
+			if (fsck_walk(obj, mark_link, 0))
+				die("Not all child objects of %s are reachable", sha1_to_hex(obj->sha1));
+
+			if (obj->type == OBJ_TREE) {
+				struct tree *item = (struct item*) obj;
+				item->buffer = NULL;
+			}
+			if (obj->type == OBJ_COMMIT) {
+				struct commit *commit = (struct commit*) obj;
+				commit->buffer = NULL;
+			}
+			obj->flags |= FLAG_CHECKED;
+		}
+	}
 }
 
 static void resolve_delta(struct object_entry *delta_obj, void *base_data,
@@ -714,6 +794,8 @@ int main(int argc, char **argv)
 				from_stdin = 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack = 1;
+			} else if (!strcmp(arg, "--strict")) {
+				strict = 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg = "";
 			} else if (!prefixcmp(arg, "--keep=")) {
@@ -812,6 +894,8 @@ int main(int argc, char **argv)
 			    nr_deltas - nr_resolved_deltas);
 	}
 	free(deltas);
+	if (strict)
+		check_objects();
 
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
 	for (i = 0; i < nr_objects; i++)
-- 
1.5.4.3.g3c5f

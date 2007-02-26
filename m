From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/6] formalize typename(),
 and add its reverse type_from_string()
Date: Mon, 26 Feb 2007 14:55:58 -0500
Message-ID: <11725197633144-git-send-email-nico@cam.org>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlxb-0004Dt-6d
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbXBZT4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbXBZT4K
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:56:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501AbXBZT4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:56:05 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3007SW61CD1Q1@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 14:56:03 -0500 (EST)
In-reply-to: <11725197622423-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.572.ge86d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40655>

Sometime typename() is used, sometimes type_names[] is accessed directly.
Let's enforce typename() all the time which allows for validating the
type.

Also let's add a function to go from a name to a type and use it instead
of manual memcpy() when appropriate.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-for-each-ref.c |    2 +-
 builtin-pack-objects.c |   13 +------------
 fast-import.c          |   10 +++++-----
 index-pack.c           |    7 +------
 object.c               |   26 +++++++++++++++++++++++---
 object.h               |   10 +++-------
 sha1_file.c            |   19 +++++--------------
 7 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index ac0b9f6..14fff2b 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -196,7 +196,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "objecttype"))
-			v->s = type_names[obj->type];
+			v->s = typename(obj->type);
 		else if (!strcmp(name, "objectsize")) {
 			char *s = xmalloc(40);
 			sprintf(s, "%lu", sz);
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b5ed9ce..c456f49 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1065,18 +1065,7 @@ static void check_object(struct object_entry *entry)
 	if (sha1_object_info(entry->sha1, type, &entry->size))
 		die("unable to get type of object %s",
 		    sha1_to_hex(entry->sha1));
-
-	if (!strcmp(type, commit_type)) {
-		entry->type = OBJ_COMMIT;
-	} else if (!strcmp(type, tree_type)) {
-		entry->type = OBJ_TREE;
-	} else if (!strcmp(type, blob_type)) {
-		entry->type = OBJ_BLOB;
-	} else if (!strcmp(type, tag_type)) {
-		entry->type = OBJ_TAG;
-	} else
-		die("unable to pack object %s of type %s",
-		    sha1_to_hex(entry->sha1), type);
+	entry->type = type_from_string(type);
 }
 
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
diff --git a/fast-import.c b/fast-import.c
index 5d040fd..aa9eac3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -891,7 +891,7 @@ static int store_object(
 	SHA_CTX c;
 	z_stream s;
 
-	hdrlen = sprintf((char*)hdr,"%s %lu", type_names[type],
+	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
 		(unsigned long)datlen) + 1;
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, hdrlen);
@@ -1626,7 +1626,7 @@ static void file_change_m(struct branch *b)
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
-				command_buf.buf, type_names[oe->type]);
+				command_buf.buf, typename(oe->type));
 	} else {
 		if (sha1_object_info(sha1, type, NULL))
 			die("Blob not found: %s", command_buf.buf);
@@ -1711,7 +1711,7 @@ static void cmd_from(struct branch *b)
 			char *buf;
 
 			buf = read_object_with_reference(b->sha1,
-				type_names[OBJ_COMMIT], &size, b->sha1);
+				commit_type, &size, b->sha1);
 			if (!buf || size < 46)
 				die("Not a valid commit: %s", from);
 			if (memcmp("tree ", buf, 5)
@@ -1895,7 +1895,7 @@ static void cmd_new_tag(void)
 		char *buf;
 
 		buf = read_object_with_reference(sha1,
-			type_names[OBJ_COMMIT], &size, sha1);
+			commit_type, &size, sha1);
 		if (!buf || size < 46)
 			die("Not a valid commit: %s", from);
 		free(buf);
@@ -1916,7 +1916,7 @@ static void cmd_new_tag(void)
 	size_dbuf(&new_data, 67+strlen(t->name)+strlen(tagger)+msglen);
 	sp = new_data.buffer;
 	sp += sprintf(sp, "object %s\n", sha1_to_hex(sha1));
-	sp += sprintf(sp, "type %s\n", type_names[OBJ_COMMIT]);
+	sp += sprintf(sp, "type %s\n", commit_type);
 	sp += sprintf(sp, "tag %s\n", t->name);
 	sp += sprintf(sp, "tagger %s\n", tagger);
 	*sp++ = '\n';
diff --git a/index-pack.c b/index-pack.c
index 365f8f3..c25cd40 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -605,13 +605,8 @@ static void fix_unresolved_deltas(int nr_unresolved)
 		data = read_sha1_file(d->base.sha1, type, &size);
 		if (!data)
 			continue;
-		if      (!strcmp(type, blob_type))   obj_type = OBJ_BLOB;
-		else if (!strcmp(type, tree_type))   obj_type = OBJ_TREE;
-		else if (!strcmp(type, commit_type)) obj_type = OBJ_COMMIT;
-		else if (!strcmp(type, tag_type))    obj_type = OBJ_TAG;
-		else die("base object %s is of type '%s'",
-			 sha1_to_hex(d->base.sha1), type);
 
+		obj_type = type_from_string(type);
 		find_delta_children(&d->base, &first, &last);
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
diff --git a/object.c b/object.c
index de244e2..37cedc0 100644
--- a/object.c
+++ b/object.c
@@ -18,11 +18,31 @@ struct object *get_indexed_object(unsigned int idx)
 	return obj_hash[idx];
 }
 
-const char *type_names[] = {
-	"none", "commit", "tree", "blob", "tag",
-	"bad type 5", "bad type 6", "delta", "bad",
+static const char *object_type_strings[] = {
+	NULL,		/* OBJ_NONE = 0 */
+	"commit",	/* OBJ_COMMIT = 1 */
+	"tree",		/* OBJ_TREE = 2 */
+	"blob",		/* OBJ_BLOB = 3 */
+	"tag",		/* OBJ_TAG = 4 */
 };
 
+const char *typename(unsigned int type)
+{
+	if (type >= ARRAY_SIZE(object_type_strings))
+		return NULL;
+	return object_type_strings[type];
+}
+
+int type_from_string(const char *str)
+{
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
+		if (!strcmp(str, object_type_strings[i]))
+			return i;
+	die("invalid object type \"%s\"", str);
+}
+
 static unsigned int hash_obj(struct object *obj, unsigned int n)
 {
 	unsigned int hash = *(unsigned int *)obj->sha1;
diff --git a/object.h b/object.h
index caee733..ade4dae 100644
--- a/object.h
+++ b/object.h
@@ -36,16 +36,12 @@ struct object {
 };
 
 extern int track_object_refs;
-extern const char *type_names[9];
+
+extern const char *typename(unsigned int type);
+extern int type_from_string(const char *str);
 
 extern unsigned int get_max_object_index(void);
 extern struct object *get_indexed_object(unsigned int);
-
-static inline const char *typename(unsigned int type)
-{
-	return type_names[type > OBJ_BAD ? OBJ_BAD : type];
-}
-
 extern struct object_refs *lookup_object_refs(struct object *);
 
 /** Internal only **/
diff --git a/sha1_file.c b/sha1_file.c
index 8b7b68c..423ff0a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -952,7 +952,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 
 	/* And generate the fake traditional header */
 	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
-					 type_names[type], size);
+					 typename(type), size);
 	return 0;
 }
 
@@ -1195,7 +1195,7 @@ void packed_object_info_detail(struct packed_git *p,
 		case OBJ_TREE:
 		case OBJ_BLOB:
 		case OBJ_TAG:
-			strcpy(type, type_names[kind]);
+			strcpy(type, typename(kind));
 			*store_size = 0; /* notyet */
 			unuse_pack(&w_curs);
 			return;
@@ -1237,7 +1237,7 @@ static int packed_object_info(struct packed_git *p, unsigned long obj_offset,
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		strcpy(type, type_names[kind]);
+		strcpy(type, typename(kind));
 		if (sizep)
 			*sizep = size;
 		break;
@@ -1329,7 +1329,7 @@ void *unpack_entry(struct packed_git *p, unsigned long obj_offset,
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		strcpy(type, type_names[kind]);
+		strcpy(type, typename(kind));
 		*sizep = size;
 		retval = unpack_compressed_entry(p, &w_curs, curpos, size);
 		break;
@@ -1739,16 +1739,7 @@ static void setup_object_header(z_stream *stream, const char *type, unsigned lon
 			/* nothing */;
 		return;
 	}
-	if (!strcmp(type, blob_type))
-		obj_type = OBJ_BLOB;
-	else if (!strcmp(type, tree_type))
-		obj_type = OBJ_TREE;
-	else if (!strcmp(type, commit_type))
-		obj_type = OBJ_COMMIT;
-	else if (!strcmp(type, tag_type))
-		obj_type = OBJ_TAG;
-	else
-		die("trying to generate bogus object of type '%s'", type);
+	obj_type = type_from_string(type);
 	hdrlen = write_binary_header(stream->next_out, obj_type, len);
 	stream->total_out = hdrlen;
 	stream->next_out += hdrlen;
-- 
1.5.0.572.ge86d

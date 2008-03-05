From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] unpack-objects: fix --strict handling
Date: Wed,  5 Mar 2008 02:09:08 -0800
Message-ID: <1204711748-10044-3-git-send-email-gitster@pobox.com>
References: <1204711748-10044-1-git-send-email-gitster@pobox.com>
 <1204711748-10044-2-git-send-email-gitster@pobox.com>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Sergey Vlasov <vsu@altlinux.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 11:10:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWqZs-0006Ol-GK
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 11:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761166AbYCEKJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 05:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761229AbYCEKJh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 05:09:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761166AbYCEKJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 05:09:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF72924A1
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 05:09:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 843B8243F for <git@vger.kernel.org>; Wed,  5 Mar 2008 05:09:33 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.529.gb25fb
In-Reply-To: <1204711748-10044-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76207>

Earlier attempt (which was reverted) called added_object() (by the way,
the function should be renamed to resolve_dependents() --- it is called
when we have a complete object data, and is responsible to resolve pending
deltified objects that use this object as their delta base object) without
updating obj_list[nr].sha1 with the correct value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I still doubt that FLAG_OPEN is necessary, but at least this
   seems to fix the issue for me.  I am sick and tired of having
   spent two nights looking at this issue, and I ran out of time
   to deal with other topics I looked at on the list.

   The moral of the story is _NOT_ "do not to trust Martin's
   patches", but "I should ignore topics unless I have enough
   time to read them line-by-line.  Queuing them, hoping that
   problems are caught by somebody while they are in 'next',
   would NOT work".

 builtin-unpack-objects.c |   73 ++++++++++++++++++++++++++++++++++++----------
 t/t5300-pack-object.sh   |    2 +-
 2 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9d2a854..fecf0be 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -21,6 +21,11 @@ static unsigned int offset, len;
 static off_t consumed_bytes;
 static SHA_CTX ctx;
 
+/*
+ * When running under --strict mode, objects whose reachability are
+ * suspect are kept in core without getting written in the object
+ * store.
+ */
 struct obj_buffer {
 	char *buffer;
 	unsigned long size;
@@ -155,6 +160,10 @@ struct obj_info {
 static struct obj_info *obj_list;
 unsigned nr_objects;
 
+/*
+ * Called only from check_object() after it verified this object
+ * is Ok.
+ */
 static void write_cached_object(struct object *obj)
 {
 	unsigned char sha1[20];
@@ -164,6 +173,11 @@ static void write_cached_object(struct object *obj)
 	obj->flags |= FLAG_WRITTEN;
 }
 
+/*
+ * At the very end of the processing, write_rest() scans the objects
+ * that have reachability requirements and calls this function.
+ * Verify its reachability and validity recursively and write it out.
+ */
 static int check_object(struct object *obj, int type, void *data)
 {
 	if (!obj)
@@ -202,19 +216,25 @@ static void write_rest(void)
 static void added_object(unsigned nr, enum object_type type,
 			 void *data, unsigned long size);
 
+/*
+ * Write out nr-th object from the list, now we know the contents
+ * of it.  Under --strict, this buffers structured objects in-core,
+ * to be checked at the end.
+ */
 static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
-	added_object(nr, type, buf, size);
 	if (!strict) {
 		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
 			die("failed to write object");
+		added_object(nr, type, buf, size);
 		free(buf);
-		obj_list[nr].obj = 0;
+		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
 		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
 			die("failed to write object");
+		added_object(nr, type, buf, size);
 		free(buf);
 
 		blob = lookup_blob(obj_list[nr].sha1);
@@ -222,15 +242,15 @@ static void write_object(unsigned nr, enum object_type type,
 			blob->object.flags |= FLAG_WRITTEN;
 		else
 			die("invalid blob object");
-		obj_list[nr].obj = 0;
+		obj_list[nr].obj = NULL;
 	} else {
 		struct object *obj;
 		int eaten;
 		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
+		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(obj_list[nr].sha1, type, size, buf, &eaten);
 		if (!obj)
 			die("invalid %s", typename(type));
-		/* buf is stored via add_object_buffer and in obj, if its a tree or commit */
 		add_object_buffer(obj, buf, size);
 		obj->flags |= FLAG_OPEN;
 		obj_list[nr].obj = obj;
@@ -253,6 +273,10 @@ static void resolve_delta(unsigned nr, enum object_type type,
 	write_object(nr, type, result, result_size);
 }
 
+/*
+ * We now know the contents of an object (which is nr-th in the pack);
+ * resolve all the deltified objects that are based on it.
+ */
 static void added_object(unsigned nr, enum object_type type,
 			 void *data, unsigned long size)
 {
@@ -284,13 +308,28 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 		free(buf);
 }
 
+static int resolve_against_held(unsigned nr, const unsigned char *base,
+				void *delta_data, unsigned long delta_size)
+{
+	struct object *obj;
+	struct obj_buffer *obj_buffer;
+	obj = lookup_object(base);
+	if (!obj)
+		return 0;
+	obj_buffer = lookup_object_buffer(obj);
+	if (!obj_buffer)
+		return 0;
+	resolve_delta(nr, obj->type, obj_buffer->buffer,
+		      obj_buffer->size, delta_data, delta_size);
+	return 1;
+}
+
 static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			       unsigned nr)
 {
 	void *delta_data, *base;
 	unsigned long base_size;
 	unsigned char base_sha1[20];
-	struct object *obj;
 
 	if (type == OBJ_REF_DELTA) {
 		hashcpy(base_sha1, fill(20));
@@ -300,7 +339,13 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			free(delta_data);
 			return;
 		}
-		if (!has_sha1_file(base_sha1)) {
+		if (has_sha1_file(base_sha1))
+			; /* Ok we have this one */
+		else if (resolve_against_held(nr, base_sha1,
+					      delta_data, delta_size))
+			return; /* we are done */
+		else {
+			/* cannot resolve yet --- queue it */
 			hashcpy(obj_list[nr].sha1, null_sha1);
 			add_delta_to_list(nr, base_sha1, 0, delta_data, delta_size);
 			return;
@@ -346,22 +391,18 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			}
 		}
 		if (!base_found) {
-			/* The delta base object is itself a delta that
-			   has not been	resolved yet. */
+			/*
+			 * The delta base object is itself a delta that
+			 * has not been resolved yet.
+			 */
 			hashcpy(obj_list[nr].sha1, null_sha1);
 			add_delta_to_list(nr, null_sha1, base_offset, delta_data, delta_size);
 			return;
 		}
 	}
 
-	obj = lookup_object(base_sha1);
-	if (obj) {
-		struct obj_buffer *obj_buf = lookup_object_buffer(obj);
-		if (obj_buf) {
-			resolve_delta(nr, obj->type, obj_buf->buffer, obj_buf->size, delta_data, delta_size);
-			return;
-		}
-	}
+	if (resolve_against_held(nr, base_sha1, delta_data, delta_size))
+		return;
 
 	base = read_sha1_file(base_sha1, &type, &base_size);
 	if (!base) {
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index b297393..b7610d1 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -274,7 +274,7 @@ test_expect_success \
      packname_4=$(git pack-objects test-4 <obj-list) &&
      test 3 = $(ls test-4-*.pack | wc -l)'
 
-test_expect_failure 'unpacking with --strict' '
+test_expect_success 'unpacking with --strict' '
 
 	git config --unset pack.packsizelimit &&
 	COPYING=$(git hash-object -w ../../COPYING) &&
-- 
1.5.4.3.529.gb25fb


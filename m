From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 7/9] bundle.c: convert leaf functions to struct object_id
Date: Sat,  3 May 2014 20:12:20 +0000
Message-ID: <1399147942-165308-8-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIh-0004K5-5f
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbaECUMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:41 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47533 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753312AbaECUMc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2C2F928089
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:30 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248051>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bundle.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/bundle.c b/bundle.c
index 1222952..798ba28 100644
--- a/bundle.c
+++ b/bundle.c
@@ -11,11 +11,11 @@
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
-static void add_to_ref_list(const unsigned char *sha1, const char *name,
+static void add_to_ref_list(const struct object_id *sha1, const char *name,
 		struct ref_list *list)
 {
 	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
-	hashcpy(list->list[list->nr].sha1, sha1);
+	hashcpy(list->list[list->nr].sha1, sha1->oid);
 	list->list[list->nr].name = xstrdup(name);
 	list->nr++;
 }
@@ -39,7 +39,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	/* The bundle header ends with an empty line */
 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
 	       buf.len && buf.buf[0] != '\n') {
-		unsigned char sha1[20];
+		struct object_id sha1;
 		int is_prereq = 0;
 
 		if (*buf.buf == '-') {
@@ -53,9 +53,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		 * Prerequisites have object name that is optionally
 		 * followed by SP and subject line.
 		 */
-		if (get_sha1_hex(buf.buf, sha1) ||
-		    (buf.len > 40 && !isspace(buf.buf[40])) ||
-		    (!is_prereq && buf.len <= 40)) {
+		if (get_sha1_hex(buf.buf, sha1.oid) ||
+		    (buf.len > GIT_OID_HEXSZ && !isspace(buf.buf[GIT_OID_HEXSZ])) ||
+		    (!is_prereq && buf.len <= GIT_OID_HEXSZ)) {
 			if (report_path)
 				error(_("unrecognized header: %s%s (%d)"),
 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
@@ -63,9 +63,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 			break;
 		} else {
 			if (is_prereq)
-				add_to_ref_list(sha1, "", &header->prerequisites);
+				add_to_ref_list(&sha1, "", &header->prerequisites);
 			else
-				add_to_ref_list(sha1, buf.buf + 41, &header->references);
+				add_to_ref_list(&sha1, buf.buf + 41, &header->references);
 		}
 	}
 
@@ -274,16 +274,16 @@ int create_bundle(struct bundle_header *header, const char *path,
 		return -1;
 	rls_fout = xfdopen(rls.out, "r");
 	while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
-		unsigned char sha1[20];
+		struct object_id sha1;
 		if (buf.len > 0 && buf.buf[0] == '-') {
 			write_or_die(bundle_fd, buf.buf, buf.len);
-			if (!get_sha1_hex(buf.buf + 1, sha1)) {
-				struct object *object = parse_object_or_die(sha1, buf.buf);
+			if (!get_sha1_hex(buf.buf + 1, sha1.oid)) {
+				struct object *object = parse_object_or_die(sha1.oid, buf.buf);
 				object->flags |= UNINTERESTING;
 				add_pending_object(&revs, object, buf.buf);
 			}
-		} else if (!get_sha1_hex(buf.buf, sha1)) {
-			struct object *object = parse_object_or_die(sha1, buf.buf);
+		} else if (!get_sha1_hex(buf.buf, sha1.oid)) {
+			struct object *object = parse_object_or_die(sha1.oid, buf.buf);
 			object->flags |= SHOWN;
 		}
 	}
@@ -302,16 +302,16 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
-		unsigned char sha1[20];
+		struct object_id sha1;
 		char *ref;
 		const char *display_ref;
 		int flag;
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
+		if (dwim_ref(e->name, strlen(e->name), sha1.oid, &ref) != 1)
 			continue;
-		if (read_ref_full(e->name, sha1, 1, &flag))
+		if (read_ref_full(e->name, sha1.oid, 1, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
@@ -342,13 +342,13 @@ int create_bundle(struct bundle_header *header, const char *path,
 		 * commit that is referenced by the tag, and not the tag
 		 * itself.
 		 */
-		if (hashcmp(sha1, e->item->sha1)) {
+		if (hashcmp(sha1.oid, e->item->sha1)) {
 			/*
 			 * Is this the positive end of a range expressed
 			 * in terms of a tag (e.g. v2.0 from the range
 			 * "v1.0..v2.0")?
 			 */
-			struct commit *one = lookup_commit_reference(sha1);
+			struct commit *one = lookup_commit_reference(sha1.oid);
 			struct object *obj;
 
 			if (e->item == &(one->object)) {
@@ -360,7 +360,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 				 * end up triggering "empty bundle"
 				 * error.
 				 */
-				obj = parse_object_or_die(sha1, e->name);
+				obj = parse_object_or_die(sha1.oid, e->name);
 				obj->flags |= SHOWN;
 				add_pending_object(&revs, obj, e->name);
 			}
-- 
2.0.0.rc0

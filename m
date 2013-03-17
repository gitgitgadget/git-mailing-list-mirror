From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/4] avoid segfaults on parse_object failure
Date: Sun, 17 Mar 2013 04:22:36 -0400
Message-ID: <20130317082236.GA29550@sigill.intra.peff.net>
References: <20130317082139.GA29505@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 09:23:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH8s0-0000C2-Us
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab3CQIWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:22:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54166 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756023Ab3CQIWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:22:39 -0400
Received: (qmail 7719 invoked by uid 107); 17 Mar 2013 08:24:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:24:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:22:36 -0400
Content-Disposition: inline
In-Reply-To: <20130317082139.GA29505@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218346>

Many call-sites of parse_object assume that they will get a
non-NULL return value; this is not the case if we encounter
an error while parsing the object.

This patch adds a wrapper function around parse_object that
handles dying automatically, and uses it anywhere we
immediately try to access the return value as a non-NULL
pointer (i.e., anywhere that we would currently segfault).

This wrapper may also be useful in other places. The most
obvious one is code like:

  o = parse_object(sha1);
  if (!o)
	  die(...);

However, these should not be mechanically converted to
parse_object_or_die, as the die message is sometimes
customized. Later patches can address these sites on a
case-by-case basis.

Signed-off-by: Jeff King <peff@peff.net>
---
 bundle.c    |  6 +++---
 object.c    | 10 ++++++++++
 object.h    | 13 ++++++++++++-
 pack-refs.c |  2 +-
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index 8d12816..26ceebd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -279,12 +279,12 @@ int create_bundle(struct bundle_header *header, const char *path,
 		if (buf.len > 0 && buf.buf[0] == '-') {
 			write_or_die(bundle_fd, buf.buf, buf.len);
 			if (!get_sha1_hex(buf.buf + 1, sha1)) {
-				struct object *object = parse_object(sha1);
+				struct object *object = parse_object_or_die(sha1, buf.buf);
 				object->flags |= UNINTERESTING;
 				add_pending_object(&revs, object, xstrdup(buf.buf));
 			}
 		} else if (!get_sha1_hex(buf.buf, sha1)) {
-			struct object *object = parse_object(sha1);
+			struct object *object = parse_object_or_die(sha1, buf.buf);
 			object->flags |= SHOWN;
 		}
 	}
@@ -361,7 +361,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 				 * end up triggering "empty bundle"
 				 * error.
 				 */
-				obj = parse_object(sha1);
+				obj = parse_object_or_die(sha1, e->name);
 				obj->flags |= SHOWN;
 				add_pending_object(&revs, obj, e->name);
 			}
diff --git a/object.c b/object.c
index 4af3451..20703f5 100644
--- a/object.c
+++ b/object.c
@@ -185,6 +185,16 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 	return obj;
 }
 
+struct object *parse_object_or_die(const unsigned char *sha1,
+				   const char *name)
+{
+	struct object *o = parse_object(sha1);
+	if (o)
+		return o;
+
+	die(_("unable to parse object: %s"), name ? name : sha1_to_hex(sha1));
+}
+
 struct object *parse_object(const unsigned char *sha1)
 {
 	unsigned long size;
diff --git a/object.h b/object.h
index 6a97b6b..97d384b 100644
--- a/object.h
+++ b/object.h
@@ -54,9 +54,20 @@ struct object *parse_object(const unsigned char *sha1);
 
 extern void *create_object(const unsigned char *sha1, int type, void *obj);
 
-/** Returns the object, having parsed it to find out what it is. **/
+/*
+ * Returns the object, having parsed it to find out what it is.
+ *
+ * Returns NULL if the object is missing or corrupt.
+ */
 struct object *parse_object(const unsigned char *sha1);
 
+/*
+ * Like parse_object, but will die() instead of returning NULL. If the
+ * "name" parameter is not NULL, it is included in the error message
+ * (otherwise, the sha1 hex is given).
+ */
+struct object *parse_object_or_die(const unsigned char *sha1, const char *name);
+
 /* Given the result of read_sha1_file(), returns the object after
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
diff --git a/pack-refs.c b/pack-refs.c
index f09a054..6a689f3 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -40,7 +40,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 
 	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
 	if (is_tag_ref) {
-		struct object *o = parse_object(sha1);
+		struct object *o = parse_object_or_die(sha1, path);
 		if (o->type == OBJ_TAG) {
 			o = deref_tag(o, path, 0);
 			if (o)
-- 
1.8.2.rc2.7.gef06216

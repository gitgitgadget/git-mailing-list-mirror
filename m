From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] fast-export: use object to uint32 map instead of
 "decorate"
Date: Sat, 4 Aug 2012 13:11:03 -0400
Message-ID: <20120804171103.GC19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:11:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxhsp-0003Iu-EJ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2HDRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:11:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51680 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753769Ab2HDRLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:11:05 -0400
Received: (qmail 2011 invoked by uid 107); 4 Aug 2012 17:11:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:11:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:11:03 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202885>

Previously we encoded the "mark" mapping inside the "void *"
field of a "struct decorate". It's a little more natural for
us to do so using a data structure made for holding actual
values.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9ab6db3..03e8f5f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -12,7 +12,7 @@
 #include "diffcore.h"
 #include "log-tree.h"
 #include "revision.h"
-#include "decorate.h"
+#include "map-object.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
@@ -61,7 +61,17 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	return 0;
 }
 
-static struct decoration idnums;
+#define NAME object_uint32
+#define KEY_TYPE struct object *
+#define VALUE_TYPE uint32_t
+#define HASH hash_obj
+#define KEY_EQUAL obj_equal
+#define SENTINEL_NULL
+#include "map-decl.h"
+#include "map-impl.h"
+#include "map-done.h"
+
+static struct map_object_uint32 idnums;
 static uint32_t last_idnum;
 
 static int has_unshown_parent(struct commit *commit)
@@ -75,20 +85,9 @@ static int has_unshown_parent(struct commit *commit)
 	return 0;
 }
 
-/* Since intptr_t is C99, we do not use it here */
-static inline uint32_t *mark_to_ptr(uint32_t mark)
-{
-	return ((uint32_t *)NULL) + mark;
-}
-
-static inline uint32_t ptr_to_mark(void * mark)
-{
-	return (uint32_t *)mark - (uint32_t *)NULL;
-}
-
 static inline void mark_object(struct object *object, uint32_t mark)
 {
-	add_decoration(&idnums, object, mark_to_ptr(mark));
+	map_set_object_uint32(&idnums, object, mark, NULL);
 }
 
 static inline void mark_next_object(struct object *object)
@@ -98,10 +97,9 @@ static inline void mark_next_object(struct object *object)
 
 static int get_object_mark(struct object *object)
 {
-	void *decoration = lookup_decoration(&idnums, object);
-	if (!decoration)
-		return 0;
-	return ptr_to_mark(decoration);
+	uint32_t ret = 0;
+	map_get_object_uint32(&idnums, object, &ret);
+	return ret;
 }
 
 static void show_progress(void)
@@ -557,8 +555,6 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 static void export_marks(char *file)
 {
 	unsigned int i;
-	uint32_t mark;
-	struct object_decoration *deco = idnums.hash;
 	FILE *f;
 	int e = 0;
 
@@ -567,15 +563,15 @@ static void export_marks(char *file)
 		die_errno("Unable to open marks file %s for writing.", file);
 
 	for (i = 0; i < idnums.size; i++) {
-		if (deco->base && deco->base->type == 1) {
-			mark = ptr_to_mark(deco->decoration);
-			if (fprintf(f, ":%"PRIu32" %s\n", mark,
-				sha1_to_hex(deco->base->sha1)) < 0) {
+		const struct map_entry_object_uint32 *m = idnums.hash + i;
+
+		if (m->key && m->key->type == 1) {
+			if (fprintf(f, ":%"PRIu32" %s\n", m->value,
+				sha1_to_hex(m->key->sha1)) < 0) {
 			    e = 1;
 			    break;
 			}
 		}
-		deco++;
 	}
 
 	e |= ferror(f);
-- 
1.7.12.rc1.7.g7a223a6

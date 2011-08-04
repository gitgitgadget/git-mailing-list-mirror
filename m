From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] fast-export: use object to uint32 map instead of
 "decorate"
Date: Thu, 4 Aug 2011 16:46:00 -0600
Message-ID: <20110804224600.GB27912@sigill.intra.peff.net>
References: <20110804224354.GA27476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:46:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6g6-0006uE-Jl
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab1HDWqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:46:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32916
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1HDWqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:46:04 -0400
Received: (qmail 23366 invoked by uid 107); 4 Aug 2011 22:46:37 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:46:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:46:00 -0600
Content-Disposition: inline
In-Reply-To: <20110804224354.GA27476@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178769>

Previously we encoded the "mark" mapping inside the "void *"
field of a "struct decorate". It's a little more natural for
us to do so using a data structure made for holding actual
values.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-map.txt |    2 +-
 builtin/fast-export.c               |   36 ++++++++++------------------------
 map.c                               |    2 +
 map.h                               |    2 +
 4 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/Documentation/technical/api-map.txt b/Documentation/technical/api-map.txt
index 4153ef1..97e5a32 100644
--- a/Documentation/technical/api-map.txt
+++ b/Documentation/technical/api-map.txt
@@ -149,7 +149,7 @@ void dump_foos(void)
 	printf("there are %u foos:\n", foos.nr);
 
 	for (i = 0; i < foos.size; i++) {
-		struct map_entry_object_int *e = foos.hash[i];
+		struct map_entry_object_int *e = foos.hash + i;
 
 		if (!e->used)
 			continue;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index becef85..9247871 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -12,7 +12,7 @@
 #include "diffcore.h"
 #include "log-tree.h"
 #include "revision.h"
-#include "decorate.h"
+#include "map.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
@@ -60,7 +60,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	return 0;
 }
 
-static struct decoration idnums;
+static struct map_object_uint32 idnums;
 static uint32_t last_idnum;
 
 static int has_unshown_parent(struct commit *commit)
@@ -74,20 +74,9 @@ static int has_unshown_parent(struct commit *commit)
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
@@ -97,10 +86,9 @@ static inline void mark_next_object(struct object *object)
 
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
@@ -538,8 +526,6 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 static void export_marks(char *file)
 {
 	unsigned int i;
-	uint32_t mark;
-	struct object_decoration *deco = idnums.hash;
 	FILE *f;
 	int e = 0;
 
@@ -548,15 +534,15 @@ static void export_marks(char *file)
 		die_errno("Unable to open marks file %s for writing.", file);
 
 	for (i = 0; i < idnums.size; i++) {
-		if (deco->base && deco->base->type == 1) {
-			mark = ptr_to_mark(deco->decoration);
-			if (fprintf(f, ":%"PRIu32" %s\n", mark,
-				sha1_to_hex(deco->base->sha1)) < 0) {
+		const struct map_entry_object_uint32 *m = idnums.hash + i;
+
+		if (m->used && m->key->type == 1) {
+			if (fprintf(f, ":%"PRIu32" %s\n", m->value,
+				sha1_to_hex(m->key->sha1)) < 0) {
 			    e = 1;
 			    break;
 			}
 		}
-		deco++;
 	}
 
 	e |= ferror(f);
diff --git a/map.c b/map.c
index 35f300e..1fdd1aa 100644
--- a/map.c
+++ b/map.c
@@ -84,3 +84,5 @@ int map_get_##name(struct map_##name *m, \
 	} \
 	return 0; \
 }
+
+IMPLEMENT_MAP(object_uint32, obj_equal, hash_obj)
diff --git a/map.h b/map.h
index cb2d4e2..7449593 100644
--- a/map.h
+++ b/map.h
@@ -23,4 +23,6 @@ extern int map_set_##name(struct map_##name *, \
 			  map_vtype_##name value, \
 			  map_vtype_##name *old);
 
+DECLARE_MAP(object_uint32, const struct object *, uint32_t)
+
 #endif /* MAP_H */
-- 
1.7.6.34.g86521e

From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] fast-export: use object to uint32 map instead of
 "decorate"
Date: Thu, 14 Jul 2011 13:52:11 -0400
Message-ID: <20110714175211.GB21771@sigill.intra.peff.net>
References: <20110714173454.GA21657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:52:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQ5D-0001xZ-6v
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278Ab1GNRwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 13:52:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53273
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168Ab1GNRwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:52:13 -0400
Received: (qmail 8808 invoked by uid 107); 14 Jul 2011 17:52:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 13:52:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 13:52:11 -0400
Content-Disposition: inline
In-Reply-To: <20110714173454.GA21657@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177142>

Previously we encoded the "mark" mapping inside the "void *"
field of a "struct decorate". It's a little more natural for
us to do so using a data structure made for holding actual
values.

Signed-off-by: Jeff King <peff@peff.net>
---
And this is an example of use. It doesn't save all that much code, but I
think it's a little more natural. It can also save some bytes of the hash
value in each entry if your pointers are larger than 32-bit.

 builtin/fast-export.c |   36 +++++++++++-------------------------
 map.c                 |    2 ++
 map.h                 |    2 ++
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index daf1945..fd50503 100644
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
@@ -59,7 +59,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	return 0;
 }
 
-static struct decoration idnums;
+static struct map_object_uint32 idnums;
 static uint32_t last_idnum;
 
 static int has_unshown_parent(struct commit *commit)
@@ -73,20 +73,9 @@ static int has_unshown_parent(struct commit *commit)
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
@@ -96,10 +85,9 @@ static inline void mark_next_object(struct object *object)
 
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
@@ -537,8 +525,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 static void export_marks(char *file)
 {
 	unsigned int i;
-	uint32_t mark;
-	struct object_decoration *deco = idnums.hash;
+	struct map_entry_object_uint32 *map = idnums.hash;
 	FILE *f;
 	int e = 0;
 
@@ -547,15 +534,14 @@ static void export_marks(char *file)
 		die_errno("Unable to open marks file %s for writing.", file);
 
 	for (i = 0; i < idnums.size; i++) {
-		if (deco->base && deco->base->type == 1) {
-			mark = ptr_to_mark(deco->decoration);
-			if (fprintf(f, ":%"PRIu32" %s\n", mark,
-				sha1_to_hex(deco->base->sha1)) < 0) {
+		if (map->used && map->key->type == 1) {
+			if (fprintf(f, ":%"PRIu32" %s\n", map->value,
+				sha1_to_hex(map->key->sha1)) < 0) {
 			    e = 1;
 			    break;
 			}
 		}
-		deco++;
+		map++;
 	}
 
 	e |= ferror(f);
diff --git a/map.c b/map.c
index 378cecb..28f885e 100644
--- a/map.c
+++ b/map.c
@@ -84,3 +84,5 @@ int map_get_##name(struct map_##name *m, \
 	} \
 	return 0; \
 }
+
+MAP_IMPLEMENT(object_uint32, struct object *, uint32_t, cmp_obj, hash_obj)
diff --git a/map.h b/map.h
index 496c5d1..e80d85d 100644
--- a/map.h
+++ b/map.h
@@ -21,4 +21,6 @@ extern int map_set_##name(struct map_##name *, \
 			  vtype value, \
 			  vtype *old); \
 
+DECLARE_MAP(object_uint32, struct object *, uint32_t)
+
 #endif /* MAP_H */
-- 
1.7.6.38.ge5b33

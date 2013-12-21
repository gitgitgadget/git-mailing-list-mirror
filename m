From: Jeff King <peff@peff.net>
Subject: [PATCH v4 11/23] pack-objects: split add_object_entry
Date: Sat, 21 Dec 2013 09:00:06 -0500
Message-ID: <20131221140005.GK21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:00:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6I-0005IA-Kl
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab3LUOAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:00:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:48486 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755169Ab3LUOAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:07 -0500
Received: (qmail 7407 invoked by uid 102); 21 Dec 2013 14:00:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:06 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239603>

This function actually does three things:

  1. Check whether we've already added the object to our
     packing list.

  2. Check whether the object meets our criteria for adding.

  3. Actually add the object to our packing list.

It's a little hard to see these three phases, because they
happen linearly in the rather long function. Instead, this
patch breaks them up into three separate helper functions.

The result is a little easier to follow, though it
unfortunately suffers from some optimization
interdependencies between the stages (e.g., during step 3 we
use the packing list index from step 1 and the packfile
information from step 2).

More importantly, though, the various parts can be
composed differently, as they will be in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 98 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index faf746b..13b171d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -800,41 +800,69 @@ static int no_try_delta(const char *path)
 	return 0;
 }
 
-static int add_object_entry(const unsigned char *sha1, enum object_type type,
-			    const char *name, int exclude)
+/*
+ * When adding an object, check whether we have already added it
+ * to our packing list. If so, we can skip. However, if we are
+ * being asked to excludei t, but the previous mention was to include
+ * it, make sure to adjust its flags and tweak our numbers accordingly.
+ *
+ * As an optimization, we pass out the index position where we would have
+ * found the item, since that saves us from having to look it up again a
+ * few lines later when we want to add the new entry.
+ */
+static int have_duplicate_entry(const unsigned char *sha1,
+				int exclude,
+				uint32_t *index_pos)
 {
 	struct object_entry *entry;
-	struct packed_git *p, *found_pack = NULL;
-	off_t found_offset = 0;
-	uint32_t hash = pack_name_hash(name);
-	uint32_t index_pos;
 
-	entry = packlist_find(&to_pack, sha1, &index_pos);
-	if (entry) {
-		if (exclude) {
-			if (!entry->preferred_base)
-				nr_result--;
-			entry->preferred_base = 1;
-		}
+	entry = packlist_find(&to_pack, sha1, index_pos);
+	if (!entry)
 		return 0;
+
+	if (exclude) {
+		if (!entry->preferred_base)
+			nr_result--;
+		entry->preferred_base = 1;
 	}
 
+	return 1;
+}
+
+/*
+ * Check whether we want the object in the pack (e.g., we do not want
+ * objects found in non-local stores if the "--local" option was used).
+ *
+ * As a side effect of this check, we will find the packed version of this
+ * object, if any. We therefore pass out the pack information to avoid having
+ * to look it up again later.
+ */
+static int want_object_in_pack(const unsigned char *sha1,
+			       int exclude,
+			       struct packed_git **found_pack,
+			       off_t *found_offset)
+{
+	struct packed_git *p;
+
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
 
+	*found_pack = NULL;
+	*found_offset = 0;
+
 	for (p = packed_git; p; p = p->next) {
 		off_t offset = find_pack_entry_one(sha1, p);
 		if (offset) {
-			if (!found_pack) {
+			if (!*found_pack) {
 				if (!is_pack_valid(p)) {
 					warning("packfile %s cannot be accessed", p->pack_name);
 					continue;
 				}
-				found_offset = offset;
-				found_pack = p;
+				*found_offset = offset;
+				*found_pack = p;
 			}
 			if (exclude)
-				break;
+				return 1;
 			if (incremental)
 				return 0;
 			if (local && !p->pack_local)
@@ -844,6 +872,20 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		}
 	}
 
+	return 1;
+}
+
+static void create_object_entry(const unsigned char *sha1,
+				enum object_type type,
+				uint32_t hash,
+				int exclude,
+				int no_try_delta,
+				uint32_t index_pos,
+				struct packed_git *found_pack,
+				off_t found_offset)
+{
+	struct object_entry *entry;
+
 	entry = packlist_alloc(&to_pack, sha1, index_pos);
 	entry->hash = hash;
 	if (type)
@@ -857,11 +899,27 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		entry->in_pack_offset = found_offset;
 	}
 
-	display_progress(progress_state, to_pack.nr_objects);
+	entry->no_try_delta = no_try_delta;
+}
+
+static int add_object_entry(const unsigned char *sha1, enum object_type type,
+			    const char *name, int exclude)
+{
+	struct packed_git *found_pack;
+	off_t found_offset;
+	uint32_t index_pos;
 
-	if (name && no_try_delta(name))
-		entry->no_try_delta = 1;
+	if (have_duplicate_entry(sha1, exclude, &index_pos))
+		return 0;
 
+	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset))
+		return 0;
+
+	create_object_entry(sha1, type, pack_name_hash(name),
+			    exclude, name && no_try_delta(name),
+			    index_pos, found_pack, found_offset);
+
+	display_progress(progress_state, to_pack.nr_objects);
 	return 1;
 }
 
-- 
1.8.5.1.399.g900e7cd

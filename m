Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126051F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeIFXs6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:48:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:41608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729560AbeIFXs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:48:57 -0400
Received: (qmail 26188 invoked by uid 109); 6 Sep 2018 19:12:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 19:12:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6885 invoked by uid 111); 6 Sep 2018 19:12:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 15:12:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 15:12:03 -0400
Date:   Thu, 6 Sep 2018 15:12:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Tim Schumacher <timschumi@gmx.de>, gitster@pobox.com,
        pclouds@gmail.com
Subject: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180906191203.GA26184@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 10:59:42AM -0400, Jeff King wrote:

> > +		string_list_append(&cmd_list, *argv[0]);
> 
> This will create an unsorted list. You'd have to use
> string_list_insert() here for a sorted list, or
> unsorted_string_list_has_string() in the earlier call.
> 
> It's unfortunate that string_list makes this so easy to get wrong.

This is getting really off-topic (since it sounds like we'd probably
want to use an ordered list here), but is it crazy to think that
basically every use of an ordered string list could just be a hashmap?

And then the sometimes-sorted/sometimes-not duality of string-list could
go away?

As a bonus, that would fix a bunch of places which possibly quadratic,
since calling string_list_insert() may have to do O(n) work to shift the
memory around (though the worst case is reverse-sorted order, so in
practice many of these callers are actually fine, and those that aren't
often do a series of appends followed by a sort).

One pain point is that hashmaps are a little inconvenient due to their
memory ownership. But I sketched out an API below (and converted one
caller) that could make that less awful.

Another alternative is for string_list to keep a "sorted" flag, reset it
after an _append(), and BUG() when it's not set in the right places.
That's still easy to mis-use, but at least you get a run-time check.

---
 apply.c  | 35 +++++++++--------------------
 apply.h  |  3 ++-
 strmap.h | 42 +++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/apply.c b/apply.c
index e485fbc6bc..df3ba94caf 100644
--- a/apply.c
+++ b/apply.c
@@ -90,7 +90,7 @@ int init_apply_state(struct apply_state *state,
 	state->ws_error_action = warn_on_ws_error;
 	state->ws_ignore_action = ignore_ws_none;
 	state->linenr = 1;
-	string_list_init(&state->fn_table, 0);
+	strmap_init(&state->fn_table);
 	string_list_init(&state->limit_by_name, 0);
 	string_list_init(&state->symlink_changes, 0);
 	strbuf_init(&state->root, 0);
@@ -3265,16 +3265,10 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
 
 static struct patch *in_fn_table(struct apply_state *state, const char *name)
 {
-	struct string_list_item *item;
-
 	if (name == NULL)
 		return NULL;
 
-	item = string_list_lookup(&state->fn_table, name);
-	if (item != NULL)
-		return (struct patch *)item->util;
-
-	return NULL;
+	return strmap_get(&state->fn_table, name);
 }
 
 /*
@@ -3304,26 +3298,21 @@ static int was_deleted(struct patch *patch)
 
 static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 {
-	struct string_list_item *item;
-
 	/*
 	 * Always add new_name unless patch is a deletion
 	 * This should cover the cases for normal diffs,
 	 * file creations and copies
 	 */
-	if (patch->new_name != NULL) {
-		item = string_list_insert(&state->fn_table, patch->new_name);
-		item->util = patch;
-	}
+	if (patch->new_name != NULL)
+		strmap_put(&state->fn_table, patch->new_name, patch);
 
 	/*
 	 * store a failure on rename/deletion cases because
 	 * later chunks shouldn't patch old names
 	 */
-	if ((patch->new_name == NULL) || (patch->is_rename)) {
-		item = string_list_insert(&state->fn_table, patch->old_name);
-		item->util = PATH_WAS_DELETED;
-	}
+	if ((patch->new_name == NULL) || (patch->is_rename))
+		strmap_put(&state->fn_table, patch->old_name,
+			   PATH_WAS_DELETED);
 }
 
 static void prepare_fn_table(struct apply_state *state, struct patch *patch)
@@ -3332,11 +3321,9 @@ static void prepare_fn_table(struct apply_state *state, struct patch *patch)
 	 * store information about incoming file deletion
 	 */
 	while (patch) {
-		if ((patch->new_name == NULL) || (patch->is_rename)) {
-			struct string_list_item *item;
-			item = string_list_insert(&state->fn_table, patch->old_name);
-			item->util = PATH_TO_BE_DELETED;
-		}
+		if ((patch->new_name == NULL) || (patch->is_rename))
+			strmap_put(&state->fn_table, patch->old_name,
+				   PATH_TO_BE_DELETED);
 		patch = patch->next;
 	}
 }
@@ -4757,7 +4744,7 @@ static int apply_patch(struct apply_state *state,
 end:
 	free_patch_list(list);
 	strbuf_release(&buf);
-	string_list_clear(&state->fn_table, 0);
+	strmap_clear(&state->fn_table);
 	return res;
 }
 
diff --git a/apply.h b/apply.h
index 5948348133..66f681622e 100644
--- a/apply.h
+++ b/apply.h
@@ -3,6 +3,7 @@
 
 #include "lockfile.h"
 #include "string-list.h"
+#include "strmap.h"
 
 struct repository;
 
@@ -98,7 +99,7 @@ struct apply_state {
 	 * Records filenames that have been touched, in order to handle
 	 * the case where more than one patches touch the same file.
 	 */
-	struct string_list fn_table;
+	struct strmap fn_table;
 
 	/*
 	 * This is to save reporting routines before using
diff --git a/strmap.h b/strmap.h
new file mode 100644
index 0000000000..2748f50e3e
--- /dev/null
+++ b/strmap.h
@@ -0,0 +1,42 @@
+#ifndef STRMAP_H
+#define STRMAP_H
+
+struct strmap {
+	struct hashmap map;
+};
+
+#define STRMAP_INIT { { NULL } }
+
+/*
+ * Initialize an empty strmap (this is unnecessary if it was initialized with
+ * STRMAP_INIT).
+ */
+void strmap_init(struct strmap *map);
+
+/*
+ * Remove all entries from the map, releasing any allocated resources.
+ */
+void strmap_clear(struct strmap *map);
+
+/*
+ * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
+ * it does not need to persist after the this function is called.
+ *
+ * If an entry for "str" already exists, its data pointer is overwritten, and
+ * the original data pointer returned. Otherwise, returns NULL.
+ */
+void *strmap_put(struct strmap *map, const char *str, void *data);
+
+/*
+ * Return the data pointer mapped by "str", or NULL if the entry does not
+ * exist.
+ */
+void *strmap_get(struct strmap *map, const char *str);
+
+/*
+ * Return non-zero iff "str" is present in the map. This differs from
+ * strmap_get() in that it can distinguish entries with a NULL data pointer.
+ */
+int strmap_contains(struct strmap *map, const char *str);
+
+#endif /* STRMAP_H */

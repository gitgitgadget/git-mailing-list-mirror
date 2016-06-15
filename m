From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 5/7] string_list: Fix argument order for string_list_lookup
Date: Sat, 26 Jun 2010 00:41:37 +0100
Message-ID: <20100625234140.18927.4201.julian@quantumfyre.co.uk>
References: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:55:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIkI-0004gB-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab0FYXze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:55:34 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39020 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756757Ab0FYXzV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 19:55:21 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id AED04819C6DA;
	Sat, 26 Jun 2010 01:20:45 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 525812B3B0;
	Sat, 26 Jun 2010 00:45:46 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Cg7dN1rryOXu; Sat, 26 Jun 2010 00:45:45 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 878121EC128;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-git-sha1: ad9f6c61fb11937c2a69bdce98fba59811f42e57 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149719>

Update the definition and callers of string_list_lookup to use the
string_list as the first argument.  This helps make the string_list
API easier to use by being more consistent.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin/apply.c        |    2 +-
 builtin/fetch.c        |    4 ++--
 builtin/receive-pack.c |    2 +-
 http-backend.c         |    4 ++--
 mailmap.c              |    4 ++--
 merge-recursive.c      |    8 ++++----
 reflog-walk.c          |    2 +-
 remote.c               |    2 +-
 resolve-undo.c         |    2 +-
 string-list.c          |    2 +-
 string-list.h          |    2 +-
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d103837..c5c6d10 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2628,7 +2628,7 @@ static struct patch *in_fn_table(const char *name)
 	if (name == NULL)
 		return NULL;
 
-	item = string_list_lookup(name, &fn_table);
+	item = string_list_lookup(&fn_table, name);
 	if (item != NULL)
 		return (struct patch *)item->util;
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d1e5865..bb8337a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -696,8 +696,8 @@ static int do_fetch(struct transport *transport,
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->peer_ref) {
-			peer_item = string_list_lookup(rm->peer_ref->name,
-						       &existing_refs);
+			peer_item = string_list_lookup(&existing_refs,
+						       rm->peer_ref->name);
 			if (peer_item)
 				hashcpy(rm->peer_ref->old_sha1,
 					peer_item->util);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 29bc8d5..08bc089 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -501,7 +501,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	if (!(flag & REF_ISSYMREF))
 		return;
 
-	if ((item = string_list_lookup(dst_name, list)) == NULL)
+	if ((item = string_list_lookup(list, dst_name)) == NULL)
 		return;
 
 	cmd->skip_update = 1;
diff --git a/http-backend.c b/http-backend.c
index d43732a..14c90c2 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -37,7 +37,7 @@ static struct string_list *get_parameters(void)
 			char *value = url_decode_parameter_value(&query);
 			struct string_list_item *i;
 
-			i = string_list_lookup(name, query_params);
+			i = string_list_lookup(query_params, name);
 			if (!i)
 				i = string_list_insert(query_params, name);
 			else
@@ -51,7 +51,7 @@ static struct string_list *get_parameters(void)
 static const char *get_parameter(const char *name)
 {
 	struct string_list_item *i;
-	i = string_list_lookup(name, get_parameters());
+	i = string_list_lookup(get_parameters(), name);
 	return i ? i->util : NULL;
 }
 
diff --git a/mailmap.c b/mailmap.c
index 8b6dc36..f80b701 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -214,13 +214,13 @@ int map_user(struct string_list *map,
 	mailbuf[i] = 0;
 
 	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf);
-	item = string_list_lookup(mailbuf, map);
+	item = string_list_lookup(map, mailbuf);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
 			/* The item has multiple items, so we'll look up on name too */
 			/* If the name is not found, we choose the simple entry      */
-			struct string_list_item *subitem = string_list_lookup(name, &me->namemap);
+			struct string_list_item *subitem = string_list_lookup(&me->namemap, name);
 			if (subitem)
 				item = subitem;
 		}
diff --git a/merge-recursive.c b/merge-recursive.c
index 5e60f4b..856e98c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -294,7 +294,7 @@ static struct string_list *get_unmerged(void)
 		if (!ce_stage(ce))
 			continue;
 
-		item = string_list_lookup(ce->name, unmerged);
+		item = string_list_lookup(unmerged, ce->name);
 		if (!item) {
 			item = string_list_insert(unmerged, ce->name);
 			item->util = xcalloc(1, sizeof(struct stage_data));
@@ -356,14 +356,14 @@ static struct string_list *get_renames(struct merge_options *o,
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
 		re->pair = pair;
-		item = string_list_lookup(re->pair->one->path, entries);
+		item = string_list_lookup(entries, re->pair->one->path);
 		if (!item)
 			re->src_entry = insert_stage_data(re->pair->one->path,
 					o_tree, a_tree, b_tree, entries);
 		else
 			re->src_entry = item->util;
 
-		item = string_list_lookup(re->pair->two->path, entries);
+		item = string_list_lookup(entries, re->pair->two->path);
 		if (!item)
 			re->dst_entry = insert_stage_data(re->pair->two->path,
 					o_tree, a_tree, b_tree, entries);
@@ -988,7 +988,7 @@ static int process_renames(struct merge_options *o,
 					output(o, 1, "Adding as %s instead", new_path);
 					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
 				}
-			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
+			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
diff --git a/reflog-walk.c b/reflog-walk.c
index f125f37..4879615 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -162,7 +162,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	} else
 		recno = 0;
 
-	item = string_list_lookup(branch, &info->complete_reflogs);
+	item = string_list_lookup(&info->complete_reflogs, branch);
 	if (item)
 		reflogs = item->util;
 	else {
diff --git a/remote.c b/remote.c
index 851d860..43f00f1 100644
--- a/remote.c
+++ b/remote.c
@@ -762,7 +762,7 @@ void ref_remove_duplicates(struct ref *ref_map)
 		if (!ref_map->peer_ref)
 			continue;
 
-		item = string_list_lookup(ref_map->peer_ref->name, &refs);
+		item = string_list_lookup(&refs, ref_map->peer_ref->name);
 		if (item) {
 			if (strcmp(((struct ref *)item->util)->name,
 				   ref_map->name))
diff --git a/resolve-undo.c b/resolve-undo.c
index 8b93559..174ebec 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -135,7 +135,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 			pos++;
 		return pos - 1; /* return the last entry processed */
 	}
-	item = string_list_lookup(ce->name, istate->resolve_undo);
+	item = string_list_lookup(istate->resolve_undo, ce->name);
 	if (!item)
 		return pos;
 	ru = item->util;
diff --git a/string-list.c b/string-list.c
index 84444c2..7b616ae 100644
--- a/string-list.c
+++ b/string-list.c
@@ -84,7 +84,7 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
 	return index;
 }
 
-struct string_list_item *string_list_lookup(const char *string, struct string_list *list)
+struct string_list_item *string_list_lookup(struct string_list *list, const char *string)
 {
 	int exact_match, i = get_entry_index(list, string, &exact_match);
 	if (!exact_match)
diff --git a/string-list.h b/string-list.h
index a4e1919..4a30e9d 100644
--- a/string-list.h
+++ b/string-list.h
@@ -32,7 +32,7 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
 struct string_list_item *string_list_insert_at_index(struct string_list *list,
 						     int insert_at, const char *string);
-struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
+struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
 /* Use these functions only on unsorted lists: */
 struct string_list_item *string_list_append(const char *string, struct string_list *list);
-- 
1.7.0.4

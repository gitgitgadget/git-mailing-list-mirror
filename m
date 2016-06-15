From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 2/7] string_list: Fix argument order for
	for_each_string_list
Date: Sat, 26 Jun 2010 00:41:34 +0100
Message-ID: <20100625234140.18927.48317.julian@quantumfyre.co.uk>
References: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:55:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIkF-0004gB-SM
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab0FYXzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:55:21 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39009 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752189Ab0FYXzU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 19:55:20 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id B22A9819E785;
	Sat, 26 Jun 2010 01:20:43 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 7BC8F1EC0CB;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uBu0sK1ybM4E; Sat, 26 Jun 2010 00:45:45 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id E4F231EC125;
	Sat, 26 Jun 2010 00:45:44 +0100 (BST)
X-git-sha1: ad53116861ea00e1e7596194b954afe649e5addf 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149715>

Update the definition and callers of for_each_string_list to use the
string_list as the first argument.  This helps make the string_list
API easier to use by being more consistent.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin/fetch.c    |    2 +-
 builtin/ls-files.c |    2 +-
 builtin/remote.c   |   16 ++++++++--------
 notes.c            |    6 +++---
 resolve-undo.c     |    2 +-
 string-list.c      |    4 ++--
 string-list.h      |    4 ++--
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5cb369c..7edeaef 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -634,7 +634,7 @@ static void find_non_local_tags(struct transport *transport,
 	 * For all the tags in the remote_refs string list, call
 	 * add_to_tail to add them to the list of refs to be fetched
 	 */
-	for_each_string_list(add_to_tail, &remote_refs, &data);
+	for_each_string_list(&remote_refs, add_to_tail, &data);
 
 	string_list_clear(&remote_refs, 0);
 }
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 0804047..1b9b8a8 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -190,7 +190,7 @@ static void show_ru_info(void)
 {
 	if (!the_index.resolve_undo)
 		return;
-	for_each_string_list(show_one_ru, the_index.resolve_undo, NULL);
+	for_each_string_list(the_index.resolve_undo, show_one_ru, NULL);
 }
 
 static void show_files(struct dir_struct *dir)
diff --git a/builtin/remote.c b/builtin/remote.c
index 0a52667..25c3daa 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1096,24 +1096,24 @@ static int show(int argc, const char **argv)
 
 		/* remote branch info */
 		info.width = 0;
-		for_each_string_list(add_remote_to_show_info, &states.new, &info);
-		for_each_string_list(add_remote_to_show_info, &states.tracked, &info);
-		for_each_string_list(add_remote_to_show_info, &states.stale, &info);
+		for_each_string_list(&states.new, add_remote_to_show_info, &info);
+		for_each_string_list(&states.tracked, add_remote_to_show_info, &info);
+		for_each_string_list(&states.stale, add_remote_to_show_info, &info);
 		if (info.list->nr)
 			printf("  Remote branch%s:%s\n",
 			       info.list->nr > 1 ? "es" : "",
 				no_query ? " (status not queried)" : "");
-		for_each_string_list(show_remote_info_item, info.list, &info);
+		for_each_string_list(info.list, show_remote_info_item, &info);
 		string_list_clear(info.list, 0);
 
 		/* git pull info */
 		info.width = 0;
 		info.any_rebase = 0;
-		for_each_string_list(add_local_to_show_info, &branch_list, &info);
+		for_each_string_list(&branch_list, add_local_to_show_info, &info);
 		if (info.list->nr)
 			printf("  Local branch%s configured for 'git pull':\n",
 			       info.list->nr > 1 ? "es" : "");
-		for_each_string_list(show_local_info_item, info.list, &info);
+		for_each_string_list(info.list, show_local_info_item, &info);
 		string_list_clear(info.list, 0);
 
 		/* git push info */
@@ -1121,14 +1121,14 @@ static int show(int argc, const char **argv)
 			printf("  Local refs will be mirrored by 'git push'\n");
 
 		info.width = info.width2 = 0;
-		for_each_string_list(add_push_to_show_info, &states.push, &info);
+		for_each_string_list(&states.push, add_push_to_show_info, &info);
 		qsort(info.list->items, info.list->nr,
 			sizeof(*info.list->items), cmp_string_with_push);
 		if (info.list->nr)
 			printf("  Local ref%s configured for 'git push'%s:\n",
 				info.list->nr > 1 ? "s" : "",
 				no_query ? " (status not queried)" : "");
-		for_each_string_list(show_push_info_item, info.list, &info);
+		for_each_string_list(info.list, show_push_info_item, &info);
 		string_list_clear(info.list, 0);
 
 		free_remote_ref_states(&states);
diff --git a/notes.c b/notes.c
index 6ee04e7..f379681 100644
--- a/notes.c
+++ b/notes.c
@@ -969,7 +969,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs)
 	trees = xmalloc((refs->nr+1) * sizeof(struct notes_tree *));
 	cb_data.counter = 0;
 	cb_data.trees = trees;
-	for_each_string_list(load_one_display_note_ref, refs, &cb_data);
+	for_each_string_list(refs, load_one_display_note_ref, &cb_data);
 	trees[cb_data.counter] = NULL;
 	return trees;
 }
@@ -996,8 +996,8 @@ void init_display_notes(struct display_notes_opt *opt)
 	git_config(notes_display_config, &load_config_refs);
 
 	if (opt && opt->extra_notes_refs)
-		for_each_string_list(string_list_add_refs_from_list,
-				     opt->extra_notes_refs,
+		for_each_string_list(opt->extra_notes_refs,
+				     string_list_add_refs_from_list,
 				     &display_notes_refs);
 
 	display_notes_trees = load_notes_trees(&display_notes_refs);
diff --git a/resolve-undo.c b/resolve-undo.c
index 0f50ee0..e93b3d1 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -50,7 +50,7 @@ static int write_one(struct string_list_item *item, void *cbdata)
 
 void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 {
-	for_each_string_list(write_one, resolve_undo, sb);
+   for_each_string_list(resolve_undo, write_one, sb);
 }
 
 struct string_list *resolve_undo_read(const char *data, unsigned long size)
diff --git a/string-list.c b/string-list.c
index b7e57a4..09798a2 100644
--- a/string-list.c
+++ b/string-list.c
@@ -92,8 +92,8 @@ struct string_list_item *string_list_lookup(const char *string, struct string_li
 	return list->items + i;
 }
 
-int for_each_string_list(string_list_each_func_t fn,
-			 struct string_list *list, void *cb_data)
+int for_each_string_list(struct string_list *list,
+			 string_list_each_func_t fn, void *cb_data)
 {
 	int i, ret = 0;
 	for (i = 0; i < list->nr; i++)
diff --git a/string-list.h b/string-list.h
index de29dcd..1e2dfc3 100644
--- a/string-list.h
+++ b/string-list.h
@@ -22,8 +22,8 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 
 /* Use this function to iterate over each item */
 typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
-int for_each_string_list(string_list_each_func_t,
-			 struct string_list *list, void *cb_data);
+int for_each_string_list(struct string_list *list,
+			 string_list_each_func_t, void *cb_data);
 
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
-- 
1.7.0.4

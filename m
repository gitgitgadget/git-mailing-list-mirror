From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Convert the users of for_each_string_list to
	for_each_string_list_item macro
Date: Sat, 3 Jul 2010 14:41:54 +0200
Message-ID: <20100703124154.GB5511@blimp.localdomain>
References: <AANLkTilj7MiqiCmptDw0PLM5QqKZOOSZnSsxMlELS_5_@mail.gmail.com> <20100702205417.GA4941@blimp.localdomain> <20100703124004.GA5511@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 15:11:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV2VK-00051A-Up
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 15:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab0GCNL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 09:11:29 -0400
Received: from mout8.freenet.de ([195.4.92.98]:35959 "EHLO mout8.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239Ab0GCNL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 09:11:28 -0400
X-Greylist: delayed 1767 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jul 2010 09:11:28 EDT
Received: from [195.4.92.19] (helo=9.mx.freenet.de)
	by mout8.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1OV22f-00022x-8b; Sat, 03 Jul 2010 14:41:57 +0200
Received: from krlh-5f7252d7.pool.mediaways.net ([95.114.82.215]:43490 helo=tigra.home)
	by 9.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1OV22e-000847-VI; Sat, 03 Jul 2010 14:41:57 +0200
Received: from blimp.localdomain (unknown [192.168.0.83])
	by tigra.home (Postfix) with ESMTP id 345729FD2C;
	Sat,  3 Jul 2010 14:41:55 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id E319F36D28; Sat,  3 Jul 2010 14:41:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100703124004.GA5511@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150190>

The rule for selecting the candidates for conversion is: if the callback
function returns only 0 (the condition for for_each_string_list to exit
early), than it can be safely converted to the macro.

A notable exception are the callers in builtin/remote.c. If converted, the
readability in the file will suffer greately. Besides, the code is not very
performance critical (at the moment, at least): it does output formatting of
the list of remotes.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

 builtin/fetch.c    |   42 +++++++++++++-----------------------------
 builtin/ls-files.c |   45 ++++++++++++++++++++++-----------------------
 notes.c            |   46 ++++++++++++++--------------------------------
 resolve-undo.c     |   34 +++++++++++++++-------------------
 4 files changed, 64 insertions(+), 103 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6eb1dfe..b0bfaa9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -544,40 +544,14 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
-struct tag_data {
-	struct ref **head;
-	struct ref ***tail;
-};
-
-static int add_to_tail(struct string_list_item *item, void *cb_data)
-{
-	struct tag_data *data = (struct tag_data *)cb_data;
-	struct ref *rm = NULL;
-
-	/* We have already decided to ignore this item */
-	if (!item->util)
-		return 0;
-
-	rm = alloc_ref(item->string);
-	rm->peer_ref = alloc_ref(item->string);
-	hashcpy(rm->old_sha1, item->util);
-
-	**data->tail = rm;
-	*data->tail = &rm->next;
-
-	return 0;
-}
-
 static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
 	struct string_list existing_refs = { NULL, 0, 0, 0 };
 	struct string_list remote_refs = { NULL, 0, 0, 0 };
-	struct tag_data data;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
-	data.head = head; data.tail = tail;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
@@ -631,10 +605,20 @@ static void find_non_local_tags(struct transport *transport,
 		item->util = NULL;
 
 	/*
-	 * For all the tags in the remote_refs string list, call
-	 * add_to_tail to add them to the list of refs to be fetched
+	 * For all the tags in the remote_refs string list,
+	 * add them to the list of refs to be fetched
 	 */
-	for_each_string_list(&remote_refs, add_to_tail, &data);
+	for_each_string_list_item(item, &remote_refs) {
+		/* Unless we have already decided to ignore this item... */
+		if (item->util)
+		{
+			struct ref *rm = alloc_ref(item->string);
+			rm->peer_ref = alloc_ref(item->string);
+			hashcpy(rm->old_sha1, item->util);
+			**tail = rm;
+			*tail = &rm->next;
+		}
+	}
 
 	string_list_clear(&remote_refs, 0);
 }
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1b9b8a8..cf6ab03 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -164,33 +164,32 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	write_name(ce->name, ce_namelen(ce));
 }
 
-static int show_one_ru(struct string_list_item *item, void *cbdata)
-{
-	const char *path = item->string;
-	struct resolve_undo_info *ui = item->util;
-	int i, len;
-
-	len = strlen(path);
-	if (len < max_prefix_len)
-		return 0; /* outside of the prefix */
-	if (!match_pathspec(pathspec, path, len, max_prefix_len, ps_matched))
-		return 0; /* uninterested */
-	for (i = 0; i < 3; i++) {
-		if (!ui->mode[i])
-			continue;
-		printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-		       find_unique_abbrev(ui->sha1[i], abbrev),
-		       i + 1);
-		write_name(path, len);
-	}
-	return 0;
-}
-
 static void show_ru_info(void)
 {
+	struct string_list_item *item;
+
 	if (!the_index.resolve_undo)
 		return;
-	for_each_string_list(the_index.resolve_undo, show_one_ru, NULL);
+
+	for_each_string_list_item(item, the_index.resolve_undo) {
+		const char *path = item->string;
+		struct resolve_undo_info *ui = item->util;
+		int i, len;
+
+		len = strlen(path);
+		if (len < max_prefix_len)
+			continue; /* outside of the prefix */
+		if (!match_pathspec(pathspec, path, len, max_prefix_len, ps_matched))
+			continue; /* uninterested */
+		for (i = 0; i < 3; i++) {
+			if (!ui->mode[i])
+				continue;
+			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
+			       find_unique_abbrev(ui->sha1[i], abbrev),
+			       i + 1);
+			write_name(path, len);
+		}
+	}
 }
 
 static void show_files(struct dir_struct *dir)
diff --git a/notes.c b/notes.c
index 1978244..7fd2035 100644
--- a/notes.c
+++ b/notes.c
@@ -877,14 +877,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	strbuf_release(&globbuf);
 }
 
-static int string_list_add_refs_from_list(struct string_list_item *item,
-					  void *cb)
-{
-	struct string_list *list = cb;
-	string_list_add_refs_by_glob(list, item->string);
-	return 0;
-}
-
 static int notes_display_config(const char *k, const char *v, void *cb)
 {
 	int *load_refs = cb;
@@ -947,30 +939,18 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	load_subtree(t, &root_tree, t->root, 0);
 }
 
-struct load_notes_cb_data {
-	int counter;
-	struct notes_tree **trees;
-};
-
-static int load_one_display_note_ref(struct string_list_item *item,
-				     void *cb_data)
-{
-	struct load_notes_cb_data *c = cb_data;
-	struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
-	init_notes(t, item->string, combine_notes_ignore, 0);
-	c->trees[c->counter++] = t;
-	return 0;
-}
-
 struct notes_tree **load_notes_trees(struct string_list *refs)
 {
+	struct string_list_item *item;
+	int counter = 0;
 	struct notes_tree **trees;
-	struct load_notes_cb_data cb_data;
 	trees = xmalloc((refs->nr+1) * sizeof(struct notes_tree *));
-	cb_data.counter = 0;
-	cb_data.trees = trees;
-	for_each_string_list(refs, load_one_display_note_ref, &cb_data);
-	trees[cb_data.counter] = NULL;
+	for_each_string_list_item(item, refs) {
+		struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
+		init_notes(t, item->string, combine_notes_ignore, 0);
+		trees[counter++] = t;
+	}
+	trees[counter] = NULL;
 	return trees;
 }
 
@@ -995,10 +975,12 @@ void init_display_notes(struct display_notes_opt *opt)
 
 	git_config(notes_display_config, &load_config_refs);
 
-	if (opt && opt->extra_notes_refs)
-		for_each_string_list(opt->extra_notes_refs,
-				     string_list_add_refs_from_list,
-				     &display_notes_refs);
+	if (opt && opt->extra_notes_refs) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, opt->extra_notes_refs)
+			string_list_add_refs_by_glob(&display_notes_refs,
+						     item->string);
+	}
 
 	display_notes_trees = load_notes_trees(&display_notes_refs);
 	string_list_clear(&display_notes_refs, 0);
diff --git a/resolve-undo.c b/resolve-undo.c
index 174ebec..72b4612 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -28,29 +28,25 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 	ui->mode[stage - 1] = ce->ce_mode;
 }
 
-static int write_one(struct string_list_item *item, void *cbdata)
+void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 {
-	struct strbuf *sb = cbdata;
-	struct resolve_undo_info *ui = item->util;
-	int i;
+	struct string_list_item *item;
+	for_each_string_list_item(item, resolve_undo) {
+		struct resolve_undo_info *ui = item->util;
+		int i;
 
-	if (!ui)
-		return 0;
-	strbuf_addstr(sb, item->string);
-	strbuf_addch(sb, 0);
-	for (i = 0; i < 3; i++)
-		strbuf_addf(sb, "%o%c", ui->mode[i], 0);
-	for (i = 0; i < 3; i++) {
-		if (!ui->mode[i])
+		if (!ui)
 			continue;
-		strbuf_add(sb, ui->sha1[i], 20);
+		strbuf_addstr(sb, item->string);
+		strbuf_addch(sb, 0);
+		for (i = 0; i < 3; i++)
+			strbuf_addf(sb, "%o%c", ui->mode[i], 0);
+		for (i = 0; i < 3; i++) {
+			if (!ui->mode[i])
+				continue;
+			strbuf_add(sb, ui->sha1[i], 20);
+		}
 	}
-	return 0;
-}
-
-void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
-{
-   for_each_string_list(resolve_undo, write_one, sb);
 }
 
 struct string_list *resolve_undo_read(const char *data, unsigned long size)
-- 
1.7.1.304.g8446

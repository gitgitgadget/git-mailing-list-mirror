Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DFFC761AF
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjCWQsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCWQrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:07 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A146D10253
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DEFA82424A
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B0b-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 7/8] sequencer: pass `onto` to complete_action() as object-id
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162235.995574-8-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... instead of as a commit, which makes the purpose clearer and will
simplify things later.

As a side effect, this change revealed that skip_unnecessary_picks() was
butchering the commit object due to missing const-correctness. Slightly
adjust its API to rectify this.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 builtin/rebase.c |  2 +-
 sequencer.c      | 21 ++++++++++-----------
 sequencer.h      |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 728c869db4..e703b29835 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -285,7 +285,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			BUG("unusable todo list");
 
 		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto,
+			shortrevisions, opts->onto_name, &opts->onto->object.oid,
 			&opts->orig_head->object.oid, &opts->exec,
 			opts->autosquash, opts->update_refs, &todo_list,
 			opts->action);
diff --git a/sequencer.c b/sequencer.c
index fb224445fa..aef42122f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2083,7 +2083,7 @@ static void flush_rewritten_pending(void)
 	strbuf_release(&buf);
 }
 
-static void record_in_rewritten(struct object_id *oid,
+static void record_in_rewritten(const struct object_id *oid,
 		enum todo_command next_command)
 {
 	FILE *out = fopen_or_warn(rebase_path_rewritten_pending(), "a");
@@ -5918,7 +5918,7 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 /* skip picking commits whose parents are unchanged */
 static int skip_unnecessary_picks(struct repository *r,
 				  struct todo_list *todo_list,
-				  struct object_id *base_oid)
+				  const struct object_id **base_oid)
 {
 	struct object_id *parent_oid;
 	int i;
@@ -5939,9 +5939,9 @@ static int skip_unnecessary_picks(struct repository *r,
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (!oideq(parent_oid, base_oid))
+		if (!oideq(parent_oid, *base_oid))
 			break;
-		oidcpy(base_oid, &item->commit->object.oid);
+		*base_oid = &item->commit->object.oid;
 	}
 	if (i > 0) {
 		const char *done_path = rebase_path_done();
@@ -5958,7 +5958,7 @@ static int skip_unnecessary_picks(struct repository *r,
 		todo_list->done_nr += i;
 
 		if (is_fixup(peek_command(todo_list, 0)))
-			record_in_rewritten(base_oid, peek_command(todo_list, 0));
+			record_in_rewritten(*base_oid, peek_command(todo_list, 0));
 	}
 
 	return 0;
@@ -6090,19 +6090,18 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const struct object_id *orig_head,
+		    const struct object_id *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
 		    unsigned update_refs, struct todo_list *todo_list,
 		    enum rebase_action action)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
 	const char *todo_file = rebase_path_todo();
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
-	struct object_id oid = onto->object.oid;
 	int res;
 
-	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
+	find_unique_abbrev_r(shortonto, onto, DEFAULT_ABBREV);
 
 	if (buf->len == 0) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -6143,7 +6142,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 		return error(_("nothing to do"));
 	} else if (res == EDIT_TODO_INCORRECT) {
-		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
+		checkout_onto(r, opts, onto_name, onto, orig_head);
 		todo_list_release(&new_todo);
 
 		return -1;
@@ -6158,7 +6157,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
+	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &onto)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
 	}
@@ -6171,7 +6170,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	res = -1;
 
-	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
+	if (checkout_onto(r, opts, onto_name, onto, orig_head))
 		goto cleanup;
 
 	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
diff --git a/sequencer.h b/sequencer.h
index a1b8ca6eb1..24bf71d5db 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -188,7 +188,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const struct object_id *orig_head,
+		    const struct object_id *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
 		    unsigned update_refs, struct todo_list *todo_list,
 		    enum rebase_action action);
-- 
2.40.0.152.g15d061e6df


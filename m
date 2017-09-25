Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E539520281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbdIYKLZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:25 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:55487 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933717AbdIYKLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:16 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM7dIVJA; Mon, 25 Sep 2017 11:11:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334275; bh=r++6eUvjS0tW8KcrWuUj5TJahMKB0OSXNs7xTrSOvL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=fnlS7/WPBh6wjMQOlzSdtS/8uSPv3ovrldWrnnwvcIDzkUy7eBVJGfAMB1WD5pqmZ
         sDDjrQfOGG95BqE00QcQa0u+n0PWYth5QEIvJpPwrzgARdG4R+fdCR6ObKqVHCxIeg
         ppt3lNyeyu+KtLoRrgWvVHv2I3/cxDCcVlVAFVgA=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=PVKsiLmdxsjtzAd8bCgA:9
 a=EZd9hP71195jwKy7:21 a=aOmc0qwUbnrHrisa:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 8/8] sequencer: try to commit without forking 'git commit'
Date:   Mon, 25 Sep 2017 11:10:41 +0100
Message-Id: <20170925101041.18344-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDHwm/11zIkXscG7s73x299dNuRiv6EDq5zeYvoG+NzTSxo3FsOb1sWojYWzyArQugoZXr4iFbRBYfSMKQuz0XNpfhjEt77EC71ytIXvAcDDrojYVAp4
 T1SALIOJjqwBT8fa0tDKOpM+yPyL9+7kslMz2w9ss133jAFb126rCZEa+lcTOFo0JXtsKm3hClbquH1nOy2G30Ihtq/mcowX5pWSrr7MJUZudWRs7wHiuWca
 T4y3PxurB3LLCCQCpYe3JQ0FY5t0sjtB8cH9F3ZnfSE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the commit message does not need to be edited then create the
commit without forking 'git commit'. Taking the best time of ten runs
with a warm cache this reduces the time taken to cherry-pick 10
commits by 26% (from 319ms to 235ms), and the time taken by 'git
rebase --continue' to pick 10 commits by 44% (from 376ms to 211ms) on
my computer running linux. The greater saving for rebase is because it
longer wastes time creating the commit summary just to throw it away.

Even when not forking 'git commit' the commit message is written to a
file and CHERRY_PICK_HEAD/REVERT_HEAD are created unnecessarily. This
could be eliminated in future. I hacked up a version that does not
write these files and just passed an strbuf (with the wrong message
for fixup and squash commands) to do_commit() but I couldn't measure
any significant time difference when running cherry-pick or rebase. I
think eliminating the writes properly for rebase would require a bit
of effort as the code would need to be restructured.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

I wonder if this should reparse the author it gets from the existing
commit rather than just reusing it.

 sequencer.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 230bdb8535a422b1263429e5894e3f8b1733e844..ebba53583727e947ed767d6181b14254e23fc146 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -591,6 +591,18 @@ static int read_env_script(struct argv_array *env)
 	return 0;
 }
 
+static char *get_author(const char* message)
+{
+	size_t len;
+	const char *a;
+
+	a = find_commit_header(message, "author", &len);
+	if (a)
+		return xmemdupz(a, len);
+
+	return NULL;
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -973,6 +985,130 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&format);
 }
 
+static int try_to_commit(struct strbuf *msgbuf, const char *author,
+			 struct replay_opts *opts, unsigned int flags)
+{
+	struct object_id tree;
+	struct object_id oid;
+	struct commit *current_head;
+	struct commit_list *parents = NULL;
+	struct commit_extra_header *extra = NULL;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf amend_msg = STRBUF_INIT;
+	struct strbuf *msg;
+	char *amend_author = NULL;
+	const char *gpg_sign;
+	enum cleanup_mode cleanup;
+	int res = 0;
+
+	msg = msgbuf;
+	if (flags & EDIT_MSG || flags & VERIFY_MSG)
+		return 1;
+
+	if (get_oid("HEAD", &oid)) {
+		current_head = NULL;
+	} else {
+		current_head = lookup_commit_or_die(&oid, "HEAD");
+		if (parse_commit(current_head))
+			return error(_("could not parse HEAD commit"));
+	}
+
+	if (flags & AMEND_MSG) {
+		const char *body;
+		const char *exclude_gpgsig[2] = { "gpgsig", NULL };
+		const char *out_enc = get_commit_output_encoding();
+		const char *message = logmsg_reencode(current_head, NULL,
+						      out_enc);
+
+		msg = &amend_msg;
+		if (find_commit_subject(message, &body))
+			strbuf_addstr(&amend_msg, body);
+		author = amend_author = get_author (message);
+		unuse_commit_buffer(current_head, message);
+		if (!author) {
+			res = error(_("unable to parse commit author"));
+			goto out;
+		}
+		parents = copy_commit_list(current_head->parents);
+		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
+	} else if (current_head) {
+		commit_list_insert(current_head, &parents);
+	}
+
+	cleanup = (flags & CLEANUP_MSG) ? CLEANUP_ALL : default_msg_cleanup;
+	if (cleanup != CLEANUP_NONE)
+		strbuf_stripspace(msg, cleanup == CLEANUP_ALL);
+	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
+		res = 1;
+		goto out;
+	}
+
+	gpg_sign = (opts->gpg_sign) ? opts->gpg_sign : default_gpg_sign;
+
+	if (write_cache_as_tree(tree.hash, 0, NULL)) {
+		res = error(_("git write-tree failed to write a tree"));
+		goto out;
+	}
+
+	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
+					      &current_head->tree->object.oid :
+					      &empty_tree_oid, &tree)) {
+		res = 1;
+		goto out;
+	}
+
+	res = commit_tree_extended(msg->buf, msg->len, tree.hash, parents,
+				   oid.hash, author, gpg_sign, extra);
+	if (res) {
+		res = error(_("failed to write commit object"));
+		goto out;
+	}
+
+	res = update_head(current_head, &oid, msg, &err);
+	if (res) {
+		error("%s", err.buf);
+		goto out;
+	}
+
+	if (flags & AMEND_MSG)
+		commit_post_rewrite(current_head, &oid);
+
+	if (!is_rebase_i(opts))
+		print_commit_summary(NULL, &oid, SUMMARY_SHOW_AUTHOR_DATE);
+out:
+	free_commit_extra_headers(extra);
+	strbuf_release(&err);
+	strbuf_release(&amend_msg);
+	if (amend_author)
+		free(amend_author);
+
+	return res;
+}
+
+static int do_commit(const char *defmsg, const char* author,
+		     struct replay_opts *opts, unsigned int flags)
+{
+	int res;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (defmsg && strbuf_read_file(&sb, defmsg, 2048) < 0)
+		return error_errno(_("unable to read commit message from '%s'"),
+				   defmsg);
+	res = try_to_commit(&sb, author, opts, flags);
+	strbuf_release(&sb);
+
+	if (res == 0) {
+		unlink(git_path_cherry_pick_head());
+		unlink(git_path_revert_head());
+		unlink(git_path_merge_msg());
+		return res;
+	} else if (res == 1) {
+		return run_git_commit(defmsg, opts, flags);
+	}
+
+	return res;
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
@@ -1224,6 +1360,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
+	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, allow;
@@ -1339,6 +1476,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
+		if (!is_fixup (command))
+			author = get_author(msg.message);
 	}
 
 	if (command == TODO_REWORD)
@@ -1424,9 +1563,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	} else if (allow)
 		flags |= ALLOW_EMPTY;
-	if (!opts->no_commit)
+	if (!opts->no_commit) {
 fast_forward_edit:
-		res = run_git_commit(msg_file, opts, flags);
+		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
+			res = do_commit(msg_file, author, opts, flags);
+		else
+			res = error(_("unable to parse commit author"));
+	}
 
 	if (!res && final_fixup) {
 		unlink(rebase_path_fixup_msg());
@@ -1435,6 +1578,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 leave:
 	free_message(commit, &msg);
+	if (author)
+		free(author);
 	update_abort_safety_file();
 
 	return res;
-- 
2.14.1


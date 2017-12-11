Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7146F1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbdLKOOI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:14:08 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:35381 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbdLKONu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:50 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOq5eBiwE; Mon, 11 Dec 2017 14:13:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001629;
        bh=vzTB9zZ06QUgtmNHZO2raTmr4ui9zh/itTH/LzG1LoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=a+4GZPZZ3+9JhpPpYkMEjPfVbyHbSKfD5/NHQE6QbYgzKZXNdVfAe7MSXTkf7zvD4
         bxfH8xdUYaRrxHVvYCViJDb9K1hvkqhIOCLODcRAi+CUTXQCQ6QkZ+lhtdV9IFrwcz
         3RDwzSPl1PgI8NiTBARJIZd83s/q2SaeqQwxdRI0=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=okoqV1XmMXfFbB0JckAA:9
 a=erY4bljehwCFADyP:21 a=mXiPC96pzGqrftqL:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 8/9] sequencer: try to commit without forking 'git commit'
Date:   Mon, 11 Dec 2017 14:13:29 +0000
Message-Id: <20171211141330.23566-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCJMr5CICHb1u3txFxYlws6YcZKnl2kjKZseArAEf+5Tzv46SemVG3vV71rRmYEiIW+As/U8V0ARtVoet8/bh48vterxwRJ0YYcDJylnDpPm9YoekfJH
 CA2BQWPOfcVnJMAqiRzYORE54jRCa+off9fxKB3BGxPHcBkzezrBzMnFmrsMwr2HmVZSlBd3OaLJWkqHFon+iOmRgPIoewf1LDPKbZ2quGjyI0xgKL+V4Cts
 PrpTaJoMGhD44mkrU8I2h3dUkLtVqkGuaZpucZCyH/pwZ1cya//4w2j+3INTZcvjbi367bC4kAqoskgQtn2bMcpVKfUjEwANSY7Qs/wAQmdAeNBJevl3EwVZ
 FB3WYx9zvW/ZWR5f38H9GgAeC7jboMuLStewJumk3jN4a8TcdN4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the commit message does not need to be edited then create the
commit without forking 'git commit'. Taking the best time of ten runs
with a warm cache this reduces the time taken to cherry-pick 10
commits by 27% (from 282ms to 204ms), and the time taken by 'git
rebase --continue' to pick 10 commits by 45% (from 386ms to 212ms) on
my computer running linux. Some of greater saving for rebase is
because it no longer wastes time creating the commit summary just to
throw it away.

The code to create the commit is based on builtin/commit.c. It is
simplified as it doesn't have to deal with merges and modified so that
it does not die but returns an error to make sure the sequencer exits
cleanly, as it would when forking 'git commit'

Even when not forking 'git commit' the commit message is written to a
file and CHERRY_PICK_HEAD is created unnecessarily. This could be
eliminated in future. I hacked up a version that does not write these
files and just passed an strbuf (with the wrong message for fixup and
squash commands) to do_commit() but I couldn't measure any significant
time difference when running cherry-pick or rebase. I think
eliminating the writes properly for rebase would require a bit of
effort as the code would need to be restructured.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v4:
     - changed cleanup and gpg handling to reflect the changes in the last patch
    
    changes since v3:
     - take account of change print_commit_summary() return type after
       dropping the patch that made it return an error instead of dying.
    
    changes since v2:
     - style fixes
    
    changes since v1:
     - added comments to explain return value of try_to_commit()
     - removed unnecessary NULL tests before calling free()
     - style cleanups
     - corrected commit message
     - prefixed cleanup_mode constants to reflect the changes to patch 2
       in this series

 sequencer.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3ce1e5b71474f1cd25b232a319fb7b0e13dc6e14..74770bd00cc3840573057a1868e0a3acb05a71bb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -638,6 +638,18 @@ static int read_env_script(struct argv_array *env)
 	return 0;
 }
 
+static char *get_author(const char *message)
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
@@ -996,6 +1008,158 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&format);
 }
 
+static int parse_head(struct commit **head)
+{
+	struct commit *current_head;
+	struct object_id oid;
+
+	if (get_oid("HEAD", &oid)) {
+		current_head = NULL;
+	} else {
+		current_head = lookup_commit_reference(&oid);
+		if (!current_head)
+			return error(_("could not parse HEAD"));
+		if (oidcmp(&oid, &current_head->object.oid)) {
+			warning(_("HEAD %s is not a commit!"),
+				oid_to_hex(&oid));
+		}
+		if (parse_commit(current_head))
+			return error(_("could not parse HEAD commit"));
+	}
+	*head = current_head;
+
+	return 0;
+}
+
+/*
+ * Try to commit without forking 'git commit'. In some cases we need
+ * to run 'git commit' to display an error message
+ *
+ * Returns:
+ *  -1 - error unable to commit
+ *   0 - success
+ *   1 - run 'git commit'
+ */
+static int try_to_commit(struct strbuf *msg, const char *author,
+			 struct replay_opts *opts, unsigned int flags,
+			 struct object_id *oid)
+{
+	struct object_id tree;
+	struct commit *current_head;
+	struct commit_list *parents = NULL;
+	struct commit_extra_header *extra = NULL;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf amend_msg = STRBUF_INIT;
+	char *amend_author = NULL;
+	enum commit_msg_cleanup_mode cleanup;
+	int res = 0;
+
+	if (parse_head(&current_head))
+		return -1;
+
+	if (flags & AMEND_MSG) {
+		const char *exclude_gpgsig[] = { "gpgsig", NULL };
+		const char *out_enc = get_commit_output_encoding();
+		const char *message = logmsg_reencode(current_head, NULL,
+						      out_enc);
+
+		if (!msg) {
+			const char *orig_message = NULL;
+
+			find_commit_subject(message, &orig_message);
+			msg = &amend_msg;
+			strbuf_addstr(msg, orig_message);
+		}
+		author = amend_author = get_author(message);
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
+	cleanup = (flags & CLEANUP_MSG) ? COMMIT_MSG_CLEANUP_ALL :
+					  opts->default_msg_cleanup;
+
+	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
+	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
+		res = 1; /* run 'git commit' to display error message */
+		goto out;
+	}
+
+	if (write_cache_as_tree(tree.hash, 0, NULL)) {
+		res = error(_("git write-tree failed to write a tree"));
+		goto out;
+	}
+
+	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
+					      &current_head->tree->object.oid :
+					      &empty_tree_oid, &tree)) {
+		res = 1; /* run 'git commit' to display error message */
+		goto out;
+	}
+
+	if (commit_tree_extended(msg->buf, msg->len, tree.hash, parents,
+				 oid->hash, author, opts->gpg_sign, extra)) {
+		res = error(_("failed to write commit object"));
+		goto out;
+	}
+
+	if (update_head_with_reflog(current_head, oid,
+				    getenv("GIT_REFLOG_ACTION"), msg, &err)) {
+		res = error("%s", err.buf);
+		goto out;
+	}
+
+	if (flags & AMEND_MSG)
+		commit_post_rewrite(current_head, oid);
+
+out:
+	free_commit_extra_headers(extra);
+	strbuf_release(&err);
+	strbuf_release(&amend_msg);
+	free(amend_author);
+
+	return res;
+}
+
+static int do_commit(const char *msg_file, const char *author,
+		     struct replay_opts *opts, unsigned int flags)
+{
+	int res = 1;
+
+	if (!(flags & EDIT_MSG) && !(flags & VERIFY_MSG)) {
+		struct object_id oid;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (msg_file && strbuf_read_file(&sb, msg_file, 2048) < 0)
+			return error_errno(_("unable to read commit message "
+					     "from '%s'"),
+					   msg_file);
+
+		res = try_to_commit(msg_file ? &sb : NULL, author, opts, flags,
+				    &oid);
+		strbuf_release(&sb);
+		if (!res) {
+			unlink(git_path_cherry_pick_head());
+			unlink(git_path_merge_msg());
+			if (!is_rebase_i(opts))
+				print_commit_summary(NULL, &oid,
+						SUMMARY_SHOW_AUTHOR_DATE);
+			return res;
+		}
+	}
+	if (res == 1)
+		return run_git_commit(msg_file, opts, flags);
+
+	return res;
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
@@ -1247,6 +1411,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
+	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, allow;
@@ -1363,6 +1528,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
+		if (!is_fixup(command))
+			author = get_author(msg.message);
 	}
 
 	if (command == TODO_REWORD)
@@ -1448,9 +1615,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
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
@@ -1459,6 +1630,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 leave:
 	free_message(commit, &msg);
+	free(author);
 	update_abort_safety_file();
 
 	return res;
-- 
2.15.1


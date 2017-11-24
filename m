Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A96F20954
	for <e@80x24.org>; Fri, 24 Nov 2017 11:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753472AbdKXLIf (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 06:08:35 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57722 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbdKXLIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 06:08:17 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id IBq0eNps6Ap17IBqCeb1CG; Fri, 24 Nov 2017 11:08:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511521697;
        bh=5j0mZntqgHsSoa3IXX5z8EL6FxFs9NwHbmX5lrBn40c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=kBTdv7STSVkrzEdinFYSmNK8mNW6pAEsaHVW0SjQ4EpippcqX80b3x7Ga6IrpFYAT
         5Wq/zDnQdEmbTLHq4zODeM74dSLQi96w5b7kdgVj4UCbKHJbfJsDHPZuiXEfpmyJps
         BR6Wkp9V5vf4BDe9jYxWLmMSaFZp6UI7ULXUi2Fg=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=okoqV1XmMXfFbB0JckAA:9
 a=ygwfbTXXuYQ10Y_t:21 a=GtTGSxFIDTQW_MHV:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 8/9] sequencer: try to commit without forking 'git commit'
Date:   Fri, 24 Nov 2017 11:07:57 +0000
Message-Id: <20171124110758.9406-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171124110758.9406-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKAWFKIH/leX0PMQWdLQGisd9XPdpAUUELh+0CForo8awQNZfj3RNw9AHOz98r+ZZr0ndoeWSEJM8ROFUOLK0H5F7hXuhAQXXME2kg/ZCrnMNK3OYNOh
 hGA/kWEHSnk8enLC8d6vbFw0tBTiiBZzro5qVEQZcFRX7HUcwzJkOp/5yvPVkSydh6za1g82hPMvscJL7n1fbqu/ull6EhhZjas9hIeTBMao7S2Bo74ZU/Bm
 JWc0WvwiavYPXRio/jbIjgRD0aCmu9BhgX27MxxbBp0jCUuCsmD+NGnj/ZTlLC/vhssh5LxHVe9PpiGFFD7fXM6Wegl7qKr/wURU55M5mPNZIk7FL7TRkF4T
 /33Rf7rPRB6UAi4WCyEzToizBRyFkEIRt+A9MQ2DqLQm0XoOwow=
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

 sequencer.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 40461a41e3798e267813656de6b669c297b521c6..99095a28c6732ef697b5b763b347751bd8a440cf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -592,6 +592,18 @@ static int read_env_script(struct argv_array *env)
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
@@ -984,6 +996,160 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
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
+	const char *gpg_sign;
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
+					  default_msg_cleanup;
+	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
+	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
+		res = 1; /* run 'git commit' to display error message */
+		goto out;
+	}
+
+	gpg_sign = opts->gpg_sign ? opts->gpg_sign : default_gpg_sign;
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
+				 oid->hash, author, gpg_sign, extra)) {
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
@@ -1235,6 +1401,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
+	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, allow;
@@ -1351,6 +1518,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
+		if (!is_fixup(command))
+			author = get_author(msg.message);
 	}
 
 	if (command == TODO_REWORD)
@@ -1436,9 +1605,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
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
@@ -1447,6 +1620,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 leave:
 	free_message(commit, &msg);
+	free(author);
 	update_abort_safety_file();
 
 	return res;
-- 
2.15.0


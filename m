Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746E91F424
	for <e@80x24.org>; Fri, 27 Apr 2018 22:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeD0Wb1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 18:31:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:50297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbeD0Wb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 18:31:26 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M9OMc-1f67543qEI-00CeGR; Sat, 28 Apr 2018 00:31:21 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 2/6] sequencer: learn about the special "fake root commit" handling
Date:   Sat, 28 Apr 2018 00:31:13 +0200
Message-Id: <42db734a98059fcfd67627aecc93cc8f0439fd37.1524868165.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:1rwgD6jqgkFDQEylU089mX2lUvhwAsfgFnHnlUF9vitaIA/wwhu
 E4DqrWbrCWXEy6403C8ZiLvmqzWhani/WFcFWEacqWDMuqeJWf2R1AjvAtTXfnaGQgAbLqO
 1tq4cSKYTECp2HcJFnVMcYVcqLwtY3v7oKziHGhbCKFh3voQqbz+mTuKPUisoGHEFN2XjTX
 rv3le83DPLqHtOUdQEV1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T9mp/YPMwRg=:Zr1MbsQ9+wnppvbjHgLXtd
 W6P34Tcr2/8q5aT0OgnM5fTe3wTHggC5LLj3s/VWPdu07ubkRx4A3m4TikBXhudixWK2AntWI
 LMKJU/Srcaq6ULWqJM0qDmXaGA67vsYw9y3daebEdIczgcjuUvzEiGn/GlhTMIVHsN+2Xjd9d
 Ie8JwoOzpg40GfK6dgLmc5iOJDyv29n/DEI5frckKXx1UEccGWcBMR6ZFjb9d2gXhqhMKFM0B
 obpKZBrD5Rte1V2+hOpaNdXLQRLknQsqppOY77Bd4JQp82NztVWhphX8h+k2QCy1/lctfX2ka
 1m5bkC5SADCBpBN9kmh5vs0MQ2LKJqCz0hxP3Q9suWpI8QdFn2COV7inSNZQrx35Ld387pzaK
 50voJA2Z8YEVm8ZuATl8x/+0CyDusUgL776+Vz0I3uz5REYUvmTQY2nq1WgXQg1dIRf1T1ZBn
 BIDF+xZKI9HvrUZIuXc4/EOqmSn8n72s/b32mZ7FYy5Qn2Jbbc7TRt9NX+9fhM/alFQhpCgYP
 hLY+KV+gcUX/B2eXPsomhLShdBzR5BQMbJgvI5VpHR5nCGA2qfHGkTq9FgKPR5RtL7awaroEE
 2SfuSyI6AzqofReLh/kEst5aSlGhgrekm/kiPwySxj/pXILCS7uD3J3hT2xjGtx39PVfxOxtl
 NyZvBLLCr2dmXkIWkmdO6qXIeOBSNVEk6bv4a5Cszi887sFjcNtA8vY/wFv1GkvJkfAjCJ81+
 aSCjHc9u84pWVZ+SqucnOuDvSqzFKtPr2exIWPCFKrB9wGWP0KyXzO+znAbJLWJZF5DbdBACm
 Z8dZlw4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an interactive rebase wants to recreate a root commit, it
- first creates a new, empty root commit,
- checks it out,
- converts the next `pick` command so that it amends the empty root
  commit

Introduce support in the sequencer to handle such an empty root commit,
by looking for the file <GIT_DIR>/rebase-merge/squash-onto; if it exists
and contains a commit name, the sequencer will compare the HEAD to said
root commit, and if identical, a new root commit will be created.

While converting scripted code into proper, portable C, we also do away
with the old "amend with an empty commit message, then cherry-pick
without committing, then amend again" dance and replace it with code
that uses the internal API properly to do exactly what we want: create a
new root commit.

To keep the implementation simple, we always spawn `git commit` to create
new root commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 sequencer.h |   4 ++
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 90c8218aa9a..fc124596b53 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -125,6 +125,12 @@ static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
 static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 	"rebase-merge/rewritten-pending")
 
+/*
+ * The path of the file containig the OID of the "squash onto" commit, i.e.
+ * the dummy commit used for `reset [new root]`.
+ */
+static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
+
 /*
  * The path of the file listing refs that need to be deleted after the rebase
  * finishes. This is used by the `label` command to record the need for cleanup.
@@ -470,7 +476,8 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
-				   to, unborn ? &null_oid : from,
+				   to, unborn && !is_rebase_i(opts) ?
+				   &null_oid : from,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -692,6 +699,42 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+static const char *read_author_ident(struct strbuf *buf)
+{
+	char *p, *p2;
+
+	if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
+		return NULL;
+
+	for (p = buf->buf; *p; p++)
+		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
+			strbuf_splice(buf, p - buf->buf, p2 - p, "'", 1);
+		else if (*p == '\'')
+			strbuf_splice(buf, p-- - buf->buf, 1, "", 0);
+
+	if (skip_prefix(buf->buf, "GIT_AUTHOR_NAME=", (const char **)&p)) {
+		strbuf_splice(buf, 0, p - buf->buf, "", 0);
+		p = strchr(buf->buf, '\n');
+		if (skip_prefix(p, "\nGIT_AUTHOR_EMAIL=", (const char **)&p2)) {
+			strbuf_splice(buf, p - buf->buf, p2 - p, " <", 2);
+			p = strchr(p, '\n');
+			if (skip_prefix(p, "\nGIT_AUTHOR_DATE=@",
+					(const char **)&p2)) {
+				strbuf_splice(buf, p - buf->buf, p2 - p,
+					      "> ", 2);
+				p = strchr(p, '\n');
+				if (p) {
+					strbuf_setlen(buf, p - buf->buf);
+					return buf->buf;
+				}
+			}
+		}
+	}
+
+	warning(_("could not parse '%s'"), rebase_path_author_script());
+	return NULL;
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -711,6 +754,7 @@ N_("you have staged changes in your working tree\n"
 #define AMEND_MSG   (1<<2)
 #define CLEANUP_MSG (1<<3)
 #define VERIFY_MSG  (1<<4)
+#define CREATE_ROOT_COMMIT (1<<5)
 
 /*
  * If we are cherry-pick, and if the merge did not result in
@@ -730,6 +774,40 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	const char *value;
 
+	if (flags & CREATE_ROOT_COMMIT) {
+		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
+		const char *author = is_rebase_i(opts) ?
+			read_author_ident(&script) : NULL;
+		struct object_id root_commit, *cache_tree_oid;
+		int res = 0;
+
+		if (!defmsg)
+			BUG("root commit without message");
+
+		if (!(cache_tree_oid = get_cache_tree_oid()))
+			res = -1;
+
+		if (!res)
+			res = strbuf_read_file(&msg, defmsg, 0);
+
+		if (res <= 0)
+			res = error_errno(_("could not read '%s'"), defmsg);
+		else
+			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
+					  NULL, &root_commit, author,
+					  opts->gpg_sign);
+
+		strbuf_release(&msg);
+		strbuf_release(&script);
+		if (!res) {
+			update_ref(NULL, "CHERRY_PICK_HEAD", &root_commit, NULL,
+				   REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR);
+			res = update_ref(NULL, "HEAD", &root_commit, NULL, 0,
+					 UPDATE_REFS_MSG_ON_ERR);
+		}
+		return res < 0 ? error(_("writing root commit")) : 0;
+	}
+
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts)) {
@@ -1216,7 +1294,8 @@ static int do_commit(const char *msg_file, const char *author,
 {
 	int res = 1;
 
-	if (!(flags & EDIT_MSG) && !(flags & VERIFY_MSG)) {
+	if (!(flags & EDIT_MSG) && !(flags & VERIFY_MSG) &&
+	    !(flags & CREATE_ROOT_COMMIT)) {
 		struct object_id oid;
 		struct strbuf sb = STRBUF_INIT;
 
@@ -1369,6 +1448,12 @@ static int is_fixup(enum todo_command command)
 	return command == TODO_FIXUP || command == TODO_SQUASH;
 }
 
+/* Does this command create a (non-merge) commit? */
+static int is_pick_or_similar(enum todo_command command)
+{
+	return command <= TODO_SQUASH;
+}
+
 static int update_squash_messages(enum todo_command command,
 		struct commit *commit, struct replay_opts *opts)
 {
@@ -1523,7 +1608,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			return error(_("your index file is unmerged."));
 	} else {
 		unborn = get_oid("HEAD", &head);
-		if (unborn)
+		/* Do we want to generate a root commit? */
+		if (is_pick_or_similar(command) && opts->have_squash_onto &&
+		    !oidcmp(&head, &opts->squash_onto)) {
+			if (is_fixup(command))
+				return error(_("cannot fixup root commit"));
+			flags |= CREATE_ROOT_COMMIT;
+			unborn = 1;
+		} else if (unborn)
 			oidcpy(&head, the_hash_algo->empty_tree);
 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD",
 				       NULL, 0))
@@ -2136,6 +2228,12 @@ static int read_populate_opts(struct replay_opts *opts)
 		read_strategy_opts(opts, &buf);
 		strbuf_release(&buf);
 
+		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
+			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0)
+				return error(_("unusable squash-onto"));
+			opts->have_squash_onto = 1;
+		}
+
 		return 0;
 	}
 
diff --git a/sequencer.h b/sequencer.h
index d9570d92b11..4b2717881fa 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,6 +44,10 @@ struct replay_opts {
 	char **xopts;
 	size_t xopts_nr, xopts_alloc;
 
+	/* placeholder commit for -i --root */
+	struct object_id squash_onto;
+	int have_squash_onto;
+
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 };
-- 
2.17.0.windows.1.33.gfcbb1fa0445



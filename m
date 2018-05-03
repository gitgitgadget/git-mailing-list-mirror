Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C375200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeECXBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:01:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:36967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbeECXBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:01:22 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0McEkx-1ex7M23NGZ-00Jecl; Fri, 04 May 2018 01:01:17 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH v2 2/6] sequencer: learn about the special "fake root commit" handling
Date:   Fri,  4 May 2018 01:01:17 +0200
Message-Id: <73398da7119311c10fedfcfcbce7cc50203377ac.1525388472.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.38.g05ca542f78d
In-Reply-To: <cover.1525388472.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ATDUu7oPYEKg5Hjw0CLr43xfrghT4LaSzUG6Wn/AwDz+fCslR+s
 fdLjxHT5puARZsCe26/gXi57vkYLcsumm/1VCP3pu+fVhaO6DeP1Fjgp/e9urmFnqJoXX/I
 BWV44KOO5symGiRpfF387DLk9mSBHlG4In/x0BKVmBdxBdEsXAPfY/enyRe41ueV/ZHtQwm
 FdGwdH3+aZ68No6luci5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ohU7SMnk+Pk=:7qIKedBCWnZL25/r+xhUvj
 vGFqLArolqD7ywMAzlbbbg+PpD3N0xe1pnr8qJqIiot6rk2dkdiGR+HzYa0Px2SwqwgojoxAJ
 1XLS033QbKNcKPi5bl7mca0kSJF/Q86T03pirkZGT52E6MxzA9oHQ4rZFy4jG7QhRgE/jLtdr
 oegdpKZhqhiGn+ddJ0avmDi9tvji9m62xYFdrUqcRjc5iUFKuhu4DAGkoltQj/sFwTFPjo1k5
 MtOuf5s3tU5uHViVSRU2eKyEUApPUwdpHMsssMAsu6NcS21L933DGo7kpSzPNGnR9PWf9OoJ5
 vHkDLK0DX0ceSb7KbxHT1YX+PCd0wDxHuhi03MuhRoL3ENq2mzrU2ho8xfMBeyD5y1JyvlyJv
 HPN0320hNCnaiexCPOVkJ4lLdE2/JqpZ0aut7s8CCJ7CkiJ9pGskWNasYmK8AOGdoPjuxdMs3
 Ad2m6E0/BuNKbuITQCns5jPop9GFaTGn2WF5v01LqgV1avwK5moMLyGSY4Pn9T+GNL0TYhos6
 HXs1YDv8VhctkHMGIl1vO8WyGQFzzDiAtylk0OoGD6ryPwOgh2EROkK97Nr025awIbvioXMBs
 CujUSfn+Jwbq47IeGrLHF72IuVvWuLpSDfx3WOSVWPf497JnN8a2GR1E0RkHrqa9Epyxv96tW
 Mhnd7sBa5p6kwjOwCtplrnXQQoxpbY03q6OG2TRLD8UuGKfK5HiJT8P1DKP7Ss9xew4QVssDI
 hdAiiV9pCOqLhJnnVnuNljUn2wFbg/b3ugB+FBlCVVg4jWByfQwHAQOplpqWiuTKwicjfUWho
 T2Qfp3Q
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
 sequencer.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 sequencer.h |   4 ++
 2 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 90c8218aa9a..8eddda681d1 100644
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
@@ -692,6 +699,52 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+/* Read author-script and return an ident line (author <email> timestamp) */
+static const char *read_author_ident(struct strbuf *buf)
+{
+	const char *keys[] = {
+		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
+	};
+	char *in, *out, *eol;
+	int i = 0, len;
+
+	if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
+		return NULL;
+
+	/* dequote values and construct ident line in-place */
+	for (in = out = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
+		if (!skip_prefix(in, keys[i], (const char **)&in)) {
+			warning("could not parse '%s' (looking for '%s'",
+				rebase_path_author_script(), keys[i]);
+			return NULL;
+		}
+
+		eol = strchrnul(in, '\n');
+		*eol = '\0';
+		sq_dequote(in);
+		len = strlen(in);
+
+		if (i > 0) /* separate values by spaces */
+			*(out++) = ' ';
+		if (i == 1) /* email needs to be surrounded by <...> */
+			*(out++) = '<';
+		memmove(out, in, len);
+		out += len;
+		if (i == 1) /* email needs to be surrounded by <...> */
+			*(out++) = '>';
+		in = eol + 1;
+	}
+
+	if (i < 3) {
+		warning("could not parse '%s' (looking for '%s')",
+			rebase_path_author_script(), keys[i]);
+		return NULL;
+	}
+
+	buf->len = out - buf->buf;
+	return buf->buf;
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -711,6 +764,7 @@ N_("you have staged changes in your working tree\n"
 #define AMEND_MSG   (1<<2)
 #define CLEANUP_MSG (1<<3)
 #define VERIFY_MSG  (1<<4)
+#define CREATE_ROOT_COMMIT (1<<5)
 
 /*
  * If we are cherry-pick, and if the merge did not result in
@@ -730,6 +784,40 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
@@ -1216,7 +1304,8 @@ static int do_commit(const char *msg_file, const char *author,
 {
 	int res = 1;
 
-	if (!(flags & EDIT_MSG) && !(flags & VERIFY_MSG)) {
+	if (!(flags & EDIT_MSG) && !(flags & VERIFY_MSG) &&
+	    !(flags & CREATE_ROOT_COMMIT)) {
 		struct object_id oid;
 		struct strbuf sb = STRBUF_INIT;
 
@@ -1369,6 +1458,22 @@ static int is_fixup(enum todo_command command)
 	return command == TODO_FIXUP || command == TODO_SQUASH;
 }
 
+/* Does this command create a (non-merge) commit? */
+static int is_pick_or_similar(enum todo_command command)
+{
+	switch (command) {
+	case TODO_PICK:
+	case TODO_REVERT:
+	case TODO_EDIT:
+	case TODO_REWORD:
+	case TODO_FIXUP:
+	case TODO_SQUASH:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static int update_squash_messages(enum todo_command command,
 		struct commit *commit, struct replay_opts *opts)
 {
@@ -1523,7 +1628,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
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
@@ -2136,6 +2248,12 @@ static int read_populate_opts(struct replay_opts *opts)
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
2.17.0.windows.1.38.g05ca542f78d



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC2D20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbcJJR0G (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:52454 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753259AbcJJR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:00 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MS5jy-1bQSNJ1emo-00TBMb; Mon, 10 Oct 2016 19:25:51
 +0200
Date:   Mon, 10 Oct 2016 19:25:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 15/25] sequencer: allow editing the commit message on a
 case-by-case basis
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <0577f66a108dced07775e10b87292c0eabfcc514.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/FZhS5FlYN4Ofhzz0XdWDr9guy01++XuULzJZFnzzDXHkAKzuMK
 BcLrLFTne5BAUNHPvNRoMX5qvt4vhNFYnhXZw1Bb1rRWGL/lku5kGqCVXU0OXumjOzo80XK
 kAny1veMW2KWn9yLvhg51T5YYJtGbUE9xDhYcEYOR+IpfyJdQTH/KdV4EjM/1EKcUqcJoWO
 /bwq4obUpZ1UShnamJINQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HYki/cGVpbk=:H9XvflZr/pXLTmB6qklLVK
 nbOOjtTKnaXXxWbw95udmE4wfIV4L6F9oyEmP+BBIBBtx4jDqyiJ9NkqbbOYMvPjRbTgCFoG5
 7mz6ogTY6g8COco74PT1ht2+JdCP5BE1SKos/fvl8BSk6fuUMIVyGXxKFaKYvCXfjRquWibtv
 w8Cdg7nWZ2LOHL4OxS9Eu5VWU7PhCPFFma8gprFGh7FS73EM6xMoNlI0wMoyP90fXKn1GWNYD
 mFLmXeodSc2N6ginOFQOA0y1OvMfj7VN0Ag/W8HAa03i2VU8G1yiH8OAvdspkMmuGV0Qvb4v4
 nEqbxBjikYmhIo84f4u/gg2iS1FR2Xu10AUJgGo62bLpmhYCFHH44/iG0K/qI+G9JfPE7+imm
 VwRFBHQUXicJkcIDNTXiBB2a8ycfXFWh08WLRdSE4B977z6zUGBljgqthOlA7mcatoHqmBerD
 tJzhay8VGnGlu6zj/R+c5bf3iQJ173E59/D+zleRI2tq4WeBPSN0jibu0pD10/5KFpEmTzYoe
 MOjoJDHXcduFsEN1jC4olbkYKMR4E1SB5f6zCyZQPIbQT/9rW0D6pL0cgnIVzy9LxopljbM1p
 UT9RqI5/ybxRLKr8NRS4utK0pjeAjLjmUb861xXIoyHw0kVn+GytYyekl9oqKMAro/o7/H26C
 aokId+iMnhyVEBbbSRiKLTziH2CHmHrzYAId0teO29Rg+onluhYVfmKJVxWTOmCf0WqdYomvf
 VTCUul67Lgg7SHzD2YzMf/M9sVrRnUpy+OF8flg5DQh56/bb37LEv8zXaUSfiZGyA6Orovno9
 BLMyIVr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will implement more and more of rebase -i's
functionality inside the sequencer. One particular feature of the
commands to come is that some of them allow editing the commit message
while others don't, i.e. we cannot define in the replay_opts whether the
commit message should be edited or not.

Let's add a new parameter to the run_git_commit() function. Previously,
it was the duty of the caller to ensure that the opts->edit setting
indicates whether to let the user edit the commit message or not,
indicating that it is an "all or nothing" setting, i.e. that the
sequencer wants to let the user edit *all* commit message, or none at
all. In the upcoming rebase -i mode, it will depend on the particular
command that is currently executed, though.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 681552a..b621f4b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -15,6 +15,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "quote.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -33,6 +34,11 @@ static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
  * being rebased.
  */
 static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
+/*
+ * The following files are written by git-rebase just after parsing the
+ * command-line (and are only consumed, not modified, by the sequencer).
+ */
+static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -132,6 +138,16 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
+static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
+{
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	if (opts->gpg_sign)
+		sq_quotef(&buf, "-S%s", opts->gpg_sign);
+	return buf.buf;
+}
+
 int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
@@ -465,7 +481,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty)
+			  int allow_empty, int edit)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -474,17 +490,20 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 	if (is_rebase_i(opts)) {
 		env = read_author_script();
-		if (!env)
+		if (!env) {
+			const char *gpg_opt = gpg_sign_opt_quoted(opts);
+
 			return error("You have staged changes in your working "
 				"tree. If these changes are meant to be\n"
 				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend $gpg_sign_opt_quoted\n\n"
+				"  git commit --amend %s\n\n"
 				"If they are meant to go into a new commit, "
 				"run:\n\n"
-				"  git commit $gpg_sign_opt_quoted\n\n"
+				"  git commit %s\n\n"
 				"In both cases, once you're done, continue "
 				"with:\n\n"
-				"  git rebase --continue\n");
+				"  git rebase --continue\n", gpg_opt, gpg_opt);
+		}
 	}
 
 	argv_array_init(&array);
@@ -497,7 +516,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
-	if (opts->edit)
+	if (edit)
 		argv_array_push(&array, "-e");
 	else if (!opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
@@ -766,7 +785,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow);
+				     opts, allow, opts->edit);
 
 leave:
 	free_message(commit, &msg);
@@ -990,8 +1009,21 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
-	if (is_rebase_i(opts))
+	if (is_rebase_i(opts)) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+			if (!starts_with(buf.buf, "-S"))
+				strbuf_reset(&buf);
+			else {
+				free(opts->gpg_sign);
+				opts->gpg_sign = xstrdup(buf.buf + 2);
+			}
+		}
+		strbuf_release(&buf);
+
 		return 0;
+	}
 
 	if (!file_exists(git_path_opts_file()))
 		return 0;
-- 
2.10.0.windows.1.325.ge6089c1



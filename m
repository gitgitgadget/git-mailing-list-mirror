Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35A70207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1948112AbdD1Vcu (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:32:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:53706 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425802AbdD1Vcs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:32:48 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgZdt-1drFI63StB-00nvkl; Fri, 28
 Apr 2017 23:32:36 +0200
Date:   Fri, 28 Apr 2017 23:32:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 05/10] rebase -i: also expand/collapse the SHA-1s via the
 rebase--helper
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <6cf1bcd39672474230b179a3d12c5eeab353ae0c.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ogcMjfH/zMC8+Mp2vdGKT4fyJH6NS7FyKy/4jaB15BH44lTGRx6
 xx9KZXKkc682VQlnstp320Av3XZl1GypyT7+1ycAJfMxEbyfG0A55Rk6lhXodvikcl7rKId
 iEG7+adPce0TC0Pk5zMH4aVGklAR51h52Z+bzupni3r4640/IT2sFNDnYCtRT4lrAi4Z8gC
 4OEhihOu9Lf/Yp5Phym8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0/0etPkoo6w=:MwE7w3tV0Bd2NZtTCwMj0g
 EfjPg3vBrmAGomspB3lfwcOnQy45IdYge15jHj5ABHL5uMNZb7T/Fsr/Pmp8nUe/vMUZha0fl
 1TK+QUImfOhRE5Gfg7pdiVMqzLPbiR/Uu5c9SjiFR8gpJxl9euv5oquvSdm9xcrP21IHBg6GE
 PHX5bBf2KRpoGkYNOegsl0iyDDH/zHEy38jTDdH5Usvcx1gnvMAGcu12bGH+3xk5IRG4aHizM
 ZF0L6YTZmmkijHnwpkdnlaZufqVz0uACoRkSHxwBZguc7FEBKr9XbmYojZKGXrUiX2V1UzyZj
 zUg8942xjsY1mLoyiRlfoOO5PQsLImW3lFHP2wYBBNBbNhUzrjUX8nhaHVza5HsDeIteUtLcX
 HXsUcesO61YTrz3T0R07rZ9sZsRUlUQiLaQaGjFNe2PrtLy5EZYqy9OzrK2MmqrTbNQJS8Mk7
 2y6kLo13s4NNvaRo393g0GT2PHSEw8LfKYjRMx5K+TtBUO+tj2DIqsyQm7090IViEoKehtK92
 S5r/RvMDjBO9pqsoez4BblqtIz/cf+DhJy1BEYR3XDJwpHMoF2FPpC16chkOMkT4zkcyp6/Dg
 MXFD1bidKOULJXu2TvCGiVHEI700rDCq8qEjy8IrwaU4i0gXrIuRnaJ+dviY6Ka+reB8GGTO6
 p5jXEA7SHH3uXilZma0OBtqbGcP8PuG2fRnuRPa9lOOyQT0mNTyOp0xMVMaN3fwnXbuyvzBmw
 HyPsc4u6pyaxAE6z2tJIbE+Q58f8wOtnY44ZGESZjVqGrONfEX7KNVBL4jQAR6KlZd2GDl1p2
 9vn6vrL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is crucial to improve performance on Windows, as the speed is now
mostly dominated by the SHA-1 transformation (because it spawns a new
rev-parse process for *every* line, and spawning processes is pretty
slow from Git for Windows' MSYS2 Bash).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c   | 10 +++++++-
 git-rebase--interactive.sh | 27 ++--------------------
 sequencer.c                | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  2 ++
 4 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 821058d452d..9444c8d6c60 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,7 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int keep_empty = 0;
 	enum {
-		CONTINUE = 1, ABORT, MAKE_SCRIPT
+		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -24,6 +24,10 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 				ABORT),
 		OPT_CMDMODE(0, "make-script", &command,
 			N_("make rebase script"), MAKE_SCRIPT),
+		OPT_CMDMODE(0, "shorten-sha1s", &command,
+			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
+		OPT_CMDMODE(0, "expand-sha1s", &command,
+			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),
 		OPT_END()
 	};
 
@@ -42,5 +46,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
 		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
+	if (command == SHORTEN_SHA1S && argc == 1)
+		return !!transform_todo_ids(1);
+	if (command == EXPAND_SHA1S && argc == 1)
+		return !!transform_todo_ids(0);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 214af0372ba..82a1941c42c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -750,35 +750,12 @@ skip_unnecessary_picks () {
 		die "$(gettext "Could not skip unnecessary pick commands")"
 }
 
-transform_todo_ids () {
-	while read -r command rest
-	do
-		case "$command" in
-		"$comment_char"* | exec)
-			# Be careful for oddball commands like 'exec'
-			# that do not have a SHA-1 at the beginning of $rest.
-			;;
-		*)
-			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
-			if test "a$rest" = "a${rest#*[	 ]}"
-			then
-				rest=$sha1
-			else
-				rest="$sha1 ${rest#*[	 ]}"
-			fi
-			;;
-		esac
-		printf '%s\n' "$command${rest:+ }$rest"
-	done <"$todo" >"$todo.new" &&
-	mv -f "$todo.new" "$todo"
-}
-
 expand_todo_ids() {
-	transform_todo_ids
+	git rebase--helper --expand-sha1s
 }
 
 collapse_todo_ids() {
-	transform_todo_ids --short
+	git rebase--helper --shorten-sha1s
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
diff --git a/sequencer.c b/sequencer.c
index 88819a1a2a9..201d45b1677 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2437,3 +2437,60 @@ int sequencer_make_script(int keep_empty, FILE *out,
 	strbuf_release(&buf);
 	return 0;
 }
+
+
+int transform_todo_ids(int shorten_sha1s)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int fd, res, i;
+	FILE *out;
+
+	strbuf_reset(&todo_list.buf);
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0)
+		return error_errno(_("could not open '%s'"), todo_file);
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("could not read '%s'."), todo_file);
+	}
+	close(fd);
+
+	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	if (res) {
+		todo_list_release(&todo_list);
+		return error(_("unusable instruction sheet: '%s'"), todo_file);
+	}
+
+	out = fopen(todo_file, "w");
+	if (!out) {
+		todo_list_release(&todo_list);
+		return error(_("unable to open '%s' for writing"), todo_file);
+	}
+	for (i = 0; i < todo_list.nr; i++) {
+		struct todo_item *item = todo_list.items + i;
+		int bol = item->offset_in_buf;
+		const char *p = todo_list.buf.buf + bol;
+		int eol = i + 1 < todo_list.nr ?
+			todo_list.items[i + 1].offset_in_buf :
+			todo_list.buf.len;
+
+		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
+			fwrite(p, eol - bol, 1, out);
+		else {
+			const char *sha1 = shorten_sha1s ?
+				short_commit_name(item->commit) :
+				oid_to_hex(&item->commit->object.oid);
+			int len;
+
+			p += strspn(p, " \t"); /* left-trim command */
+			len = strcspn(p, " \t"); /* length of command */
+
+			fprintf(out, "%.*s %s %.*s\n",
+				len, p, sha1, item->arg_len, item->arg);
+		}
+	}
+	fclose(out);
+	todo_list_release(&todo_list);
+	return 0;
+}
diff --git a/sequencer.h b/sequencer.h
index 83f2943b7a9..47a81034e76 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
+int transform_todo_ids(int shorten_sha1s);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.12.2.windows.2.800.gede8f145e06



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CFA20282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdFNNHz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:07:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:51916 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752486AbdFNNHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:07:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbA4j-1e5A4n2lnV-00kedE; Wed, 14
 Jun 2017 15:07:44 +0200
Date:   Wed, 14 Jun 2017 15:07:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 05/10] rebase -i: also expand/collapse the SHA-1s via the
 rebase--helper
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <f2af44f76483fd083c4db57ba5f245c61455c517.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:d3HKR3fb/836Ruqfc7Wq+lFSt1o/immI93UU1L+PtKBAEMcFp9r
 sic61w3buGgM3/ihKSYE54yirLwuM87pBjdbXYl6uJlbVNvEgkr87JElnfdK12bWxXNWZTH
 trtba128auvuKl5EOMJ0SSq/vG2i9Wv1loNQ0yf1Kw5o+YeiScqY3y2MOHOMY3jy8RV0dXY
 s/RS8jDATBcPebbvYGbFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C4ByTnY9B70=:qeXtgHG2yFLw4Ed/m2v4P/
 OHuEfLHTYuesHv59VrA/HJWEl6qZ7FY7l4i6iwmnuDF0XYeFA9HbIS8utNGp9/cEIzWjkPPNh
 ayrCo9cPcyfdtAl95hd24A9z8aTN+QALQyxs1R6OQEhQOaZ0G5btfSMVn/UsYkd1uUHdtxlTt
 jOmcXL+49JH5p2Dos/Z2m/ERFv7aCpB6JJXmFiFv/69bI1u+5wDntRqL8EMBQ56RSED6hDMn8
 CY2fqkQaWvmVSQ2ctinePBpIh6bDdkbA/iVDtpCeDMTm3VNVZ5aBsnpdU+vzclOZF/+4DuwDI
 3yZr/HFH4/CPOuQgFLkHLB/fuVirEwEWKR6ojOMcUpxLVPYFR48P2KgRWtaGTMYB1lRyPmgEO
 A7J86T4ZL2zrnNOH/tOSDcsiCRnmMeWDBNucYNxSLO1V8xfyoTnhh7fDwRUkonrI5dMOL3bgd
 ZI+WuJZ9DevRjJo0s2X2XVUJaazeTlQoqxsaMwtxSYw6tcO7b1LljfcSEKJcPbgqT2vdyRJWJ
 XwcHHdGvnKZtluzJiad0hSoJI8NLFz3KLbuQ1ULe+YX2CU8D0LvP3GPB5eq/7bt6VF/b/AcTh
 hN3R/S9nHTQoaH1/KIC4z7+dy4BNoYXDWRtVuGdjg7JB1qRjAjsqFtqs5mK9RukSHDIqMSe/g
 qP/pFQsVvWv79Nxb1OjnfuV3EQP2Ec4bYzxn7B/Hl750/SkRqc3wDk8Lcs+IFE0sF+9Md8G67
 GC/FG8S6MUzCChf5wfr0NzOSJuT9Hr71g+tFnDedJDQFakmIiaBC44s3uEHlzohhhCqX19NJ2
 PvxSAwT
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
index 821058d452d..b6ad4008398 100644
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
+		OPT_CMDMODE(0, "shorten-ids", &command,
+			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
+		OPT_CMDMODE(0, "expand-ids", &command,
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
index 9d65212b7f1..d5df02435ae 100644
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
+	git rebase--helper --expand-ids
 }
 
 collapse_todo_ids() {
-	transform_todo_ids --short
+	git rebase--helper --shorten-ids
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
diff --git a/sequencer.c b/sequencer.c
index 133d9aa7c74..5b893ca3878 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2461,3 +2461,60 @@ int sequencer_make_script(int keep_empty, FILE *out,
 	strbuf_release(&buf);
 	return 0;
 }
+
+
+int transform_todo_ids(int shorten_ids)
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
+		return error(_("unusable todo list: '%s'"), todo_file);
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
+			const char *id = shorten_ids ?
+				short_commit_name(item->commit) :
+				oid_to_hex(&item->commit->object.oid);
+			int len;
+
+			p += strspn(p, " \t"); /* left-trim command */
+			len = strcspn(p, " \t"); /* length of command */
+
+			fprintf(out, "%.*s %s %.*s\n",
+				len, p, id, item->arg_len, item->arg);
+		}
+	}
+	fclose(out);
+	todo_list_release(&todo_list);
+	return 0;
+}
diff --git a/sequencer.h b/sequencer.h
index 83f2943b7a9..71d25374afe 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
+int transform_todo_ids(int shorten_ids);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.13.1.windows.1.1.ga36e14b3aaa



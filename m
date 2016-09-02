Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A4E1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbcIBQXJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:59033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbcIBQXI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:08 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MKYLf-1bhE1J0g1X-0022N1; Fri, 02 Sep 2016 18:23:02
 +0200
Date:   Fri, 2 Sep 2016 18:23:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] rebase -i: generate the script via rebase--helper
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <be9c724f1d664d1c85dd1df71e352e3ac1ccc0f9.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aRC+VXhN4J1SEe6bqnSJSHh64K0NC93uQdjX3/DKwQQYOEPRzOG
 fzkBx8y/s5ju1UH7ArB5xJJIvJxl/dRAHbGE7F+VBDrbtp7vBrX2R0WwTHS9638aiQaxtgq
 HZgdKiuYch0oN+ZOyYCgh3iP5G3XglOySG6IfAXgcqXNdKAQKBRVKMjtaKTH5qWlFQqYBV1
 0F8S5TIN4VboPXkeVdAag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5gDCvBh8FCY=:y+3eBEOw3JGKQ7QGuSBxHw
 Z8Ri8PcpMCLexIDq4imU0jBmkCWE0G5Wxhon4TP2cXB6Rl6qnMx52D2NU8l/gdUrX2qoAOA7f
 oedyfeVjsSEv9VuxzD7Ue0EBgJa5CY3q24P+/6yg+VnibjxSy0TOLgZeH0St9Vj5GX918d9oX
 ypqFL1je4gr2fjMbV8vFZtKIWEAcbDbiVl+BvnAvVEUNtZc1mFTrnMUIuGT/XXJChY98A0mSD
 OHCbN5GZdQ/iK3OVJ8KLGcB+HmstUUuKtHMxdMOXCSCuLsc4U30RP8KgQgVq5JrCvthWTmJG3
 Kr+p6j/Z7jW2Nc53JyFgd1z47d30B6ijfV/gIMIY78imantVAMbMzORL1cFs1Qn8+XmNzg3z2
 fhLOiJZ0IQXo1vxKNc5LvmocXPbkl97OAMtHT7XMCmcOw4Q1rbJrXnzSdPHgRspTqoIf763eB
 k9QLlRrhB+qepjPR6je62p0S/cHhVBkw6DgvDUT0WGwYD7f5WDAe7BuL/gGXXy6va97kI8xLu
 CKTp3K6CqG+r7+hma/zjQzs7io60tiW3my7hB3tImNuE5pn9WACJ5AA4sfn5x/eDxL/ltDHNO
 JLHn8Y/w4DiRtR3f2IbXgRu+DMjOSxP0Kzm/HqbIwix4EHXgwCILRuJLPwnf5R5DZlYSIlAN6
 MB7Bpqcv1ME7nXdRvEMtQ6ySy8L5R8TiN4Jwuo+//Zjr4vGgrC68hdiUDgN4hUn27RFiThBBj
 ZknZgAK3wo/WTth2vhKCmf9ZiMaJ8p6eXAOmZIwA97Bx0FgeAPqoH0KefiPY/VmTjd3mIqkUm
 r8riZj+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first step of an interactive rebase is to generate the so-called "todo
script", to be stored in the state directory as "git-rebase-todo" and to
be edited by the user.

Originally, we adjusted the output of `git log <options>` using a simple
sed script. Over the course of the years, the code became more
complicated. We now use shell scripting to edit the output of `git log`
conditionally, depending whether to keep "empty" commits (i.e. commits
that do not change any files).

On platforms where shell scripting is not native, this can be a serious
drag. And it opens the door for incompatibilities between platforms when
it comes to shell scripting or to Unix-y commands.

Let's just re-implement the todo script generation in plain C, using the
revision machinery directly.

This is substantially faster, improving the speed relative to the
shell script version of the interactive rebase from 2x to 3x on Windows.

Note that the rearrange_squash() function in git-rebase--interactive
relied on the fact that we set the "format" variable to the config setting
rebase.instructionFormat. Relying on a side effect like this is no good,
hence we explicitly perform that assignment (possibly again) in
rearrange_squash().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c   |  8 +++++++-
 git-rebase--interactive.sh | 44 +++++++++++++++++++++++---------------------
 sequencer.c                | 44 ++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  2 ++
 4 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index ca1ebb2..821058d 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -11,15 +11,19 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int keep_empty = 0;
 	enum {
-		CONTINUE = 1, ABORT
+		CONTINUE = 1, ABORT, MAKE_SCRIPT
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
+		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
 				ABORT),
+		OPT_CMDMODE(0, "make-script", &command,
+			N_("make rebase script"), MAKE_SCRIPT),
 		OPT_END()
 	};
 
@@ -36,5 +40,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
+	if (command == MAKE_SCRIPT && argc > 1)
+		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 022766b..01c9fec 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -775,6 +775,7 @@ collapse_todo_ids() {
 # each log message will be re-retrieved in order to normalize the
 # autosquash arrangement
 rearrange_squash () {
+	format=$(git config --get rebase.instructionFormat)
 	# extract fixup!/squash! lines and resolve any referenced sha1's
 	while read -r pick sha1 message
 	do
@@ -1203,26 +1204,27 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-format=$(git config --get rebase.instructionFormat)
-# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
-git rev-list $merges_option --format="%m%H ${format:-%s}" \
-	--reverse --left-right --topo-order \
-	$revisions ${restrict_revision+^$restrict_revision} | \
-	sed -n "s/^>//p" |
-while read -r sha1 rest
-do
-
-	if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
-	then
-		comment_out="$comment_char "
-	else
-		comment_out=
-	fi
+if test t != "$preserve_merges"
+then
+	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		$revisions ${restrict_revision+^$restrict_revision} >"$todo"
+else
+	format=$(git config --get rebase.instructionFormat)
+	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+	git rev-list $merges_option --format="%m%H ${format:-%s}" \
+		--reverse --left-right --topo-order \
+		$revisions ${restrict_revision+^$restrict_revision} | \
+		sed -n "s/^>//p" |
+	while read -r sha1 rest
+	do
+
+		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
+		then
+			comment_out="$comment_char "
+		else
+			comment_out=
+		fi
 
-	if test t != "$preserve_merges"
-	then
-		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
-	else
 		if test -z "$rebase_root"
 		then
 			preserve=t
@@ -1241,8 +1243,8 @@ do
 			touch "$rewritten"/$sha1
 			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
 		fi
-	fi
-done
+	done
+fi
 
 # Watch for commits that been dropped by --cherry-pick
 if test t = "$preserve_merges"
diff --git a/sequencer.c b/sequencer.c
index c0c6661..43e078a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2347,3 +2347,47 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 
 	strbuf_release(&sob);
 }
+
+int sequencer_make_script(int keep_empty, FILE *out,
+		int argc, const char **argv)
+{
+	char *format = "%s";
+	struct pretty_print_context pp = {0};
+	struct strbuf buf = STRBUF_INIT;
+	struct rev_info revs;
+	struct commit *commit;
+
+	init_revisions(&revs, NULL);
+	revs.verbose_header = 1;
+	revs.max_parents = 1;
+	revs.cherry_pick = 1;
+	revs.limited = 1;
+	revs.reverse = 1;
+	revs.right_only = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+
+	revs.pretty_given = 1;
+	git_config_get_string("rebase.instructionFormat", &format);
+	get_commit_format(format, &revs);
+	pp.fmt = revs.commit_format;
+	pp.output_encoding = get_log_output_encoding();
+
+	if (setup_revisions(argc, argv, &revs, NULL) > 1)
+		return error("make_script: unhandled options");
+
+	if (prepare_revision_walk(&revs) < 0)
+		return error("make_script: error preparing revisions");
+
+	while ((commit = get_revision(&revs))) {
+		strbuf_reset(&buf);
+		if (!keep_empty && is_original_commit_empty(commit))
+			strbuf_addf(&buf, "%c ", comment_line_char);
+		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
+		pretty_print_commit(&pp, commit, &buf);
+		strbuf_addch(&buf, '\n');
+		fputs(buf.buf, out);
+	}
+	strbuf_release(&buf);
+	return 0;
+}
diff --git a/sequencer.h b/sequencer.h
index fd2a719..bc524be 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -58,6 +58,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 			  int allow_empty, int edit, int amend,
 			  int cleanup_commit_message);
+int sequencer_make_script(int keep_empty, FILE *out,
+		int argc, const char **argv);
 
 extern const char sign_off_header[];
 
-- 
2.9.3.windows.3



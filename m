Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D7920282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbdFNNHT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:07:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:51209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbdFNNHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:07:18 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3RVA-1dcvsb3jH6-00qyv5; Wed, 14
 Jun 2017 15:07:10 +0200
Date:   Wed, 14 Jun 2017 15:07:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 02/10] rebase -i: generate the script via rebase--helper
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <7cdf532fe2d1798a5371dcbb07ee13857f161c3a.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r3Fgezcv2QMXzBgPF/7HZIyWCNLkMcBLet25Mvv+wGXjKuhMjXa
 ZyNQRKRIdaTJIwpViYeks6tSf30aATg03H867xP3A4tt1jdt9C8vsvQyF3VJKW0cXUULcWd
 Uw45d0gqj6R+dh6oXyov9hHIsmp/rfKHjwKWVoEpk9VGHBazDTDTUZ6910u5u8CCylVV1A+
 XlggGe2OP291ldNcL7ICA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vx1pTgJPIMM=:Cy8Ny2IHz2j82a5BQ88uQZ
 gd4xtSEwf1Sm9ph9z5ewpubUvGV7VT8fzxmgi79nIwIyf4yJTjjNFea345xYOSZO9s0TmiTGH
 rkk12Ly1kipgnWEjgV9Rsl7+A837pQ0sx1zMEbRMyyktAOGDG5Ee+i+skYnE8kMTSJ4lRvq2J
 OwNNRncZt8/B8uzcfglfVl6jPm67dD7q5ErBTXBcpESxb1IbtmpRJ51GIgT0DNdZQYDFFqRYm
 ReCoAkiCiKkB5OCPjwZ1xqGEqPT4lXo7QBokhDqkYiOunpXDEusUhmhqEz/E6wqn3lbYPKfh3
 aMioD7H8Iqo12msF7xuK1+h5k4CgovQd8IsZX69TPezfyW7ztNooyNd3jgi2vRrqvA0vDVAtO
 TSzvfKfa99fxBRV0572DbwrV93tbUFzoTcuha060mHsNH6Qo6yMHQxpHnZuJXiU7wF97bDHJy
 R7Y8UjmaTx2EM0/B420Nc+PzGOnpDf0ezpTeL6S9HQY0cdMnV+/LrQpK4NUlKSvlaNxt+Ofzc
 NC2awClnaOGj52yn00wSuMXf5v7ueHKAx7UsK9c6TstgFH9OG5q9I1wDl3RzSA76lTdRFfTXz
 W3qvuV4eW1QO4MsXAKGt4KNY4fe3z3Px2noBF6U3o/NbdhuMuZT8UzKw+8YDfnPn78oLId+gM
 zE8Hzoryy6ZCgE+m6eOcT1CPrJBcREVTEuQlbGei/xhUMhoQncESwb1XN0IzknlTeN/2Vfvh3
 pjIP0HSU/yy5OOJDSQ+d2kdrzyj9Z7TAm74kXo6nx/F4ch8jSxx68orNsS+DDhYdrOCfj3Oeg
 MEidsf3
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
 git-rebase--interactive.sh | 44 +++++++++++++++++++++--------------------
 sequencer.c                | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index ca1ebb2fa18..821058d452d 100644
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
index 90b1fbe9cf6..05766835de1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -785,6 +785,7 @@ collapse_todo_ids() {
 # each log message will be re-retrieved in order to normalize the
 # autosquash arrangement
 rearrange_squash () {
+	format=$(git config --get rebase.instructionFormat)
 	# extract fixup!/squash! lines and resolve any referenced sha1's
 	while read -r pick sha1 message
 	do
@@ -1210,26 +1211,27 @@ else
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
@@ -1248,8 +1250,8 @@ do
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
index 5282fb849c5..133d9aa7c74 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2412,3 +2412,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 
 	strbuf_release(&sob);
 }
+
+int sequencer_make_script(int keep_empty, FILE *out,
+		int argc, const char **argv)
+{
+	char *format = NULL;
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
+	if (!format || !*format) {
+		free(format);
+		format = xstrdup("%s");
+	}
+	get_commit_format(format, &revs);
+	free(format);
+	pp.fmt = revs.commit_format;
+	pp.output_encoding = get_log_output_encoding();
+
+	if (setup_revisions(argc, argv, &revs, NULL) > 1)
+		return error(_("make_script: unhandled options"));
+
+	if (prepare_revision_walk(&revs) < 0)
+		return error(_("make_script: error preparing revisions"));
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
index f885b68395f..83f2943b7a9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,6 +45,9 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
+int sequencer_make_script(int keep_empty, FILE *out,
+		int argc, const char **argv);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.13.1.windows.1.1.ga36e14b3aaa



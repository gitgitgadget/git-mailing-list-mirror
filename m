Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769E5207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954321AbdDZL73 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:59:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:53459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949826AbdDZL71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:59:27 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYcJi-1dYoWO2xlq-00VS1y; Wed, 26
 Apr 2017 13:59:14 +0200
Date:   Wed, 26 Apr 2017 13:59:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cOu4M1u5NleoCWIhGAldMRu1JwqMgaVvc3SLNQzF+d6l7mV1r7o
 oYQwylOG+MpsiXswzmrRs5tQaARIerU7xZMaoHkOWlzh4cc9PTANcaX2RVXtB+cNpoB/8+x
 00DxKQc/YDj4MDTtnc1F4FxFY+CInERv/oTDGPklm+2Lr7zVz6J+5yo+Rp47qKgrETT7wq4
 YC08jryo3uDYRdZO/1Igg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YOA//CJl7Vg=:35mUW+5AGzBS5ogP2E46/r
 hPu0YJFF0dwScyioXvYcrN7RHL1yPtE54hzcRTNgSKOcP6M9KNupyAETX+y9ZcFIYNBW/dK/o
 QDwS4ein1Cbt16ifPoDAWqzFIlH1SdN+gvEl5ULCMUfJ/GANgBn76Vbpy5FZH03XERN23heVz
 HgibsOkqjMMpoddJIsqBi9ueJdu1FnAU7BqbbNb0CIDO93dcmho4R6sfwYQ4v6ouCVHkwSPp3
 jYW9gIlrwpY4CcGsNpqxxl9P0NJSGNr+81YDKe/TMdeniwsLDV4ajY+QPsIOasLrZcZNLEBqy
 05yCVp9w5dP24rHQm2y4Z0DmN5Tta6B+hIqmol7t3cyZOC0dOJ89U1MmYTkkioioOWVHUIiEX
 t5PuhQWUk8nbLYewNqrF45PCTEF6Pv9maRINVZzBQFEqWxaNN2dBsEbu9ZZOFJ9qoVl8K3HUD
 WKDProfwgZTkE89T8UgU89Bbnn/Mmbqc+5FjkTqizySqBHl8ufUT1HWANda/pBSdySTAxdbVN
 L4CBZNXvoMndMkcFzdKdjO6ru6kqIhaOlRkRnPcPjoIeH51nAqY3JL2T4WGLb1vDPWc7X0GXY
 2CLua5Szk+RNt8bkgI/4+0vZyjM1Xx8JwsZ5Atlou8rwYHnSC/7o5dGyeJxu/s6Kn502B2Y2v
 dWHp9cXVoRxUUA4bGQUKU+C/VZFVHG3xoqU5+NqYyx1EuYeL9n2wOznbNLGB33KPYCV9F0OIy
 5GzhPMfPsA4FRJiCiT15Gu0N1NDaFvMzms013rZyaOr1WnNdelS7SjoeOdjLy9vnUSbLKeg1f
 6aAPT4n
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
 sequencer.c                | 45 +++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 78 insertions(+), 22 deletions(-)

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
index 2c9c0165b5a..609e150d38f 100644
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
index 77afecaebf0..e858a976279 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2388,3 +2388,48 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 
 	strbuf_release(&sob);
 }
+
+int sequencer_make_script(int keep_empty, FILE *out,
+		int argc, const char **argv)
+{
+	char *format = xstrdup("%s");
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
2.12.2.windows.2.406.gd14a8f8640f



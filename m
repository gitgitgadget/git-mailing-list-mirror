Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632FB20282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbdFNNIX (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:08:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:63670 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752106AbdFNNIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:08:21 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1e4KCb0ClI-00jHAr; Wed, 14
 Jun 2017 15:08:09 +0200
Date:   Wed, 14 Jun 2017 15:08:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SGm5PNLvONBsl2usB+647jDP10C1Gxn/WIrBm2FKKk90OwfjkMO
 KqscIh6MJb2sLM0ySg3LjcInJ2MbgT+0xbX3ElTjkGmAqmrqXJoqwtLNZRvRj/qsRK6FpGs
 3np7Rdwk5oifprfbVEsuXo+G+K5/yjMBbTZ3UuU1U2pKQiOvv36Vk85j9vchqWEFs9hkhJa
 12VL6CAj53+4P5SiAO3kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2m8aWoO82Xo=:1xBTp0+oCyL3lyhthuCuJh
 esB1obFkTy6obmcQRCZ84N+aMJqle+1MdIv7fYASs828QGMIkUU3eq+3BBa61GepLJYoxnRxd
 6XLBzlmumueMId6WyLZ5UkpG9nKPMRPLH9WGkXQzaeoQRzIUuvlNTnZG+bJwzkltesZbtdUP3
 fHKn1m4YNPRpAXZfIFwDXkC1FGx6zGCBO2IbhkoHBY94vbHb2v2xjRcNwfxJ9zef1RlF2B2G+
 OyR+J3aLnLM4Dm6T82JDujIutRJ5pJNgCBf0jyWB6FHRroHg3gMMsx9gKGBibuBriapm4L+pW
 2blKt4+VNg0i3D8ard8TMQ2dwH/y+syazVXqPH/TvLLSWsY5TFhG9VnPx76zgp1ATPFQI+cW4
 QHT42rnlJhns7TNfmtignc4teWN6LQzN5bQCvcJASsE4/k7baVn3iYOZNcDJ5t6+onTLKvc7P
 mBTBDkHxwaLtjmbGXopyefKoUB7KV7A1FcxSyXprFhCPylSn23zPObZpBk/HL7ajOkHdO7BGu
 oI2RHw6zouiStw54k8Co/6wQnxSpcKMf22gaE0AtNiYgjgJ+fqFjPHcWAI1IQBg/XpkuMYtug
 3zr959mwnsLKASRuChAk5uukrpDcGy2Byby1xspzw1Zqw0KHSO3KLvb4Qzm+ygBTcHoJ/G26I
 goytQ4E9TvpfAJ2ZmGcMJVSnamXSVrKzYoVQXDY9xivyDfb7s8H6WFIGuVXMIvYJVGf/XcKze
 oQBcDkB6X4eATS7+3MX6d5RlOLFUGqBOrupz/6OuLgyXBTd8bxA9FFOdVfRixlluZCkF8TZA4
 ooLZuQa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular on Windows, where shell scripts are even more expensive
than on MacOSX or Linux, it makes sense to move a loop that forks
Git at least once for every line in the todo list into a builtin.

Note: The original code did not try to skip unnecessary picks of root
commits but punts instead (probably --root was not considered common
enough of a use case to bother optimizing). We do the same, for now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c   |   6 ++-
 git-rebase--interactive.sh |  41 ++---------------
 sequencer.c                | 107 +++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |   1 +
 4 files changed, 116 insertions(+), 39 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 0deba9d1945..fdc933dc64a 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -14,7 +14,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	int keep_empty = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
-		CHECK_TODO_LIST
+		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -31,6 +31,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),
 		OPT_CMDMODE(0, "check-todo-list", &command,
 			N_("check the todo list"), CHECK_TODO_LIST),
+		OPT_CMDMODE(0, "skip-unnecessary-picks", &command,
+			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
 		OPT_END()
 	};
 
@@ -55,5 +57,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todo_ids(0);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
+	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
+		return !!skip_unnecessary_picks();
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c8cad318fa4..af8d7bd77fb 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -713,43 +713,6 @@ do_rest () {
 	done
 }
 
-# skip picking commits whose parents are unchanged
-skip_unnecessary_picks () {
-	fd=3
-	while read -r command rest
-	do
-		# fd=3 means we skip the command
-		case "$fd,$command" in
-		3,pick|3,p)
-			# pick a commit whose parent is current $onto -> skip
-			sha1=${rest%% *}
-			case "$(git rev-parse --verify --quiet "$sha1"^)" in
-			"$onto"*)
-				onto=$sha1
-				;;
-			*)
-				fd=1
-				;;
-			esac
-			;;
-		3,"$comment_char"*|3,)
-			# copy comments
-			;;
-		*)
-			fd=1
-			;;
-		esac
-		printf '%s\n' "$command${rest:+ }$rest" >&$fd
-	done <"$todo" >"$todo.new" 3>>"$done" &&
-	mv -f "$todo".new "$todo" &&
-	case "$(peek_next_command)" in
-	squash|s|fixup|f)
-		record_in_rewritten "$onto"
-		;;
-	esac ||
-		die "$(gettext "Could not skip unnecessary pick commands")"
-}
-
 expand_todo_ids() {
 	git rebase--helper --expand-ids
 }
@@ -1149,7 +1112,9 @@ git rebase--helper --check-todo-list || {
 
 expand_todo_ids
 
-test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
+test -d "$rewritten" || test -n "$force_rebase" ||
+onto="$(git rebase--helper --skip-unnecessary-picks)" ||
+die "Could not skip unnecessary pick commands"
 
 checkout_onto
 if test -z "$rebase_root" && test ! -d "$rewritten"
diff --git a/sequencer.c b/sequencer.c
index a697906d463..a0e020dab09 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2640,3 +2640,110 @@ int check_todo_list(void)
 
 	return res;
 }
+
+/* skip picking commits whose parents are unchanged */
+int skip_unnecessary_picks(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct strbuf buf = STRBUF_INIT;
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
+	int fd, i;
+
+	if (!read_oneliner(&buf, rebase_path_onto(), 0))
+		return error(_("could not read 'onto'"));
+	if (get_sha1(buf.buf, onto_oid.hash)) {
+		strbuf_release(&buf);
+		return error(_("need a HEAD to fixup"));
+	}
+	strbuf_release(&buf);
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0) {
+		return error_errno(_("could not open '%s'"), todo_file);
+	}
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("could not read '%s'."), todo_file);
+	}
+	close(fd);
+	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+		todo_list_release(&todo_list);
+		return -1;
+	}
+
+	for (i = 0; i < todo_list.nr; i++) {
+		struct todo_item *item = todo_list.items + i;
+
+		if (item->command >= TODO_NOOP)
+			continue;
+		if (item->command != TODO_PICK)
+			break;
+		if (parse_commit(item->commit)) {
+			todo_list_release(&todo_list);
+			return error(_("could not parse commit '%s'"),
+				oid_to_hex(&item->commit->object.oid));
+		}
+		if (!item->commit->parents)
+			break; /* root commit */
+		if (item->commit->parents->next)
+			break; /* merge commit */
+		parent_oid = &item->commit->parents->item->object.oid;
+		if (hashcmp(parent_oid->hash, oid->hash))
+			break;
+		oid = &item->commit->object.oid;
+	}
+	if (i > 0) {
+		int offset = i < todo_list.nr ?
+			todo_list.items[i].offset_in_buf : todo_list.buf.len;
+		const char *done_path = rebase_path_done();
+
+		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
+		if (fd < 0) {
+			error_errno(_("could not open '%s' for writing"),
+				    done_path);
+			todo_list_release(&todo_list);
+			return -1;
+		}
+		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
+			error_errno(_("could not write to '%s'"), done_path);
+			todo_list_release(&todo_list);
+			close(fd);
+			return -1;
+		}
+		close(fd);
+
+		fd = open(rebase_path_todo(), O_WRONLY, 0666);
+		if (fd < 0) {
+			error_errno(_("could not open '%s' for writing"),
+				    rebase_path_todo());
+			todo_list_release(&todo_list);
+			return -1;
+		}
+		if (write_in_full(fd, todo_list.buf.buf + offset,
+				todo_list.buf.len - offset) < 0) {
+			error_errno(_("could not write to '%s'"),
+				    rebase_path_todo());
+			close(fd);
+			todo_list_release(&todo_list);
+			return -1;
+		}
+		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
+			error_errno(_("could not truncate '%s'"),
+				    rebase_path_todo());
+			todo_list_release(&todo_list);
+			close(fd);
+			return -1;
+		}
+		close(fd);
+
+		todo_list.current = i;
+		if (is_fixup(peek_command(&todo_list, 0)))
+			record_in_rewritten(oid, peek_command(&todo_list, 0));
+	}
+
+	todo_list_release(&todo_list);
+	printf("%s\n", oid_to_hex(oid));
+
+	return 0;
+}
diff --git a/sequencer.h b/sequencer.h
index 878dd296f8c..04a57e09a1d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,6 +50,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 
 int transform_todo_ids(int shorten_ids);
 int check_todo_list(void);
+int skip_unnecessary_picks(void);
 
 extern const char sign_off_header[];
 
-- 
2.13.1.windows.1.1.ga36e14b3aaa



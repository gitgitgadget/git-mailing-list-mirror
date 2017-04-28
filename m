Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A168C207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2992748AbdD1VdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:33:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:64786 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2992569AbdD1VdB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:33:01 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEFlg-1dJZb11kts-00FPf3; Fri, 28
 Apr 2017 23:32:51 +0200
Date:   Fri, 28 Apr 2017 23:32:49 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <3da0bb88f6a4c34d36d457d4118082f7ac6cfbc6.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cwRVqb4fPCKGYm2OgEkRcsfFsxhyz8EgPtMSMBMHwq7Gsh6xTpM
 Lw0RdHa70mzaWKJ38llwabp+UHHdotoBJ0y4gQCxWOd+/IJUUu/oXC/2GU8YK1tfUn6uFSZ
 wlhDaA1Iwz2D9gD2/1kqMi5swMSHb/tJgWABuGtqvO+zVCbFDjsxG7Ya5/Xg5eac516Psxl
 niJN3knL4k3joixaFMoRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QdpuQ4JTxFE=:EiRSJdk/CaMxkg+AXYNJtf
 IsmfoDirK94u9CpWE2fZF86/ej1INLEp/snAq8AHCQXa6e4Tw01zfYHRi2a4pyAuBiUprHg8X
 BYcIO9JrqkrLDrs6tdj4dYLaDH7xUhTqlP1BGaLEhLMXCLMqEsf2glYc/y5OcNNY2iRfTlxV0
 kVOUBo9mbc/yhTnk/MnYB43bNytkVBRIysL4oi89Nedu6bXT9KkqAdHwFlLFGaCEU12Xa76Lh
 fWPsEA3vQQchKXt37o+5BPa72lfZvBW9Ur0bt8sEQRbPMYzMwmVk+vm37yvAZr9B8Jn4R62Va
 E42b3ZS1UHtz38BLXZCujBwqcu5olKQF4D6bp/HwIyP+71j+RY5ossdOu9yjF4gtaFoqPG8Fx
 9eOB1YZOZqJ33vmlmG5o3BcNiFwQIF5q4lTR0niQFolLWgyGsGV86ZZO4+DBshZ9/GnST9Riz
 GILOHj3P+z4XS/3zfJuugXQUkJ/LxB6C3d+0OcF9C5OaHJsl3A1LDMzJADkPxvzYLerXjQPsk
 jf9Z+qdJNv7ynLQUCpJasYeEJQ872rOzmEUsavm9AYeGc6DTea1tFAV8FtIyZp/YsVKIcSxQm
 AQZ8NwyUq3F522CI1LEd9qfQAH6d2rQRFnXswAgTbyYkOadEJqO7CD2EVXxKcey7mUMXFdXlz
 PlwOZfwy9ggGCdRsNltoXcQ/K/ttbFI9CWAWdi5Bhy2pyDKg2VAoJ/A/vGMhyJ2L7ObJv+AxA
 A8pVUuwcMicSQ761mneWgoq7NrmMiYBldZKJ5SB3h1yGrr1Sm7hywgxgxTaMPhd6oMdMBslyp
 WX1KloJ
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
index e706eac710d..de3ccd9bfbc 100644
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
index 08168a0d46b..92e3ca1de3b 100644
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
 	git rebase--helper --expand-sha1s
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
index 4535ba9d12f..72e3ad8d145 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2616,3 +2616,110 @@ int check_todo_list(void)
 
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
index 4978a61b83b..28e1fc1e9bb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,6 +50,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 
 int transform_todo_ids(int shorten_sha1s);
 int check_todo_list(void);
+int skip_unnecessary_picks(void);
 
 extern const char sign_off_header[];
 
-- 
2.12.2.windows.2.800.gede8f145e06



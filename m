Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DC5207EC
	for <e@80x24.org>; Tue, 25 Apr 2017 13:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431388AbdDYNws (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:52:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:49562 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1431366AbdDYNwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:52:47 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhba-1clzKW3im6-00H4u7; Tue, 25
 Apr 2017 15:52:10 +0200
Date:   Tue, 25 Apr 2017 15:52:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 7/9] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <ecab086a62e96388f4dfc7e36a679821fdc7c8c3.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:99RVyIqJMQctCUhGUNe0NAh5Gr4MJZWc7MeT/gfl3ji0uoOYK7p
 OAAl7pY/B9aB5aE9RJ7d6cP8Xn+6TO1+BKaOO/CN6hTR1dFKkBzK/d5/1etFdncm44rJl5q
 UQicUx2pFYqgeIfjyxXdezPveRNFcxcaUuVdvjzy+mPv7JSOiR82o4h0fX3GoBFZ3AEgCPk
 6eDnrI0r5Q5xjo0ffInUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4aLZjI/JUSs=:9umbE5ufXYoUqhXFJZihKs
 mdEX8uWI7y3Ur40YraarJcGAY30ZsSGlV3TbuMdIM2qMYdQsbff3DhHOg/rZOb327GikGe0og
 XbX2t78UgHL8eOOgyAJBYgjCXqViu0xdiVvf9XjZke1+WgngAouM+zGiigg8ErGm9x3Idu2nx
 lZaOLX+kvQNjBqJa8ax4+FxEe+kmGvCUO+aCpYOi3IvPPWQglI4WI1sHZY0e1aqjDCXetcCVQ
 xF/Js5pgMGo6mCR8hUau/z7AS6ZtbdzLolL2bpCGUqCgybe9xcLuytgSvYyQcZBPFcUMZw9ot
 0Ghhad9XtIkaEoqtRwwIIU5XnOeWHXCfxgwWx87c5KVzrdQ9CN5yil3k2ilGNbLOLS/0PRtdd
 Bb8xAtef9dlYYnDLD6u+azuZXctInv5/2QPVJtBTYERPoNIET1WlIjcvvARNyWOR3XPpBeO5H
 MKwjOP4QqX2zfiYWTwQHhciW3tjASGeXzWV+c22irVRHFGrrhQI9bMahoMPUwcVxnjUx4vdR4
 Z5dIGFAknze0RLyXUshAyBx4cJ8TuZMsF6LqNbExxh+2tgqY0B/M4Z/ylSriQItuJWYqZoWSl
 OqqIYa5ks3MiPYLYW6lo8qiAvBJoEzFdXf1Z8W1Rzrufv0zKRjKqybSmA2OxHebt/L+EeY2CY
 aDV6+TiMdlktkDj0qip37fE0o4bjHbqFqL1jqcDcRuH47cR6XyOJ95qpYzqDMfaSlogntX5GO
 Q0At8CeedE41L6xAvw/WY4N7I0dxxDUKjV3+ybiC/wuc6wVFTYKMpvN7xWGTxEBUqyfB87gg5
 jZIHdFj
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
 builtin/rebase--helper.c   |  6 +++-
 git-rebase--interactive.sh | 41 ++-------------------
 sequencer.c                | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 99 insertions(+), 39 deletions(-)

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
index 1649506e1e4..931bc09e0cf 100644
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
 transform_todo_ids () {
 	while read -r command rest
 	do
@@ -1172,7 +1135,9 @@ git rebase--helper --check-todo-list || {
 
 expand_todo_ids
 
-test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
+test -d "$rewritten" || test -n "$force_rebase" ||
+onto="$(git rebase--helper --skip-unnecessary-picks)" ||
+die "Could not skip unnecessary pick commands"
 
 checkout_onto
 if test -z "$rebase_root" && test ! -d "$rewritten"
diff --git a/sequencer.c b/sequencer.c
index 3a935fa4cbc..bbbc98c9116 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2616,3 +2616,93 @@ int check_todo_list(void)
 
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
+		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
+			todo_list_release(&todo_list);
+			return error_errno(_("could not write to '%s'"),
+				done_path);
+		}
+		close(fd);
+
+		fd = open(rebase_path_todo(), O_WRONLY, 0666);
+		if (write_in_full(fd, todo_list.buf.buf + offset,
+				todo_list.buf.len - offset) < 0) {
+			todo_list_release(&todo_list);
+			return error_errno(_("could not write to '%s'"),
+				rebase_path_todo());
+		}
+		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
+			todo_list_release(&todo_list);
+			return error_errno(_("could not truncate '%s'"),
+				rebase_path_todo());
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
2.12.2.windows.2.406.gd14a8f8640f



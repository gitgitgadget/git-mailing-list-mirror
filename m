Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772EA1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbcIBQXt (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:59168 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcIBQXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lq9se-1bAwHo2qWG-00dkHL; Fri, 02 Sep 2016 18:23:36
 +0200
Date:   Fri, 2 Sep 2016 18:23:35 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <a9e6611f0137efac719766fc3295ead4d8567c20.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:En73Nrsrp7bob6sBKkoAdLshJIBDiiw2ZuRXoFztwtSX/W89Cel
 3+MORNFHJ8Qj0AQwbrjF38VTVRJRQ40wEbGCOdtXwqqEfhZBX9lvseh/fqK4k3STBuJbwHm
 DkLHSCznzpBSIXmajMu+zwcJTqQlx2hskpGbEpQ8lxjLY0SIdClTdI2HG9FGuxPbsa10gk3
 yeSpT6pRHCCYXr21DYGdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:21bB6AlqgWM=:qEFJS9sAhijpbKHgpuq2r9
 /5D0QJQf6BHZ1Btj+17MdJ7dNbLkAo1DC/I5SusEfOV8sG0I/ZXjgYjSUjtlHtfRlVMQ1jc6L
 JKH3IOjavEsgZgbIpuAKB/vq358issI2dGrtCVJNibI9No6ECBID4qzvrz2fx2gePyVUHSXBZ
 ffM6vv59/WAiZaoq10Y8MFo/wetEJtQHXCX/78TKzQLo0XFr8GOxFu4I3QB541vQFtjBAZcn6
 0L/lZaLts87iEosBd8sQEMrDD4ZFP0uSRqAFUce2hLdGseNnP0yXT83V29KUqB+ssxZxEsqe1
 43aPDwXP5ghZ2szFLy1jjJB7Nlaf11u/35svQNQoja/qBfly6jQK2IKMiXn8Ev5mkW+DxHeUY
 00PoRP8enFODrfjMpjce1YCAjb85RLOdw9V1Z6GvY87nUFUqnEXS2zF+ndybW3flTq1btkqQs
 uhbkEgVfo031s+IHlgh6MOG6eIHT3Cgzb59HKBg82XJ/WyOxvdv+kx67O3Q6qrztgCZaSiltB
 vYDi6xYROnHtmarj9J7XEaUgRO4+akVfF47YJUs6mYMUuM4/9VgJJhNroRiGS8fgFWf/vq9JU
 hU9NZiyLym0fxWrrYI/m9jB8sidZCVSuLcaTnOcwUhK+QVY4YM+Fb3aVVwF975+sDopkaps8c
 3I1tSo5RJrLP06cXDL/9+Iv9kQ6xz+ZDy1CNb1kpxV9/Uw4L4OXaO1yDSkAjiUdOoR8lYI8Qa
 gZOE3BCkFKB8bTwzEnBuVGQUDVU/lgBnV3p4yDurI54bdb2Rt73gnIPm7xo4VqdhXr4131ABC
 PhhXock
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
index e706eac..de3ccd9 100644
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
index 02a7698..a34ebdc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -703,43 +703,6 @@ do_rest () {
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
@@ -1165,7 +1128,9 @@ git rebase--helper --check-todo-list || {
 
 expand_todo_ids
 
-test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
+test -d "$rewritten" || test -n "$force_rebase" ||
+onto="$(git rebase--helper --skip-unnecessary-picks)" ||
+die "Could not skip unnecessary pick commands"
 
 checkout_onto
 if test -z "$rebase_root" && test ! -d "$rewritten"
diff --git a/sequencer.c b/sequencer.c
index 0c82925..6cc94c9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2574,3 +2574,93 @@ int check_todo_list(void)
 
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
+		return error("Could not read 'onto'");
+	if (get_sha1(buf.buf, onto_oid.hash)) {
+		strbuf_release(&buf);
+		return error("Need a HEAD to fixup");
+	}
+	strbuf_release(&buf);
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0) {
+		return error_errno(_("Could not open '%s'"), todo_file);
+	}
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("Could not read '%s'."), todo_file);
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
+			return error(_("Could not parse commit '%s'"),
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
+			return error_errno(_("Could not write to '%s'"),
+				done_path);
+		}
+		close(fd);
+
+		fd = open(rebase_path_todo(), O_WRONLY, 0666);
+		if (write_in_full(fd, todo_list.buf.buf + offset,
+				todo_list.buf.len - offset) < 0) {
+			todo_list_release(&todo_list);
+			return error_errno(_("Could not write to '%s'"),
+				rebase_path_todo());
+		}
+		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
+			todo_list_release(&todo_list);
+			return error_errno(_("Could not truncate '%s'"),
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
index 8e3daf9..4da215c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -63,6 +63,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 
 int transform_todo_ids(int shorten_sha1s);
 int check_todo_list(void);
+int skip_unnecessary_picks(void);
 
 extern const char sign_off_header[];
 
-- 
2.9.3.windows.3



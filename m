Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55636207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999334AbdDZMAa (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 08:00:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:58667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2999140AbdDZMA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 08:00:28 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1W5x-1dwXXQ3tvt-00tXmp; Wed, 26
 Apr 2017 14:00:22 +0200
Date:   Wed, 26 Apr 2017 14:00:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 7/9] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <1a5e609efb3b464e6350927df90c8d7d30d6b97b.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yjZSnPUjKUI4/8IcDXoQNVoBYWSuCW91vQRaUIZqRVxbNR1XtTK
 dv17Z64kaSNXR2q6PNhjCAX/UWkC3S1sKPKKHt14e+vIDMVN7/2+h6LVZQEfyiQ9FrHS3SW
 FquLFKZNE6irX6C0rA9m3Vr1lq6msiSHtb/Cy3IL2pnxkkRxmHLEPVlj9YQgpn7HPMmRxZx
 ShbWJJynHFQdONrjWix2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PyScXyj0HY4=:PsRbDjMTzSv9EC/aA0qyDf
 Npwwx1FnjySoq3MpyvGseN/X3DF5lxn5y1NJ1j9qnQqm3A3uyZazHiOKll2qxuPMPrK05576k
 /GdIFc02/P+rgLBLDL+xAuyBmbzyHItske2lhjXsHax1fsj/FDfGBfFekfePqsuFJwSUl/08z
 eXIdDO2iNlcmDh4TNKi6lwrvsGtq+B27k/l+/kdiao039rD9AwAPclJHF5vP8975I9cIwtDRo
 nhFrZsHyC/+L8YXO28edmfhi4L0UQT8qbZp7wXbpclg0KXom3kkEcTW/6EEehSRXyUPD9jfQI
 0pnV6VMohtPWA70BmSYV4+6knbReYoofs6VZFQ6XvNW5UqHKuNfHlhnyDQoMFESYsVDr1Y6r2
 YYGKPEDa1gV5jM47IAff3jiimnyOxRvXo488twsTVezz8tZn514didw/1tGdMvWmWcuXdf3fo
 SvILp3u9JAaQkkRjgiXVsV9yvX4KB0vdUgaB/puGtO8O/4AE6n5dsXmYY1j0Yo/KDr31Qxf0n
 0KdOYi6BrKP/f6fwUv1SVfdd8ddlJaRkaTmllxDDxhy8sUd5MSHf3cI1+7u8oeUeIo+cpnFbz
 BvKJ/L4b6du3DNZJng2dtwgLd2A/Q9RQum1owKtHtmqt9B9H5U/le9eC7WgupUfK+mM6Tmc5T
 4q154SvSEJl1PTCSiSo0j9ZElZD/Qac73UEagLnvmv40M0wJ/4WGX8Nxfw/2BtDxBaxHMVgKE
 hZFDwimZ/Fo4mbqLOXYC+ZPBkizYAxpqjCrxYa/Azbg0PcQvlsbsPbxiPNPqPRGwxOIMRxTfZ
 FLKXmKa
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
index fb3915ee39e..b51faa0120f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2617,3 +2617,110 @@ int check_todo_list(void)
 
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
2.12.2.windows.2.406.gd14a8f8640f



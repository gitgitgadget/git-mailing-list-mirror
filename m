Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139731FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbcIBQYC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:24:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:53058 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcIBQYB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:24:01 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LejNC-1bJ9l42R9q-00qOo5; Fri, 02 Sep 2016 18:23:56
 +0200
Date:   Fri, 2 Sep 2016 18:23:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] rebase -i: rearrange fixup/squash lines using the
 rebase--helper
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <3810bd4bddb3b850a78e5d960207157de64a2e56.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jYvll+fX4quD2TSYIh9nkiXTbHjlpaIcW9IUsUP7cb2EHBYlUSy
 8SXGUyAvxLqdI+OBqdtBLO4lYSNLdTJcaZ2HwH4aC21+Ce/PE6x/dA/cGvTJO0t04g2O6T4
 7mspWWHDTApWUflGSiXpgQF98tuH1mmIYDm9bMsVrPoz+GXufUY8UVVfV5/WyEVl+Na/JnG
 YsCGumS29dRkMpxWyhCVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:muDT4yyimCU=:pkGfdlpm8TZiekKt7kZA+o
 Q2nbLw0ChSHBrN2g4yMdL01wM+7/a5jFh1GUzWIgvmlmTzUKQBnbrbnEVV4weIzpvo1myAoof
 sftY7CdTpSRPd/smFxl8tW5DhGDjXIzdtrA6R6E2tedV7iooiQWOHpXVAMKZMLkC0/+u+KT9O
 2wcD6v1R9QpjhWWFHx77kk410mXty1MgxvUv0Ots+5GtgFAUQ9XQDvkGkOEC6mO8/SH8xniRy
 HWsXlM6ZQQjFWAf+2LelWlEEXXnzhpGflQadhP23q9jNom9SMh2YfSymRpGLpX47fJ4BBBKLc
 76QXcHfDP+tfxH7nDOz4+MW+Vql+tTOCiKz3YuRy3mWoCrx1/2Vu/pFtHYtuIZuvPfByIM0dP
 YuafBgavO5sAApRZXEHlTwyhNgmUEIDuVbouyKhWlS8HNrFf/UuZkgtY4VOGuI60tF0Yp86Gm
 Oz7Rx16wRQzoKTVkAI/ToxwrH5lJBaw9xLmaiEMo9XEBYHBlYFDAE5YVxHKW5BPwrtbQhZYAl
 vBlXsAxRYheVpVQBzWlpUlSqNCMEo0M45N4562lfhOa344CcZGZXctPOjcDo9mVo1xFxuUgpC
 W3rc6raFwG/tFWVMi1drpGS/GUryFwDrv82TMUR1KE6M1vUwRCC2EFrMb5XcZptkabXZEOnlV
 +6x5VKf66Qnakm3TBVnM2PF+azaITNUtTee6TWIwKUnyUZdxcEF948fSpoLK05IpKIEA72UmO
 61F03L7NG+4LTw/9Cmbuo4Bd8LHZyCzXFJ1e9OOnnbkph5sw5KWNMZboFd1HjaC6+7cDc3+gW
 fvNE/IZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This operation has quadratic complexity, which is especially painful
on Windows, where shell scripts are *already* slow (mainly due to the
overhead of the POSIX emulation layer).

Let's reimplement this with linear complexity (using a hash map to
match the commits' subject lines) for the common case; Sadly, the
fixup/squash feature's design neglected performance considerations,
allowing arbitrary prefixes (read: `fixup! hell` will match the
commit subject `hello world`), which means that we are stuck with
quadratic performance in the worst case.

The reimplemented logic also happens to fix a bug where commented-out
lines (representing empty patches) were dropped by the previous code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c     |   6 +-
 git-rebase--interactive.sh   |  90 +-------------------
 sequencer.c                  | 197 +++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                  |   1 +
 t/t3415-rebase-autosquash.sh |   2 +-
 5 files changed, 205 insertions(+), 91 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index de3ccd9..e6591f0 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -14,7 +14,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	int keep_empty = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
-		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS
+		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -33,6 +33,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("check the todo list"), CHECK_TODO_LIST),
 		OPT_CMDMODE(0, "skip-unnecessary-picks", &command,
 			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
+		OPT_CMDMODE(0, "rearrange-squash", &command,
+			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_END()
 	};
 
@@ -59,5 +61,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
 		return !!skip_unnecessary_picks();
+	if (command == REARRANGE_SQUASH && argc == 1)
+		return !!rearrange_squash();
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a34ebdc..68a6e6a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -734,94 +734,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-sha1s
 }
 
-# Rearrange the todo list that has both "pick sha1 msg" and
-# "pick sha1 fixup!/squash! msg" appears in it so that the latter
-# comes immediately after the former, and change "pick" to
-# "fixup"/"squash".
-#
-# Note that if the config has specified a custom instruction format
-# each log message will be re-retrieved in order to normalize the
-# autosquash arrangement
-rearrange_squash () {
-	format=$(git config --get rebase.instructionFormat)
-	# extract fixup!/squash! lines and resolve any referenced sha1's
-	while read -r pick sha1 message
-	do
-		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
-		case "$message" in
-		"squash! "*|"fixup! "*)
-			action="${message%%!*}"
-			rest=$message
-			prefix=
-			# skip all squash! or fixup! (but save for later)
-			while :
-			do
-				case "$rest" in
-				"squash! "*|"fixup! "*)
-					prefix="$prefix${rest%%!*},"
-					rest="${rest#*! }"
-					;;
-				*)
-					break
-					;;
-				esac
-			done
-			printf '%s %s %s %s\n' "$sha1" "$action" "$prefix" "$rest"
-			# if it's a single word, try to resolve to a full sha1 and
-			# emit a second copy. This allows us to match on both message
-			# and on sha1 prefix
-			if test "${rest#* }" = "$rest"; then
-				fullsha="$(git rev-parse -q --verify "$rest" 2>/dev/null)"
-				if test -n "$fullsha"; then
-					# prefix the action to uniquely identify this line as
-					# intended for full sha1 match
-					echo "$sha1 +$action $prefix $fullsha"
-				fi
-			fi
-		esac
-	done >"$1.sq" <"$1"
-	test -s "$1.sq" || return
-
-	used=
-	while read -r pick sha1 message
-	do
-		case " $used" in
-		*" $sha1 "*) continue ;;
-		esac
-		printf '%s\n' "$pick $sha1 $message"
-		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
-		used="$used$sha1 "
-		while read -r squash action msg_prefix msg_content
-		do
-			case " $used" in
-			*" $squash "*) continue ;;
-			esac
-			emit=0
-			case "$action" in
-			+*)
-				action="${action#+}"
-				# full sha1 prefix test
-				case "$msg_content" in "$sha1"*) emit=1;; esac ;;
-			*)
-				# message prefix test
-				case "$message" in "$msg_content"*) emit=1;; esac ;;
-			esac
-			if test $emit = 1; then
-				if test -n "${format}"
-				then
-					msg_content=$(git log -n 1 --format="${format}" ${squash})
-				else
-					msg_content="$(echo "$msg_prefix" | sed "s/,/! /g")$msg_content"
-				fi
-				printf '%s\n' "$action $squash $msg_content"
-				used="$used$squash "
-			fi
-		done <"$1.sq"
-	done >"$1.rearranged" <"$1"
-	cat "$1.rearranged" >"$1"
-	rm -f "$1.sq" "$1.rearranged"
-}
-
 # Add commands after a pick or after a squash/fixup serie
 # in the todo list.
 add_exec_commands () {
@@ -1084,7 +996,7 @@ then
 fi
 
 test -s "$todo" || echo noop >> "$todo"
-test -n "$autosquash" && rearrange_squash "$todo"
+test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
 test -n "$cmd" && add_exec_commands "$todo"
 
 todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
diff --git a/sequencer.c b/sequencer.c
index 6cc94c9..4b50a4c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -18,6 +18,7 @@
 #include "quote.h"
 #include "log-tree.h"
 #include "wt-status.h"
+#include "hashmap.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2664,3 +2665,199 @@ int skip_unnecessary_picks(void)
 
 	return 0;
 }
+
+struct subject2item_entry {
+	struct hashmap_entry entry;
+	int i;
+	char subject[FLEX_ARRAY];
+};
+
+static int subject2item_cmp(const struct subject2item_entry *a,
+	const struct subject2item_entry *b, const void *key)
+{
+	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
+}
+
+/*
+ * Rearrange the todo list that has both "pick sha1 msg" and "pick sha1
+ * fixup!/squash! msg" in it so that the latter is put immediately after the
+ * former, and change "pick" to "fixup"/"squash".
+ *
+ * Note that if the config has specified a custom instruction format, each log
+ * message will have to be retrieved from the commit (as the oneline in the
+ * script cannot be trusted) in order to normalize the autosquash arrangement.
+ */
+int rearrange_squash(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct hashmap subject2item;
+	int res = 0, rearranged = 0, *next, *tail, fd, i;
+	char **subjects;
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0)
+		return error_errno(_("Could not open %s"), todo_file);
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("Could not read %s."), todo_file);
+	}
+	close(fd);
+	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+		todo_list_release(&todo_list);
+		return -1;
+	}
+
+	/*
+	 * The hashmap maps onelines to the respective todo list index.
+	 *
+	 * If any items need to be rearranged, the next[i] value will indicate
+	 * which item was moved directly after the i'th.
+	 *
+	 * In that case, last[i] will indicate the index of the latest item to
+	 * be moved to appear after the i'th.
+	 */
+	hashmap_init(&subject2item, (hashmap_cmp_fn) subject2item_cmp,
+		     todo_list.nr);
+	ALLOC_ARRAY(next, todo_list.nr);
+	ALLOC_ARRAY(tail, todo_list.nr);
+	ALLOC_ARRAY(subjects, todo_list.nr);
+	for (i = 0; i < todo_list.nr; i++) {
+		struct strbuf buf = STRBUF_INIT;
+		struct todo_item *item = todo_list.items + i;
+		const char *commit_buffer, *subject, *p;
+		int i2 = -1;
+		struct subject2item_entry *entry;
+
+		next[i] = tail[i] = -1;
+		if (item->command >= TODO_EXEC) {
+			subjects[i] = NULL;
+			continue;
+		}
+
+		if (is_fixup(item->command)) {
+			todo_list_release(&todo_list);
+			return error(_("The script was already rearranged."));
+		}
+
+		item->commit->util = item;
+
+		parse_commit(item->commit);
+		commit_buffer = get_commit_buffer(item->commit, NULL);
+		find_commit_subject(commit_buffer, &subject);
+		format_subject(&buf, subject, " ");
+		subject = subjects[i] = buf.buf;
+		unuse_commit_buffer(item->commit, commit_buffer);
+		if ((skip_prefix(subject, "fixup! ", &p) ||
+		     skip_prefix(subject, "squash! ", &p))) {
+			struct commit *commit2;
+
+			for (;;) {
+				while (isspace(*p))
+					p++;
+				if (!skip_prefix(p, "fixup! ", &p) &&
+				    !skip_prefix(p, "squash! ", &p))
+					break;
+			}
+
+			if ((entry = hashmap_get_from_hash(&subject2item,
+							   strhash(p), p)))
+				/* found by title */
+				i2 = entry->i;
+			else if (!strchr(p, ' ') &&
+				 (commit2 =
+				  lookup_commit_reference_by_name(p)) &&
+				 commit2->util)
+				/* found by commit name */
+				i2 = (struct todo_item *)commit2->util
+					- todo_list.items;
+			else {
+				/* copy can be a prefix of the commit subject */
+				for (i2 = 0; i2 < i; i2++)
+					if (subjects[i2] &&
+					    starts_with(subjects[i2], p))
+						break;
+				if (i2 == i)
+					i2 = -1;
+			}
+		}
+		if (i2 >= 0) {
+			rearranged = 1;
+			todo_list.items[i].command =
+				starts_with(subject, "fixup!") ?
+				TODO_FIXUP : TODO_SQUASH;
+			if (next[i2] < 0)
+				next[i2] = i;
+			else
+				next[tail[i2]] = i;
+			tail[i2] = i;
+		}
+		else if (!hashmap_get_from_hash(&subject2item,
+						strhash(subject), subject)) {
+			FLEX_ALLOC_MEM(entry, subject, buf.buf, buf.len);
+			entry->i = i;
+			hashmap_entry_init(entry, strhash(entry->subject));
+			hashmap_put(&subject2item, entry);
+		}
+		strbuf_detach(&buf, NULL);
+	}
+
+	if (rearranged) {
+		struct strbuf buf = STRBUF_INIT;
+		char *format = NULL;
+
+		git_config_get_string("rebase.instructionFormat", &format);
+		for (i = 0; i < todo_list.nr; i++) {
+			enum todo_command command = todo_list.items[i].command;
+			int cur = i;
+
+			/*
+			 * Initially, all commands are 'pick's. If it is a
+			 * fixup or a squash now, we have rearranged it.
+			 */
+			if (is_fixup(command))
+				continue;
+
+			while (cur >= 0) {
+				int offset = todo_list.items[cur].offset_in_buf;
+				int end_offset = cur + 1 < todo_list.nr ?
+					todo_list.items[cur + 1].offset_in_buf :
+					todo_list.buf.len;
+				char *bol = todo_list.buf.buf + offset;
+				char *eol = todo_list.buf.buf + end_offset;
+
+				/* replace 'pick', by 'fixup' or 'squash' */
+				command = todo_list.items[cur].command;
+				if (is_fixup(command)) {
+					strbuf_addstr(&buf,
+						todo_command_info[command].str);
+					bol += strcspn(bol, " \t");
+				}
+
+				strbuf_add(&buf, bol, eol - bol);
+
+				cur = next[cur];
+			}
+		}
+
+		fd = open(todo_file, O_WRONLY);
+		if (fd < 0)
+			res |= error_errno(_("Could not open %s"), todo_file);
+		else if (write(fd, buf.buf, buf.len) < 0)
+			res |= error_errno(_("Could not read %s."), todo_file);
+		else if (ftruncate(fd, buf.len) < 0)
+			res |= error_errno(_("Could not finish %s"), todo_file);
+		close(fd);
+		strbuf_release(&buf);
+	}
+
+	free(next);
+	free(tail);
+	for (i = 0; i < todo_list.nr; i++)
+		free(subjects[i]);
+	free(subjects);
+	hashmap_free(&subject2item, 1);
+	todo_list_release(&todo_list);
+
+	return res;
+}
diff --git a/sequencer.h b/sequencer.h
index 4da215c..a3aa3cb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -64,6 +64,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 int transform_todo_ids(int shorten_sha1s);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
+int rearrange_squash(void);
 
 extern const char sign_off_header[];
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 9fd629a..b9e2600 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -278,7 +278,7 @@ set_backup_editor () {
 	test_set_editor "$PWD/backup-editor.sh"
 }
 
-test_expect_failure 'autosquash with multiple empty patches' '
+test_expect_success 'autosquash with multiple empty patches' '
 	test_tick &&
 	git commit --allow-empty -m "empty" &&
 	test_tick &&
-- 
2.9.3.windows.3

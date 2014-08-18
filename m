From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 22/27] rebase -i: parse to-do list command line options
Date: Mon, 18 Aug 2014 23:23:05 +0200
Message-ID: <c054086dab6d301d0a02b4440bc047036f305fd6.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUQQ-0000yc-BU
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbaHRVY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:59 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:34114 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbaHRVYV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:21 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so5163587lam.0
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+rzClCBxXCilLL0P6cZk5PGNMab2hYN+VB4LBHjgLas=;
        b=b0tEUc/BKG+r9Yu4MchADmj6ujJ3P1FhzfvW77Vwcc+U+qg7cA7UO+JL+GDts3snwi
         VAK8aDKNUoGZEY9TWn+iga7axcOhW6jmpseNe00sWMILXH+IzxXekGEX9bXw8a0lZler
         95mC9IS3oSsVrMKvEhbI6ROe4gLaAfdjwQpBjen4RFvnRzr1yDKGs8KmzSoBTco2k/G5
         pv9+/RaVOZOtRAlmBT4562ZujS/5iLZvnzNklNBW9rBYYxnQPCRI/cWbmRhGuiypDxKY
         7uBr9mxpxaNA5qq3U8VsIJrXlSpk/L4HhsCmIicjFBNfE2RUW1D9l/FNUGZq47WXFieO
         0FOA==
X-Received: by 10.112.199.42 with SMTP id jh10mr14275810lbc.49.1408397060409;
        Mon, 18 Aug 2014 14:24:20 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255430>

Read in to-do list lines as

    command args

instead of

    command sha1 rest

so that to-do list command lines can specify additional arguments
apart from the commit hash and the log message title, which become
the non-options in `args`. Loop over `args`, put all options (an
argument beginning with a dash) in `opts`, stop the loop on the first
non-option and assign it to `sha1`. For instance, the to-do list

    reword --signoff fa1afe1 Some change

is parsed as `command=reword`, `opts= '--signoff'` (including the
single quotes and the space for evaluation and concatenation of
options), `sha1=fa1afel` and `rest=Some change`. The loop does not
know the options it parses so that options that take an argument
themselves are not supported at the moment. Neither are options that
contain spaces because the shell expansion of `args` in `do_next`
interprets white space characters as argument separator.

Print an error message for unknown or unsupported command line
options, which means an error for all specified options at the
moment. Cleanly break the `do_next` loop by assigning a reason to the
local variable `malformed`, which triggers the unknown command code
in `do_replay`. Move the error code to the beginning of `do_replay`
so that unknown commands are reported before bad options are as only
the first error we come across is reported. For instance, the to-do
list from above produces the error

    Unknown 'reword' option: --signoff
    Please fix this using 'git rebase --edit-todo'.

The to-do list is also parsed when the commit hashes are translated
between long and short format before and after the to-do list is
edited. Apply the same procedure as in `do_replay` with the exception
that we only care about where the options stop and the commit hash
begins. Do not reject any options when transforming the commit
hashes.

Enable the specification of to-do list command line options in
`FAKE_LINES` the same way this is accomplished for command lines
passed to `exec`. Define a new `fake_editor.sh` that edits a static
to-do list instead of the one passed as argument when invoked by
git-rebase. Add a test case that checks that unknown options are
refused and can be corrected using `--edit-todo`.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh     | 95 +++++++++++++++++++++++++++++++-----------
 t/lib-rebase.sh                | 20 ++++++++-
 t/t3427-rebase-line-options.sh | 26 ++++++++++++
 3 files changed, 114 insertions(+), 27 deletions(-)
 create mode 100755 t/t3427-rebase-line-options.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e140bf0..8b39f2d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -578,30 +578,71 @@ do_pick () {
 }
 
 do_replay () {
+	malformed=
 	command=$1
-	sha1=$2
-	rest=$3
+	shift
+	case "$command" in
+	pick|reword|edit|squash|fixup)
+		;;
+	*)
+		read -r command <"$todo"
+		malformed="Unknown command: $command"
+		;;
+	esac
+
+	opts=
+	while test $# -gt 0 && test -z "$malformed"
+	do
+		case "$1" in
+		-*)
+			malformed="Unknown '$command' option: $1"
+			;;
+		*)
+			break
+			;;
+		esac
+		opts="$opts $1"
+		shift
+	done
+	sha1=$1
+	shift
+	rest=$*
+
+	if test -n "$malformed"
+	then
+		warn "$malformed"
+		fixtodo="Please fix this using 'git rebase --edit-todo'."
+		if git rev-parse --verify -q "$sha1" >/dev/null
+		then
+			die_with_patch $sha1 "$fixtodo"
+		else
+			die "$fixtodo"
+		fi
+	fi
 
 	case "$command" in
 	pick|p)
 		comment_for_reflog pick
 
 		mark_action_done
-		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
+		do_pick $opts $sha1 \
+			|| die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	reword|r)
 		comment_for_reflog reword
 
 		mark_action_done
-		do_pick --edit $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
+		do_pick --edit $opts $sha1 \
+			|| die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
 		comment_for_reflog edit
 
 		mark_action_done
-		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
+		do_pick $opts $sha1 \
+			|| die_with_patch $sha1 "Could not apply $sha1... $rest"
 		warn "Stopped at $sha1... $rest"
 		exit_with_patch $sha1 0
 		;;
@@ -625,18 +666,18 @@ do_replay () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			do_pick --amend -F "$squash_msg" $sha1 \
+			do_pick --amend -F "$squash_msg" $opts $sha1 \
 				|| die_failed_squash $sha1 "$rest"
 			;;
 		*)
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_pick --amend -F "$fixup_msg" $sha1 \
+				do_pick --amend -F "$fixup_msg" $opts $sha1 \
 					|| die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
-				do_pick --amend -F "$GIT_DIR"/SQUASH_MSG -e $sha1 \
+				do_pick --amend -F "$GIT_DIR"/SQUASH_MSG -e $opts $sha1 \
 					|| die_failed_squash $sha1 "$rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
@@ -658,23 +699,12 @@ do_replay () {
 		esac
 		record_in_rewritten $sha1
 		;;
-	*)
-		read -r command <"$todo"
-		warn "Unknown command: $command"
-		fixtodo="Please fix this using 'git rebase --edit-todo'."
-		if git rev-parse --verify -q "$sha1" >/dev/null
-		then
-			die_with_patch $sha1 "$fixtodo"
-		else
-			die "$fixtodo"
-		fi
-		;;
 	esac
 }
 
 do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
-	read -r command sha1 rest <"$todo"
+	read -r command args <"$todo"
 
 	case "$command" in
 	"$comment_char"*|''|noop)
@@ -719,7 +749,7 @@ do_next () {
 		fi
 		;;
 	*)
-		do_replay $command $sha1 "$rest"
+		do_replay $command $args
 		;;
 	esac
 	test -s "$todo" && return
@@ -799,19 +829,34 @@ skip_unnecessary_picks () {
 }
 
 transform_todo_ids () {
-	while read -r command rest
+	while read -r command args
 	do
 		case "$command" in
 		"$comment_char"* | exec)
 			# Be careful for oddball commands like 'exec'
 			# that do not have a SHA-1 at the beginning of $rest.
+			newargs=\ $args
 			;;
 		*)
-			sha1=$(git rev-parse --verify --quiet "$@" ${rest%% *}) &&
-			rest="$sha1 ${rest#* }"
+			newargs=
+			sha1=
+			for arg in $args
+			do
+				case "$arg" in
+				-*)
+					newargs="$newargs $arg"
+					;;
+				*)
+					test -z "$sha1" &&
+						sha1=$(git rev-parse --verify --quiet "$@" $arg) &&
+						arg=$sha1
+					newargs="$newargs $arg"
+					;;
+				esac
+			done
 			;;
 		esac
-		printf '%s\n' "$command${rest:+ }$rest"
+		printf '%s\n' "$command$newargs"
 	done <"$todo" >"$todo.new" &&
 	mv -f "$todo.new" "$todo"
 }
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 0cd1193..104f5bd 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -46,8 +46,8 @@ set_fake_editor () {
 	action=pick
 	for line in $FAKE_LINES; do
 		case $line in
-		squash|fixup|edit|reword)
-			action="$line";;
+		pick*|squash*|fixup*|edit*|reword*)
+			action=$(echo "$line" | sed 's/_/ /g');;
 		exec*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		"#")
@@ -80,6 +80,22 @@ set_cat_todo_editor () {
 	test_set_editor "$(pwd)/fake-editor.sh"
 }
 
+# set_fixed_todo_editor takes a file path as argument and installs an
+# editor script that, firstly, overwrites the file path argument with
+# the one specified during installation and, secondly, calls
+# fake-editor.sh for changing the contents as usual. This comes in
+# handy if it is easier to change some fixed file instead of the one
+# that will be passed when the editor is being invoked.
+
+set_fixed_todo_editor () {
+	set_fake_editor
+	write_script fake-editor-wrapper.sh <<-EOF
+	cp "$1" "\$1"
+	"$(pwd)"/fake-editor.sh "\$1"
+	EOF
+	test_set_editor "$(pwd)/fake-editor-wrapper.sh"
+}
+
 # checks that the revisions in "$2" represent a linear range with the
 # subjects in "$1"
 test_linear_range () {
diff --git a/t/t3427-rebase-line-options.sh b/t/t3427-rebase-line-options.sh
new file mode 100755
index 0000000..5881162
--- /dev/null
+++ b/t/t3427-rebase-line-options.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='git rebase -i with line options'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'Set up repository' '
+	test_commit Initial &&
+	test_commit Commit1 &&
+	test_commit Commit2
+'
+
+test_expect_success 'Unknown option' '
+	git checkout -b unknown-option master &&
+	set_cat_todo_editor &&
+	test_must_fail git rebase -i HEAD^ >todo &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 pick_--unknown-option 2" git rebase -i HEAD~2 &&
+	set_fixed_todo_editor "$(pwd)"/todo &&
+	git rebase --edit-todo &&
+	git rebase --continue
+'
+
+test_done
-- 
2.0.1

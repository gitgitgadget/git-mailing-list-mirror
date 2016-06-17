Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D12B1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbcFQUY0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:26 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52120 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964881AbcFQUYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:25 -0400
Received: (qmail 23704 invoked from network); 17 Jun 2016 20:24:23 -0000
Received: (qmail 6015 invoked from network); 17 Jun 2016 20:24:23 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 15/38] i18n: rebase-interactive: mark here-doc strings for translation
Date:	Fri, 17 Jun 2016 20:21:04 +0000
Message-Id: <1466194887-18236-16-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use pipe to send gettext output to git stripspace instead of the
original method of using shell here-document, because command
substitution '$(...)' would not take place inside the here-documents.
The exception is the case of the last here-document redirecting to cat,
in which commands substitution works and, thus, is preserved in this
commit.

t3404: adapt test to the strings newly marked for translation
Test t3404-rebase-interactive.sh would fail under GETTEXT_POISON unless
using test_i18ngrep.

Add eval_ngettext fallback functions to be called when running, for
instance, under GETTEXT_POISON. Otherwise, tests would fail under
GETTEXT_POISON, or other build that doesn't support the GNU gettext,
because that function could not be found.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-rebase--interactive.sh    | 30 +++++++++++++++---------------
 git-sh-i18n.sh                | 18 ++++++++++++++++++
 t/t3404-rebase-interactive.sh | 14 +++++++-------
 3 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2b8a845..a16ce3a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -144,29 +144,28 @@ reschedule_last_action () {
 }
 
 append_todo_help () {
-	git stripspace --comment-lines >>"$todo" <<\EOF
-
+	gettext "
 Commands:
  p, pick = use commit
  r, reword = use commit, but edit the commit message
  e, edit = use commit, but stop for amending
  s, squash = use commit, but meld into previous commit
- f, fixup = like "squash", but discard this commit's log message
+ f, fixup = like \"squash\", but discard this commit's log message
  x, exec = run command (the rest of the line) using shell
  d, drop = remove commit
 
 These lines can be re-ordered; they are executed from top to bottom.
+" | git stripspace --comment-lines >>"$todo"
 
-EOF
 	if test $(get_missing_commit_check_level) = error
 	then
-		git stripspace --comment-lines >>"$todo" <<\EOF
+		gettext "
 Do not remove any line. Use 'drop' explicitly to remove a commit.
-EOF
+" | git stripspace --comment-lines >>"$todo"
 	else
-		git stripspace --comment-lines >>"$todo" <<\EOF
+		gettext "
 If you remove a line here THAT COMMIT WILL BE LOST.
-EOF
+" | git stripspace --comment-lines >>"$todo"
 	fi
 }
 
@@ -1122,13 +1121,12 @@ edit-todo)
 	mv -f "$todo".new "$todo"
 	collapse_todo_ids
 	append_todo_help
-	git stripspace --comment-lines >>"$todo" <<\EOF
-
+	gettext "
 You are editing the todo file of an ongoing interactive rebase.
 To continue rebase after editing, run:
     git rebase --continue
 
-EOF
+" | git stripspace --comment-lines >>"$todo"
 
 	git_sequence_editor "$todo" ||
 		die "$(gettext "Could not execute editor")"
@@ -1269,14 +1267,16 @@ todocount=${todocount##* }
 
 cat >>"$todo" <<EOF
 
-$comment_char Rebase $shortrevisions onto $shortonto ($todocount command(s))
+$comment_char $(eval_ngettext \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
+	"$todocount")
 EOF
 append_todo_help
-git stripspace --comment-lines >>"$todo" <<\EOF
-
+gettext "
 However, if you remove everything, the rebase will be aborted.
 
-EOF
+" | git stripspace --comment-lines >>"$todo"
 
 if test -z "$keep_empty"
 then
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index e6c3116..1ef1889 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -53,6 +53,13 @@ gettext_without_eval_gettext)
 			git sh-i18n--envsubst "$1"
 		)
 	}
+
+	eval_ngettext () {
+		ngettext "$1" "$2" "$3" | (
+			export PATH $(git sh-i18n--envsubst --variables "$2");
+			git sh-i18n--envsubst "$2"
+		)
+	}
 	;;
 poison)
 	# Emit garbage so that tests that incorrectly rely on translatable
@@ -64,6 +71,10 @@ poison)
 	eval_gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
+
+	eval_ngettext () {
+		printf "%s" "# GETTEXT POISON #"
+	}
 	;;
 *)
 	gettext () {
@@ -76,6 +87,13 @@ poison)
 			git sh-i18n--envsubst "$1"
 		)
 	}
+
+	eval_ngettext () {
+		(test "$3" = 1 && printf "%s" "$1" || printf "%s" "$2") | (
+			export PATH $(git sh-i18n--envsubst --variables "$2");
+			git sh-i18n--envsubst "$2"
+		)
+	}
 	;;
 esac
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66348f1..f4ccd10 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -540,7 +540,7 @@ test_expect_success 'clean error after failed "exec"' '
 	echo "edited again" > file7 &&
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
-	grep "You have staged changes in your working tree." error
+	test_i18ngrep "You have staged changes in your working tree." error
 '
 
 test_expect_success 'rebase a detached HEAD' '
@@ -1060,7 +1060,7 @@ test_expect_success 'todo count' '
 	EOF
 	test_set_editor "$(pwd)/dump-raw.sh" &&
 	git rebase -i HEAD~4 >actual &&
-	grep "^# Rebase ..* onto ..* ([0-9]" actual
+	test_i18ngrep "^# Rebase ..* onto ..* ([0-9]" actual
 '
 
 test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
@@ -1160,7 +1160,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 	FAKE_LINES="1 2 3 4" \
 		git rebase -i --root 2>actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 cat >expect <<EOF
@@ -1181,7 +1181,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	set_fake_editor &&
 	FAKE_LINES="1 2 3 4" \
 		git rebase -i --root 2>actual &&
-	test_cmp expect actual &&
+	test_i18ncmp expect actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
@@ -1205,7 +1205,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 4" \
 		git rebase -i --root 2>actual &&
-	test_cmp expect actual &&
+	test_i18ncmp expect actual &&
 	cp .git/rebase-merge/git-rebase-todo.backup \
 		.git/rebase-merge/git-rebase-todo &&
 	FAKE_LINES="1 2 drop 3 4 drop 5" \
@@ -1228,7 +1228,7 @@ test_expect_success 'static check of bad command' '
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-	test_cmp expect actual &&
+	test_i18ncmp expect actual &&
 	FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
@@ -1263,7 +1263,7 @@ test_expect_success 'static check of bad SHA-1' '
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
 		git rebase -i --root 2>actual &&
-	test_cmp expect actual &&
+	test_i18ncmp expect actual &&
 	FAKE_LINES="1 2 4 5 6" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
-- 
2.6.6


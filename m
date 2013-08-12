From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] rebase: interactive: fix short SHA-1 collision
Date: Mon, 12 Aug 2013 00:07:39 -0400
Message-ID: <1376280459-55188-4-git-send-email-sunshine@sunshineco.com>
References: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 06:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8jR6-0006R1-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 06:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab3HLEIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 00:08:45 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:52927 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3HLEIc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 00:08:32 -0400
Received: by mail-ie0-f180.google.com with SMTP id aq17so7178134iec.25
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1bBFAJYYyTqnW6yvxSF5liZTbJcSM9sfiHHndSsOcQ=;
        b=GfENTeA7f86364oxNJLxSGdkJnVUm6hoWWb0hCjbIK1I8FOxNNMd0kMxhJ7JqGFG6V
         8Z3HZTB0yo0j6wCjcjWkzPrzHELZHPhx4knpzee7RhjbedEeU1fPv+EHsODfeU1E0RNf
         rRp/EOVPkKgdmt2Ria+2A4uJx29Akous7+VAB7vo/zWXGzPHtf99lv+mNeBUcSilClUk
         8AP2RUxhC6Rlj37QkA65NdzywfLAQvSPV/LErK1i1ltor1f+FZ07Rj381Pc6TrJqkbTg
         Qz8nYbdUdZqhRaIYooChkaxJD2gFBZU4Cvbv6NSCJRm3/blcfdC4GMpvNYhv0DLbDmOX
         P2aw==
X-Received: by 10.50.88.7 with SMTP id bc7mr7146219igb.37.1376280511977;
        Sun, 11 Aug 2013 21:08:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id x2sm11986256igw.0.2013.08.11.21.08.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 21:08:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
In-Reply-To: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232149>

From: Junio C Hamano <gitster@pobox.com>

The 'todo' sheet for interactive rebase shows abbreviated SHA-1's and
then performs its operations upon those shortened values. This can lead
to an abort if the SHA-1 of a reworded or edited commit is no longer
unique within the abbreviated SHA-1 space and a subsequent SHA-1 in the
todo list has the same abbreviated value.

For example:

  edit f00dfad first
  pick badbeef second

If, after editing, the new SHA-1 of "first" is now
badbeef5ba78983324dff5265c80c4490d5a809a, then the subsequent 'pick
badbeef second' will fail since badbeef is no longer a unique SHA-1
abbreviation:

  error: short SHA1 badbeef is ambiguous.
  fatal: Needed a single revision
  Invalid commit name: badbeef

Fix this problem by expanding the SHA-1's in the todo list before
performing the operations.

[es: also collapse & expand SHA-1's for --edit-todo]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-rebase--interactive.sh    | 30 ++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 83d6d46..ea11e62 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -689,6 +689,32 @@ skip_unnecessary_picks () {
 	die "Could not skip unnecessary pick commands"
 }
 
+transform_todo_ids () {
+	while read -r command rest
+	do
+		case "$command" in
+		'#'* | exec)
+			# Be careful for oddball commands like 'exec'
+			# that do not have a SHA-1 at the beginning of $rest.
+			;;
+		*)
+			sha1=$(git rev-parse --verify --quiet "$@" ${rest%% *}) &&
+			rest="$sha1 ${rest#* }"
+			;;
+		esac
+		printf '%s\n' "$command${rest:+ }$rest"
+	done <"$todo" >"$todo.new" &&
+	mv -f "$todo.new" "$todo"
+}
+
+expand_todo_ids() {
+	transform_todo_ids
+}
+
+collapse_todo_ids() {
+	transform_todo_ids --short=7
+}
+
 # Rearrange the todo list that has both "pick sha1 msg" and
 # "pick sha1 fixup!/squash! msg" appears in it so that the latter
 # comes immediately after the former, and change "pick" to
@@ -841,6 +867,7 @@ skip)
 edit-todo)
 	git stripspace --strip-comments <"$todo" >"$todo".new
 	mv -f "$todo".new "$todo"
+	collapse_todo_ids
 	append_todo_help
 	git stripspace --comment-lines >>"$todo" <<\EOF
 
@@ -852,6 +879,7 @@ EOF
 
 	git_sequence_editor "$todo" ||
 		die "Could not execute editor"
+	expand_todo_ids
 
 	exit
 	;;
@@ -1008,6 +1036,8 @@ git_sequence_editor "$todo" ||
 has_action "$todo" ||
 	die_abort "Nothing to do"
 
+expand_todo_ids
+
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
 GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e5ebec6..db56db3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -987,7 +987,7 @@ test_expect_success 'short SHA-1 setup' '
 	test_commit --notick "collide3 115158b5" collide collide3 collide3
 '
 
-test_expect_failure 'short SHA-1 collide' '
+test_expect_success 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
 	FAKE_COMMIT_MESSAGE="collide2 815200e" \
-- 
1.8.4.rc2.460.ga591f4a

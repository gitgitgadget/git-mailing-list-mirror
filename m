From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] rebase -i: fix short SHA-1 collision
Date: Fri, 23 Aug 2013 20:10:42 -0400
Message-ID: <1377303042-50868-4-git-send-email-sunshine@sunshineco.com>
References: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 02:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1Rd-0007ZG-50
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307Ab3HXALD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:11:03 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34191 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab3HXAK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:10:59 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so1982009iea.9
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6R1c///vi8CPXjPyRNpxVuC8LK77p0aPdLu0Sn0mSeo=;
        b=uowiq2CIQSKkEyLfJyHc0KoopuhOBqS9p8ZO7ydZWJ0CMAzabfE1Ji6xn9qMV/Giua
         INuvYL9814sesWGx6L7Ppx1eUVG2t/ruLWtAGzgcZVRZ1LB4Oozb7hvF38ZBJB6A2O8a
         sU01z7MgDpCT4Crw0vynnOTeyTBQb3yUbatOXp7NfjgDvP7Gwc3sVlJtzdQf95RxHp7A
         q5lxVl8yb93gD6lO0AGSNjxNqSDMMbVX+5BEeovahCV0C5x4lSO68BSkJUxVNN/9icWa
         iKdfES8xgg1EZXm6A2LLqtiV283hzGvsg66iQwAJfw8wEzeBwdoLdbW9i4io69PaScfX
         TOow==
X-Received: by 10.50.13.66 with SMTP id f2mr3438610igc.17.1377303058986;
        Fri, 23 Aug 2013 17:10:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id k6sm1068749igx.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 17:10:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.557.g34b3a2e
In-Reply-To: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232852>

From: Junio C Hamano <gitster@pobox.com>

The 'todo' sheet for interactive rebase shows abbreviated SHA-1's and
then performs its operations upon those shortened values. This can lead
to an abort if the SHA-1 of a reworded or edited commit is no longer
unique within the abbreviated SHA-1 space and a subsequent SHA-1 in the
todo list has the same abbreviated value.

For example:

  edit f00dfad first
  pick badbeef second

If, after editing, the new SHA-1 of "first" also has prefix badbeef,
then the subsequent 'pick badbeef second' will fail since badbeef is no
longer a unique SHA-1 abbreviation:

  error: short SHA1 badbeef is ambiguous.
  fatal: Needed a single revision
  Invalid commit name: badbeef

Fix this problem by expanding the SHA-1's in the todo list before
performing the operations.

[es: also collapse & expand SHA-1's for --edit-todo; respect
core.commentchar in transform_todo_ids(); compose commit message]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-rebase--interactive.sh    | 30 ++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 83d6d46..b97a1d0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -689,6 +689,32 @@ skip_unnecessary_picks () {
 	die "Could not skip unnecessary pick commands"
 }
 
+transform_todo_ids () {
+	while read -r command rest
+	do
+		case "$command" in
+		"$comment_char"* | exec)
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
index 64a02a0..6cdc2ea 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1049,7 +1049,7 @@ test_expect_success 'short SHA-1 setup' '
 	)
 '
 
-test_expect_failure 'short SHA-1 collide' '
+test_expect_success 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
 	(
-- 
1.8.4.557.g34b3a2e

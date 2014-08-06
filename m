From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 19/23] rebase -i: explicitly distinguish replay commands and exec tasks
Date: Thu,  7 Aug 2014 01:59:26 +0200
Message-ID: <d1ee1d61eb09a582a557acbed64d76287c168dda.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8l-0004DU-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbaHGABB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:01:01 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:56951 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbaHGAA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:57 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so3256818qad.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZFOnOf9ZT/ocSdQRPur9kMCGxb/zCifdMT2Se34BfX8=;
        b=qTqmBXavtzeSqDaRNyLN8atKC1NGhGvTk7VHTKmvc8cREvYfCx6olrf2NxEiRxo1KD
         J8jrWOLnPFZJQT2MsxmZEHyhHaQa16GEwAJGNEyDMw9a4Fx1CRIAiHU12OtVuSj7hc01
         hm8uLYGsqgjksBTpVUY08tkjZmh+luUsbXPuPV+22a+k/q479bElevBz0qHYhnMJQQdF
         ughjYhJvX0ssy2q5gX+UR+yB2OnQd6bJ5y8EZF1/p3DE1mmpgXxIDmZ2JQoa0z3QpOS1
         3f7OwAMxXyrXxumMoAy1us6reSfaVm8PyVK6ghVjTj6UPWr85Irms9KTWnZbIj40uBtx
         GdSA==
X-Received: by 10.229.25.199 with SMTP id a7mr17945311qcc.30.1407369656316;
        Wed, 06 Aug 2014 17:00:56 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254932>

There are two kinds of to-do list commands available. One kind
replays a commit (`pick`, `reword`, `edit`, `squash` and `fixup` that
is) and the other executes a shell command (`exec`). We will call the
first kind replay commands.

The two kinds of tasks are scheduled using different line formats.
Replay commands expect a commit hash argument following the command
name and exec concatenates all arguments to assemble a command line.

Adhere to the distinction of formats by not trying to parse the
`sha1` field unless we are dealing with a replay command. Move the
replay command handling code to a new function `do_replay` which
assumes the first argument to be a commit hash and make no more such
assumptions in `do_next`.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 29eca7e..6ecd4d7 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -575,13 +575,12 @@ do_pick () {
 	fi
 }
 
-do_next () {
-	rm -f "$msg" "$author_script" "$amend" || exit
-	read -r command sha1 rest < "$todo"
+do_replay () {
+	command=$1
+	sha1=$2
+	rest=$3
+
 	case "$command" in
-	"$comment_char"*|''|noop)
-		mark_action_done
-		;;
 	pick|p)
 		comment_for_reflog pick
 
@@ -660,6 +659,28 @@ do_next () {
 		esac
 		record_in_rewritten $sha1
 		;;
+	*)
+		read -r command <"$todo"
+		warn "Unknown command: $command"
+		fixtodo="Please fix this using 'git rebase --edit-todo'."
+		if git rev-parse --verify -q "$sha1" >/dev/null
+		then
+			die_with_patch $sha1 "$fixtodo"
+		else
+			die "$fixtodo"
+		fi
+		;;
+	esac
+}
+
+do_next () {
+	rm -f "$msg" "$author_script" "$amend" || exit
+	read -r command sha1 rest <"$todo"
+
+	case "$command" in
+	"$comment_char"*|''|noop)
+		mark_action_done
+		;;
 	x|"exec")
 		read -r command rest < "$todo"
 		mark_action_done
@@ -699,14 +720,7 @@ do_next () {
 		fi
 		;;
 	*)
-		warn "Unknown command: $command $sha1 $rest"
-		fixtodo="Please fix this using 'git rebase --edit-todo'."
-		if git rev-parse --verify -q "$sha1" >/dev/null
-		then
-			die_with_patch $sha1 "$fixtodo"
-		else
-			die "$fixtodo"
-		fi
+		do_replay $command $sha1 "$rest"
 		;;
 	esac
 	test -s "$todo" && return
-- 
2.0.1

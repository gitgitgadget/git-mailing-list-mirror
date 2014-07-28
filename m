From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 15/19] rebase -i: explicitly distinguish replay commands and exec tasks
Date: Tue, 29 Jul 2014 01:18:15 +0200
Message-ID: <b844f549d7b2e6f864dc6e5b13d2390030f5f31c.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEN-0006Li-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbaG1XVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:18 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:40421 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbaG1XU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:59 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so7861851wgh.23
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vqQlKYx1O6M6A8tLj672lCO51Vn0kX07p0kp6isP4Qs=;
        b=hHgFUHERLVF1yQrwzN+Qhv01em5uA/3EgE6mS9sCl3A0LDs3PFLpl+5xDAa4WSNmZj
         aePaRvkkenJ/T20XWilmpo8caYuI4Fc5M/0H7r+6vwAXYAkxtazRUQwNnugGxfG82WAJ
         updWvZzv4jVsrYhsnuVFx4oRd4R+DJds3mdU8tvb/499xsl+5i2UoWSGViJ6Geg0rgzP
         W2QroC+m1CNh0TlRTRIIVIYBHpzEsTfdvyuM66P+/YmXpIKud9KfrwHrYq8uyXBq9uoP
         idL5yOGkuyqDPu5UZ3/stp2TeZyVCONOfGbw/lrXUJIRro9IQ8DQtxJXBzHmXmDl8U2O
         yliA==
X-Received: by 10.180.94.166 with SMTP id dd6mr468846wib.33.1406589658357;
        Mon, 28 Jul 2014 16:20:58 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254379>

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
index 9307fa4..8dde8e6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -588,13 +588,12 @@ do_pick () {
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
 
@@ -659,6 +658,28 @@ do_next () {
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
@@ -698,14 +719,7 @@ do_next () {
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

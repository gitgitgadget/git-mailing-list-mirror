From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 21/27] rebase -i: explicitly distinguish replay commands and exec tasks
Date: Mon, 18 Aug 2014 23:23:04 +0200
Message-ID: <f2bd4b597ddabc0fb79d40b494041a43b0ffbddf.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPs-0000iP-0g
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbaHRVYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:23 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:58087 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaHRVYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:19 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so4742827lbi.13
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xxo4GI3kvJeDl5wBCOdKdXZPIaBnPDQB/OWQIinDelg=;
        b=Lyxn4WrpQPyRJJI0mjZljSqumueQXLNEAgDlqX+yacfRoxCKzJa2RmmqWpR/bR4YKa
         71k8Yr61NVec4bEvR3/Ag1vbIbdOLdo1cqLeVGqF2Bj7/fXScTDi5/8N1WCt7ZaWiatd
         J4UMsWnZG29FrNuurkEjMW9wvEP8IR53UN+/OodHbo8SlwPUoikmU7nbYkWAC1keQgOo
         4uRyS+xYXTQf/dnmFsRBpTWaoG7mxpUvixLPnZYbfv5DBwlmtPm/2Z8co5Y5M2ixfUH1
         iCHcVhyMYbQYeYo6LikP5Mv/RjH1txIQqHrm8fvBZnlUpyfYiCWN4FEqXbGI5iTAlDao
         pigg==
X-Received: by 10.112.209.36 with SMTP id mj4mr30696605lbc.26.1408397058656;
        Mon, 18 Aug 2014 14:24:18 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255423>

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
index 6a123f0..e140bf0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -577,13 +577,12 @@ do_pick () {
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

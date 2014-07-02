From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 15/19] rebase -i: Explicitly distinguish replay commands and exec tasks
Date: Wed,  2 Jul 2014 19:48:07 +0200
Message-ID: <07e5f295c0042e78ba83ffb66925e3f09988ae3c.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Ofk-0006xe-37
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbaGBRuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:08 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:55649 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbaGBRuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:50:05 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so10060293wib.6
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DrqLBRQHMz2LCXBPtfyB6/s5e/uyifxX06Gzj3OxsjA=;
        b=jcKuJiigsKaFm4aGheRO2ICZosZF5KeFmMFMFlYNONNNfTmLoM4A9neQ3pEH0UtTC6
         FrsrqJgdXUtfaNWp3hsO6a64+vT6o3or8baQAalipT+iIVqrh6TWQYoxMLUHhQxwHZIO
         z7CbZv66fkxQNsErwEmif71txnnquBCe/elfUNqRUNoLLzluKZYGkqABHdzyNux7BEnQ
         xnxjcPVzEaibcle5i12Rjp32fUjS5QNHC+uV62eLTVgjun5bYRwHaqe+4CNXQis2oc65
         J0MifQBKHKIF8gnaHoRGEnd3Zkb5d8XH9552BdL4aFao2e0GlqWXdIY3pABoe1FO/A9Q
         S/7Q==
X-Received: by 10.194.48.103 with SMTP id k7mr60237272wjn.68.1404323404488;
        Wed, 02 Jul 2014 10:50:04 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.50.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:50:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252815>

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
index 008f3a0..9de7441 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -585,13 +585,12 @@ do_pick () {
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
 
@@ -656,6 +655,28 @@ do_next () {
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
@@ -695,14 +716,7 @@ do_next () {
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
2.0.0

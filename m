From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 13/19] rebase -i: Prepare for squash in terms of do_pick --amend
Date: Wed,  2 Jul 2014 19:48:05 +0200
Message-ID: <9b5c502a106a23c35caf78b4331278ac3c2ad3c9.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:51:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OgU-0007cA-6B
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbaGBRuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:55 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37614 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749AbaGBRuC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:50:02 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so927063wib.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CBF2dxC2fXZx28R+ZzR1izF9oXxye2kqdhSUSxLbA0=;
        b=quLP2HD/P2aUcSrFlePaFFXYikKxdQbxNgtCjfLGqK6/E4GU2pes48B9SOBzC76O25
         bSfyfszTFQrZVc2vqOJqn6lNqzNW1z6eRPQHNrwJMGziIwvvnN/CAtO39c4w3nI8or1Q
         vHFQ9G5rqxgDY/vLbMVw8pw6IphHvrIkW//XOslvziLQNSB76Sx9gsTiF38PWJ70QM6P
         flZ8AEAXm/+DXudhu/aOmxYM21iaMCnWe6o+WjB/R/a9FcTmKWJLCfjNMZaoSB3Dhyga
         p4a4ONlCxDm7muLPnz4neLJ32yjGe4ditKrTw88ohE0F7I8JoNZ3Bs3uEgcIFOuLp6FK
         tDbg==
X-Received: by 10.180.205.141 with SMTP id lg13mr32517373wic.21.1404323400304;
        Wed, 02 Jul 2014 10:50:00 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252821>

Rewrite `squash` and `fixup` handling in `do_next` using the sequence

    pick_one
    commit

in order to test the correctness of a single `do_squash` or
parameterised `do_pick` and make the subsequent patch reimplementing
`squash` in terms of such a single function more readable.

Do not call `rm -f "$GIT_DIR"/MERGE_MSG` since it has no effect on
the state after git-rebase--interactive terminates. The option `-F`
makes git-commit ignore `MERGE_MSG` for the log message. If
git-commit succeeds, `MERGE_MSG` is removed, and if it fails,
`MERGE_MSG` is overwritten by the error sequence `die_failed_squash`.
In summary, removing `MERGE_MSG` neither influences the squash commit
message nor the file state after git-commit returns.

Moreover, `pick_one` ignores `$GIT_DIR/SQUASH_MSG` and does not touch
`$squash_msg` so that it is correct to execute `pick_one` immediately
before git-commit.

Might be squashed into the subsequent commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 47e3edf..37800be 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -633,15 +633,15 @@ do_next () {
 		author_script_content=$(get_author_ident_from_commit HEAD)
 		echo "$author_script_content" > "$author_script"
 		eval "$author_script_content"
-		if ! pick_one -n $sha1
-		then
-			git rev-parse --verify HEAD >"$amend"
-			die_failed_squash $sha1 "$rest"
-		fi
 		case "$(peek_next_command)" in
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
+			if ! pick_one -n $sha1
+			then
+				git rev-parse --verify HEAD >"$amend"
+				die_failed_squash $sha1 "Could not apply $sha1... $rest"
+			fi
 			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die_failed_squash $sha1 "$rest"
@@ -650,12 +650,21 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
+				if ! pick_one -n $sha1
+				then
+					git rev-parse --verify HEAD >"$amend"
+					die_failed_squash $sha1 "Could not apply $sha1... $rest"
+				fi
 				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
-				rm -f "$GIT_DIR"/MERGE_MSG
+				if ! pick_one -n $sha1
+				then
+					git rev-parse --verify HEAD >"$amend"
+					die_failed_squash $sha1 "Could not apply $sha1... $rest"
+				fi
 				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
-- 
2.0.0

From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 13/19] rebase -i: prepare for squash in terms of do_pick --amend
Date: Tue, 29 Jul 2014 01:18:13 +0200
Message-ID: <727fd7808a93b6d03f68e66dac64ee5e11830e55.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEL-0006Li-E4
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbaG1XVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:01 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:50980 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbaG1XU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:56 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so8153449wes.15
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=70ZQYUx21fU19rk+yZV4CUxC7kq9Z1ErXfz6dhKvVPI=;
        b=0KAnD3gtbb3t0i4vXo7Nr98DMXIsAXki6hweSm4vSOTdK/32U3myIgb9VOGb8nu1mx
         EhJwSiH8mopSll1AKhTTckNFzcFJqvjWNd8DL+1dr54IM6rjNR1LAjy00JoO6gZRv2Q9
         YOVH97ahOmu9bFxErCTnNp3sy/XQ8zPOmRNVhEVYlejk7gXHxYnIbiET9p6MaYH2IQlh
         /2ldhORreL/itZBbx2tMdgBE6XE2aL2p0N7p2z/RIRF91RrXlnjByqKo/OHqZfYBI8Vo
         WTc4splqv0x95xesVacmy0FJ0RfAZbXCjnl+USiwH21/duPOp6NGvWDTgqsE4vPBomb7
         r3GQ==
X-Received: by 10.194.179.4 with SMTP id dc4mr53443173wjc.32.1406589655516;
        Mon, 28 Jul 2014 16:20:55 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254373>

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
index 5df1086..d85e55d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -636,15 +636,15 @@ do_next () {
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
@@ -653,12 +653,21 @@ do_next () {
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
2.0.1

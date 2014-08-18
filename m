From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 19/27] rebase -i: prepare for squash in terms of do_pick --amend
Date: Mon, 18 Aug 2014 23:23:02 +0200
Message-ID: <27101bc167217e58a3b694e113d991d1d76d7be8.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:25:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUQO-0000yc-KC
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbaHRVYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:17 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:42029 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaHRVYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:16 -0400
Received: by mail-la0-f44.google.com with SMTP id el20so5239264lab.3
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r993mnqABIwSmRpn9DSrstdttKzJ3G9oZZg1wrbLt7k=;
        b=VF4m2B/1ANxtro+z7kQp22+X/XFr7XajV3la3Yz7sZNEH7keXl9r1zWwoY7J98+4JE
         XbDVBXMs/7Qyk9/9Iw9uBiZRV5izM1A+xr6wJl+DxACF7VsKPlYjkF0TXhopYNSDzZ0K
         6SYQM0aRw8PaX+TyeFiiUq2s4E2eYXgUcIe8nGURx2P/DzrXJRcZyhcGSLqAJpqTjA8i
         1i+0tbHaKO/wMHCKFOh3OvQ3D/dx3bBIV6s8QM7XqhUVqXYCYULKeiPqEILYmb+nF+43
         iFrnNMU/0EF4TKHCCW/1KadCqSvSm0a2VvaOkFZvkgwMeeV1WJ1XcUPpSyG/KooMx8fM
         PLZA==
X-Received: by 10.152.6.133 with SMTP id b5mr15161226laa.16.1408397054745;
        Mon, 18 Aug 2014 14:24:14 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255431>

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
index ab807e5..614579c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -622,15 +622,15 @@ do_next () {
 
 		mark_action_done
 		update_squash_messages $squash_style $sha1
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
 			output git commit --allow-empty-message --allow-empty \
 				--amend --no-verify -F "$squash_msg" \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
@@ -640,13 +640,22 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
+				if ! pick_one -n $sha1
+				then
+					git rev-parse --verify HEAD >"$amend"
+					die_failed_squash $sha1 "Could not apply $sha1... $rest"
+				fi
 				output git commit --allow-empty-message --allow-empty \
 					--amend --no-verify -F "$fixup_msg" \
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
 				output git commit --allow-empty --amend --no-pre-commit -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
-- 
2.0.1

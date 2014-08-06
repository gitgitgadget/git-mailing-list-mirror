From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 17/23] rebase -i: prepare for squash in terms of do_pick --amend
Date: Thu,  7 Aug 2014 01:59:24 +0200
Message-ID: <bddbbac363a5491168d48d184e5b584e33b063fa.1407368621.git.bafain@gmail.com>
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
	id 1XFB8k-0004DU-Ql
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbaHGAAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:55 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:46493 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbaHGAAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:53 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so3525440qga.36
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iq6USXnemBK8pD+wMd+WsOUXWesVrKsEM9+FTCU2SwY=;
        b=SnJJ2Tnp8rNrhaAIOMQe5lQBvpvlVwqN+ZHoky0/RjwmsCVguQ76MkyMe23ggbj7xO
         ul2IEerf7aHKuu+hkCezFDO72ci3oIWSPAGSJfc1nigDr5i6QbcONHNDECqmF/MqESve
         Tm0dYFBq/pxGiuZ7tz02JnwzFSaUGuqdkJTFRt9s3FRGN1M4nFo0MYyh3NbnkNxC0YLC
         I7AjXvZizfhlG6gYuyvV1xSYe/p7bQ5V+EZE9MBEEeX/Y5Y9804cukNaBGkYrJMTWuTR
         YmgW1n+4Uqno7QkU9a/Sz1x+Qn5NPnTcl0GBeWgcfR2sMWeqaSeuyn2HHQ+0NEc3MTb7
         1HJA==
X-Received: by 10.140.27.144 with SMTP id 16mr8839037qgx.18.1407369653125;
        Wed, 06 Aug 2014 17:00:53 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254933>

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
index 0fbf773..601a2ff 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -623,15 +623,15 @@ do_next () {
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
 			do_with_author output git commit --allow-empty-message --allow-empty \
 				--amend --no-verify -F "$squash_msg" \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
@@ -641,13 +641,22 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
+				if ! pick_one -n $sha1
+				then
+					git rev-parse --verify HEAD >"$amend"
+					die_failed_squash $sha1 "Could not apply $sha1... $rest"
+				fi
 				do_with_author output git commit --allow-empty-message --allow-empty \
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
 				do_with_author output git commit --allow-empty --amend --no-pre-commit -F "$GIT_DIR"/SQUASH_MSG -e \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
-- 
2.0.1

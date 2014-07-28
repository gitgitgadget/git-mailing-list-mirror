From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 14/19] rebase -i: implement squash in terms of do_pick
Date: Tue, 29 Jul 2014 01:18:14 +0200
Message-ID: <ab7f8e0cd02a02144ed6dbe50efacbad2d017838.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEO-0006Li-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbaG1XVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:19 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:42277 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaG1XU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:58 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so8129128wes.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+150bXeV6wubhvBXdgvD8raLnw4jQmcBvvkGmwEUbMU=;
        b=b/nnNVMJqO85C0NCKFny2hzcVLpUqcucexefgtxr91uG5Jc6A+Vza7qP8tJ8O/JGYw
         25p/1kZijZTx007Ik+mT8Hh4aeu1B/vuj9cxR2PW2pwuJxawEM8XGJAzo6NOr7lU/+ZW
         QoaIP+EcNSKz2AU31aR4Co+ApeyYPyPm3sAM+8BaFszOlGNnjm7EJMBzLc/f7EkfLVJG
         CmsOp4kmcGPn6krUd6lX9kuc4rn7njcX+/ujaqF8cGDCVa84jCiLgEzYKLk6otnuxCWP
         bEsackNIilYtJ/8jFuLoPxwCgLcukE0lHV8YXDxSM/ikTIpYM2Z6cOjIFxpCFd0+EhyS
         prUg==
X-Received: by 10.194.57.45 with SMTP id f13mr524461wjq.98.1406589656925;
        Mon, 28 Jul 2014 16:20:56 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254376>

The to-do list command `squash` and its close relative `fixup` replay
the changes of a commit like `pick` but do not recreate the commit.
Instead they replace the previous commit with a new commit that also
introduces the changes of the squashed commit. This is roughly like
cherry-picking without committing and using git-commit to amend the
previous commit.

The to-do list

    pick   a Some changes
    squash b Some more changes

gets translated into the sequence of git commands

    git cherry-pick a
    git cherry-pick -n b
    git commit --amend

and if git-cherry-pick supported `--amend` this would look even more
like the to-do list it is based on

    git cherry-pick a
    git cherry-pick --amend b.

Since `do_pick` takes care of `pick` entries and the above suggests
`squash` as an alias for `pick --amend`, reimplement `squash` in
terms of `do_pick --amend`. Introduce `$squash_msg` as the commit
message via the `--file` option. When the last commit of a squash
series is processed, the user is asked to review the log message.
Pass `--edit` as additional option in this case. The only difference
in the options passed to git-commit and `do_pick` is the omitted
`--no-verify`. However, `do_pick` does not execute the verification
hooks anyway because it solely replays commits and assumes that they
have been verified before.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d85e55d..9307fa4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -640,37 +640,19 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			if ! pick_one -n $sha1
-			then
-				git rev-parse --verify HEAD >"$amend"
-				die_failed_squash $sha1 "Could not apply $sha1... $rest"
-			fi
-			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				die_failed_squash $sha1 "$rest"
+			do_with_author do_pick --amend -F "$squash_msg" $sha1 \
+				|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			;;
 		*)
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$fixup_msg" $sha1 \
+					|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$GIT_DIR"/SQUASH_MSG -e $sha1 \
+					|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
 			;;
-- 
2.0.1

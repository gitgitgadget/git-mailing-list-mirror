From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 01/19] rebase -i: failed reword prints redundant error message
Date: Tue, 29 Jul 2014 01:18:01 +0200
Message-ID: <b2b05cb1f5ea70743e90502d05a4d8d13ddff73f.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDe-00066N-OO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaG1XUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:33 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:40788 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaG1XUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:32 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so8173653wgg.16
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cDQGwE/LKRJotxKhtvmLTgRwsJtzosME8cOj3//Dc6A=;
        b=D5KqGkjZs0NT+cZMCUzzH8vvz4pGoDudshlfchWgS93juVd9z1X/gwAcjqL4lCLynu
         zlmErnIkk6RFVo846BShFjO11iCnsnonnDVz8iAt9kssd4bnotSs0wwLYJwbyNW81rO1
         AReVcwYNNaRrcQvnVPvT+jwMIrFzbjZj8oB38gQBWpxxZfWTtDwism8qcrBPck5akPs0
         ZkDtsEfYxxB2YR+XArRlmDr5yMbJb4Bu4zeboMOkTfuVwAwTSbsQBaPYfu/PJTNDhfwQ
         Z+GjP5qwM6SWuap1c0rcMtrHh9VK1uT5NBWN4zVx7zcqYsAqACPI8ACti6D0MYNpSACe
         lcAQ==
X-Received: by 10.195.13.102 with SMTP id ex6mr52719991wjd.48.1406589631660;
        Mon, 28 Jul 2014 16:20:31 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254362>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. If the edited log
message is empty or is found ill-formatted by one of the commit
hooks, git-rebase--interactive prints three error messages to the
console.

    1. The git-commit output, which contains all the output from hook
       scripts.
    2. A rebase diagnosis saying at which task on the to-do list it
       got stuck.
    3. Generic presumptions about what could have triggered the
       error.

The third message contains redundant information and does not add any
enlightenment either, which makes the output unnecessarily longish
and different from the other command's output. For instance, this is
what the output looks like if the log message is empty (contains
duplicate Signed-off-by lines).

    (1.) Aborting commit due to empty commit message. (Duplicate Signed-off-by lines.)
    (2.) Could not amend commit after successfully picking fa1afe1... Some change
    (3.) This is most likely due to an empty commit message, or the pre-commit hook
         failed. If the pre-commit hook failed, you may need to resolve the issue before
         you are able to reword the commit.

Discard the third message.

It is true that a failed hook script might not output any diagnosis
but then the generic message is not of much help either. Since this
lack of information affects the built-in git commands for commit,
merge and cherry-pick first, the solution would be to keep track of
the failed hooks in their output so that the user knows which of her
hooks require improvement.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e1eda0..e733d7f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -506,9 +506,6 @@ do_next () {
 		do_pick $sha1 "$rest"
 		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
-			warn "This is most likely due to an empty commit message, or the pre-commit hook"
-			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
-			warn "you are able to reword the commit."
 			exit_with_patch $sha1 1
 		}
 		record_in_rewritten $sha1
-- 
2.0.1

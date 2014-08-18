From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 06/27] rebase -i: discard redundant message when rewording fails
Date: Mon, 18 Aug 2014 23:22:49 +0200
Message-ID: <c53714eaa34804c55b6cd4b72db8405b700a381d.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPH-0000N5-7m
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbaHRVX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:56 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:42712 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbaHRVXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:52 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so5083181lab.22
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2FnxEJJmoQmIKi203H1WqiVL/VolKbskEeiK1OSykaE=;
        b=Q3B+sttVowmJNLY7TJwdHHe4qffdkpSqD5zUJ1km1lvS6gXXqUIE2E9Wguid7NG9a0
         /ZrbC/OMn/Adz5a4+IWiwmimF19O5tX7FtPTr+ewaRE1s2ikw1nNMo4PRkHxRUNJu//F
         ixlO4W+AlcEBnPXJnkf2HJ/ZPPJTHztAlnqaRdKQ+uMM1Cev6UysomgzBs/zchZUxSlm
         /Ff/MLFg3wPImxHPAyek3sCVm5W81hNcDdTn+Yp9+yx/R/r9JRuILflxdSdK97WFz1w4
         NvAo/tKCQoVjg5wqBpeKRpIGtcobrmb4DGaW7m4Zlf/8MynWG6+D7JNag3lq7tZTrWWh
         Wvpg==
X-Received: by 10.112.53.199 with SMTP id d7mr4997079lbp.106.1408397030943;
        Mon, 18 Aug 2014 14:23:50 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255413>

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
and different from the other commands' output. For instance, this is
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
index cebe742..cf62daa 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -506,9 +506,6 @@ do_next () {
 		do_pick $sha1 "$rest"
 		output git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
-			warn "This is most likely due to an empty commit message, or the pre-commit hook"
-			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
-			warn "you are able to reword the commit."
 			exit_with_patch $sha1 1
 		}
 		record_in_rewritten $sha1
-- 
2.0.1

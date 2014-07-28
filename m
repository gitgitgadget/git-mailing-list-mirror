From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 02/19] rebase -i: allow rewording an empty commit without complaints
Date: Tue, 29 Jul 2014 01:18:02 +0200
Message-ID: <080f67cf9334f0e66ec8ca2e7828295fbdbb096c.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDu-0006Bf-GO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaG1XUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:41 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33702 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaG1XUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:40 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so87389wib.10
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x0gSJg/A+woAtQccW/7cMXesR80eikJjcp6RZD0OlAA=;
        b=NKjtw0oJdBxUOCDCCuVIZTvd5VhRArC/SGLeFWdMNyCpM6qrca5m46T8aDaez6naoH
         mOlQfNZ6eU5YP5SribPLqAExQhHWadDaNjVEQAQ7SAIPjk63ePtjgUSg+3lsIxxKDBOQ
         +YCnVKmKT/2bTWAbwMHuecW9FutNYY5HI0mLVXhKkfVczohFYihOiirksTfxd+eszpEz
         MSj+9mL1sLaSnhTY+mk26qZ5w2/085L+odnTOAzY2gJPld+N4ePH35VmxDsWXQy8dWSF
         ccYQD9dyKZegFeruH+dlXxFibyVfpOdLraby5JfSTkPeOAlP6MX/Eyem+kPSLxBmDPt3
         lk7w==
X-Received: by 10.194.91.228 with SMTP id ch4mr53957497wjb.59.1406589639434;
        Mon, 28 Jul 2014 16:20:39 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254365>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. If `--keep-empty` is
passed as option to git-rebase--interactive, empty commits ought to
be replayed without complaints. However, if the users chooses to
reword an empty commit by changing the respective to-do list entry
from

    pick fa1afe1 Empty commit

to

    reword fa1afe1 Empty commit

, then git-rebase--interactive suddenly fails to replay the empty
commit. This is especially counterintuitive because `reword` is
thought of as a `pick` that alters the log message in some way but
nothing more and the unchanged to-do list entry would not fail.

Handle `reword` by cherry-picking the named commit and editing the
log message using

    git commit --allow-empty --amend

instead of

    git commit --amend.

Add test.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    | 2 +-
 t/t3404-rebase-interactive.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e733d7f..689400e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,7 +504,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			exit_with_patch $sha1 1
 		}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8197ed2..9931143 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,6 +75,14 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
+test_expect_success 'rebase --keep-empty' '
+	git checkout emptybranch &&
+	set_fake_editor &&
+	FAKE_LINES="1 reword 2" git rebase --keep-empty -i HEAD~2 &&
+	git log --oneline >actual &&
+	test_line_count = 6 actual
+'
+
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
-- 
2.0.1

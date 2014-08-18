From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 09/27] rebase -i: do not verify reworded patches using pre-commit
Date: Mon, 18 Aug 2014 23:22:52 +0200
Message-ID: <a15c35c8d5eb9424bca8ae8ad50143f32c867b28.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPT-0000U7-6w
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbaHRVYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:00 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:64857 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaHRVX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:58 -0400
Received: by mail-lb0-f173.google.com with SMTP id u10so4698141lbd.18
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pU+64jXz++/N2UDASreAnf/J6mXATCL2/X61l9D+Vjg=;
        b=ByG2MhvomvudVwXWVuPOvQmph1wbG8U13KQimUlk8ZMETNnvWuPYTKsZ4CgJ5ong5f
         K8s2FIpiHcO01EjLyW7xWvLwYlxI5NC0I77oR4/x1+Ij9HLiV5mPQQwbQqJUdXyxzIuU
         mhB2ESOylw9xhIto8RUu8klzTJmTXEAVtYt8FoiqjY1FyV7ozjJ+/qA23m5ahCzULMcF
         fnwyi754pKdlIJRaUncd2Q7/u5FUP2bavEsM8uYcqb5ByEUZmoqYM9QXIpgxOgC5Fefn
         KpuQmNIpH11+pIiMbp3OKLKtBPu+RSicSsJZj5l8reyKqfSDmcUT11iOlOGfnGTUdmH1
         w6vg==
X-Received: by 10.112.42.167 with SMTP id p7mr30693602lbl.83.1408397036862;
        Mon, 18 Aug 2014 14:23:56 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255418>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. This happens in two
steps. Firstly, the named commit is cherry-picked. Secondly, the
commit created in the first step is amended using an unchanged index
to edit the log message. The pre-commit hook is meant to verify the
changes introduced by a commit (for instance, catching inserted
trailing white space). Since the committed tree is not changed
between the two steps and we do not verify rebased patches, do not
execute the pre-commit hook in the second step.

Specify the git-commit option `--no-pre-commit` to disable the
pre-commit hook when editing the log message. The commit-msg hook
will still be executed to verify the edited commit log message. As
before, if the hook finds the new log message ill-formatted, the
rebase will be interrupted with the unchanged commit replayed and the
new log message in `$GIT_DIR/COMMIT_EDITMSG`.

Add tests.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    |  2 +-
 t/t3404-rebase-interactive.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 54c4614..570c4e9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,7 +504,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		output git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+		output git commit --allow-empty --amend --no-post-rewrite --no-pre-commit ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			exit_with_patch $sha1 1
 		}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index abb829e..ecdab11 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -683,6 +683,13 @@ test_expect_success 'setup failing pre-commit' '
 	test_commit --no-verify pre-commit-violated-3
 '
 
+test_expect_success 'reword a commit violating pre-commit' '
+	git checkout -b reword-violating-pre-commit violating-pre-commit &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	env FAKE_LINES="reword 1" git rebase -i master
+'
+
 test_expect_success 'squash commits violating pre-commit' '
 	git checkout -b squash-violating-pre-commit violating-pre-commit &&
 	test_when_finished reset_rebase &&
@@ -726,6 +733,13 @@ test_expect_success 'rebase a commit violating commit-msg' '
 	FAKE_LINES="1" git rebase -i master
 '
 
+test_expect_success 'reword a commit violating commit-msg' '
+	git checkout -b reword-violating-commit-msg violating-commit-msg &&
+	test_when_finished reset_rebase &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 1" git rebase -i master
+'
+
 test_expect_success 'squash commits violating commit-msg' '
 	git checkout -b squash-violating-commit-msg violating-commit-msg &&
 	set_fake_editor &&
-- 
2.0.1

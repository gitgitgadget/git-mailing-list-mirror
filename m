From: Max Kirillov <max@max630.net>
Subject: [PATCH] prune --worktrees: fix expire vs worktree existence condition
Date: Mon, 30 Mar 2015 23:47:47 +0300
Message-ID: <1427748467-27786-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 22:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycgbr-0005sI-66
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 22:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbbC3UsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 16:48:25 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:52261
	"EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbC3UsY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2015 16:48:24 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-09.prod.phx3.secureserver.net with 
	id 9wo91q00L5B68XE01woNWJ; Mon, 30 Mar 2015 13:48:23 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266473>

`git prune --worktrees` was pruning worktrees which were non-existent OR
expired, while it rather should prune those which are orphaned AND
expired, as git-checkout documentation describes. Fix it.

Add test 'not prune proper checkouts', which uses valid but expired
worktree.

Modify test 'not prune recent checkouts' to remove the worktree before
pruning - link in worktrees still must survive. In older form it is
useless because would pass always when the other test passes.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/prune.c                   | 10 +++++++---
 t/t2026-prune-linked-checkouts.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 34a5ce1..fd31485 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,11 +120,15 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
 		    st_link.st_nlink > 1)
 			return 0;
-		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
-		return 1;
+		if (st.st_mtime <= expire) {
+		    strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
+		    return 1;
+		} else {
+		    return 0;
+		}
 	}
 	free(path);
-	return st.st_mtime <= expire;
+	return 0;
 }
 
 static void prune_worktrees(void)
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index e885baf..1821a48 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -4,6 +4,10 @@ test_description='prune $GIT_DIR/worktrees'
 
 . ./test-lib.sh
 
+test_expect_success initialize '
+	git commit --allow-empty -m init
+'
+
 test_expect_success 'prune --worktrees on normal repo' '
 	git prune --worktrees &&
 	test_must_fail git prune --worktrees abc
@@ -77,8 +81,16 @@ test_expect_success 'not prune recent checkouts' '
 	mkdir zz &&
 	mkdir -p .git/worktrees/jlm &&
 	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
+	rmdir zz &&
 	git prune --worktrees --verbose --expire=2.days.ago &&
 	test -d .git/worktrees/jlm
 '
 
+test_expect_success 'not prune proper checkouts' '
+	test_when_finished rm -r .git/worktrees &&
+	git checkout "--to=$PWD/nop" --detach master &&
+	git prune --worktrees &&
+	test -d .git/worktrees/nop
+'
+
 test_done
-- 
2.3.4.2801.g3d0809b

From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] rebase: use reflog to find common base with upstream
Date: Wed, 16 Oct 2013 19:53:53 +0100
Message-ID: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 16 20:54:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWWEo-00035C-3M
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 20:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761795Ab3JPSyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 14:54:09 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:57100 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761561Ab3JPSyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 14:54:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id F34B6606529;
	Wed, 16 Oct 2013 19:54:05 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3+QgYbiv6mNo; Wed, 16 Oct 2013 19:54:05 +0100 (BST)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 800B66064FC;
	Wed, 16 Oct 2013 19:53:59 +0100 (BST)
X-Mailer: git-send-email 1.8.4.566.g73d370b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236252>

Commit 15a147e (rebase: use @{upstream} if no upstream specified,
2011-02-09) says:

	Make it default to 'git rebase @{upstream}'. That is also what
	'git pull [--rebase]' defaults to, so it only makes sense that
	'git rebase' defaults to the same thing.

but that isn't actually the case.  Since commit d44e712 (pull: support
rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
chosen the most recent reflog entry which is an ancestor of the current
branch if it can find one.

Change rebase so that it uses the same logic.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-rebase.sh     | 8 ++++++++
 t/t3400-rebase.sh | 6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 226752f..fd36cf7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -437,6 +437,14 @@ then
 			error_on_missing_default_upstream "rebase" "rebase" \
 				"against" "git rebase <branch>"
 		fi
+		for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
+		do
+			if test "$reflog" = "$(git merge-base "$reflog" HEAD)"
+			then
+				upstream_name=$reflog
+				break
+			fi
+		done
 		;;
 	*)	upstream_name="$1"
 		shift
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ebf93b0..4f45f7e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -134,12 +134,14 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
-test_expect_success 'default to @{upstream} when upstream arg is missing' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/master &&
 	git rebase &&
-	test "$(git rev-parse default~1)" = "$(git rev-parse master)"
+	git merge-base topic master >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -q is quiet' '
-- 
1.8.4.566.g73d370b

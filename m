From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] rebase -i: respect core.abbrev for real
Date: Mon, 19 Jan 2015 16:20:48 +0200
Message-ID: <1421677248-137853-1-git-send-email-kirill.shutemov@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 15:21:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDDCM-0004mG-DG
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 15:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbbASOUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 09:20:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:34116 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbbASOUw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 09:20:52 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP; 19 Jan 2015 06:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,427,1418112000"; 
   d="scan'208";a="653177663"
Received: from black.fi.intel.com ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2015 06:20:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 37F6A9D; Mon, 19 Jan 2015 16:20:49 +0200 (EET)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262615>

I have tried to fix this before: see 568950388be2, but it doesn't
really work.

I don't know how it happend, but that commit makes interactive rebase to
respect core.abbrev only during --edit-todo, but not the initial todo
list edit.

For this time I've included a test-case to avoid this frustration again.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 git-rebase--interactive.sh    | 4 ++--
 t/t3404-rebase-interactive.sh | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c6a4629cbc2b..1855e12f1ada 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -962,7 +962,7 @@ else
 	shortrevisions=$shorthead
 fi
 git rev-list $merges_option --pretty=oneline --abbrev-commit \
-	--abbrev=7 --reverse --left-right --topo-order \
+	--reverse --left-right --topo-order \
 	$revisions ${restrict_revision+^$restrict_revision} | \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
@@ -1020,7 +1020,7 @@ then
 			# just the history of its first-parent for others that will
 			# be rebasing on top of it
 			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
-			short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
+			short=$(git rev-list -1 --abbrev-commit $rev)
 			sane_grep -v "^[a-z][a-z]* $short" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
 			rm "$rewritten"/$rev
 		fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8197ed29a9ec..a8ffc24ce46b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1039,4 +1039,11 @@ test_expect_success 'short SHA-1 collide' '
 	)
 '
 
+test_expect_success 'respect core.abbrev' '
+	git config core.abbrev 12 &&
+	set_cat_todo_editor &&
+	test_must_fail git rebase -i HEAD~4 >todo-list 2>&1
+	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
+'
+
 test_done
-- 
2.1.4

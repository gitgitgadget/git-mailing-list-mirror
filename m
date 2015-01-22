From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3] rebase -i: respect core.abbrev for real
Date: Thu, 22 Jan 2015 13:50:15 +0200
Message-ID: <1421927415-114643-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <CAPig+cQcYXzRwHMRcKQJf-mWq7d9Kgp7KndnEhFs4_mwgLpiiA@mail.gmail.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 12:50:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEGHU-0002DU-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 12:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbAVLu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 06:50:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:61655 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbbAVLuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 06:50:20 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 22 Jan 2015 03:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,448,1418112000"; 
   d="scan'208";a="674081790"
Received: from black.fi.intel.com ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2015 03:50:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 375475EA; Thu, 22 Jan 2015 13:50:17 +0200 (EET)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CAPig+cQcYXzRwHMRcKQJf-mWq7d9Kgp7KndnEhFs4_mwgLpiiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262820>

I have tried to fix this before: see 568950388be2, but it doesn't
really work.

I don't know how it happend, but that commit makes interactive rebase to
respect core.abbrev only during --edit-todo, but not the initial todo
list edit.

For this time I've included a test-case to avoid this frustration again.

The patch change code to use full 40-hex revision ids for todo actions
everywhere and collapse them only to show to user.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 v3:
    - use full 40-hex revision ids for todo actions everywhere and collapse them
      only to show to user;
 v2:
    - fix &&-chain in the test-case
---
 git-rebase--interactive.sh    | 17 ++++++++---------
 t/t3404-rebase-interactive.sh |  7 +++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c6a4629cbc2b..c96b9847e9fc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -961,14 +961,13 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
-	--abbrev=7 --reverse --left-right --topo-order \
+git rev-list $merges_option --pretty=oneline --reverse --left-right --topo-order \
 	$revisions ${restrict_revision+^$restrict_revision} | \
 	sed -n "s/^>//p" |
-while read -r shortsha1 rest
+while read -r sha1 rest
 do
 
-	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
+	if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
 	then
 		comment_out="$comment_char "
 	else
@@ -977,9 +976,8 @@ do
 
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
 	else
-		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
 		then
 			preserve=t
@@ -996,7 +994,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
 		fi
 	fi
 done
@@ -1020,8 +1018,8 @@ then
 			# just the history of its first-parent for others that will
 			# be rebasing on top of it
 			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
-			short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
-			sane_grep -v "^[a-z][a-z]* $short" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+			sha1=$(git rev-list -1 $rev)
+			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
 			rm "$rewritten"/$rev
 		fi
 	done
@@ -1054,6 +1052,7 @@ has_action "$todo" ||
 	return 2
 
 cp "$todo" "$todo".backup
+collapse_todo_ids
 git_sequence_editor "$todo" ||
 	die_abort "Could not execute editor"
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8197ed29a9ec..a31f7e0430e1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1039,4 +1039,11 @@ test_expect_success 'short SHA-1 collide' '
 	)
 '
 
+test_expect_success 'respect core.abbrev' '
+	git config core.abbrev 12 &&
+	set_cat_todo_editor &&
+	test_must_fail git rebase -i HEAD~4 >todo-list &&
+	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
+'
+
 test_done
-- 
2.1.4

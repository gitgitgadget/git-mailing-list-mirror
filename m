From: Dave Ware <davidw@realtimegenomics.com>
Subject: [PATCH v7] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Fri, 15 Jan 2016 13:41:43 +1300
Message-ID: <1452818503-21079-1-git-send-email-davidw@realtimegenomics.com>
References: <1452806795-26621-1-git-send-email-davidw@realtimegenomics.com>
Cc: Dave Ware <davidw@realtimegenomics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 01:42:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJsTA-00032P-4X
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 01:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263AbcAOAmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 19:42:19 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34516 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcAOAmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 19:42:17 -0500
Received: by mail-pa0-f49.google.com with SMTP id uo6so369931192pac.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GRx01ePaWspJwROLHFybUdWTz75P4NlKIUDkTEJtHxY=;
        b=L/ddUksEAy39SICz5YkDgQwbK2A7hlCIOtE8tn4yM6UQ6zhnI1LQR3pIACdEYRVURJ
         bzgdc6J1PF5Plys7BP0XgcioVziuL6jclfsqgGhksQhsMsRscaaIXqx2r71gwSpxLNlx
         fx1YqRa7Ar+LBYC7reUQI7jqmiNToFgXhLMxIOMG0HrffbjIe3HykWCtrJqPokr7QKND
         PEZlBdzZ9PFOOSVIW6U95rZQodIDECO/O24rEp4t9PISNujDTBd6nuExpUsGS1m2hhhc
         YRH/p3nII8RFASeaJezIwlJC56RT5Zp7uWdiXKIae3lplPb/LFwV98jmpy/lmtJXPvGU
         ZkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GRx01ePaWspJwROLHFybUdWTz75P4NlKIUDkTEJtHxY=;
        b=MJ84QFzMGuahNkIYvEWdQykn9tYiqZ9G6/+5725u5crntD/hQ7OyMsQOpY2d7AhiRk
         h6C2uxMCjwJvumlozU8IP6OYPaoFilwrnlW6s85L2+BClV0z7UuxVKAaKabYg4zWj/mF
         3+hA2s/C0EIr/PF60FeMmFPJLHb0/LS/ohPA+ewmZFNrn6JwyJfAkGv9eB0qTckaj5kT
         pQg86L2ka9SHRJ39kbfhlUOnhmQUu0LKbUUYBJgdAMXQaLDm6Ah8VfqaLRJUUXlQwey6
         pLJIu146R0eX7TNoGHqXYU5PVPa9wd963eQXuJEcVlBxZUCLcvzlFE7NWRjowRM660xl
         93fA==
X-Gm-Message-State: ALoCoQkKC5pzMdqQ5va9bFBbnADfS+KWLsDsBui/a79XbP4dFGC2l/quj+3L9Jc2FBSzpFjJliorKl4XZWicxKVmjzs0ue+x/A==
X-Received: by 10.66.136.101 with SMTP id pz5mr10504993pab.91.1452818536315;
        Thu, 14 Jan 2016 16:42:16 -0800 (PST)
Received: from tinman.nz.realtimegenomics.com ([114.134.15.146])
        by smtp.googlemail.com with ESMTPSA id r12sm11843776pfi.9.2016.01.14.16.42.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 16:42:15 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1452806795-26621-1-git-send-email-davidw@realtimegenomics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284125>

'git subtree split' can incorrectly skip a merge even when both parents
act on the subtree, provided the merge results in a tree identical to
one of the parents. Fix by copying the merge if at least one parent is
non-identical, and the non-identical parent is not an ancestor of the
identical parent.

Also, add a test case which checks that a descendant remains a
descendent on the subtree in this case.

Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
---

Notes:
    Many thanks to Eric Sunshine and Junio Hamano for adivce on this patch
    Also many thanks to David A. Greene for help with subtree test style
    
    Changes since v6
    - I forgot the notes when I sumbitted v6. (I have now set notes.rewriteRef,
      so hopefully this wont happen again).
    - Fixed some missing && in my test rewrite.
    Changes since v5
    - Rewrote test case to use subtree test repo and commit creation methods
    - Added comments on what the test does and which bits are checked
    - Added comments to test on related bugs which aren't fixed yet
    Changes since v4
    - Minor spelling and style fixes to test case
    Changes since v3:
    - Improvements to commit message
    - Removed incorrect use of --boundary on rev-list
    - Changed use of rev-list to use --count
    Changes since v2:
    - Minor improvements to commit message
    - Changed space indentation to tab indentation in test case
    - Changed use of rev-list for obtaining commit id to use rev-parse instead
    Changes since v1:
    - Minor improvements to commit message
    - Added sign off
    - Moved test case from own file into t7900-subtree.sh
    - Added subshell to test around 'cd'
    - Moved record of commit for cherry-pick to variable instead of dumping into file
    
    [v6]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=284095
    [v5]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282197
    [v4]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282182
    [v3]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282176
    [v2]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282121
    [v1]: http://thread.gmane.org/gmane.comp.version-control.git/282065

 contrib/subtree/git-subtree.sh     | 12 ++++++--
 contrib/subtree/t/t7900-subtree.sh | 60 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index edf36f8..5c83727 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -479,8 +479,16 @@ copy_or_skip()
 			p="$p -p $parent"
 		fi
 	done
-	
-	if [ -n "$identical" ]; then
+
+	copycommit=
+	if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
+		extras=$(git rev-list --count $identical..$nonidentical)
+		if [ "$extras" -ne 0 ]; then
+			# we need to preserve history along the other branch
+			copycommit=1
+		fi
+	fi
+	if [ -n "$identical" ] && [ -z "$copycommit" ]; then
 		echo $identical
 	else
 		copy_commit $rev $tree "$p" || exit $?
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 751aee3..3bf96a9 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -1014,4 +1014,64 @@ test_expect_success 'push split to subproj' '
 	)
 '
 
+#
+# This test covers 2 cases in subtree split copy_or_skip code
+# 1) Merges where one parent is a superset of the changes of the other
+#    parent regarding changes to the subtree, in this case the merge
+#    commit should be copied
+# 2) Merges where only one parent operate on the subtree, and the merge
+#    commit should be skipped
+#
+# (1) is checked by ensuring subtree_tip is a descendent of subtree_branch
+# (2) should have a check added (not_a_subtree_change shouldn't be present
+#     on the produced subtree)
+#
+# Other related cases which are not tested (or currently handled correctly)
+# - Case (1) where there are more than 2 parents, it will sometimes correctly copy
+#   the merge, and sometimes not
+# - Merge commit where both parents have same tree as the merge, currently
+#   will always be skipped, even if they reached that state via different
+#   set of commits.
+#
+
+next_test
+test_expect_success 'subtree descendant check' '
+	subtree_test_create_repo "$subtree_test_count" &&
+	test_create_commit "$subtree_test_count" folder_subtree/a &&
+	(
+		cd "$subtree_test_count" &&
+		git branch branch
+	) &&
+	test_create_commit "$subtree_test_count" folder_subtree/0 &&
+	test_create_commit "$subtree_test_count" folder_subtree/b &&
+	cherry=$(cd "$subtree_test_count"; git rev-parse HEAD) &&
+	(
+		cd "$subtree_test_count" &&
+		git checkout branch
+	) &&
+	test_create_commit "$subtree_test_count" commit_on_branch &&
+	(
+		cd "$subtree_test_count" &&
+		git cherry-pick $cherry &&
+		git checkout master &&
+		git merge -m "merge should be kept on subtree" branch &&
+		git branch no_subtree_work_branch
+	) &&
+	test_create_commit "$subtree_test_count" folder_subtree/d &&
+	(
+		cd "$subtree_test_count" &&
+		git checkout no_subtree_work_branch
+	) &&
+	test_create_commit "$subtree_test_count" not_a_subtree_change &&
+	(
+		cd "$subtree_test_count" &&
+		git checkout master &&
+		git merge -m "merge should be skipped on subtree" no_subtree_work_branch &&
+
+		git subtree split --prefix folder_subtree/ --branch subtree_tip master &&
+		git subtree split --prefix folder_subtree/ --branch subtree_branch branch &&
+		check_equal $(git rev-list --count subtree_tip..subtree_branch) 0
+	)
+'
+
 test_done
-- 
1.9.1

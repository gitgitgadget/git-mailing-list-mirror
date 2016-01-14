From: Dave Ware <davidw@realtimegenomics.com>
Subject: [PATCH v6] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Fri, 15 Jan 2016 10:26:35 +1300
Message-ID: <1452806795-26621-1-git-send-email-davidw@realtimegenomics.com>
References: <87bn8o97mh.fsf@waller.obbligato.org>
Cc: Dave Ware <davidw@realtimegenomics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 22:27:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJpQq-0006Bp-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 22:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbcANV1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 16:27:38 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35574 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbcANV1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 16:27:20 -0500
Received: by mail-pa0-f54.google.com with SMTP id ho8so122125444pac.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dOcxVGKpJ2Ry5ar/GlC2/JwoDccXRVq0YypGyMPYT1Q=;
        b=o9DVmDcSMJGusw3NXODwPd/KyTjoET1R0iErLSQy/PCYeX0qVDDdn8ttdieklYFBws
         fSEA/pRF/3jRx5VVuyYyFp6r+G7oTy0whLgbuydSUk8vPtsMbYCp665WyYp6AsrOnmGH
         pkoKvcKToMFPYD25VEV3oFtukCWhpWHCYXHtHYXCgkL/ZsG9RSRJpuIk4nS0jdKr4NXe
         FwpjEL23TlCdr8j0NOhtVoe6Vb7qHIzgqk8J2QqOSzmmgAu2a+NEUjcRSuk66IFnc7eU
         mWWXkNWf9PwDDQNHiW4Y1ZwPmpTtkY3aT2hV1u6+qiwKdjQ9HPQ7U01nGvCoQiDWOeH2
         knhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dOcxVGKpJ2Ry5ar/GlC2/JwoDccXRVq0YypGyMPYT1Q=;
        b=IgsNWdqVL4GkcbGtluwwQoTVSLtFlUww2MfLtHJuKucc1Zhk3VM7ZYlZ0xdMpB2s3S
         TBLh6xmFst6KRlibsNX/IJTo1jiUUqutM4GbA8GHwvwdTUpFlPfGmwJQI599G4yBVP3K
         m6BhB8kcYNy7yVn/UFndz9xpVaEcKVsQktnfrexuO241jlmjI4/rt6l0oF6YQBiMGk5e
         8kZLAr10QW4xSUGp5/EiGwzj1p+2YUopy+wzz9UQV+wZIvKEZCpNSfUMITA9iyMQ5O4L
         Kjmh6YZiFRSdrmax/y7SoN95jPmYkDWXrjRyW7MARJCucGZQX4mx3uv1GHKU7Drw7N2F
         WNRw==
X-Gm-Message-State: ALoCoQny8eyjS0oZESj1cOze0o27V+VlJzlht9FUzsW1dZWdtd+qBJKy8Zude6SNQAM99e+aioyJkVhcaGjjLNNXnXtdKfTIPw==
X-Received: by 10.66.220.170 with SMTP id px10mr9509663pac.145.1452806840130;
        Thu, 14 Jan 2016 13:27:20 -0800 (PST)
Received: from tinman.nz.realtimegenomics.com ([114.134.15.146])
        by smtp.googlemail.com with ESMTPSA id b84sm11355009pfj.25.2016.01.14.13.27.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 13:27:19 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <87bn8o97mh.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284095>

'git subtree split' can incorrectly skip a merge even when both parents
act on the subtree, provided the merge results in a tree identical to
one of the parents. Fix by copying the merge if at least one parent is
non-identical, and the non-identical parent is not an ancestor of the
identical parent.

Also, add a test case which checks that a descendant remains a
descendent on the subtree in this case.

Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
---
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
index 751aee3..c5089c3 100755
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
+		git checkout master
+		git merge -m "merge should be skipped on subtree" no_subtree_work_branch
+
+		git subtree split --prefix folder_subtree/ --branch subtree_tip master &&
+		git subtree split --prefix folder_subtree/ --branch subtree_branch branch
+		check_equal $(git rev-list --count subtree_tip..subtree_branch) 0
+	)
+'
+
 test_done
-- 
1.9.1

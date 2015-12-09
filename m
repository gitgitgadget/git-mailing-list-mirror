From: Dave Ware <davidw@realtimegenomics.com>
Subject: [PATCH v5] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Thu, 10 Dec 2015 10:17:33 +1300
Message-ID: <1449695853-24929-1-git-send-email-davidw@realtimegenomics.com>
References: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
Cc: Dave Ware <davidw@realtimegenomics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 22:18:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6m7t-0003Cx-IW
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 22:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbbLIVSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 16:18:13 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35417 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbLIVSM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 16:18:12 -0500
Received: by pacej9 with SMTP id ej9so35666371pac.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 13:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v/43HnzZPbFCB4W5RpM/IEc7C2OD3CeS/hiTbbIuAd8=;
        b=orjMy7JQjaJpFh9faPuBJx7k6LntBeWbwxGQdWMdp2W2wScDzxHzw9D6Z7NnFnotM3
         yJYLnK8iP9Iy7zmIpBBijrDtR/tEnKVwkKffGXdHwptENq96ZvkTJY/wgtSf04/shzSn
         3g5jzXCOcEBsGjWTN9rjHOPjzaz8vSnBf7d6HRdKnWGwD3eH+fDOBEsldlFPvM0LP4nm
         CEvrLnowOfIX4Rvl1kKKSdKdaXZdQHqgE8Fg4E/qASSB+rJ8HeUPA4PNtw45nryLocRy
         cspZmNmFaXgH2WbLbZU7HsWw2DpVH+1IJyWo4GQ8gfs9s5vq/kGt+4645LXPQi6GFEYV
         5uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v/43HnzZPbFCB4W5RpM/IEc7C2OD3CeS/hiTbbIuAd8=;
        b=ihfi68GpgprM1NGf2yk4G6svpRwBYcHwpkw8tBeuhfhHib9KB2cWgb5a1O+55lawil
         LloBw5xwdp+E4LhlVyU6WXMg/KVRUFvoQOuo4ENtHZi3wPBQHX5blGuGDpNYBv/gja2U
         NQrs89Lax4D8e+3wskPDtZbfi+Z0aY5HfDLE/5I0sbdlLawB9ki7Yg6ZO59XLjb3ODre
         OvEp/APvRNFxyn1tq9845GybJAv6spkzqRoE96P0EapGuMSU6LeY2T2QhRlJvSEr1sD9
         Qhi+TAh8IPdocMBa4RkkrIsADx3Gzg3r1pQVGnZqPXkJHqCeGDd6zdZ9FHXNIlWpGHLA
         /RSg==
X-Gm-Message-State: ALoCoQkzqec+4IOI/giWBmLW+jNSy9AD5n7JOeWfP/42hRn3lssASEOFc09y0g9TAXIRv6hjgydzW2H3Ucsb2gllrI73LXK3zw==
X-Received: by 10.66.248.74 with SMTP id yk10mr11151479pac.17.1449695891702;
        Wed, 09 Dec 2015 13:18:11 -0800 (PST)
Received: from tinman.nz.realtimegenomics.com ([114.134.15.146])
        by smtp.googlemail.com with ESMTPSA id d6sm13638323pfj.82.2015.12.09.13.18.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Dec 2015 13:18:11 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282197>

'git subtree split' can incorrectly skip a merge even when both parents
act on the subtree, provided the merge results in a tree identical to
one of the parents. Fix by copying the merge if at least one parent is
non-identical, and the non-identical parent is not an ancestor of the
identical parent.

Also, add a test case which checks that a descendant can be pushed to
its ancestor in this case.

Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
---

Notes:
    Many thanks to Eric Sunshine and Junio Hamano for adivce on this patch
    
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
    
    [v4]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282182
    [v3]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282176
    [v2]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282121
    [v1]: http://thread.gmane.org/gmane.comp.version-control.git/282065

 contrib/subtree/git-subtree.sh     | 12 +++++++--
 contrib/subtree/t/t7900-subtree.sh | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9f06571..ebf99d9 100755
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
index 9051982..4fe4820 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
 	))
 '
 
+test_expect_success 'subtree descendant check' '
+	mkdir git_subtree_split_check &&
+	(
+		cd git_subtree_split_check &&
+		git init &&
+
+		mkdir folder &&
+
+		echo a >folder/a &&
+		git add . &&
+		git commit -m "first commit" &&
+
+		git branch branch &&
+
+		echo 0 >folder/0 &&
+		git add . &&
+		git commit -m "adding 0 to folder" &&
+
+		echo b >folder/b &&
+		git add . &&
+		git commit -m "adding b to folder" &&
+		cherry=$(git rev-parse HEAD) &&
+
+		git checkout branch &&
+		echo text >textBranch.txt &&
+		git add . &&
+		git commit -m "commit to fiddle with branch: branch" &&
+
+		git cherry-pick $cherry &&
+		git checkout master &&
+		git merge -m "merge" branch &&
+
+		git branch noop_branch &&
+
+		echo d >folder/d &&
+		git add . &&
+		git commit -m "adding d to folder" &&
+
+		git checkout noop_branch &&
+		echo moreText >anotherText.txt &&
+		git add . &&
+		git commit -m "irrelevant" &&
+
+		git checkout master &&
+		git merge -m "second merge" noop_branch &&
+
+		git subtree split --prefix folder/ --branch subtree_tip master &&
+		git subtree split --prefix folder/ --branch subtree_branch branch &&
+		git push . subtree_tip:subtree_branch
+	)
+'
+
 test_done
-- 
1.9.1

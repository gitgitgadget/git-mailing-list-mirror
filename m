From: Dave Ware <davidw@realtimegenomics.com>
Subject: [PATCH v4] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Wed,  9 Dec 2015 13:19:37 +1300
Message-ID: <1449620377-30479-1-git-send-email-davidw@realtimegenomics.com>
References: <xmqqk2ook52u.fsf@gitster.mtv.corp.google.com>
Cc: Dave Ware <davidw@realtimegenomics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 01:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6SUd-0000DD-PS
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 01:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbbLIAUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 19:20:21 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36057 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbbLIAUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 19:20:20 -0500
Received: by pacdm15 with SMTP id dm15so19941779pac.3
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 16:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ln9xEQGT5LCF0QsXhnH5evoh/jTHk6/8a/IFXKXtRbU=;
        b=t9E/yoPsEqqIYEgqkoeu0dUecD3DTjDxC9fhbyQ0E2cWcXuqIKByppsEUMlBBx0/q1
         YxltQv0x31spPWL0l/q6SzI/jHupJ4cTUFlD3GyDWZt6rpowrBQV1JuS1N0V3f0Be3ai
         oDU2tSdkPjbqxa0f9tmvQYAsrqrjrtDwIe+K0BRZma0r9UZvuvYCYgqIQhGEHtm/xScw
         jGv5D4aKTY2D9CDXKcWFO9ZCPzL0R6tBb8V4dXPKGs7ak66SR3mJdJrJbnO1I8YpawpZ
         oEp6QAsHigCj0S5s694n+r9aAkMQyb89hjy9Q0qyd5zyfIyXpLWVemSOvEF7EYKR8kA7
         gG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ln9xEQGT5LCF0QsXhnH5evoh/jTHk6/8a/IFXKXtRbU=;
        b=FInJWsCiE9AbAABlnFJ3vVnmfHK9v6tOfdiJAAUzXQLbe/ioIl3RPVFYZRIA40uryi
         KuptXZShx3xsS6dexJJNac06YbSZcNbh+V96BNB7bFWLmynmSRI2IRK7S7jfxtVq3XsR
         a1yO4ylkUCwXKf99IbYGJSCGVrf1TljZHB3G+ZKk/PyQEnFGh3F3RDu8XV4v/Tj2e1ag
         NYAJOOYxS0uLwHED193LdoiN4pdpdkrPJMuJE5wRDxmiqNYxrG3YThpuAEvPxda97P5f
         Mg6/YSE4IV5zc9N5igmKSZYtcMaNQ1/DvDHvP7J3aVnsSJ63v0FlElN0CDf9zX/IGRtC
         RArQ==
X-Gm-Message-State: ALoCoQkWVcCU780S2Cw6/PsrY1aGwhzWRNkMue2AtXOPH77kCRx3+n0bBvBVQKMJbHCGWIEyM2OWKauU2AtP0XjAIrWcgRKxaA==
X-Received: by 10.66.216.200 with SMTP id os8mr3934173pac.143.1449620419556;
        Tue, 08 Dec 2015 16:20:19 -0800 (PST)
Received: from tinman.nz.realtimegenomics.com ([114.134.15.146])
        by smtp.googlemail.com with ESMTPSA id 186sm7120329pfa.24.2015.12.08.16.20.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Dec 2015 16:20:18 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqqk2ook52u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282182>

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
index 9051982..710278c 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
 	))
 '
 
+test_expect_success 'subtree descendent check' '
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
+	'
+
 test_done
-- 
1.9.1

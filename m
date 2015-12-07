From: Dave Ware <davidw@realtimegenomics.com>
Subject: [PATCH] contrib/subtree: fix "subtree split" skipped-merge bug.
Date: Tue,  8 Dec 2015 09:50:52 +1300
Message-ID: <1449521452-19043-1-git-send-email-davidw@realtimegenomics.com>
References: <20151207045307.GA624@flurp.local>
Cc: Dave Ware <davidw@realtimegenomics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 21:52:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62lo-0007xu-DU
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbbLGUwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 15:52:19 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35204 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbbLGUwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 15:52:17 -0500
Received: by pacej9 with SMTP id ej9so130644560pac.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 12:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KNF8yRF98byHHNEpvew0YNoIA2ytImGEoj6giD/xUa8=;
        b=h/9b6MkRqMcb4x5JQTRhWLJ3Xc7e/NuDGEweCfFPVAijftmqD7l4Tcg23k7KxVybME
         LFDnsq89XFj3qeNS3IZnjZuKEbg4FiuADMzY6RCm/G+XY2GgvPQ+GinYVdNOhnRk+/20
         hWHH+LWey4tS41zQgssii3Oyk8cu0qRMzf2e1F2cH7Zi56XJnGqZsYzOhcPqWUHE5d29
         sUpHCBWR2bsz6SmLRdRlgo1Au4+r/ABKFF9M8Fj74UVWPZEGwqGJWFuA949OvfPedYUQ
         CADIuPzzk5EFsitoyrN54uyn3Lp3FfI+yY7D6UtptslLTvofc/1LQl2HPgpOvFPzS10l
         TAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KNF8yRF98byHHNEpvew0YNoIA2ytImGEoj6giD/xUa8=;
        b=FPa1dhWn9IIUC4Z1DSJ/ttOnK/7vv8NlcadjNycgGvO6cbauy5XfK4v6j+9nzVwX+G
         GDIoiH2ipDd6F03atcZ1+ZVVEtjnoOK3blZ+DC1P1cV4K+iH47diPFuszueO31YNyS8b
         MCQ2fwuisolvFa7y0t2+OkKqA5CfAQP/tOPEJ7/bUDTtY4YCHWw60XjzGaSirR23OJH0
         vuTnyzVzIRgdH7TB8dGFuj3UMUCiqLcureHAF8uxL5YfI9BxP+rXnHltcmtbpKmhSBAW
         qlFpZoSwhkOc8acUzXCedMuRSwXWRRiHgH8N5hva12iVSrymOxqzE1JaWD9Y8vU+qqnJ
         JhDA==
X-Gm-Message-State: ALoCoQkkf/Rhewv4MCt+wB+mxx0nVhzl4wcmbnyYjJuKGK2lh7eNvcBehc6i9N3iaadtCACxIR3i
X-Received: by 10.66.162.38 with SMTP id xx6mr46448763pab.57.1449521536729;
        Mon, 07 Dec 2015 12:52:16 -0800 (PST)
Received: from tinman.nz.realtimegenomics.com ([114.134.15.146])
        by smtp.googlemail.com with ESMTPSA id uz4sm30432378pac.39.2015.12.07.12.52.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Dec 2015 12:52:15 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20151207045307.GA624@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282121>

A bug occurs in 'git-subtree split' where a merge is skipped even when
both parents act on the subtree, provided the merge results in a tree
identical to one of the parents. Fix by copying the merge if at least
one parent is non-identical, and the non-identical parent is not an
ancestor of the identical parent.

Also adding a test case, this checks that a descendant can be pushed to
it's ancestor in this case.

Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
---
 contrib/subtree/git-subtree.sh     | 12 +++++++--
 contrib/subtree/t/t7900-subtree.sh | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9f06571..b837531 100755
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
+		extras=$(git rev-list --boundary $identical..$nonidentical)
+		if [ -n "$extras" ]; then
+			# we need to preserve history along the other branch
+			copycommit=1
+		fi
+	fi
+	if [ -n "$identical" ] && [ -z "$copycommit" ]; then
 		echo $identical
 	else
 		copy_commit $rev $tree "$p" || exit $?
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 9051982..ea991eb 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
 	))
 '
 
+test_expect_success 'subtree descendent check' '
+  mkdir git_subtree_split_check &&
+  (
+    cd git_subtree_split_check &&
+    git init &&
+
+    mkdir folder &&
+
+    echo a >folder/a &&
+    git add . &&
+    git commit -m "first commit" &&
+
+    git branch branch &&
+
+    echo 0 >folder/0 &&
+    git add . &&
+    git commit -m "adding 0 to folder" &&
+
+    echo b >folder/b &&
+    git add . &&
+    git commit -m "adding b to folder" &&
+    cherry=$(git rev-list HEAD -1) &&
+
+    git checkout branch &&
+    echo text >textBranch.txt &&
+    git add . &&
+    git commit -m "commit to fiddle with branch: branch" &&
+
+    git cherry-pick $cherry &&
+    git checkout master &&
+    git merge -m "merge" branch &&
+
+    git branch noop_branch &&
+
+    echo d >folder/d &&
+    git add . &&
+    git commit -m "adding d to folder" &&
+
+    git checkout noop_branch &&
+    echo moreText >anotherText.txt &&
+    git add . &&
+    git commit -m "irrelevant" &&
+
+    git checkout master &&
+    git merge -m "second merge" noop_branch &&
+
+    git subtree split --prefix folder/ --branch subtree_tip master &&
+    git subtree split --prefix folder/ --branch subtree_branch branch &&
+    git push . subtree_tip:subtree_branch
+  )
+  '
+
 test_done
-- 
1.9.1

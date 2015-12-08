From: Dave Ware <davidw@realtimegenomics.com>
Subject: [PATCH v3] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Wed,  9 Dec 2015 09:39:20 +1300
Message-ID: <1449607160-20608-1-git-send-email-davidw@realtimegenomics.com>
References: <CAPig+cR36772YDc5RQRwXP3+ucVWumim9HYTXVMuGXN2cnQ7Ow@mail.gmail.com>
Cc: Dave Ware <davidw@realtimegenomics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 21:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6P41-0002Gi-M0
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 21:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbLHUkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 15:40:41 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32816 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbbLHUkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 15:40:39 -0500
Received: by pfnn128 with SMTP id n128so17534589pfn.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=glSJpcNwc6SX39C3GnnDMVP3CTC/Qd1UkIWPu857SNE=;
        b=GbqJfXsK5dZ5cn/ynoC1iplhI8JaKFenaKIM/ZsbalrKWQrsCAtqQVM1xu3mI5CTCa
         xuLgSEYzl7L5sSMOAC8ak0Byxs0cEYsoBWR/k3EjU/0hdXZeCbIVpJI+oSAoO00xMTeL
         uOAtkBLbfZqLO+Yly6jZzjMMSoXRU0yc4CZOG0jLerufJ8xgbKbVWf8HzPhlFIx8ANQt
         +uKGXvGlf97vKqv2dFrsxUwgToXEQxWShEywje/dbQ5rrsefmon/DkcvAPR1SZkP5j7S
         A3CBuboPoqpAYs/58Zbie1BD3MOAolc6YKo25JU8Z1sJOT6FBpq7PBCPgr/89+lp0emy
         5SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=glSJpcNwc6SX39C3GnnDMVP3CTC/Qd1UkIWPu857SNE=;
        b=G6s6+Yfr6Iae6JT62PH0IGpmUUO7pgoYrSR9uwnsYgrPwdGw3WOlMXuSECkwUdnE8m
         +yAFB5986jSVKY2P12NM7eDRZyEPd9i9RqbeZJrKBoMbjGlRWWQCmg/hjXOKgo8wgdzr
         sgUW6FVq6UscKtsjZzeNnAw696+hoYVKrE18HNIQsv2kFbhWpdp4lRQZNyAMlq1uPnyg
         HBQub/tDPRketEROsPypIgz9ydIfBHDVrtsPn9Z0iUprO7sN8tg5B3zXLOFZrwS+2zM+
         sqMKyLU1QogXGLg3ofi/xawj/GL+6h9NZL+wRcVRep+GLyZ9de5ImcrjSbhGdme8N+vM
         PTCA==
X-Gm-Message-State: ALoCoQnEvpHgvPOct8TY7tcEr1kb0nxO9GbO+n6H4Mri8igEnOJBQs9CVeN/+32zgH1Kca1E8E2CsCcFGfseOnCjeWjbbVsDIQ==
X-Received: by 10.98.44.137 with SMTP id s131mr7832771pfs.11.1449607238984;
        Tue, 08 Dec 2015 12:40:38 -0800 (PST)
Received: from tinman.nz.realtimegenomics.com ([114.134.15.146])
        by smtp.googlemail.com with ESMTPSA id w23sm6575074pfi.96.2015.12.08.12.40.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Dec 2015 12:40:38 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAPig+cR36772YDc5RQRwXP3+ucVWumim9HYTXVMuGXN2cnQ7Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282176>

A bug occurs in 'git-subtree split' where a merge is skipped even when
both parents act on the subtree, provided the merge results in a tree
identical to one of the parents. Fix by copying the merge if at least
one parent is non-identical, and the non-identical parent is not an
ancestor of the identical parent.

Also, add a test case which checks that a descendant can be pushed to
its ancestor in this case.

Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
---

Notes:
    Many thanks to Eric Sunshine for his adivce on this patch
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
    
    [v2]: http://thread.gmane.org/gmane.comp.version-control.git/282065/focus=282121
    [v1]: http://thread.gmane.org/gmane.comp.version-control.git/282065

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

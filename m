From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 5/7] rebase -p: use --cherry-mark for todo file
Date: Wed, 18 Jul 2012 00:27:33 -0700
Message-ID: <1342596455-17046-6-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:28:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOg2-0008T4-C2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab2GRH16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:27:58 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:53572 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2GRH1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:50 -0400
Received: by yenl3 with SMTP id l3so130544yen.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=6eFK5BSvkz3mDAmt/YFOiNim1JIKsewYuLuqq3mVQaM=;
        b=ob7sPbxoWgXfo47RQD8i/KNPUj+9qFJDv1jM3ag8Rg8B1sxWdic307arzEG2ZQCAN/
         puxhdORUW8qk3KJ+4ft/wZujayXP9DcqfMgdtB7vtkhrjrh7NzQ7bhGwsGWI5/4ufdNf
         R+JjFsUt9VTVCrKOZOeTDypyNhzNjUP6ekRw1j/IcLZ3K2CrKPYIqNV3SpBhl1XodTsT
         sbW+1epaSpsEZWwBYwAM3vj8BfSY6828kYGCSzBwOS3UQpwE8h8ekh3nbIMfGQNgZcHl
         HrIhdUk1xAGOabGYai8sWY4P+9XnI8w+fvWKNvqSp+tu/I63ajiEWz0zqP3sIk7wzjWu
         tq4Q==
Received: by 10.236.79.198 with SMTP id i46mr997526yhe.4.1342596469776;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.236.79.198 with SMTP id i46mr997521yhe.4.1342596469741;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id u67si3938852yhi.7.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id A04BF100047;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 306A9C195B; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQkds4cQmNjPKkIV/9QY66m14RxrPBhLIxX9+2Zl7GzKit+JTcVzjoUT7KGn+pxHEa9IwU5ufLm8DqGY/xeou05rSV2AbAvg0DwnxevYner4LCF1oD3wKIdQBrAa/At7290YiYf9j0NCfY0WnvaqCNxhFKvUHUGi/6qXqdZybMeExTz1wRwei4b1lK4HG4IOtzBJ6aLG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201660>

While building the todo file, 'rebase -p' needs to find the
cherry-picked commits in the branch that is about to be rebased. For
this, it calculates the set difference between the full set of commits
and the non-cherry-picked ones (as reported by 'git rev-list
--left-right --cherry-pick'). Now that have the 'git rev-list
--cherry-mark' option (since adbbb31 (revision.c: introduce
--cherry-mark, 2011-03-07)), we can instead use that option to get the
set of cherry-picked commits.
---
 git-rebase--interactive.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9715830..47beb58 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -859,17 +859,12 @@ then
 			add_pick_line $sha1
 		fi
 	done
-	# Watch for commits that been dropped by --cherry-pick
+	# Now drop cherry-picked commits
 	mkdir "$dropped"
-	# Save all non-cherry-picked changes
-	git rev-list $revisions --left-right --cherry-pick | \
-		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
-	# Now all commits and note which ones are missing in
-	# not-cherry-picks and hence being dropped
-	git rev-list $revisions |
+	git rev-list $revisions --cherry-mark --right-only | sed -ne "s/^=//p" |
 	while read rev
 	do
-		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
-- 
1.7.11.1.104.ge7b44f1

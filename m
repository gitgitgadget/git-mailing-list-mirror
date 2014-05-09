From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/17] contrib: remove 'rerere-train'
Date: Fri,  9 May 2014 14:11:39 -0500
Message-ID: <1399662703-355-14-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDv-0001jz-9N
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313AbaEITMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:43 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:32901 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241AbaEITMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:40 -0400
Received: by mail-yk0-f174.google.com with SMTP id 9so3835408ykp.33
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRMsmW18+WFLp3+E9aJ+r15atUrCJcTVbbcg5AKDXJw=;
        b=UY+LJ5/LM3F+6L3+5xDOB9Y5qTF0Fckkb8BadEKOvCXBc2Xp+g5Wau9MMayEV+U7Xw
         PmoRL54vmimgOLXBowGGDnIrLWsr4iA9ywG/wT174zxqdr9lAh7j+Qn2qNvu9+TOBNuM
         6urC0/QBcwQjglQQ23zdQZWiaDRWPpTIThcB5OPN//AwelwT3Sl/GJo2ERst6gzcHszy
         hMcfjK+gQVIl6UCvYjT1Zd98tfCE+cCuLGdGJYn6KQ0ez7LPrGMcaekFd9RYvIDkLTh7
         rcmJKjrjRJ8rahwSrKFFxzKCFPcc93NF7lppyUEoD1OVh/FrJhiHdpmJZka7lIofXyjo
         Dnfw==
X-Received: by 10.236.129.227 with SMTP id h63mr17573206yhi.148.1399662760155;
        Fri, 09 May 2014 12:12:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a104sm7425130yhq.5.2014.05.09.12.12.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248625>

No activity, no nothing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/rerere-train.sh | 52 -------------------------------------------------
 1 file changed, 52 deletions(-)
 delete mode 100755 contrib/rerere-train.sh

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
deleted file mode 100755
index 36b6fee..0000000
--- a/contrib/rerere-train.sh
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2008, Nanako Shiraishi
-# Prime rerere database from existing merge commits
-
-me=rerere-train
-USAGE="$me rev-list-args"
-
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-. $(git --exec-path)/git-sh-setup
-require_work_tree
-cd_to_toplevel
-
-# Remember original branch
-branch=$(git symbolic-ref -q HEAD) ||
-original_HEAD=$(git rev-parse --verify HEAD) || {
-	echo >&2 "Not on any branch and no commit yet?"
-	exit 1
-}
-
-mkdir -p "$GIT_DIR/rr-cache" || exit
-
-git rev-list --parents "$@" |
-while read commit parent1 other_parents
-do
-	if test -z "$other_parents"
-	then
-		# Skip non-merges
-		continue
-	fi
-	git checkout -q "$parent1^0"
-	if git merge $other_parents >/dev/null 2>&1
-	then
-		# Cleanly merges
-		continue
-	fi
-	if test -s "$GIT_DIR/MERGE_RR"
-	then
-		git show -s --pretty=format:"Learning from %h %s" "$commit"
-		git rerere
-		git checkout -q $commit -- .
-		git rerere
-	fi
-	git reset -q --hard
-done
-
-if test -z "$branch"
-then
-	git checkout "$original_HEAD"
-else
-	git checkout "${branch#refs/heads/}"
-fi
-- 
1.9.2+fc1.28.g12374c0

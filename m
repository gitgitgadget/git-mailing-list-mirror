From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 14/25] contrib: remove 'rerere-train'
Date: Thu,  8 May 2014 19:58:25 -0500
Message-ID: <1399597116-1851-15-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZKo-0000jt-Qb
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbaEIBKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:10:38 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:56756 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbaEIBKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:10:34 -0400
Received: by mail-yk0-f180.google.com with SMTP id q9so2886581ykb.39
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U3fhgw3KKzYFUFRCfmRylZCQdOmgV9TgbfpFF2/kJkI=;
        b=Ix2Qr+WfZ8HAoknM7xrgNNaOlwtDZRhjmpxDkwQ2kM++B4YI/bqXFjv8bJuXD27gJp
         ifTAXh5ssy2zVmbcZTFYdntsN25YCmhergTJagDjN493TGF815giQftfqRpN3LJjWYkk
         5cDbIbc/yIF58Y90gUh4QZGDjyTUbvv2Hpmiv69rU/3ncAZWoYBL6Lc0sKS5Ej/HbWwX
         M9PiyttlO7Q5ot/y3z1Im9WkgcJ/FHtuH2OUUdUxoptDlok/joyw2broBU2kZSTimlUp
         gYkuObzpB53S3cp+Y44dUD6r8vbRSjoksBOHCxTBdxQhgwxl02OonxVtZfxXZznoLQDO
         HtVg==
X-Received: by 10.236.115.198 with SMTP id e46mr10136465yhh.24.1399597834341;
        Thu, 08 May 2014 18:10:34 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e64sm3920829yhc.27.2014.05.08.18.10.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:10:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248479>

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
1.9.2+fc1.27.gbce2056

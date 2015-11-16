From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Optimize usage of grep by passing -q
Date: Mon, 16 Nov 2015 13:43:29 -0800
Message-ID: <1447710209-13117-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Mon Nov 16 22:43:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyRYs-0006FZ-So
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 22:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbbKPVni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 16:43:38 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34137 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbbKPVni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 16:43:38 -0500
Received: by padhx2 with SMTP id hx2so187368722pad.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 13:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sli7DaHko0UU/1UfNlDNL5tTyfl5ZXXhG8stQ6l7C+Y=;
        b=dfsmiYSEvVgs5I5rieOJ1UG4cWq8SzgCXL1S6MmNk4DnMo2imUHTt6JxvnJ9TzaXTH
         z/nKz3/jMQC/X3g8Zvt9kLiI0IGGqczXeEgKg9Udww4LtFD57Trv0iO0/x9a6xpObwK3
         2RQp8waiK9MGA6ol7F0sjfVWG3lg2hxJjLHEbPC02tGm70mWRW1jUQSqERhUFyXKADBG
         p3K21RsTYUiYS+ZfEFjzlktHMR8fa1qg9ZkExSrn7HuMnVmoDSXhOcS4v9K+eV3n+WLR
         z/tFp04B5a7TWHQgbD0RbsTTYJDy9YZNtsRn7Eu3S6yqRc4HLUIHpr5lwRIWKe98S4hE
         Yrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sli7DaHko0UU/1UfNlDNL5tTyfl5ZXXhG8stQ6l7C+Y=;
        b=jKWctXrjwT6+S8Y7uV7IgA3YXKg/2XfKUb7zyJB1ullzRKxfZZw0wWUiJRpwLPLSEK
         yuUVD2oklh89J/4Z5/OJ+7d3rGK+xaLOB2DY/oSUZzCAIqx3Nv8rXNAIBS3A8bAD5iQb
         rzXCHEZyfYMMxOJ07o7UP1QwBKVMBJqnHqq4BJlBbhf+FBUn+VXvIGVCXxAgbeENPRWa
         kvv8qPxe2v8vMAHzJJThRe4RNbS40NmLAu7ErKKpEztesCp9WBCtZU4s9qDemewUBbLT
         LZE5skNuCM/Zt6zvBoXkt7P+ee6v/4VeY3GTlCf0ldJRxpgJVYzLhEA+8DCIBdD6KqBN
         47/g==
X-Gm-Message-State: ALoCoQkTWuEP9MWtc/eDBCNFjj97R2aBhPy9TI2uB6MkiaKm2XLLVYE0zO/q2AD1MuTsEnchV4xi
X-Received: by 10.67.22.66 with SMTP id hq2mr56932312pad.81.1447710216951;
        Mon, 16 Nov 2015 13:43:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:380a:a12b:fed2:c2ed])
        by smtp.gmail.com with ESMTPSA id yh3sm38373847pbb.82.2015.11.16.13.43.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 Nov 2015 13:43:36 -0800 (PST)
X-Mailer: git-send-email 2.6.3.368.gf34be46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281359>

Instead of redirecting all grep output to /dev/null, we can just
pass in -q instead. This preserves the exit code behavior, but is faster.
As grep returns true if it finds at least one match, grep can exit promptly
after finding the first line and doesn't need to find more occurrences
which would be redirected to /dev/null anyways.

This is true for the gnu version of grep. I am not sure if all
versions of grep support this optimization. In case it is not,
we'd revert this patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-bisect.sh              | 5 ++---
 git-rebase--interactive.sh | 2 +-
 git-rebase.sh              | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..b909605 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -519,8 +519,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 
 		cat "$GIT_DIR/BISECT_RUN"
 
-		if sane_grep "first $TERM_BAD commit could be any of" "$GIT_DIR/BISECT_RUN" \
-			>/dev/null
+		if sane_grep -q "first $TERM_BAD commit could be any of" "$GIT_DIR/BISECT_RUN"
 		then
 			gettextln "bisect run cannot continue any more" >&2
 			exit $res
@@ -533,7 +532,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
-		if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BISECT_RUN" >/dev/null
+		if sane_grep -q "is the first $TERM_BAD commit" "$GIT_DIR/BISECT_RUN"
 		then
 			gettextln "bisect run success"
 			exit 0;
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d65c06e..f360ac0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1225,7 +1225,7 @@ then
 	git rev-list $revisions |
 	while read rev
 	do
-		if test -f "$rewritten"/$rev && test "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev && test "$(sane_grep -q "$rev" "$state_dir"/not-cherry-picks)"
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
diff --git a/git-rebase.sh b/git-rebase.sh
index af7ba5f..b6a5f73 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -578,7 +578,7 @@ mb=$(git merge-base "$onto" "$orig_head")
 if test "$type" != interactive && test "$upstream" = "$onto" &&
 	test "$mb" = "$onto" && test -z "$restrict_revision" &&
 	# linear history?
-	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
+	! (git rev-list --parents "$onto".."$orig_head" | sane_grep -q " .* ")
 then
 	if test -z "$force_rebase"
 	then
-- 
2.6.3.368.gf34be46

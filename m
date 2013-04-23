From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] sh-setup: introduce require_clean_work_tree --quiet
Date: Tue, 23 Apr 2013 19:32:03 +0530
Message-ID: <1366725724-1016-7-git-send-email-artagnon@gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdmK-0001SN-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab3DWOAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:52 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51004 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab3DWOAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:49 -0400
Received: by mail-pa0-f46.google.com with SMTP id lb1so516493pab.19
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=s4RPZT9OmnCRmPDDEPYkuIodU9DrfboSP+EGJUwQlbM=;
        b=PjbqjN6ROBKbV7OJ4sysNFrSxIf0m8Pd+5BPKk4c06jbsGiLsKJaleXicfUjGsPhJ+
         VfqoPzr4GJFELs173+dCMmXsQQrIghjp4kEO7ZPkDd1zOWBlmD/lbfGo4xk8l4ar2eRB
         Lmj+Vg4d8/QmkGtCLZjDQCcaIgkRpDMRuWTJqQBq5q6ToaPMICuKbLLFyfZuiMAxRzAg
         MVSprxtPyCD8LdhWj3MOnnE+MGCKU1rAANxcncNVYjk7+AtbfkCorJZfgkcCzB64wSFy
         wZk8oJeRLgZGRDUmebX2Dj9NCM9JUAHCn4L044buW0R2RVXdG7YX9SVbV1tbPRjo4p+7
         dW+Q==
X-Received: by 10.68.172.36 with SMTP id az4mr9701163pbc.211.1366725649485;
        Tue, 23 Apr 2013 07:00:49 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.47
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
In-Reply-To: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222163>

Some callers might want to know whether or not the worktree is clean,
and require_clean_work_tree() has the logic for this.  The current
implementation of the function prints a message and exits if the
worktree wasn't clean.  Introduce a --quiet switch to get it to report
the status of the worktree back to the caller.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-sh-setup.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 2f78359..5fa22a8 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -172,6 +172,7 @@ require_clean_work_tree () {
 
 	if ! git diff-files --quiet --ignore-submodules
 	then
+		test "$1" = "--quiet" ||
 		echo >&2 "Cannot $1: You have unstaged changes."
 		err=1
 	fi
@@ -180,9 +181,11 @@ require_clean_work_tree () {
 	then
 		if [ $err = 0 ]
 		then
-		    echo >&2 "Cannot $1: Your index contains uncommitted changes."
+			test "$1" = "--quiet" ||
+			echo >&2 "Cannot $1: Your index contains uncommitted changes."
 		else
-		    echo >&2 "Additionally, your index contains uncommitted changes."
+			test "$1" = "--quiet" ||
+			echo >&2 "Additionally, your index contains uncommitted changes."
 		fi
 		err=1
 	fi
@@ -190,8 +193,9 @@ require_clean_work_tree () {
 	if [ $err = 1 ]
 	then
 		test -n "$2" && echo >&2 "$2"
-		exit 1
+		test "$1" = "--quiet" || exit 1
 	fi
+	return $err
 }
 
 # Generate a sed script to parse identities from a commit.
-- 
1.8.2.1.578.ga933817

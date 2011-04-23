From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 15/23] Introduce --same
Date: Sat, 23 Apr 2011 17:22:44 +1000
Message-ID: <1303543372-77843-16-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCt-00054D-W9
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab1DWHYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:36 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab1DWHYb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:31 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=LMjqU2/8WiHXWtj/DHe/hgEQ+pa0m5z2ndPpTEEaTIY=;
        b=oAomTD5qFnUqDjtL1ZeMIDlGABtrWGjXkKcaf/Uz0a+CtTeAYkHBmSCTaTNZCUDR5a
         C7fCOumUQxQdurkhzXcMjJwdIcpi4jRBJzIoJKgZtNDw84wwhAOe2aGLOniqOtsokmZt
         0aTXZ2v7O0HPrC5mTUVEX0I+Jv/YtWb4/caJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DDzfs2Nx3BF0gdsK13W6aYO0u3IlIMO6LRx8Uzb5D4MyMJGyfyLGZi+toonPcUJveI
         PRgdBwzBjdVj+KLmYNvm8LLJtkJOLHNX+SAparS49NWeuWnC8xL5nlLvCvHy4csWU4Ew
         RZzhzm9hiCLHtyUK/GM5LUYsr08/Zlfabox7M=
Received: by 10.68.10.98 with SMTP id h2mr2767697pbb.372.1303543471352;
        Sat, 23 Apr 2011 00:24:31 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171967>

---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   10 ++++++++++
 t/t1520-test.sh            |    8 ++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 6709fdd..b7c3161 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -90,6 +90,8 @@ CONDITIONS
 	Tests if the first commit is (not) reachable from the second.
 '--tree-same'|'--not-tree-same' first second::
         Tests if the first commit is (not) tree-same to the second commit.
+'--same'|'--not-same' first second::
+	Tests if the first object has (does not have) the same SHA1 has as the second object.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 2b7a5d1..ec9b516 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -162,5 +162,15 @@ check_tree_same_2()
 
 }
 
+check_same_2()
+{
+	if test "$(git rev-parse "$1")" = "$(git rev-parse "$2")"
+	then
+		echo "'$1' is the same as '$2'."
+	else
+		echo "'$1' is not the same as '$2'."
+		false
+	fi
+}
 
 fi
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 1fd5122..1d0776d 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -408,4 +408,12 @@ test_expect_success 'tree-same' \
 
 '
 
+test_expect_success 'same' \
+'
+   git test \
+      --same master HEAD \
+      --not-same D D1 \
+      --not-same C D 
+'
+
 test_done
-- 
1.7.5.rc1.23.g7f622

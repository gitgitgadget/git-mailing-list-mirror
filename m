From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix git-rev-parse's parent handling
Date: Wed, 10 Aug 2005 05:07:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508100506260.11734@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 10 05:08:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2gwP-0004s8-8Y
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 05:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVHJDHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 23:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVHJDHi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 23:07:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36239 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964913AbVHJDHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 23:07:38 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2CE25E31EA
	for <git@vger.kernel.org>; Wed, 10 Aug 2005 05:07:37 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id EF4D8993C1
	for <git@vger.kernel.org>; Wed, 10 Aug 2005 05:07:36 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id D965599334
	for <git@vger.kernel.org>; Wed, 10 Aug 2005 05:07:36 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id CF889E31EA
	for <git@vger.kernel.org>; Wed, 10 Aug 2005 05:07:36 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-rev-parse HEAD^1 would fail, because of an off-by-one bug (but HEAD^ 
would yield the expected result). Also, when the parent does not exist, do 
not silently return an incorrect SHA1. Of course, this no longer applies 
to git-rev-parse alone, but every user of get_sha1().

While at it, add a test.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 sha1_name.c                  |    9 ++++++---
 t/t6101-rev-parse-parents.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 t/t6101-rev-parse-parents.sh

83c1ab3e9bcba4eca5e055e27f8f4fb0b78518a5
diff --git a/sha1_name.c b/sha1_name.c
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -202,15 +202,18 @@ static int get_sha1_1(const char *name, 
 		parent = name[len-1] - '0';
 		len -= 2;
 	}
-	else if (len > 1 && name[len-1] == '^')
+	else if (len > 1 && name[len-1] == '^') {
 		parent = 1;
-	else
+		len--;
+	} else
 		parent = -1;
 
 	if (0 <= parent) {
-		ret = get_parent(name, len-1, sha1, parent);
+		ret = get_parent(name, len, sha1, parent);
 		if (!ret)
 			return 0;
+		else if(parent>0)
+			return ret;
 	}
 	ret = get_sha1_basic(name, len, sha1);
 	if (!ret)
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
new file mode 100644
--- /dev/null
+++ b/t/t6101-rev-parse-parents.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+test_description='Test git-rev-parse with different parent options'
+
+. ./test-lib.sh
+. ../t6000lib.sh # t6xxx specific functions
+
+date >path0
+git-update-cache --add path0
+save_tag tree git-write-tree
+hide_error save_tag start unique_commit "start" tree
+save_tag second unique_commit "second" tree -p start
+hide_error save_tag start2 unique_commit "start2" tree
+save_tag two_parents unique_commit "next" tree -p second -p start2
+save_tag final unique_commit "final" tree -p two_parents
+
+test_expect_success 'start is valid' 'git-rev-parse start | grep "^[0-9a-f]\{40\}$"'
+test_expect_success 'start^0' "test $(cat .git/refs/tags/start) = $(git-rev-parse start^0)"
+test_expect_success 'start^1 not valid' "test $(git-rev-parse start^1) = start^1"
+test_expect_success 'second^1 = second^' "test $(git-rev-parse second^1) = $(git-rev-parse second^)"
+test_expect_success 'final^1^1^1' "test $(git-rev-parse start) = $(git-rev-parse final^1^1^1)"
+test_expect_success 'final^1^1^1 = final^^^' "test $(git-rev-parse final^1^1^1) = $(git-rev-parse final^^^)"
+test_expect_success 'final^1^2' "test $(git-rev-parse start2) = $(git-rev-parse final^1^2)"
+test_expect_success 'final^1^2 != final^1^1' "test $(git-rev-parse final^1^2) != $(git-rev-parse final^1^1)"
+test_expect_success 'final^1^3 not valid' "test $(git-rev-parse final^1^3) = final^1^3"
+test_expect_failure '--verify start2^1' 'git-rev-parse --verify start2^1'
+test_expect_success '--verify start2^0' 'git-rev-parse --verify start2^0'
+
+test_done
+

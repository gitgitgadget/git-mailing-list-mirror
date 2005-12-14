From: Amos Waterland <apw@us.ibm.com>
Subject: git rebase loses author name/email if given bad email address
Date: Wed, 14 Dec 2005 17:48:19 -0500
Message-ID: <20051214224818.GA5362@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mostrows@watson.ibm.com
X-From: git-owner@vger.kernel.org Wed Dec 14 23:50:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmfQV-0000qX-9Q
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 23:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVLNWs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 17:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVLNWs0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 17:48:26 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:62428 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965014AbVLNWsZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 17:48:25 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBEMmNWk028312
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 17:48:23 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBEMo3GC108850
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 15:50:03 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBEMmMjl007011
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 15:48:23 -0700
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id jBEMmKPF006791;
	Wed, 14 Dec 2005 15:48:21 -0700
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1EmfQ3-0001TM-69; Wed, 14 Dec 2005 17:48:19 -0500
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13652>

If GIT_AUTHOR_EMAIL is of a certain form, `git rebase master' will blow
away the author name and email when fast-forward merging commits.  I
have not tracked it down, but here is a testcase that demonstrates the
behavior.

Signed-off-by: Amos Waterland <apw@us.ibm.com>
Acked-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 t/t3400-rebase.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100755 t/t3400-rebase.sh

6a31c31a8e6bf4328fab39f39926af6bcc794bf2
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
new file mode 100755
index 0000000..b9d3131
--- /dev/null
+++ b/t/t3400-rebase.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Amos Waterland
+#
+
+test_description='git rebase should not destroy author information
+
+This test runs git rebase and checks that the author information is not lost.
+'
+. ./test-lib.sh
+
+export GIT_AUTHOR_EMAIL=bogus_email_address
+
+test_expect_success \
+    'prepare repository with topic branch, then rebase against master' \
+    'echo First > A &&
+     git-update-index --add A &&
+     git-commit -m "Add A." &&
+     git checkout -b my-topic-branch &&
+     echo Second > B &&
+     git-update-index --add B &&
+     git-commit -m "Add B." &&
+     git checkout -f master &&
+     echo Third >> A &&
+     git-update-index A &&
+     git-commit -m "Modify A." &&
+     git checkout -f my-topic-branch &&
+     git rebase master'
+
+test_expect_failure \
+    'the rebase operation should not have destroyed author information' \
+    'git log | grep "Author:" | grep "<>"'
+
+test_done
-- 
0.99.9.GIT

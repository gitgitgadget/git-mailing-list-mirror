X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] rev-list: Document --skip and add test cases.
Date: Wed, 20 Dec 2006 14:59:48 +0000
Message-ID: <20061220145948.GD17864@localhost>
References: <20061219205422.GA17864@localhost> <7v1wmvpmef.fsf@assigned-by-dhcp.cox.net> <em9oi5$72t$1@sea.gmane.org> <20061220002906.GB17864@localhost> <7vbqlznzjm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 15:00:13 +0000 (UTC)
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vbqlznzjm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34937>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx2vH-0000Vw-PA for gcvg-git@gmane.org; Wed, 20 Dec
 2006 16:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965115AbWLTO74 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWLTO74
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:59:56 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:33573 "EHLO
 igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965115AbWLTO7z (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 09:59:55 -0500
Received: from 213-202-161-139.bas503.dsl.esat.net ([213.202.161.139]
 helo=localhost) by igraine.blacknight.ie with esmtp (Exim 4.60)
 (envelope-from <robfitz@273k.net>) id 1Gx2uj-00039x-Kj; Wed, 20 Dec 2006
 14:59:25 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---

> I am having a hard time convincing myself that this is a feature
> that is a narrow special case for rev-list and does not belong
> to the generic revision traversal machinery.

Your implementation is much better then mine.  Here's some documentation
and a set of test cases.

Robert


 Documentation/git-rev-list.txt |    5 ++++
 t/t6005-rev-list-count.sh      |   51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ec43c0b..9e0dcf8 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-rev-list' [ \--max-count=number ]
+	     [ \--skip=number ]
 	     [ \--max-age=timestamp ]
 	     [ \--min-age=timestamp ]
 	     [ \--sparse ]
@@ -139,6 +140,10 @@ limiting may be applied.
 
 	Limit the number of commits output.
 
+--skip='number'::
+
+	Skip 'number' commits before starting to show the commit output.
+
 --since='date', --after='date'::
 
 	Show commits more recent than a specific date.
diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
new file mode 100755
index 0000000..334fccf
--- /dev/null
+++ b/t/t6005-rev-list-count.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='git-rev-list --max-count and --skip test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+    for n in 1 2 3 4 5 ; do \
+        echo $n > a ; \
+        git add a ; \
+        git commit -m "$n" ; \
+    done
+'
+
+test_expect_success 'no options' '
+    test $(git-rev-list HEAD | wc -l) = 5
+'
+
+test_expect_success '--max-count' '
+    test $(git-rev-list HEAD --max-count=0 | wc -l) = 0 &&
+    test $(git-rev-list HEAD --max-count=3 | wc -l) = 3 &&
+    test $(git-rev-list HEAD --max-count=5 | wc -l) = 5 &&
+    test $(git-rev-list HEAD --max-count=10 | wc -l) = 5
+'
+
+test_expect_success '--max-count all forms' '
+    test $(git-rev-list HEAD --max-count=1 | wc -l) = 1 &&
+    test $(git-rev-list HEAD -1 | wc -l) = 1 &&
+    test $(git-rev-list HEAD -n1 | wc -l) = 1 &&
+    test $(git-rev-list HEAD -n 1 | wc -l) = 1
+'
+
+test_expect_success '--skip' '
+    test $(git-rev-list HEAD --skip=0 | wc -l) = 5 &&
+    test $(git-rev-list HEAD --skip=3 | wc -l) = 2 &&
+    test $(git-rev-list HEAD --skip=5 | wc -l) = 0 &&
+    test $(git-rev-list HEAD --skip=10 | wc -l) = 0
+'
+
+test_expect_success '--skip --max-count' '
+    test $(git-rev-list HEAD --skip=0 --max-count=0 | wc -l) = 0 &&
+    test $(git-rev-list HEAD --skip=0 --max-count=10 | wc -l) = 5 &&
+    test $(git-rev-list HEAD --skip=3 --max-count=0 | wc -l) = 0 &&
+    test $(git-rev-list HEAD --skip=3 --max-count=1 | wc -l) = 1 &&
+    test $(git-rev-list HEAD --skip=3 --max-count=2 | wc -l) = 2 &&
+    test $(git-rev-list HEAD --skip=3 --max-count=10 | wc -l) = 2 &&
+    test $(git-rev-list HEAD --skip=5 --max-count=10 | wc -l) = 0 &&
+    test $(git-rev-list HEAD --skip=10 --max-count=10 | wc -l) = 0
+'
+
+test_done
-- 
1.4.4.2.g80fef-dirty

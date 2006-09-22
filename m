From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Make cvsexportcommit remove files too.
Date: Sat, 23 Sep 2006 00:35:12 +0200
Message-ID: <20060922223512.3391.47620.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Sep 23 00:42:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQtiS-00056f-1W
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 00:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWIVWlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWIVWlO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 18:41:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18999 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S965248AbWIVWlF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 18:41:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 75A89800199
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:20 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06917-05 for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:20 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id E85E780286A
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:18 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 677CC28E15
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:41:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id roWnxofHbxrz for <git@vger.kernel.org>;
	Sat, 23 Sep 2006 00:41:08 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id DAD2028EE9
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:35:12 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27536>

From: Robin Rosenberg <robin.rosenberg@dewire.com>


---

 git-cvsexportcommit.perl       |    2 +-
 t/t9200-git-cvsexportcommit.sh |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d78100c..0b0d186 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -142,7 +142,7 @@ foreach my $f (@files) {
     if ($fields[4] eq 'M') {
 	push @mfiles, $fields[5];
     }
-    if ($fields[4] eq 'R') {
+    if ($fields[4] eq 'D') {
 	push @dfiles, $fields[5];
     }
 }
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 1041bb6..524fa2b 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -52,4 +52,16 @@ test_expect_success \
       test $(cat CVS/Entries|wc -l) = 3
       )'
      
+test_expect_success \
+     'Remove file with spaces in file name' \
+     'echo Ok then >"with spaces.txt" &&
+      rm -v "with spaces.txt" && \
+      git rm "with spaces.txt" && \
+      git commit -a -m "Remove file" &&
+      id=$(git rev-list --max-count=1 HEAD) &&
+      (cd $CVSWORK &&
+      git-cvsexportcommit.perl -v -c $id &&
+      test $(cat CVS/Entries|wc -l) = 2
+      )'
+     
 test_done

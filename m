From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: bug in read-tree -m on A -> A/A
Date: Fri, 16 Mar 2007 00:19:32 -0400
Message-ID: <20070316041932.GA31606@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 05:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS3ul-0005Xg-Or
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 05:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbXCPETh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 00:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbXCPETh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 00:19:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34584 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbXCPETg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 00:19:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HS3ug-00086J-US
	for git@vger.kernel.org; Fri, 16 Mar 2007 00:19:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CBC0C20FBAE; Fri, 16 Mar 2007 00:19:32 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42320>

dancor on #git just noticed a bug in read-tree -m that prevents
him from switching branches when the type of a path changes
between a directory and a file.  The following test appears to
trigger the same failure, but I likely won't have time to fix
it myself tonight.  So if someone else gets a chance...

diff --git a/t/t9999-typechange.sh b/t/t9999-typechange.sh
new file mode 100755
index 0000000..dc92094
--- /dev/null
+++ b/t/t9999-typechange.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description='switch branches over path typechange'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	: >A &&
+	git-add A &&
+	tree1=$(git-write-tree) &&
+	comm1=$(echo A | git-commit-tree $tree1) &&
+	git-update-ref refs/heads/comm1 $comm1 &&
+	rm .git/index &&
+	rm -f A &&
+	mkdir A &&
+	echo : >A/A &&
+	git-add A/A &&
+	tree2=$(git-write-tree) &&
+	comm2=$(echo A/A | git-commit-tree $tree2) &&
+	git-update-ref HEAD $comm2
+'
+
+test_expect_success checkout 'git-checkout $comm1'
+
+test_done

-- 
Shawn.

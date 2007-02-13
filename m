From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/3] Only show log entries for new revisions in hooks--update
Date: Tue, 13 Feb 2007 14:24:06 +0000
Message-ID: <200702131424.06983.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 15:29:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGyf5-0006Xt-QR
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 15:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbXBMO1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 09:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbXBMO1D
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 09:27:03 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:17845 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932128AbXBMOYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 09:24:09 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 13 Feb 2007 14:26:45 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HGyZk-0007jj-00
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 14:24:08 +0000
X-TUID: ecb8c641699fe2e9
X-UID: 235
X-Length: 1774
Content-Disposition: inline
X-OriginalArrivalTime: 13 Feb 2007 14:26:45.0578 (UTC) FILETIME=[FD30B2A0:01C74F7A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39526>

If you were issuing emails for two branches, and one merged the other,
you would get the same log messages appearing in two separate emails.

e.g. A working repository, where the last push to central was done at
     the revision marked "B", after which two branches were developed
     further.

  * -- B -- 1 -- 1 -- M (branch1)
        \           /
         2 -- 2 -- 2 (branch2)

Now imagine that branch2 is pushed to the email-generating repository;
an email containing all the "2" revisions would be sent.  Now, let's say
branch1 is pushed, the old update hook would run

 git-rev-list $newrev ^$baserev

Where $newrev would be "M" and $baserev would be "B".  This list
includes all the "2" revisions as well as all the "1" revisions.

This patch addresses this problem by using

 git-rev-parse --not --all | git-rev-list --stdin $newrev ^$baserev

To inhibit the display of all revisions that are already in the
repository.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index e8c536f..7e8258a 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -190,7 +190,7 @@ case "$refname_type" in
 			fi
 			echo ""
 			echo $LOGBEGIN
-			git-rev-list --pretty $newrev ^$baserev
+			git-rev-parse --not --all | git-rev-list --stdin --pretty $newrev ^$baserev
 			echo $LOGEND
 			echo ""
 			echo "Diffstat:"
-- 
1.5.0.rc4.364.g85b1

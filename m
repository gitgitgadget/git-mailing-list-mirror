From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/3] Fix potential command line overflow in hooks--update
Date: Tue, 13 Feb 2007 14:23:58 +0000
Message-ID: <200702131423.58561.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 15:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGyc2-0005B8-SW
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 15:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbXBMOYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 09:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbXBMOYH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 09:24:07 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:17839 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932132AbXBMOYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 09:24:02 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 13 Feb 2007 14:26:37 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HGyZc-0007jV-00
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 14:24:00 +0000
X-TUID: 709ee5976736f578
X-UID: 234
X-Length: 1349
Content-Disposition: inline
X-OriginalArrivalTime: 13 Feb 2007 14:26:37.0656 (UTC) FILETIME=[F877E580:01C74F7A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39524>

In a repository with a large number of refs, the following command line
could easily overflow the command line size limitations

 git-rev-list $newref $(git-rev-parse --not --all)

Fortunately, git-rev-list already has the means to cope with this
situation with the --stdin switch

 git-rev-parse --not --all | git-rev-list --stdin $newref

Which is exactly what this patch does.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index d4253cb..e8c536f 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -148,7 +148,7 @@ case "$refname_type" in
 			# This shows all log entries that are not already covered by
 			# another ref - i.e. commits that are now accessible from this
 			# ref that were previously not accessible
-			git-rev-list --pretty $newref $(git-rev-parse --not --all)
+			git-rev-parse --not --all | git-rev-list --stdin --pretty $newref
 			echo $LOGEND
 		else
 			# oldrev is valid
-- 
1.5.0.rc4.364.g85b1

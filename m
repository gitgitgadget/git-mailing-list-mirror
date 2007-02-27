From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/2] cvsserver: Remove trailing "\n" from commithash in checkin function
Date: Tue, 27 Feb 2007 12:49:09 +0000
Message-ID: <200702271249.09596.andyparkins@gmail.com>
References: <200702210908.59579.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 13:49:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1li-00077I-UL
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbXB0MtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030614AbXB0MtN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:49:13 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:39427 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030609AbXB0MtN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:49:13 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 27 Feb 2007 12:51:19 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HM1lW-0005oQ-00
	for <git@vger.kernel.org>; Tue, 27 Feb 2007 12:49:10 +0000
In-Reply-To: <200702210908.59579.andyparkins@gmail.com>
X-TUID: 4ca6e8228c336785
X-UID: 264
X-Length: 1370
Content-Disposition: inline
X-OriginalArrivalTime: 27 Feb 2007 12:51:19.0890 (UTC) FILETIME=[FA328B20:01C75A6D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40724>

The commithash for updating the ref is obtained from a call to
git-commit-tree.  However, it was returned (and stored) with the
trailing newline.  This meant that the later call to git-update-ref that
was trying to update to $commithash was including the newline in the
parameter - obviously that hash would never exist, and so git-update-ref
would always fail.

The solution is to chomp() the commithash as soon as it is returned by
git-commit-tree.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 git-cvsserver.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 8e12f81..f4b8bd2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1152,6 +1152,7 @@ sub req_ci
     close $msg_fh;
 
     my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;
+	chomp($commithash);
     $log->info("Commit hash : $commithash");
 
     unless ( $commithash =~ /[a-zA-Z0-9]{40}/ )
-- 
1.5.0.2.778.gdcb06

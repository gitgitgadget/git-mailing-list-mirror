From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] New files in git weren't being downloaded during CVS update
Date: Mon, 22 Jan 2007 10:46:12 +0000
Message-ID: <200701221046.12795.andyparkins@gmail.com>
References: <200701221044.49467.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 22 11:46:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8wgt-0005Jo-Ld
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 11:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbXAVKqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 05:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbXAVKqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 05:46:16 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:61278 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533AbXAVKqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 05:46:16 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 22 Jan 2007 10:49:04 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1H8wgo-0005g1-00
	for <git@vger.kernel.org>; Mon, 22 Jan 2007 10:46:14 +0000
In-Reply-To: <200701221044.49467.andyparkins@gmail.com>
To: git@vger.kernel.org
X-TUID: 6586a7cca6ceaff4
X-UID: 204
X-Length: 2333
Content-Disposition: inline
X-OriginalArrivalTime: 22 Jan 2007 10:49:04.0843 (UTC) FILETIME=[EF4C31B0:01C73E12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37405>

If a repository was checked out via git-cvsserver and then later a new
file is added to the git repository via some other method; a CVS update
wasn't fetching the new file.

It would be reported as a new file as
 A some/dir/newfile.c
but would never appear in the directory.

The problem seems to be that git-cvsserver was treating these two cases
identically, as "A" type results.

1. New file in repository
2. New file locally

In fact, traditionally, case 1 is treated as a "U" result, and case 2
only is treated as an "A" result.  "A", should just report that the file
is added locally and then skip that file during an update as their is
(of course) nothing to send.

In both these cases there is no working revision, so the checking for
"is there no working revision" will return true.  The test for case 2
needs refining to say "if there is no working revision and no upstream
revision".  This patch does just that, leaving case 1 to be handled by
the normal "U" handler.

I've also updated the log message to more accurately describe the
operation.  i.e. that "A" means that content is scheduled for addition;
not that it actually has been added.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 git-cvsserver.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a33a876..2479f71 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -876,9 +876,9 @@ sub req_update
                 print "MT newline\n";
 		next;
 	    }
-	    elsif ( !defined($wrev) || $wrev == 0 )
+	    elsif ( (!defined($wrev) || $wrev == 0) && (!defined($meta->{revision}) || $meta->{revision} == 0) )
 	    {
-	        $log->info("Tell the client the file will be added");
+	        $log->info("Tell the client the file is scheduled for addition");
 		print "MT text A \n";
                 print "MT fname $filename\n";
                 print "MT newline\n";
-- 
1.5.0.rc2.g3f8f2

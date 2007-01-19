From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] New files in git weren't being downloaded during CVS update
Date: Fri, 19 Jan 2007 10:49:40 +0000
Message-ID: <200701191049.40833.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 19 23:24:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H82AA-0005n2-V0
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbXASWY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbXASWY2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:24:28 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:59401 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964983AbXASWY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:24:27 -0500
Received: by an-out-0708.google.com with SMTP id b33so327375ana
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 14:24:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=TT7+RCVWTrNYxUgUPbH+wccsiAqAj0eshZzUQsG+c6J3pE9au02GqTcvdO7jCWbrA65KnGzCcjhvldDikSqHITb5xKtnLawD8Lplg5nTS7df2q/8F3vmZZfqxEyNs3Z4hDbeM7gzE4FY9rn0kaHeeiCtCQ4Ym6QnGyF62GqjskI=
Received: by 10.78.181.13 with SMTP id d13mr248245huf.1169203948170;
        Fri, 19 Jan 2007 02:52:28 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 37sm2245393hua.2007.01.19.02.52.27;
        Fri, 19 Jan 2007 02:52:27 -0800 (PST)
To: git@vger.kernel.org
X-TUID: 9d85a71b07f00e5c
X-UID: 202
X-Length: 1340
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37212>

If a repository was checked out via git-cvsserver and then later a new
file is added to the git repository via some other method; a CVS update
wasn't fetching the new file.

It would be reported as a new file as
 A some/dir/newfile.c
but would never appear in the directory.

The problem (I think) is that when git-cvsserver detected a new file, it
was issuing the new file message then skipping the actual file send part
and moving to the next file its list.  In fact only an updated file
would be transmitted.

The fix is to simply remove the "next" that was skipping the file
transmit; which is what this patch does.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I don't understand enough about the CVS protocol to know whether this really
is the right fix.  It certainly addresses my problem, but I assume that the "next"
was put in there for a reason.

 git-cvsserver.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a33a876..c370a53 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -882,7 +882,6 @@ sub req_update
 		print "MT text A \n";
                 print "MT fname $filename\n";
                 print "MT newline\n";
-		next;
 
 	    }
 	    else {
-- 
1.5.0.rc1.gf4b6c

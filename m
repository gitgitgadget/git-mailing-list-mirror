From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] New files in git weren't being downloaded during CVS update
Date: Sun, 21 Jan 2007 14:25:12 +0000
Message-ID: <200701211425.12971.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 21 15:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8dgC-0008MB-0f
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 15:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbXAUO2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 09:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXAUO2G
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 09:28:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29996 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXAUO2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 09:28:04 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1044574nfa
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 06:28:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=OMJszPX3dTgCZJIMqQJDtaYoDsXF080rn6Ds0e6zaWwSeiiUlk3ThkDZBjM0HnM9Zfu3TvwhYpPiv+Foha6+CapOhBS1q0Z7rEAx5kxDWUpMLcXxoJjLEJdyb50FqLmOwQJTu5rpu77QA19cAU52nPkK7cHunHhhUF8uFej7WcI=
Received: by 10.49.43.2 with SMTP id v2mr5071858nfj.1169389682669;
        Sun, 21 Jan 2007 06:28:02 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 23sm4951769hud.2007.01.21.06.28.01;
        Sun, 21 Jan 2007 06:28:02 -0800 (PST)
To: git@vger.kernel.org
X-TUID: 208a11b650266470
X-UID: 203
X-Length: 1791
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37326>

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

The fix is to make the added file section identical to the udpated file
section.  This additionally makes git-cvsserver behave like a
traditional CVS server and will now output
 U some/dir/newfile.c
for an added file.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
This is in response to Simon Schubert's suggestion that T_ADDED is an
inappropriate category for a remotely added file.  Instead this treats
remotely added files the same as remotely changed files.

 git-cvsserver.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a33a876..501c182 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -879,11 +879,11 @@ sub req_update
 	    elsif ( !defined($wrev) || $wrev == 0 )
 	    {
 	        $log->info("Tell the client the file will be added");
-		print "MT text A \n";
-                print "MT fname $filename\n";
-                print "MT newline\n";
-		next;
-
+			print "MT +updated\n";
+			print "MT text U \n";
+			print "MT fname $filename\n";
+			print "MT newline\n";
+			print "MT -updated\n";
 	    }
 	    else {
                 $log->info("Updating '$filename' $wrev");
-- 
1.5.0.rc1.gf4b6c

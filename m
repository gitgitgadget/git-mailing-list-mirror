From: Sergei Organov <osv@javad.com>
Subject: [PATCH] cvsserver: make the output of 'update' more compatible with cvs.
Date: Thu, 03 Dec 2009 23:12:47 +0300
Message-ID: <87zl5z4y0w.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 21:19:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGI9J-0002yx-FG
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 21:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZLCUTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 15:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbZLCUTY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 15:19:24 -0500
Received: from javad.com ([205.178.136.214]:42118 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbZLCUTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 15:19:24 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2009 15:19:24 EST
Received: (qmail 30631 invoked from network); 3 Dec 2009 20:12:48 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 3 Dec 2009 20:12:48 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.69)
	(envelope-from <osv@osv.gnss.ru>)
	id 1NGI2h-0003qs-7J; Thu, 03 Dec 2009 23:12:47 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134472>

Native cvs update outputs the string "cvs update: Updating <DIR>" for
every directory it processes (to stderr). This is used, e.g., by emacs
pcl-cvs to split files by directory. This commit implements this
feature in cvsserver.
---
 git-cvsserver.perl |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 6dc45f5..5994951 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -981,10 +981,22 @@ sub req_update
 
     #$log->debug("update state : " . Dumper($state));
 
+    my $last_dirname = "///";
+    
     # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
         $filename = filecleanup($filename);
+        my $cur_dirname = dirname($filename);
+        if ( $cur_dirname ne $last_dirname )
+        {
+            $last_dirname = $cur_dirname;
+            if ( $cur_dirname eq "" )
+            {
+                $cur_dirname = ".";
+            }
+            print "E cvs update: Updating $cur_dirname\n";
+        }
 
         $log->debug("Processing file $filename");
 
-- 
1.6.6.rc0.67.g68b144.dirty

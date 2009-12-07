From: Sergei Organov <osv@javad.com>
Subject: [PATCH v2] cvsserver: make the output of 'update' more compatible with cvs.
Date: Mon, 07 Dec 2009 14:11:44 +0300
Message-ID: <87bpibdonj.fsf@osv.gnss.ru>
References: <87zl5z4y0w.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 12:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbVh-0001T1-9K
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933667AbZLGLLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933636AbZLGLLo
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:11:44 -0500
Received: from javad.com ([205.178.136.214]:59967 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933559AbZLGLLn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 06:11:43 -0500
Received: (qmail 6083 invoked from network); 7 Dec 2009 11:11:45 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 7 Dec 2009 11:11:45 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.69)
	(envelope-from <osv@osv.gnss.ru>)
	id 1NHbVI-0006oQ-65; Mon, 07 Dec 2009 14:11:44 +0300
In-Reply-To: <87zl5z4y0w.fsf@osv.gnss.ru>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134734>

Native cvs update outputs the string "cvs update: Updating <DIR>" for
every directory it processes (to stderr) unless -q or -Q is given on
comman-line. This is used, e.g., by emacs pcl-cvs to split files by
directory. This commit implements this feature in cvsserver.

Signed-off-by: Sergei Organov <osv@javad.com>
---
 git-cvsserver.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 6dc45f5..f4c75bb 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -981,6 +981,8 @@ sub req_update
 
     #$log->debug("update state : " . Dumper($state));
 
+    my $last_dirname = "///";
+    
     # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
@@ -988,6 +990,20 @@ sub req_update
 
         $log->debug("Processing file $filename");
 
+        unless ( $state->{globaloptions}{-Q} || $state->{globaloptions}{-q} )
+        {
+            my $cur_dirname = dirname($filename);
+            if ( $cur_dirname ne $last_dirname )
+            {
+                $last_dirname = $cur_dirname;
+                if ( $cur_dirname eq "" )
+                {
+                    $cur_dirname = ".";
+                }
+                print "E cvs update: Updating $cur_dirname\n";
+            }
+        }
+
         # if we have a -C we should pretend we never saw modified stuff
         if ( exists ( $state->{opt}{C} ) )
         {
-- 
1.6.6.rc0.67.gc0456.dirty

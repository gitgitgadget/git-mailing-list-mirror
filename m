From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 01/10] cvsserver: removed unused sha1Or-k mode from kopts_from_path
Date: Sat, 24 Jan 2009 16:43:12 -0700
Message-ID: <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBX-0006Ei-3w
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbZAXXnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZAXXn3
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:29 -0500
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:37674 "EHLO
	QMTA10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbZAXXn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:29 -0500
Received: from OMTA09.emeryville.ca.mail.comcast.net ([76.96.30.20])
	by QMTA10.emeryville.ca.mail.comcast.net with comcast
	id 7SAC1b00H0S2fkCAAbjUak; Sat, 24 Jan 2009 23:43:28 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA09.emeryville.ca.mail.comcast.net with comcast
	id 7bjT1b0041TYyYj8VbjT6P; Sat, 24 Jan 2009 23:43:28 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 29CE489115;
	Sat, 24 Jan 2009 16:43:24 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107016>

sha1Or-k was a vestige from an early, never-released
attempt to handle some oddball cases of CRLF conversion (-k option).
Ultimately it wasn't needed, and I should have gotten rid of it
before submitting the CRLF patch in the first place.

See also 90948a42892779 (add ability to guess -kb from contents).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl |   38 +++++---------------------------------
 1 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index fef7faf..1de0c1e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2355,42 +2355,14 @@ sub kopts_from_path
         }
         elsif( ($cfg->{gitcvs}{allbinary} =~ /^\s*guess\s*$/i) )
         {
-            if( $srcType eq "sha1Or-k" &&
-                !defined($name) )
+            if( is_binary($srcType,$name) )
             {
-                my ($ret)=$state->{entries}{$path}{options};
-                if( !defined($ret) )
-                {
-                    $ret=$state->{opt}{k};
-                    if(defined($ret))
-                    {
-                        $ret="-k$ret";
-                    }
-                    else
-                    {
-                        $ret="";
-                    }
-                }
-                if( ! ($ret=~/^(|-kb|-kkv|-kkvl|-kk|-ko|-kv)$/) )
-                {
-                    print "E Bad -k option\n";
-                    $log->warn("Bad -k option: $ret");
-                    die "Error: Bad -k option: $ret\n";
-                }
-
-                return $ret;
+                $log->debug("... as binary");
+                return "-kb";
             }
             else
             {
-                if( is_binary($srcType,$name) )
-                {
-                    $log->debug("... as binary");
-                    return "-kb";
-                }
-                else
-                {
-                    $log->debug("... as text");
-                }
+                $log->debug("... as text");
             }
         }
     }
@@ -2497,7 +2469,7 @@ sub open_blob_or_die
             die "Unable to open file $name: $!\n";
         }
     }
-    elsif( $srcType eq "sha1" || $srcType eq "sha1Or-k" )
+    elsif( $srcType eq "sha1" )
     {
         unless ( defined ( $name ) and $name =~ /^[a-zA-Z0-9]{40}$/ )
         {
-- 
1.6.1.81.g9833d.dirty

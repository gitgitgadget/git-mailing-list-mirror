From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 02/20] cvsserver: removed unused sha1Or-k mode from kopts_from_path
Date: Sat, 13 Oct 2012 23:42:15 -0600
Message-ID: <1350193353-19210-3-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHAq-0004bu-I5
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab2JNFzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:55:24 -0400
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:48206 "EHLO
	qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751343Ab2JNFzY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:55:24 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2012 01:55:24 EDT
Received: from omta04.emeryville.ca.mail.comcast.net ([76.96.30.35])
	by qmta07.emeryville.ca.mail.comcast.net with comcast
	id AtdW1k0020lTkoCA7toH2q; Sun, 14 Oct 2012 05:48:17 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta04.emeryville.ca.mail.comcast.net with comcast
	id AtjG1k00X2wKXRC8QtjHBN; Sun, 14 Oct 2012 05:43:17 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 9154F1E9601B; Sat, 13 Oct 2012 23:43:16 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207624>

sha1Or-k was a vestige from an early, never-released
attempt to handle some oddball cases of CRLF conversion (-k option).
Ultimately it wasn't needed, and I should have gotten rid of it
before submitting the CRLF patch in the first place.

See also 90948a42892779 (add ability to guess -kb from contents).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b8eddab..f43d287 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2444,42 +2444,14 @@ sub kopts_from_path
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
@@ -2586,7 +2558,7 @@ sub open_blob_or_die
             die "Unable to open file $name: $!\n";
         }
     }
-    elsif( $srcType eq "sha1" || $srcType eq "sha1Or-k" )
+    elsif( $srcType eq "sha1" )
     {
         unless ( defined ( $name ) and $name =~ /^[a-zA-Z0-9]{40}$/ )
         {
-- 
1.7.10.2.484.gcd07cc5

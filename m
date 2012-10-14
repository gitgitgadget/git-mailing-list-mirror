From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 12/20] cvsserver: cleanup extra slashes in filename arguments
Date: Sat, 13 Oct 2012 23:42:25 -0600
Message-ID: <1350193353-19210-13-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDd-00073P-Oi
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab2JNF6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:20 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:37050 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id Atxj1k0010x6nqcA6ty3Ay; Sun, 14 Oct 2012 05:58:03 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta12.emeryville.ca.mail.comcast.net with comcast
	id Att21k00A2wKXRC8Ytt2BV; Sun, 14 Oct 2012 05:53:03 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id C094F1E96023; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207631>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index dca0ed6..1d929df 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2309,6 +2309,9 @@ sub filenamesplit
     return ( $filepart, $dirpart );
 }
 
+# Cleanup various junk in filename (try to canonicalize it), and
+# add prependdir to accomodate running CVS client from a
+# subdirectory (so the output is relative to top directory of the project).
 sub filecleanup
 {
     my $filename = shift;
@@ -2320,11 +2323,36 @@ sub filecleanup
         return undef;
     }
 
+    if($filename eq ".")
+    {
+        $filename="";
+    }
     $filename =~ s/^\.\///g;
+    $filename =~ s%/+%/%g;
     $filename = $state->{prependdir} . $filename;
+    $filename =~ s%/$%%;
     return $filename;
 }
 
+# Remove prependdir from the path, so that is is relative to the directory
+# the CVS client was started from, rather than the top of the project.
+# Essentially the inverse of filecleanup().
+sub remove_prependdir
+{
+    my($path) = @_;
+    if(defined($state->{prependdir}) && $state->{prependdir} ne "")
+    {
+        my($pre)=$state->{prependdir};
+        $pre=~s%/$%%;
+        if(!($path=~s%^\Q$pre\E/?%%))
+        {
+            $log->fatal("internal error missing prependdir");
+            die("internal error missing prependdir");
+        }
+    }
+    return $path;
+}
+
 sub validateGitDir
 {
     if( !defined($state->{CVSROOT}) )
-- 
1.7.10.2.484.gcd07cc5

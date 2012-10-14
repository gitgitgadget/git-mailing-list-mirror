From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 10/20] cvsserver status: provide real sticky info
Date: Sat, 13 Oct 2012 23:42:23 -0600
Message-ID: <1350193353-19210-11-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDr-0007Eo-0I
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab2JNF6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:18 -0400
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:39951 "EHLO
	qmta02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752029Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by qmta02.emeryville.ca.mail.comcast.net with comcast
	id Atwi1k0011HpZEsA2ty33J; Sun, 14 Oct 2012 05:58:03 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta14.emeryville.ca.mail.comcast.net with comcast
	id Att21k00K2wKXRC8att2z0; Sun, 14 Oct 2012 05:53:03 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 976A41E96021; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207635>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl            | 24 ++++++++++++++++++++----
 t/t9401-git-cvsserver-crlf.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4d514b4..c5ebfa0 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -502,7 +502,7 @@ sub req_Entry
 
     #$log->debug("req_Entry : $data");
 
-    my @data = split(/\//, $data);
+    my @data = split(/\//, $data, -1);
 
     $state->{entries}{$state->{directory}.$data[1]} = {
         revision    => $data[2],
@@ -1681,9 +1681,25 @@ sub req_status
             print "M Repository revision:\t" .
                    $meta->{revision} .
                    "\t$state->{CVSROOT}/$state->{module}/$filename,v\n";
-            print "M Sticky Tag:\t\t(none)\n";
-            print "M Sticky Date:\t\t(none)\n";
-            print "M Sticky Options:\t\t(none)\n";
+            my($tagOrDate)=$state->{entries}{$filename}{tag_or_date};
+            my($tag)=($tagOrDate=~m/^T(.+)$/);
+            if( !defined($tag) )
+            {
+                $tag="(none)";
+            }
+            print "M Sticky Tag:\t\t$tag\n";
+            my($date)=($tagOrDate=~m/^D(.+)$/);
+            if( !defined($date) )
+            {
+                $date="(none)";
+            }
+            print "M Sticky Date:\t\t$date\n";
+            my($options)=$state->{entries}{$filename}{options};
+            if( $options eq "" )
+            {
+                $options="(none)";
+            }
+            print "M Sticky Options:\t\t$options\n";
         } else {
             print "M Repository revision:\tNo revision control file\n";
         }
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index ff6d6fb..7c3c39e 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -38,6 +38,25 @@ not_present() {
     fi
 }
 
+check_status_options() {
+    (cd "$1" &&
+    GIT_CONFIG="$git_config" cvs -Q status "$2" > "${WORKDIR}/status.out" 2>&1
+    )
+    if [ x"$?" != x"0" ] ; then
+        echo "Error from cvs status: $1 $2" >> "${WORKDIR}/marked.log"
+        return 1;
+    fi
+    got="$(sed -n -e 's/^\s*Sticky Options:\s*//p' "${WORKDIR}/status.out")"
+    expect="$3"
+    if [ x"$expect" = x"" ] ; then
+        expect="(none)"
+    fi
+    test x"$got" = x"$expect"
+    stat=$?
+    echo "cvs status: $1 $2 $stat '$3' '$got'" >> "${WORKDIR}/marked.log"
+    return $stat
+}
+
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
@@ -233,6 +252,22 @@ test_expect_success 'cvs co another copy (guess)' '
     marked_as cvswork2/subdir newfile.c ""
 '
 
+test_expect_success 'cvs status - sticky options' '
+    check_status_options cvswork2 textfile.c "" &&
+    check_status_options cvswork2 binfile.bin -kb &&
+    check_status_options cvswork2 .gitattributes "" &&
+    check_status_options cvswork2 mixedUp.c -kb &&
+    check_status_options cvswork2 multiline.c -kb &&
+    check_status_options cvswork2 multilineTxt.c "" &&
+    check_status_options cvswork2/subdir withCr.bin -kb &&
+    check_status_options cvswork2 subdir/withCr.bin -kb &&
+    check_status_options cvswork2/subdir file.h "" &&
+    check_status_options cvswork2 subdir/file.h "" &&
+    check_status_options cvswork2/subdir unspecified.other "" &&
+    check_status_options cvswork2/subdir newfile.bin "" &&
+    check_status_options cvswork2/subdir newfile.c ""
+'
+
 test_expect_success 'add text (guess)' '
     (cd cvswork &&
     echo "simpleText" > simpleText.c &&
-- 
1.7.10.2.484.gcd07cc5

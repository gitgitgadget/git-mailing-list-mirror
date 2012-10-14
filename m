From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 01/20] cvsserver t9400: add basic 'cvs log' test
Date: Sat, 13 Oct 2012 23:42:14 -0600
Message-ID: <1350193353-19210-2-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:48:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNH40-0006rG-93
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab2JNFsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:48:15 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54894 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab2JNFsO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:48:14 -0400
Received: from omta13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id Atlj1k00617UAYkA1toEJM; Sun, 14 Oct 2012 05:48:14 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta13.emeryville.ca.mail.comcast.net with comcast
	id AtjD1k00M2wKXRC8ZtjEUr; Sun, 14 Oct 2012 05:43:14 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 8546C1E9601B; Sat, 13 Oct 2012 23:43:13 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207618>

'cvs log' output is arguably deficient in a number of ways
(see the comment added with the test), but add a test for
the current output to detect for accidental regressions.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/t9400-git-cvsserver-server.sh | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 806623e..6c693ff 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -505,6 +505,76 @@ test_expect_success 'cvs co -c (shows module database)' '
 '
 
 #------------
+# CVS LOG
+#------------
+
+# Known issues with git-cvsserver current log output:
+#  - Hard coded "lines: +2 -3" placeholder, instead of real numbers.
+#  - CVS normally does not internally add a blank first line
+#    nor a last line with nothing but a space to log messages.
+#  - The latest cvs 1.12.x server sends +0000 timezone (with some hidden "MT"
+#    tagging in the protocol), and if cvs 1.12.x client sees the MT tags,
+#    it converts to local time zone.  git-cvsserver doesn't do the +0000
+#    or the MT tags...
+#  - The latest 1.12.x releases add a "commitid:" field on to the end of the
+#    "date:" line (after "lines:").  Maybe we could stick git's commit id
+#    in it?  Or does CVS expect a certain number of bits (too few for
+#    a full sha1)?
+#
+# Given the above, expect the following test to break if git-cvsserver's
+# log output is improved.  The test is just to ensure it doesn't
+# accidentally get worse.
+
+sed -e 's/^x//' -e 's/SP$/ /' > "$WORKDIR/expect" <<EOF
+x
+xRCS file: $WORKDIR/gitcvs.git/master/merge,v
+xWorking file: merge
+xhead: 1.4
+xbranch:
+xlocks: strict
+xaccess list:
+xsymbolic names:
+xkeyword substitution: kv
+xtotal revisions: 4;	selected revisions: 4
+xdescription:
+x----------------------------
+xrevision 1.4
+xdate: __DATE__;  author: author;  state: Exp;  lines: +2 -3
+x
+xMerge test (no-op)
+xSP
+x----------------------------
+xrevision 1.3
+xdate: __DATE__;  author: author;  state: Exp;  lines: +2 -3
+x
+xMerge test (conflict)
+xSP
+x----------------------------
+xrevision 1.2
+xdate: __DATE__;  author: author;  state: Exp;  lines: +2 -3
+x
+xMerge test (merge)
+xSP
+x----------------------------
+xrevision 1.1
+xdate: __DATE__;  author: author;  state: Exp;  lines: +2 -3
+x
+xMerge test (pre-merge)
+xSP
+x=============================================================================
+EOF
+expectStat="$?"
+
+cd "$WORKDIR"
+test_expect_success 'cvs log' '
+    cd cvswork &&
+    test x"$expectStat" = x"0" &&
+    GIT_CONFIG="$git_config" cvs log merge >../out &&
+    sed -e "s%2[0-9][0-9][0-9]/[01][0-9]/[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]%__DATE__%" ../out > ../actual &&
+    test_cmp ../expect ../actual
+'
+
+#------------
 # CVS ANNOTATE
 #------------
 
-- 
1.7.10.2.484.gcd07cc5

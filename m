From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Avoid problem with xpg4 grep in Solaris that broke t9400
Date: Mon,  9 Apr 2012 16:13:29 -0400
Message-ID: <1334002409-5708-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 09 22:13:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHKyL-0000Sr-I9
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 22:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab2DIUNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 16:13:32 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:55907 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2DIUNb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 16:13:31 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49203 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHKxv-0001nn-0g; Mon, 09 Apr 2012 16:13:31 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHKxu-0001UZ-Vx; Mon, 09 Apr 2012 16:13:30 -0400
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195038>

The grep in Solaris' /usr/xpg4/bin as found by the default
SANE_TOOL_PATH was not properly handling the 'cvs co -c (shows module
database)' test.  The [\t ] character set selection does not properly
trigger so the first grep in the test fails.

Instead of working around this issue, switch to using the standard
test_cmp() shell function to perform the comparison instead.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---

It's possible that the specific pair of grep statements is required.
It's looking for tab or space, so maybe we get either character in
some cases, depending on cvs version?  This passed the test suite
using cvs 1.12.13 for OpenCSW.

If there is a reason for the original construction, I'll find a more
creative work around for this problem.

 t/t9400-git-cvsserver-server.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9199550..df1405f 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -500,8 +500,8 @@ test_expect_success 'cvs status (no subdirs in header)' '
 cd "$WORKDIR"
 test_expect_success 'cvs co -c (shows module database)' '
     GIT_CONFIG="$git_config" cvs co -c > out &&
-    grep "^master[	 ]\+master$" < out &&
-    ! grep -v "^master[	 ]\+master$" < out
+    echo "master	master" > out.expected &&
+    test_cmp out out.expected
 '
 
 #------------
-- 
1.7.9

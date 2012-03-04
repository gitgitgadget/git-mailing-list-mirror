From: greened@obbligato.org
Subject: [PATCH 1/2] Allow Overriding GIT_BUILD_DIR
Date: Sun,  4 Mar 2012 17:23:56 -0600
Message-ID: <1330903437-31386-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 00:27:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4KpP-0006tV-L2
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 00:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab2CDX0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 18:26:51 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:54809 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755217Ab2CDX0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 18:26:49 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S4KqW-0006kJ-Cj; Sun, 04 Mar 2012 17:28:08 -0600
X-Mailer: git-send-email 1.7.9.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Let tests
   override GIT_BUILD_DIR so git will work if tests are not at the same directory
    level as standard git tests. Prior to this change, GIT_BUILD_DIR is hardwired
    to be exactly one directory above where the test lives. A test within contrib/,
    for example, can now use test-lib.sh and set an appropriate value for GIT_BUILD_DIR.
    [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192182>

From: "David A. Greene" <greened@obbligato.org>

Let tests override GIT_BUILD_DIR so git will work if tests are not at
the same directory level as standard git tests.  Prior to this change,
GIT_BUILD_DIR is hardwired to be exactly one directory above where the
test lives.  A test within contrib/, for example, can now use
test-lib.sh and set an appropriate value for GIT_BUILD_DIR.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 t/test-lib.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a65dfc7..cb3a0a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,6 +55,7 @@ unset $(perl -e '
 		.*_TEST
 		PROVE
 		VALGRIND
+                BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
@@ -901,7 +902,20 @@ then
 	# itself.
 	TEST_DIRECTORY=$(pwd)
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+
+if test -z "$GIT_BUILD_DIR"
+then
+	# We allow tests to override this, in case they want to run tests
+	# outside of t/.
+ 
+        # For in-tree test scripts, this is one level above the
+        # TEST_DIRECTORY (t/), but a test script that lives outside t/
+        # can set this variable to point at the right place so that it
+        # can find t/ directory that house test helpers like
+        # lib-pager*.sh and test vectors like t4013/ as well as
+        # previously built git tools.
+       GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+fi
 
 if test -n "$valgrind"
 then
-- 
1.7.9.1

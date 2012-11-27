From: Max Horn <max@quendi.de>
Subject: [PATCH] configure.ac: fix pthreads detection on Mac OS X
Date: Wed, 28 Nov 2012 00:28:51 +0100
Message-ID: <1354058931-88873-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:29:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUaf-000138-47
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab2K0X3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:29:04 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:59796 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755663Ab2K0X3D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 18:29:03 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdUaL-0001B8-GE; Wed, 28 Nov 2012 00:29:01 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354058943;fc2c6281;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210628>

The configure script checks whether certain flags are required to use
pthreads. But it did not consider that *none* might be needed (as is the
case on Mac OS X). This lead to configure adding "-mt" to the list of
flags (which does nothing on OS X except producing a warning). This in
turn triggered a compiler warning on every single file.

To solve this, we now first check if pthreads work without extra flags.
This means the check is now order dependant, hence a comment is added
explaining this, and the reasons for it.

Note that it might be possible to write an order independent test, but
it does not seem worth the extra effort required for implementing and
testing such a solution, when this simple solution exists and works.

Signed-off-by: Max Horn <max@quendi.de>
---

This is actually a revised version from my patch
 "Change configure to check if pthreads are usable without any extra flags"
from July. I simply had forgotten all about it :-(.

Chers,
Max

 configure.ac | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ad215cc..41ac9a5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1021,7 +1021,17 @@ if test -n "$USER_NOPTHREAD"; then
 # -D_REENTRANT' or some such.
 elif test -z "$PTHREAD_CFLAGS"; then
   threads_found=no
-  for opt in -mt -pthread -lpthread; do
+  # Attempt to compile and link some code using pthreads to determine
+  # required linker flags. The order is somewhat important here: We
+  # first try it without any extra flags, to catch systems where
+  # pthreads are part of the C library, then go on testing various other
+  # flags. We do so to avoid false positives. For example, on Mac OS X
+  # pthreads are part of the C library; moreover, the compiler allows us
+  # to add "-mt" to the CFLAGS (although it will do nothing except
+  # trigger a warning about an unused flag). Hence if we checked for
+  # "-mt" before "" we would end up picking it. But unfortunately this
+  # would then trigger compiler warnings on every single file we compile.
+  for opt in "" -mt -pthread -lpthread; do
      old_CFLAGS="$CFLAGS"
      CFLAGS="$opt $CFLAGS"
      AC_MSG_CHECKING([for POSIX Threads with '$opt'])
-- 
1.8.0.393.gcc9701d

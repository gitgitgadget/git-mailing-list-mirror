From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 08/21] git p4 test: translate windows paths for cygwin
Date: Fri, 28 Sep 2012 08:04:12 -0400
Message-ID: <1348833865-6093-9-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZLo-0002Kq-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506Ab2I1MHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:07:10 -0400
Received: from honk.padd.com ([74.3.171.149]:34967 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab2I1MHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:07:09 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 562AE5AF2;
	Fri, 28 Sep 2012 05:07:09 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B6FDA31413; Fri, 28 Sep 2012 08:07:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206565>

Native windows binaries do not understand posix-like
path mapping offered by cygwin.  Convert paths to native
using "cygpath --windows" before presenting them to p4d.

This is done using the AltRoots mechanism of p4.  Both the
posix and windows forms are put in the client specification,
allowing p4 to find its location by native path even though
the environment reports a different PWD.

Shell operations in tests will use the normal form of $cli,
which will look like a posix path in cygwin, while p4 will
use AltRoots to match against the windows form of the working
directory.

Thanks-to: Sebastian Schuberth <sschuberth@gmail.com>
Thanks-to: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 24 ++++++++++++++++++++++--
 t/test-lib.sh   |  3 +++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 402d736..e2941ac 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -8,7 +8,8 @@ TEST_NO_CREATE_REPO=NoThanks
 
 . ./test-lib.sh
 
-if ! test_have_prereq PYTHON; then
+if ! test_have_prereq PYTHON
+then
 	skip_all='skipping git p4 tests; python not available'
 	test_done
 fi
@@ -17,6 +18,24 @@ fi
 	test_done
 }
 
+# On cygwin, the NT version of Perforce can be used.  When giving
+# it paths, either on the command-line or in client specifications,
+# be sure to use the native windows form.
+#
+# Older versions of perforce were available compiled natively for
+# cygwin.  Those do not accept native windows paths, so make sure
+# not to convert for them.
+native_path() {
+	path="$1" &&
+	if test_have_prereq CYGWIN && ! p4 -V | grep -q CYGWIN
+	then
+		path=$(cygpath --windows "$path")
+	else
+		path=$(test-path-utils real_path "$path")
+	fi &&
+	echo "$path"
+}
+
 # Try to pick a unique port: guess a large number, then hope
 # no more than one of each test is running.
 #
@@ -32,7 +51,7 @@ P4EDITOR=:
 export P4PORT P4CLIENT P4EDITOR
 
 db="$TRASH_DIRECTORY/db"
-cli=$(test-path-utils real_path "$TRASH_DIRECTORY/cli")
+cli="$TRASH_DIRECTORY/cli"
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
 
@@ -122,6 +141,7 @@ client_view() {
 		Client: $P4CLIENT
 		Description: $P4CLIENT
 		Root: $cli
+		AltRoots: $(native_path "$cli")
 		View:
 		EOF
 		for arg ; do
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8e3733..fd04870 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -624,12 +624,14 @@ case $(uname -s) in
 	# backslashes in pathspec are converted to '/'
 	# exec does not inherit the PID
 	test_set_prereq MINGW
+	test_set_prereq NOT_CYGWIN
 	test_set_prereq SED_STRIPS_CR
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq NOT_MINGW
+	test_set_prereq CYGWIN
 	test_set_prereq SED_STRIPS_CR
 	;;
 *)
@@ -637,6 +639,7 @@ case $(uname -s) in
 	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq NOT_MINGW
+	test_set_prereq NOT_CYGWIN
 	;;
 esac
 
-- 
1.7.12.1.403.g28165e1

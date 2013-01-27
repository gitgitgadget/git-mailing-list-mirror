From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 08/21] git p4 test: translate windows paths for cygwin
Date: Sat, 26 Jan 2013 22:11:11 -0500
Message-ID: <1359256284-5660-9-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:14:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIhS-0005O1-Pr
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab3A0DOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:14:10 -0500
Received: from honk.padd.com ([74.3.171.149]:58712 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:14:08 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 970B12F3F;
	Sat, 26 Jan 2013 19:14:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7B3A422838; Sat, 26 Jan 2013 22:14:04 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214658>

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

This mechanism also handles the symlink issue that was fixed in
23bd0c9 (git p4 test: use real_path to resolve p4 client
symlinks, 2012-06-27).  Now that every p4 client view has
an AltRoots with the real_path in it, explicitly calculating
the real_path elsewhere is not necessary.

Thanks-to: Sebastian Schuberth <sschuberth@gmail.com>
Thanks-to: Johannes Sixt <j6t@kdbg.org>

fixup! git p4 test: translate windows paths for cygwin

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh           | 24 ++++++++++++++++++++++--
 t/t9806-git-p4-options.sh |  2 +-
 t/test-lib.sh             |  3 +++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 185f6f1..d5596de 100644
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
 		printf "\t%s\n" "$@"
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 564fc80..254d428 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -215,7 +215,7 @@ test_expect_success 'clone --use-client-spec' '
 		test_must_fail git p4 clone --dest="$git" --use-client-spec
 	) &&
 	# build a different client
-	cli2=$(test-path-utils real_path "$TRASH_DIRECTORY/cli2") &&
+	cli2="$TRASH_DIRECTORY/cli2" &&
 	mkdir -p "$cli2" &&
 	test_when_finished "rmdir \"$cli2\"" &&
 	test_when_finished cleanup_git &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1a6c4ab..9e7f6b4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -666,12 +666,14 @@ case $(uname -s) in
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
@@ -679,6 +681,7 @@ case $(uname -s) in
 	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq NOT_MINGW
+	test_set_prereq NOT_CYGWIN
 	;;
 esac
 
-- 
1.8.1.1.460.g6fa8886

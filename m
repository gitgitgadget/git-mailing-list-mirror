From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v3 2/3] run test suite without dashed git-commands in PATH
Date: Wed,  2 Dec 2009 22:14:06 -0700
Message-ID: <1259817247-3724-3-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259817247-3724-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259817247-3724-2-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 06:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG41j-000341-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 06:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbZLCFOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 00:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZLCFOd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 00:14:33 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:37077 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbZLCFOc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 00:14:32 -0500
Received: from OMTA21.emeryville.ca.mail.comcast.net ([76.96.30.88])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id CUdD1d0041u4NiLA5VEgpP; Thu, 03 Dec 2009 05:14:40 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA21.emeryville.ca.mail.comcast.net with comcast
	id CVEZ1d0045FCJCg8hVEctc; Thu, 03 Dec 2009 05:14:39 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 4F0E589115;
	Wed,  2 Dec 2009 22:14:32 -0700 (MST)
X-Mailer: git-send-email 1.6.6.rc1
In-Reply-To: <1259817247-3724-2-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134434>

Only put bin-wrappers in the PATH (not GIT_EXEC_PATH), to emulate the
default installed user environment, and ensure all the programs run
correctly in such an environment.  This is now the default, although
it can be overridden with a --with-dashes test option when running
tests.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/README      |    9 +++++++++
 t/test-lib.sh |   33 +++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/t/README b/t/README
index 4e1d7dd..dcd3ebb 100644
--- a/t/README
+++ b/t/README
@@ -75,6 +75,15 @@ appropriately before running "make".
 	As the names depend on the tests' file names, it is safe to
 	run the tests with this option in parallel.
 
+--with-dashes::
+	By default tests are run without dashed forms of
+	commands (like git-commit) in the PATH (it only uses
+	wrappers from ../bin-wrappers).  Use this option to include
+	the build directory (..) in the PATH, which contains all
+	the dashed forms of commands.  This option is currently
+	implied by other options like --valgrind and
+	GIT_TEST_INSTALLED.
+
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
 You still need to have built this git sandbox, from which various
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ec3336a..85377c8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -105,6 +105,8 @@ do
 		verbose=t; shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t; shift ;;
+	--with-dashes)
+		with_dashes=t; shift ;;
 	--no-color)
 		color=; shift ;;
 	--no-python)
@@ -551,19 +553,8 @@ test_done () {
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 TEST_DIRECTORY=$(pwd)
-if test -z "$valgrind"
+if test -n "$valgrind"
 then
-	if test -z "$GIT_TEST_INSTALLED"
-	then
-		PATH=$TEST_DIRECTORY/..:$PATH
-		GIT_EXEC_PATH=$TEST_DIRECTORY/..
-	else
-		GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
-		error "Cannot run git from $GIT_TEST_INSTALLED."
-		PATH=$GIT_TEST_INSTALLED:$TEST_DIRECTORY/..:$PATH
-		GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
-	fi
-else
 	make_symlink () {
 		test -h "$2" &&
 		test "$1" = "$(readlink "$2")" || {
@@ -625,6 +616,24 @@ else
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
+elif test -n "$GIT_TEST_INSTALLED" ; then
+	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
+	error "Cannot run git from $GIT_TEST_INSTALLED."
+	PATH=$GIT_TEST_INSTALLED:$TEST_DIRECTORY/..:$PATH
+	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
+else # normal case, use ../bin-wrappers only unless $with_dashes:
+	git_bin_dir="$TEST_DIRECTORY/../bin-wrappers"
+	if ! test -x "$git_bin_dir/git" ; then
+		if test -z "$with_dashes" ; then
+			say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
+		fi
+		with_dashes=t
+	fi
+	PATH="$git_bin_dir:$PATH"
+	GIT_EXEC_PATH=$TEST_DIRECTORY/..
+	if test -n "$with_dashes" ; then
+		PATH="$TEST_DIRECTORY/..:$PATH"
+	fi
 fi
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
-- 
1.6.6.rc1

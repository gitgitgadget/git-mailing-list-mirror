From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v2 5/6] run test suite without dashed git-commands in PATH
Date: Sun, 29 Nov 2009 23:19:30 -0700
Message-ID: <1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 30 07:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzcJ-0000qX-Hj
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbZK3GUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbZK3GT7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:19:59 -0500
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:56409 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753251AbZK3GT6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 01:19:58 -0500
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by QMTA08.emeryville.ca.mail.comcast.net with comcast
	id BJGt1d0010vp7WLA8JL5eQ; Mon, 30 Nov 2009 06:20:05 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA05.emeryville.ca.mail.comcast.net with comcast
	id BJL31d0015FCJCg8RJL4cw; Mon, 30 Nov 2009 06:20:05 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id C2B9689114;
	Sun, 29 Nov 2009 23:20:03 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134051>

Only put bin-wrappers in the PATH (not GIT_EXEC_PATH), to emulate the
default installed user environment, and ensure all the programs run
correctly in such an environment.  This is now the default, although
it can be overridden with a --with-dashes test option when running
tests.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/README      |    8 ++++++++
 t/test-lib.sh |   33 +++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/t/README b/t/README
index 4e1d7dd..8c5d892 100644
--- a/t/README
+++ b/t/README
@@ -75,6 +75,14 @@ appropriately before running "make".
 	As the names depend on the tests' file names, it is safe to
 	run the tests with this option in parallel.
 
+--with-dashes::
+	By default tests are run without dashed forms of
+	commands (like git-commit) in the PATH (it only uses
+	wrappers from TOP/git-bin).  Use this option to include TOP
+	in the PATH, which conains all the dashed forms of commands.
+	This option is currently implied by other options like --valgrind
+	and GIT_TEST_INSTALLED.
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
1.6.4.GIT

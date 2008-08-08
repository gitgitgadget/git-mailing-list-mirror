From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Enable parallel tests
Date: Fri, 8 Aug 2008 07:59:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 08 07:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRKxE-0000ND-U2
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 07:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYHHFyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 01:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbYHHFyv
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 01:54:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:42703 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752298AbYHHFyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 01:54:50 -0400
Received: (qmail invoked by alias); 08 Aug 2008 05:54:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 08 Aug 2008 07:54:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+Ip1jXGb+Kl9Q7931p32Xw1k2ia9D9qIVpLnBOh
	gV2YCCh+lVQOLA
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91624>


On multiprocessor machines, or with I/O heavy tests (that leave the
CPU waiting a lot), it makes sense to parallelize the tests.

However, care has to be taken that the different jobs use different
trash directories.

This commit does so, by inspecting the MAKEFLAGS variable to detect
if the option "-j" or "--jobs" was passed to make.  In that case, the
test is run with the new "--parallel" option.

If parallel mode was detected, the trash directories are created with
a suffix that is unique with regard to the test, as it is the test's
base name.

Parallel mode also triggers removal of the trash directory in the test
itself if everything went fine, so that the trash directories do not
pile up only to be removed at the very end.

If a test failed, the trash directory is not removed.  Chances are
that the exact error message is lost in the clutter, but you can still
see what test failed from the name of the trash directory, and repeat
the test (without -j).

If all was good, you will see the aggregated results.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/Makefile    |    8 ++++++--
 t/test-lib.sh |   11 ++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index aa952e1..fb2fba9 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -14,6 +14,11 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
+# MAKEFLAGS only sees the -j flag when expanded in the task, so we cannot
+# use ifeq() games here.  Instead we play shell games.
+GIT_TEST_OPTS += $(shell echo " $(MAKEFLAGS)" | \
+	sed -n "s/^.* \(--jobs\|\(-\|[^-]*\)j\).*/--parallel/p")
+
 all: pre-clean
 	$(MAKE) aggregate-results-and-cleanup
 
@@ -24,7 +29,7 @@ pre-clean:
 	$(RM) -r test-results
 
 clean:
-	$(RM) -r 'trash directory' test-results
+	$(RM) -rf 'trash directory' test-results
 
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
@@ -39,4 +44,3 @@ full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
 .PHONY: pre-clean $(T) aggregate-results clean
-.NOTPARALLEL:
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11c0275..c5868c4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -74,6 +74,7 @@ esac
 	) &&
 	color=t
 
+test="trash directory"
 while test "$#" -ne 0
 do
 	case "$1" in
@@ -94,6 +95,10 @@ do
 	--no-python)
 		# noop now...
 		shift ;;
+	--parallel)
+		test="$test.$(basename "$0" .sh)"
+		remove_trash="$(pwd)/$test"
+		shift ;;
 	*)
 		break ;;
 	esac
@@ -449,6 +454,11 @@ test_done () {
 		# we will leave things as they are.
 
 		say_color pass "passed all $msg"
+
+		test ! -z = "$remove_trash" &&
+		cd "$(dirname "$remove_trash")" &&
+		rm -rf "$(basename "$remove_trash")"
+
 		exit 0 ;;
 
 	*)
@@ -485,7 +495,6 @@ fi
 . ../GIT-BUILD-OPTIONS
 
 # Test repository
-test="trash directory"
 rm -fr "$test" || {
 	trap - exit
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
1.6.0.rc2.23.gd08e9

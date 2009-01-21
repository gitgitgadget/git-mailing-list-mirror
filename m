From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [INTERDIFF of PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 02:11:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210211060.19014@racer>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 02:12:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPReD-0002lx-Pe
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 02:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758217AbZAUBL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 20:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbZAUBLZ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 20:11:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:41001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757873AbZAUBLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 20:11:25 -0500
Received: (qmail invoked by alias); 21 Jan 2009 01:11:23 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp005) with SMTP; 21 Jan 2009 02:11:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ooY9BlhNo0YW10GU3o1xDPR+iofXBWsMKPkzAUG
	VURGHAl2lHwMMh
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901210209580.19014@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106553>


 t/README               |    6 +++++-
 t/test-lib.sh          |   32 +++++++++++++++++++++-----------
 t/valgrind/.gitignore  |    3 +--
 t/valgrind/valgrind.sh |    4 ++--
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/t/README b/t/README
index 8f12d48..0cee429 100644
--- a/t/README
+++ b/t/README
@@ -39,7 +39,8 @@ this:
     * passed all 3 test(s)
 
 You can pass --verbose (or -v), --debug (or -d), and --immediate
-(or -i) command line argument to the test.
+(or -i) command line argument to the test, or by setting GIT_TEST_OPTS
+appropriately before running "make".
 
 --verbose::
 	This makes the test more verbose.  Specifically, the
@@ -58,6 +59,9 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
+--valgrind::
+	Execute all Git binaries with valgrind and stop on errors (the
+	exit code will be 126).
 
 Skipping Tests
 --------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6bd893d..f031905 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -488,27 +488,37 @@ then
 	GIT_EXEC_PATH=$TEST_DIRECTORY/..
 else
 	# override all git executables in PATH and TEST_DIRECTORY/..
-	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind/bin
 	mkdir -p "$GIT_VALGRIND"
 	OLDIFS=$IFS
 	IFS=:
-	for path in $PATH:$TEST_DIRECTORY/..
+	for path in $PATH $TEST_DIRECTORY/..
 	do
-		ls "$TEST_DIRECTORY"/../git "$path"/git-* 2> /dev/null |
+		ls "$path"/git "$path"/git-* 2> /dev/null |
 		while read file
 		do
 			# handle only executables
-			test -x "$file" || continue
+			test -x "$file" && test ! -d "$file" || continue
 
 			base=$(basename "$file")
-			test ! -h "$GIT_VALGRIND"/"$base" || continue
-
-			if test "#!" = "$(head -c 2 < "$file")"
+			symlink_target=$TEST_DIRECTORY/../$base
+			# do not override scripts
+			if test -x "$symlink_target" &&
+			    test "#!" != "$(head -c 2 < "$symlink_target")"
+			then
+				symlink_target=../valgrind.sh
+			fi
+			case "$base" in
+			*.sh|*.perl)
+				symlink_target=../unprocessed-script
+			esac
+			# create the link, or replace it if it is out of date
+			if test ! -h "$GIT_VALGRIND"/"$base" ||
+			    test "$symlink_target" != \
+					"$(readlink "$GIT_VALGRIND"/"$base")"
 			then
-				# do not override scripts
-				ln -s ../../"$base" "$GIT_VALGRIND"/"$base"
-			else
-				ln -s valgrind.sh "$GIT_VALGRIND"/"$base"
+				rm -f "$GIT_VALGRIND"/"$base" || exit
+				ln -s "$symlink_target" "$GIT_VALGRIND"/"$base"
 			fi
 		done
 	done
diff --git a/t/valgrind/.gitignore b/t/valgrind/.gitignore
index d781a63..ae3c172 100644
--- a/t/valgrind/.gitignore
+++ b/t/valgrind/.gitignore
@@ -1,2 +1 @@
-/git
-/git-*
+/bin/
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 24f3a4e..2c4b54b 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -4,9 +4,9 @@ base=$(basename "$0")
 
 exec valgrind -q --error-exitcode=126 \
 	--leak-check=no \
-	--suppressions="$GIT_VALGRIND/default.supp" \
+	--suppressions="$GIT_VALGRIND/../default.supp" \
 	--gen-suppressions=all \
 	--log-fd=4 \
 	--input-fd=4 \
 	$GIT_VALGRIND_OPTIONS \
-	"$GIT_VALGRIND"/../../"$base" "$@"
+	"$GIT_VALGRIND"/../../../"$base" "$@"

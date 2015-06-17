From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 2/2] test-lib.sh: fix color support when tput needs ~/.terminfo
Date: Wed, 17 Jun 2015 15:06:26 -0400
Message-ID: <1434567986-23552-3-git-send-email-rhansen@bbn.com>
References: <1434567986-23552-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 21:28:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5J0G-0006vr-9s
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbbFQT2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:28:00 -0400
Received: from smtp.bbn.com ([128.33.0.80]:50141 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbbFQT16 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:27:58 -0400
X-Greylist: delayed 1286 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2015 15:27:58 EDT
Received: from socket.bbn.com ([192.1.120.102]:34521)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Z5IfQ-000242-9U; Wed, 17 Jun 2015 15:06:32 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id F3FE44032B
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1434567986-23552-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271892>

If tput needs ~/.terminfo for the current $TERM, then tput will
succeed before HOME is changed to $TRASH_DIRECTORY (causing color to
be set to 't') but fail afterward.

One possible way to fix this is to treat HOME like TERM: back up the
original value and temporarily restore it before say_color() runs
tput.

Instead, pre-compute and save the color control sequences before
changing either TERM or HOME.  Use the saved control sequences in
say_color() rather than call tput each time.  This avoids the need to
back up and restore the TERM and HOME variables, and it avoids the
overhead of a subshell and two invocations of tput per call to
say_color().

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/test-lib.sh | 53 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 57212ec..4a59bfb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,9 +15,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
-# Keep the original TERM for say_color
-ORIGINAL_TERM=$TERM
-
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
@@ -68,12 +65,12 @@ done,*)
 esac
 
 # For repeatability, reset the environment to known value.
+# TERM is sanitized below, after saving color control sequences.
 LANG=C
 LC_ALL=C
 PAGER=cat
 TZ=UTC
-TERM=dumb
-export LANG LC_ALL PAGER TERM TZ
+export LANG LC_ALL PAGER TZ
 EDITOR=:
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
@@ -181,9 +178,7 @@ export _x05 _x40 _z40 LF u200c
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
-test "x$ORIGINAL_TERM" != "xdumb" && (
-		TERM=$ORIGINAL_TERM &&
-		export TERM &&
+test "x$TERM" != "xdumb" && (
 		test -t 1 &&
 		tput bold >/dev/null 2>&1 &&
 		tput setaf 1 >/dev/null 2>&1 &&
@@ -263,29 +258,34 @@ fi
 
 if test -n "$color"
 then
+	# Save the color control sequences now rather than run tput
+	# each time say_color() is called.  This is done for two
+	# reasons:
+	#   * TERM will be changed to dumb
+	#   * HOME will be changed to a temporary directory and tput
+	#     might need to read ~/.terminfo from the original HOME
+	#     directory to get the control sequences
+	# Note:  This approach assumes the control sequences don't end
+	# in a newline for any terminal of interest (command
+	# substitutions strip trailing newlines).  Given that most
+	# (all?) terminals in common use are related to ECMA-48, this
+	# shouldn't be a problem.
+	say_color_error=$(tput bold; tput setaf 1) # bold red
+	say_color_skip=$(tput setaf 4) # blue
+	say_color_warn=$(tput setaf 3) # brown/yellow
+	say_color_pass=$(tput setaf 2) # green
+	say_color_info=$(tput setaf 6) # cyan
+	say_color_sgr0=$(tput sgr0)
 	say_color () {
-		(
-		TERM=$ORIGINAL_TERM
-		export TERM
+		say_color_color=
 		case "$1" in
-		error)
-			tput bold; tput setaf 1;; # bold red
-		skip)
-			tput setaf 4;; # blue
-		warn)
-			tput setaf 3;; # brown/yellow
-		pass)
-			tput setaf 2;; # green
-		info)
-			tput setaf 6;; # cyan
+		error|skip|warn|pass|info)
+			eval "say_color_color=\$say_color_$1";;
 		*)
 			test -n "$quiet" && return;;
 		esac
 		shift
-		printf "%s" "$*"
-		tput sgr0
-		echo
-		)
+		printf "%s\\n" "$say_color_color$*$say_color_sgr0"
 	}
 else
 	say_color() {
@@ -295,6 +295,9 @@ else
 	}
 fi
 
+TERM=dumb
+export TERM
+
 error () {
 	say_color error "error: $*"
 	GIT_EXIT_OK=t
-- 
2.4.3

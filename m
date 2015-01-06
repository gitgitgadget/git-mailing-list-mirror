From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 2/2] test-lib.sh: do tests for color support after changing HOME
Date: Tue,  6 Jan 2015 17:57:51 -0500
Message-ID: <1420585071-28973-3-git-send-email-rhansen@bbn.com>
References: <xmqq8uhfpw3s.fsf@gitster.dls.corp.google.com>
 <1420585071-28973-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, rhansen@bbn.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 06 23:59:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8d4i-0000WP-18
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 23:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbbAFW6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 17:58:03 -0500
Received: from smtp.bbn.com ([128.33.0.80]:20998 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbbAFW6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 17:58:00 -0500
Received: from socket.bbn.com ([192.1.120.102]:53248)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y8d4Z-000Nm4-N1; Tue, 06 Jan 2015 17:57:59 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7597640690
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420585071-28973-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262108>

If ncurses needs ~/.terminfo for the current $TERM, then tput will
succeed before changing HOME to $TRASH_DIRECTORY but fail afterward.
Move the tests that determine whether there is color support after
changing HOME so that color=t is set if and only if tput would succeed
when say_color() is run.

Note that color=t is now set after --no-color is processed, so the
condition to set color=t has changed:  it is now set only if
color has not already been set to the empty string by --no-color.

This commit disables color support for those that need ~/.terminfo for
their TERM, but it's better than filling the screen with:

    tput: unknown terminal "custom-terminal-name-here"

An alternative would be to symlink or copy the user's terminfo
database into $TRASH_DIRECTORY, but this is tricky due to the lack of
a standard name for the terminfo database (for example, instead of a
~/.terminfo directory, NetBSD uses a ~/.terminfo.cdb database file).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/test-lib.sh | 90 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3670eed..bb1402d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,16 +184,8 @@ export _x05 _x40 _z40 LF u200c
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
-test "x$ORIGINAL_TERM" != "xdumb" && (
-		TERM=$ORIGINAL_TERM &&
-		export TERM &&
-		test -t 1 &&
-		tput bold >/dev/null 2>&1 &&
-		tput setaf 1 >/dev/null 2>&1 &&
-		tput sgr0 >/dev/null 2>&1
-	) &&
-	color=t
 
+unset color
 while test "$#" -ne 0
 do
 	case "$1" in
@@ -258,40 +250,6 @@ then
 	verbose=t
 fi
 
-if test -n "$color"
-then
-	say_color () {
-		(
-		TERM=$ORIGINAL_TERM
-		export TERM
-		case "$1" in
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
-		*)
-			test -n "$quiet" && return;;
-		esac
-		shift
-		printf "%s" "$*"
-		tput sgr0
-		echo
-		)
-	}
-else
-	say_color() {
-		test -z "$1" && test -n "$quiet" && return
-		shift
-		printf "%s\n" "$*"
-	}
-fi
-
 error () {
 	say_color error "error: $*"
 	GIT_EXIT_OK=t
@@ -857,6 +815,52 @@ HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
 export HOME GNUPGHOME
 
+# run the tput tests *after* changing HOME (in case ncurses needs
+# ~/.terminfo for $TERM)
+test -n "${color+set}" || test "x$ORIGINAL_TERM" != "xdumb" && (
+		TERM=$ORIGINAL_TERM &&
+		export TERM &&
+		test -t 1 &&
+		tput bold >/dev/null 2>&1 &&
+		tput setaf 1 >/dev/null 2>&1 &&
+		tput sgr0 >/dev/null 2>&1
+	) &&
+	color=t
+
+if test -n "$color"
+then
+	say_color () {
+		(
+		TERM=$ORIGINAL_TERM
+		export TERM
+		case "$1" in
+		error)
+			tput bold; tput setaf 1;; # bold red
+		skip)
+			tput setaf 4;; # blue
+		warn)
+			tput setaf 3;; # brown/yellow
+		pass)
+			tput setaf 2;; # green
+		info)
+			tput setaf 6;; # cyan
+		*)
+			test -n "$quiet" && return;;
+		esac
+		shift
+		printf "%s" "$*"
+		tput sgr0
+		echo
+		)
+	}
+else
+	say_color() {
+		test -z "$1" && test -n "$quiet" && return
+		shift
+		printf "%s\n" "$*"
+	}
+fi
+
 if test -z "$TEST_NO_CREATE_REPO"
 then
 	test_create_repo "$TRASH_DIRECTORY"
-- 
2.2.1

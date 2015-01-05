From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH] test-lib.sh: do tests for color support after changing HOME
Date: Mon,  5 Jan 2015 13:54:14 -0500
Message-ID: <1420484054-15948-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 20:35:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8DPb-0003H0-7G
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 20:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbbAETdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 14:33:55 -0500
Received: from smtp.bbn.com ([128.33.1.81]:39969 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbbAETdy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 14:33:54 -0500
X-Greylist: delayed 2374 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jan 2015 14:33:54 EST
Received: from socket.bbn.com ([192.1.120.102]:35258)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y8CnU-000Pkc-F1; Mon, 05 Jan 2015 13:54:36 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 75C833FF84
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262028>

If ncurses needs ~/.terminfo for the current $TERM, then tput will
succeed before changing HOME to $TRASH_DIRECTORY but fail afterward.
Move the tests that determine whether there is color support after
changing HOME so that color=t is set if and only if tput would succeed
when say_color() is run.

This disables color support for those that need ~/.terminfo for their
TERM, but it's better than filling the screen with:

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
index 9acdc88..65ecbed 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,16 +184,8 @@ export _x05 _x40 _z40 LF u200c
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
-[ "x$ORIGINAL_TERM" != "xdumb" ] && (
-		TERM=$ORIGINAL_TERM &&
-		export TERM &&
-		[ -t 1 ] &&
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
+test -n "${color+set}" || [ "x$ORIGINAL_TERM" != "xdumb" ] && (
+		TERM=$ORIGINAL_TERM &&
+		export TERM &&
+		[ -t 1 ] &&
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

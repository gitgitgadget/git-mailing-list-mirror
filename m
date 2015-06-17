From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 1/2] Revert "test-lib.sh: do tests for color support after changing HOME"
Date: Wed, 17 Jun 2015 17:11:20 -0400
Message-ID: <1434575481-24604-2-git-send-email-rhansen@bbn.com>
References: <xmqqvbem5bx9.fsf@gitster.dls.corp.google.com>
 <1434575481-24604-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Wed Jun 17 23:11:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5KcY-0001Xn-6R
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 23:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbFQVLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 17:11:37 -0400
Received: from smtp.bbn.com ([128.33.1.81]:58348 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbbFQVLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 17:11:36 -0400
Received: from socket.bbn.com ([192.1.120.102]:38928)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Z5KcL-0000qB-Ez; Wed, 17 Jun 2015 17:11:29 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 342D140329
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1434575481-24604-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271913>

This reverts commit 102fc80d32094ad6598b17ab9d607516ee8edc4a.

There are two issues with that commit:

  * It is buggy.  In pseudocode, it is doing:

       color is set || TERM != dumb && color works && color=t

    when it should be doing:

       color is set || { TERM != dumb && color works && color=t }

  * It unnecessarily disables color when tput needs to read
    ~/.terminfo to get the control sequences.
---
 t/test-lib.sh | 90 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 39da9c2..57212ec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -181,8 +181,16 @@ export _x05 _x40 _z40 LF u200c
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
+test "x$ORIGINAL_TERM" != "xdumb" && (
+		TERM=$ORIGINAL_TERM &&
+		export TERM &&
+		test -t 1 &&
+		tput bold >/dev/null 2>&1 &&
+		tput setaf 1 >/dev/null 2>&1 &&
+		tput sgr0 >/dev/null 2>&1
+	) &&
+	color=t
 
-unset color
 while test "$#" -ne 0
 do
 	case "$1" in
@@ -253,6 +261,40 @@ then
 	verbose=t
 fi
 
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
 error () {
 	say_color error "error: $*"
 	GIT_EXIT_OK=t
@@ -829,52 +871,6 @@ HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
 export HOME GNUPGHOME
 
-# run the tput tests *after* changing HOME (in case ncurses needs
-# ~/.terminfo for $TERM)
-test -n "${color+set}" || test "x$ORIGINAL_TERM" != "xdumb" && (
-		TERM=$ORIGINAL_TERM &&
-		export TERM &&
-		test -t 1 &&
-		tput bold >/dev/null 2>&1 &&
-		tput setaf 1 >/dev/null 2>&1 &&
-		tput sgr0 >/dev/null 2>&1
-	) &&
-	color=t
-
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
 if test -z "$TEST_NO_CREATE_REPO"
 then
 	test_create_repo "$TRASH_DIRECTORY"
-- 
2.4.3

From: Jon Seymour <jon.seymour@gmail.com>
Subject: [RFC] gettext: add gettextln, eval_gettextln to encode common idiom
Date: Sat,  6 Aug 2011 14:16:04 +1000
Message-ID: <1312604164-19980-1-git-send-email-jon.seymour@gmail.com>
Cc: avarab@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 06:17:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpYJo-0003Qp-Th
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 06:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab1HFEQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 00:16:21 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:38021 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab1HFEQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 00:16:20 -0400
Received: by iye16 with SMTP id 16so4870123iye.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 21:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Juy5kQdCUPXjw92CWtquj7j8iULmPn+M85yzSRvjKCg=;
        b=OZ+4JZerTpLwVgk1LVsU8A1vKiFrJR/cEjQQQqwTrDQdnUul0lpSW8ge/2d+WugjEC
         hVLtHCqlxOPl0LVCS8j0WVk+rYEgFs3s9S43tJ/8qLwnyYoZ48B80uD05ycKwJMYcM+t
         ukVeusgBuZiN8Aq04mLmdkugveELK4OAB0UJk=
Received: by 10.42.197.130 with SMTP id ek2mr1044225icb.123.1312604179586;
        Fri, 05 Aug 2011 21:16:19 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id bq3sm4039608icb.11.2011.08.05.21.16.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 21:16:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178823>

Currently, if you want to use gettext or eval_gettext to format a message
you may have to add a separate echo statement and a surrounding subshell
in order to interpolate the required trailing new line.

This patch introduces two new helper functions, gettextln and eval_gettextln
which append a trailing newline to the gettext output.

This allows constructions of the form:

	if test -s "$GIT_DIR/BISECT_START"
	then
		(
			gettext "You need to give me at least one good and one bad revisions.
(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
			echo
		) >&2
	else
	...

to be expressed more concisely as:

	if test -s "$GIT_DIR/BISECT_START"
	then
		gettextln "You need to give me at least one good and one bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
	else
	...

An example of its use in git-bisect.sh is given.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh  |   49 ++++++++++++++-----------------------------------
 git-sh-i18n.sh |   19 +++++++++++++++++++
 2 files changed, 33 insertions(+), 35 deletions(-)

This patch applies on top of Junio's "bisect: further style nitpicks" currently in kernel/pu.

FWIW, I am not attached to the suggested names. I can split the changes to git-sh-i18n.sh into a separate commit if there is agreement in principle to take the change.

diff --git a/git-bisect.sh b/git-bisect.sh
index 22c4da5..22c0e28 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -46,10 +46,7 @@ bisect_head()
 
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		(
-			gettext "You need to start by \"git bisect start\"" &&
-			echo
-		) >&2
+		gettextln "You need to start by \"git bisect start\"" >&2
 		if test -t 0
 		then
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -268,10 +265,7 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		(
-			gettext "Warning: bisecting only with a bad commit." &&
-			echo
-		) >&2
+		gettextln "Warning: bisecting only with a bad commit." >&2
 		if test -t 0
 		then
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -287,18 +281,12 @@ bisect_next_check() {
 
 		if test -s "$GIT_DIR/BISECT_START"
 		then
-			(
-				gettext "You need to give me at least one good and one bad revisions.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
-				echo
-			) >&2
+			gettextln "You need to give me at least one good and one bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
 		else
-			(
-				gettext "You need to start by \"git bisect start\".
+			gettextln "You need to start by \"git bisect start\".
 You then need to give me at least one good and one bad revisions.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
-				echo
-			) >&2
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
 		fi
 		exit 1 ;;
 	esac
@@ -351,7 +339,7 @@ bisect_visualize() {
 
 bisect_reset() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		gettext "We are not bisecting."; echo
+		gettextln "We are not bisecting."
 		return
 	}
 	case "$#" in
@@ -424,18 +412,15 @@ bisect_run () {
 	while true
 	do
 		command="$@"
-		eval_gettext "running \$command"; echo
+		eval_gettextln "running \$command"
 		"$@"
 		res=$?
 
 		# Check for really bad run error.
 		if [ $res -lt 0 -o $res -ge 128 ]
 		then
-			(
-				eval_gettext "bisect run failed:
-exit code \$res from '\$command' is < 0 or >= 128" &&
-				echo
-			) >&2
+			eval_gettextln "bisect run failed:
+exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
@@ -460,26 +445,20 @@ exit code \$res from '\$command' is < 0 or >= 128" &&
 		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
 			> /dev/null
 		then
-			(
-				gettext "bisect run cannot continue any more" &&
-				echo
-			) >&2
+			gettextln "bisect run cannot continue any more" >&2
 			exit $res
 		fi
 
 		if [ $res -ne 0 ]
 		then
-			(
-				eval_gettext "bisect run failed:
-'bisect_state \$state' exited with error code \$res" &&
-				echo
-			) >&2
+			eval_gettextln "bisect run failed:
+'bisect_state \$state' exited with error code \$res" >&2
 			exit $res
 		fi
 
 		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null
 		then
-			gettext "bisect run success"; echo
+			gettextln "bisect run success"
 			exit 0;
 		fi
 
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 32ca59d..e672366 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -11,19 +11,38 @@ then
 		printf "%s" "$1"
 	}
 
+	gettextln() {
+		printf "%s\n" "$1"
+	}
+
 	eval_gettext () {
 		printf "%s" "$1" | (
 			export PATH $(git sh-i18n--envsubst --variables "$1");
 			git sh-i18n--envsubst "$1"
 		)
 	}
+
+	eval_gettextln () {
+		printf "%s\n" "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
 else
 	gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
 
+	gettextln () {
+		printf "%s\n" "# GETTEXT POISON #"
+	}
+
 	eval_gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
+
+	eval_gettextln () {
+		printf "%s\n" "# GETTEXT POISON #"
+	}
 fi
 
-- 
1.7.6.362.gf0e6

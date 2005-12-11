From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [RFC, PATCH] Usage message clean-up, take #2
Date: Sun, 11 Dec 2005 10:55:49 +0100
Message-ID: <20051211095549.GB4919@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 10:56:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElNw6-0002os-3V
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 10:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbVLKJzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 04:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbVLKJzv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 04:55:51 -0500
Received: from [85.8.31.11] ([85.8.31.11]:52941 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161107AbVLKJzu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 04:55:50 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP id 7EB4640FD
	for <git@vger.kernel.org>; Sun, 11 Dec 2005 11:06:08 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ElNvp-0006gO-00
	for <git@vger.kernel.org>; Sun, 11 Dec 2005 10:55:49 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13495>

Hi,

There were some problems with the usage message clean-up patch
series. I hadn't realised that subdirectory aware scripts can't source
git-sh-setup. I propose that we change this and let the scripts which
are subdirectory aware set a variable, SUBDIRECTORY_OK, before they
source git-sh-setup.

The scripts will also set USAGE and possibly LONG_USAGE before they
source git-sh-setup. If LONG_USAGE isn't set it defaults to USAGE.

If we go this way it's easy to catch --help in git-sh-setup, print the
(long) usage message to stdout and exit cleanly. git-sh-setup can
define a 'usage' shell function which can be called by the scripts to
print the short usage string to stderr and exit non-cleanly. It will
also be easy to change $0 to basename $0 or something else, if would
like to do that sometime in the future.

What follows is a patch to convert a couple of the commands to this
style. If it's ok with everyone to do it this way I will convert the
rest of the scripts too.


- Fredrik

---

 git-bisect.sh   |   24 +++++++++++-------------
 git-branch.sh   |   21 ++++++---------------
 git-sh-setup.sh |   34 +++++++++++++++++++++++++++++-----
 git-status.sh   |   11 ++++++++++-
 4 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 05dae8a..51e1e44 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,4 +1,15 @@
 #!/bin/sh
+
+USAGE='[start|bad|good|next|reset|visualize]'
+LONG_USAGE='git bisect start [<pathspec>]	reset bisect state and start bisection.
+git bisect bad [<rev>]		mark <rev> a known-bad revision.
+git bisect good [<rev>...]	mark <rev>... known-good revisions.
+git bisect next			find next bisection to test and check it out.
+git bisect reset [<branch>]	finish bisection search and go back to branch.
+git bisect visualize            show bisect status in gitk.
+git bisect replay <logfile>	replay bisection log
+git bisect log			show bisect log.'
+
 . git-sh-setup
 
 sq() {
@@ -11,19 +22,6 @@ sq() {
 	' "$@"
 }
 
-usage() {
-    echo >&2 'usage: git bisect [start|bad|good|next|reset|visualize]
-git bisect start [<pathspec>]	reset bisect state and start bisection.
-git bisect bad [<rev>]		mark <rev> a known-bad revision.
-git bisect good [<rev>...]	mark <rev>... known-good revisions.
-git bisect next			find next bisection to test and check it out.
-git bisect reset [<branch>]	finish bisection search and go back to branch.
-git bisect visualize            show bisect status in gitk.
-git bisect replay <logfile>	replay bisection log
-git bisect log			show bisect log.'
-    exit 1
-}
-
 bisect_autostart() {
 	test -d "$GIT_DIR/refs/bisect" || {
 		echo >&2 'You need to start by "git bisect start"'
diff --git a/git-branch.sh b/git-branch.sh
index 5306b27..0266f46 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,21 +1,12 @@
 #!/bin/sh
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
-
-die () {
-    echo >&2 "$*"
-    exit 1
-}
-
-usage () {
-    echo >&2 "usage: $(basename $0)"' [-d <branch>] | [[-f] <branch> [start-point]]
-
-If no arguments, show available branches and mark current branch with a star.
+USAGE='[-d <branch>] | [[-f] <branch> [start-point]]'
+LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
-If two arguments, create a new branch <branchname> based off of <start-point>.
-'
-    exit 1
-}
+If two arguments, create a new branch <branchname> based off of <start-point>.'
+
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
 
 headref=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index b4f1022..1e638e4 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,13 +11,37 @@
 # exporting it.
 unset CDPATH
 
-: ${GIT_DIR=.git}
-: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-
 die() {
 	echo >&2 "$@"
 	exit 1
 }
 
-# Make sure we are in a valid repository of a vintage we understand.
-GIT_DIR="$GIT_DIR" git-var GIT_AUTHOR_IDENT >/dev/null || exit
+usage() {
+	die "Usage: $0 $USAGE"
+}
+
+if [ -z "$LONG_USAGE" ]
+then
+	LONG_USAGE="Usage: $0 $USAGE"
+else
+	LONG_USAGE="Usage: $0 $USAGE
+
+$LONG_USAGE"
+fi
+
+case "$1" in
+	--h|--he|--hel|--help)
+	echo "$LONG_USAGE"
+	exit
+esac
+
+if [ -z "$SUBDIRECTORY_OK" ]
+then
+	: ${GIT_DIR=.git}
+	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+
+	# Make sure we are in a valid repository of a vintage we understand.
+	GIT_DIR="$GIT_DIR" git-var GIT_AUTHOR_IDENT >/dev/null || exit
+else
+	GIT_DIR=$(git-rev-parse --git-dir) || exit
+fi
diff --git a/git-status.sh b/git-status.sh
index 2dda0c5..50ccd24 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -2,7 +2,16 @@
 #
 # Copyright (c) 2005 Linus Torvalds
 #
-GIT_DIR=$(git-rev-parse --git-dir) || exit
+
+USAGE=''
+SUBDIRECTORY_OK='Yes'
+
+. git-sh-setup
+
+if [ "$#" != "0" ]
+then
+  usage
+fi
 
 report () {
   header="#

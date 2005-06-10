From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: [PATCH] git cvsimport fuzz argument
Date: Fri, 10 Jun 2005 01:38:32 -0500
Message-ID: <20050610063832.GC4763@immutable.crsr.net>
References: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org> <20050610062206.GA3992@immutable.crsr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:35:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgd6N-0001RD-EE
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 08:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVFJGiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 02:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVFJGiw
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 02:38:52 -0400
Received: from [65.98.21.155] ([65.98.21.155]:270 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S262310AbVFJGii (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 02:38:38 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1DgdA0-0001MG-00; Fri, 10 Jun 2005 01:38:32 -0500
To: "Tommy M. McGuire" <mcguire@crsr.net>
Content-Disposition: inline
In-Reply-To: <20050610062206.GA3992@immutable.crsr.net>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Give the user the option of specifying the timestamp fuzz passed to
cvsps.  Looking at the other arguments to it, I can't see anything else
that would be sane to play with.  Also, use --cvs-direct, which speeds
up cvsps for remote repositories and doesn't seem to do anything bad to
local repositories.

Signed-off-by: Tommy McGuire <mcguire@crsr.net>

Add "-z fuzz" argument, passed to cvsps, and clean up argument processing.
Also, use "cvsps --cvs-direct", which is is somewhat faster.

---
commit 018aee88d1b71f96ce9ecdfba77608566f51c860
tree 623c7a40ea20ef8b68cf896605d55432cd0469ac
parent 9a861c244e79634abf3c8436d720e77140d0e0e3
author Tommy M. McGuire <mcguire@crsr.net> Fri, 10 Jun 2005 02:51:34 -0500
committer Tommy M. McGuire <mcguire@crsr.net> Fri, 10 Jun 2005 02:51:34 -0500

 git-cvsimport-script |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -1,15 +1,26 @@
 #!/bin/sh
-ARGS=""
-if [ "$1" == "-v" ]; then
-	ARGS=$1
+
+usage () {
+	echo "Usage: git cvsimport [-v] [-z fuzz] <cvsroot> <module>"
+	exit 1
+}
+
+CVS2GIT=""
+CVSPS="--cvs-direct -x -A"
+while true; do
+	case "$1" in
+	-v) CVS2GIT="$1" ;;
+	-z) shift; CVSPS="$CVSPS -z $1" ;;
+	-*) usage ;;
+	*)  break ;;
+	esac
 	shift
-fi
+done
 
 export CVSROOT="$1"
 export MODULE="$2"
 if [ ! "$CVSROOT" ] || [ ! "$MODULE" ] ; then
-	echo "Usage: git cvsimport <cvsroot> <module>"
-	exit 1
+	usage
 fi
 
 cvsps -h 2>&1 | grep -q "cvsps version 2.1" >& /dev/null || {
@@ -20,8 +31,8 @@ cvsps -h 2>&1 | grep -q "cvsps version 2
 mkdir "$MODULE" || exit 1
 cd "$MODULE"
 
-TZ=UTC cvsps -x -A $MODULE > .git-cvsps-result
+TZ=UTC cvsps $CVSPS $MODULE > .git-cvsps-result
 [ -s .git-cvsps-result ] || exit 1
-git-cvs2git $ARGS --cvsroot="$CVSROOT" --module="$MODULE" < .git-cvsps-result > .git-create-script || exit 1
+git-cvs2git $CVS2GIT --cvsroot="$CVSROOT" --module="$MODULE" < .git-cvsps-result > .git-create-script || exit 1
 sh .git-create-script
 



!-------------------------------------------------------------flip-


-- 
Tommy McGuire

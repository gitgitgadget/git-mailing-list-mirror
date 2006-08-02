From: Jeff King <peff@peff.net>
Subject: [PATCH] git-push: remove obsolete git-push.sh
Date: Wed, 2 Aug 2006 11:37:42 -0400
Message-ID: <20060802153742.GA12794@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 17:38:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8InU-0000zH-2b
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 17:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWHBPiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 11:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWHBPiH
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 11:38:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:995 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751183AbWHBPiF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 11:38:05 -0400
Received: (qmail 425 invoked from network); 2 Aug 2006 11:37:08 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Aug 2006 11:37:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 11:37:42 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24650>

This was converted to a C builtin over three months ago.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-push.sh |   87 -----------------------------------------------------------
 1 files changed, 0 insertions(+), 87 deletions(-)

diff --git a/git-push.sh b/git-push.sh
deleted file mode 100755
index 21775fc..0000000
--- a/git-push.sh
+++ /dev/null
@@ -1,87 +0,0 @@
-#!/bin/sh
-
-USAGE='[--all] [--tags] [--force] <repository> [<refspec>...]'
-. git-sh-setup
-
-# Parse out parameters and then stop at remote, so that we can
-# translate it using .git/branches information
-has_all=
-has_force=
-has_exec=
-has_thin=--thin
-remote=
-do_tags=
-
-while case "$#" in 0) break ;; esac
-do
-	case "$1" in
-	--all)
-		has_all=--all ;;
-	--tags)
-		do_tags=yes ;;
-	--force)
-		has_force=--force ;;
-	--exec=*)
-		has_exec="$1" ;;
-	--thin)
-		;; # noop
-	--no-thin)
-		has_thin= ;;
-	-*)
-                usage ;;
-        *)
-		set x "$@"
-		shift
-		break ;;
-	esac
-	shift
-done
-case "$#" in
-0)
-	echo "Where would you want to push today?"
-        usage ;;
-esac
-
-. git-parse-remote
-remote=$(get_remote_url "$@")
-
-case "$has_all" in
---all)
-	set x ;;
-'')
-	case "$do_tags,$#" in
-	yes,1)
-		set x $(cd "$GIT_DIR/refs" && find tags -type f -print) ;;
-	yes,*)
-		set x $(cd "$GIT_DIR/refs" && find tags -type f -print) \
-		    $(get_remote_refs_for_push "$@") ;;
-	,*)
-		set x $(get_remote_refs_for_push "$@") ;;
-	esac
-esac
-
-shift ;# away the initial 'x'
-
-# $# is now 0 if there was no explicit refspec on the command line
-# and there was no default refspec to push from remotes/ file.
-# we will let git-send-pack to do its "matching refs" thing.
-
-case "$remote" in
-git://*)
-	die "Cannot use READ-ONLY transport to push to $remote" ;;
-rsync://*)
-        die "Pushing with rsync transport is deprecated" ;;
-esac
-
-set x "$remote" "$@"; shift
-test "$has_all" && set x "$has_all" "$@" && shift
-test "$has_force" && set x "$has_force" "$@" && shift
-test "$has_exec" && set x "$has_exec" "$@" && shift
-test "$has_thin" && set x "$has_thin" "$@" && shift
-
-case "$remote" in
-http://* | https://*)
-	exec git-http-push "$@";;
-*)
-	exec git-send-pack "$@";;
-esac
-- 
1.4.2.rc2.g822a-dirty

From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach git push .git/branches shorthand
Date: Sun, 07 Aug 2005 23:12:26 -0700
Message-ID: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 08 08:13:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E20sB-0005JT-N4
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 08:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVHHGM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 02:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVHHGM3
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 02:12:29 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14507 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750735AbVHHGM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 02:12:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808061228.WWAA17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 02:12:28 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Although it is uncertain if we would keep .git/branches for
long, the shorthand stored there can be used for pushing if it
is host:path/to/git format, so let's make use of it.  This does
not use git-parse-remote because that script will be rewritten
quite a bit for updated pulling.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

I hear a lot of people mention $GIT_DIR/branches/ is confusing.
Maybe we should rename it to $GIT_DIR/remote/ directory?

 git-push-script |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

c781a84b5204fb294c9ccc79f8b3baceeb32c061
diff --git a/git-push-script b/git-push-script
--- a/git-push-script
+++ b/git-push-script
@@ -1,3 +1,64 @@
 #!/bin/sh
 . git-sh-setup-script || die "Not a git archive"
-git-send-pack "$@"
+
+# Parse out parameters and then stop at remote, so that we can
+# translate it using .git/branches information
+has_all=
+has_force=
+has_exec=
+remote=
+
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	--all)
+		has_all=--all ;;
+	--force)
+		has_force=--force ;;
+	--exec=*)
+		has_exec="$1" ;;
+	-*)
+		die "Unknown parameter $1" ;;
+        *)
+		remote="$1"
+		shift
+		set x "$@"
+		shift
+		break ;;
+	esac
+	shift
+done
+
+case "$remote" in
+*:* | /* | ../* | ./* )
+	# An URL, host:/path/to/git, absolute and relative paths.
+	;;
+* )
+	# Shorthand
+	if expr "$remote" : '..*/..*' >/dev/null
+	then
+		# a short-hand followed by a trailing path
+		shorthand=$(expr "$remote" : '\([^/]*\)')
+		remainder=$(expr "$remote" : '[^/]*\(/.*\)$')
+	else
+		shorthand="$remote"
+		remainder=
+	fi
+	remote=$(sed -e 's/#.*//' "$GIT_DIR/branches/$remote") &&
+	expr "$remote" : '..*:' >/dev/null &&
+	remote="$remote$remainder" ||
+	die "Cannot parse remote $remote"
+	;;
+esac
+
+case "$remote" in
+http://* | https://* | git://* | rsync://* )
+	die "Cannot push to $remote" ;;
+esac
+
+set x "$remote" "$@"; shift
+test "$has_all" && set x "$has_all" "$@" && shift
+test "$has_force" && set x "$has_force" "$@" && shift
+test "$has_exec" && set x "$has_exec" "$@" && shift
+
+exec git-send-pack "$@"

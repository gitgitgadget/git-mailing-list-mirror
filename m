From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Improve "git grep" flags handling
Date: Mon, 12 Sep 2005 17:51:56 -0700
Message-ID: <7v64t56b83.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
	<7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
	<Pine.LNX.4.58.0509121519310.3266@g5.osdl.org>
	<7vd5nd7w0x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121542050.3266@g5.osdl.org>
	<7vslw96f6j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121635060.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 02:52:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEz1y-0007Zf-LX
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 02:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVIMAv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 20:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVIMAv6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 20:51:58 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21965 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932255AbVIMAv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 20:51:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913005156.MAHY18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 20:51:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121635060.3266@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Sep 2005 16:46:53 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8459>

This allows any arbitrary flags to "grep", and knows about the few
special grep flags that take an argument too.

It also allows some flags for git-ls-files, although their usefulness
is questionable.

With this, something line

	git grep -w -1 pattern

works, without the script enumerating every possible flag.

[jc: this was the version after I showed Linus a barf-o-meter test
 version that avoids shell arrays.  The emperor penguin must have
 typed this version blindly, since he said:

    I'm not barfing, but that's probably because my brain just shut
    down and is desperately trying to gouge my eyes out with a spoon.

 I slightly fixed it to catch the remaining arguments meant to be
 given git-ls-files.]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Linus Torvalds <torvalds@osdl.org> writes:

    Wouldn't it be _much_ nicer to just do which does use bash
    array variables, but dang, it does so for a reason: they
    really are very very useful, and they make it _so_ much more
    pleasant to do these things..

 Thanks, Linus.  This is what will go into "master" tonight.

 git-grep.sh |   64 ++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 23 deletions(-)

6df4eef9b10c8de2b9bc3dc769f3a008a1200df7
diff --git a/git-grep.sh b/git-grep.sh
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -1,25 +1,43 @@
 #!/bin/sh
-flags=
-while :; do
-  pattern="$1"
-  case "$pattern" in
-  -i|-I|-a|-E|-H|-h|-l)
-    flags="$flags $pattern"
-    shift
-    ;;
-  -e)
-    pattern="$2"
-    shift
-    break
-    ;;
-  -*)
-    echo "unknown flag $pattern" >&2
-    exit 1
-    ;;
-  *)
-    break
-    ;;
-  esac
+#
+# Copyright (c) Linus Torvalds, 2005
+#
+
+pattern=
+flags=()
+git_flags=()
+while : ; do
+	case "$1" in
+	--cached|--deleted|--others|--killed|\
+	--ignored|--exclude=*|\
+	--exclude-from=*|\--exclude-per-directory=*)
+		git_flags=("${git_flags[@]}" "$1")
+		;;
+	-e)
+		pattern="$2"
+		shift
+		;;
+	-A|-B|-C|-D|-d|-f|-m)
+		flags=("${flags[@]}" "$1" "$2")
+		shift
+		;;
+	--)
+		# The rest are git-ls-files paths (or flags)
+		shift
+		break
+		;;
+	-*)
+		flags=("${flags[@]}" "$1")
+		;;
+	*)
+		if [ -z "$pattern" ]; then
+			pattern="$1"
+			shift
+		fi
+		break
+		;;
+	esac
+	shift
 done
-shift
-git-ls-files -z "$@" | xargs -0 grep $flags -e "$pattern"
+git-ls-files -z "${git_flags[@]}" "$@" |
+	xargs -0 grep "${flags[@]}" "$pattern"

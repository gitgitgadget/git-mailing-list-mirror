From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Short-circuit git-clone-pack while cloning locally.
Date: Wed, 06 Jul 2005 01:14:01 -0700
Message-ID: <7v8y0kxsfq.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050704.125744.59481768.davem@davemloft.net>
	<Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
	<Pine.LNX.4.58.0507051721450.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 10:18:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq56I-0007Gv-L9
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 10:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVGFIQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 04:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVGFIPc
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 04:15:32 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58506 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262199AbVGFIOC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 04:14:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050706081401.VZFB17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 6 Jul 2005 04:14:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507051721450.3570@g5.osdl.org> (Linus Torvalds's message of "Tue, 5 Jul 2005 17:42:00 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Anyway, as mentioned, you can certainly do a local clone a lot faster with 
LT> "cp -rl" (and yes, I'll apply Junio's patch if he makes it available 
LT> against the new version, and adds a flag to make it conditional),...

By invitation.

------------
When we are cloning a repository on a local filesystem, it is
faster to just create a hard linkfarm of .git/object hierarchy
and copy the .git/refs files.  By default, the script uses the
clone-pack method, but with -l and -c parameters it can be told
to do the hard linkfarm and recursive file copy to replicate
.git/object hierarchy.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-clone-script |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 1 deletions(-)

1eb81b1791a751ca0fd1c3e7c1d4a4baacdd042a
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -1,4 +1,81 @@
 #!/bin/sh
+#
+# Copyright (c) 2005, Linus Torvalds
+# Copyright (c) 2005, Junio C Hamano
+# 
+# Clone a repository into a different directory that does not yet exist.
+
+usage() {
+	echo >&2 "* git clone [-l|-c|-p] <repo> <dir>"
+	exit 1
+}
+
+# what to do when running locally
+local_use=default
+while
+	case "$#,$1" in
+	0,*) break ;;
+	*,-l) local_use=link ;;
+	*,-c) local_use=copy ;;
+	*,-p) local_use=pack ;;
+	*,-*) usage ;;
+	*) break ;;
+	esac
+do
+	shift
+done
+
 repo="$1"
 dir="$2"
-mkdir "$dir" && cd "$dir" && git-init-db && git-clone-pack "$repo"
+mkdir "$dir" &&
+D=$(
+	(cd "$dir" && git-init-db && pwd)
+) || exit 1
+
+# See if repo is a local directory.
+is_local=f
+if (
+	cd "$repo/objects" 2>/dev/null
+)
+then
+	is_local=t
+fi
+
+case "$local_use,$is_local" in
+default,f)
+	;;
+*,f)	echo >&2 "-l|-c|-p flag can be used only when cloning a local repo"
+	exit 1
+	;;
+copy,t | link,t)
+	l=
+	case "$local_use" in
+	link)
+	    # See if we can hardlink and drop "l" if not.
+	    sample_file=$(cd "$repo" && \
+	    		  find objects -type f -print | sed -e 1q)
+
+	    # objects directory should not be empty since we are cloning!
+	    test -f "$repo/$sample_file" || exit
+
+	    if ln "$repo/$sample_file" "$D/.git/objects/sample" 2>/dev/null
+	    then
+		    l=l
+	    fi &&
+	    rm -f "$D/.git/objects/sample"
+	    ;;
+	esac &&
+	cp -r$l "$repo/objects" "$D/.git/" || exit 1
+
+	# Make a duplicate of refs and HEAD pointer
+	HEAD=
+	if test -f "$repo/HEAD"
+	then
+		HEAD=HEAD
+	fi
+	tar Ccf "$repo" - refs $HEAD | tar Cxf "$D/.git" - || exit 1
+	;;
+*)
+	cd "$D" && git clone-pack "$repo"
+	;;
+esac

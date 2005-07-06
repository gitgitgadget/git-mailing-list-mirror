From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Short-circuit git-clone-pack while cloning locally (take 2).
Date: Wed, 06 Jul 2005 13:04:21 -0700
Message-ID: <7vd5pvwvju.fsf@assigned-by-dhcp.cox.net>
References: <20050704.125744.59481768.davem@davemloft.net>
	<Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
	<Pine.LNX.4.58.0507051721450.3570@g5.osdl.org>
	<7v8y0kxsfq.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507060911510.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 03:17:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqL0t-0006wj-0L
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 03:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVGGBQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 21:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVGGAXR
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 20:23:17 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:2975 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261801AbVGFUEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 16:04:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050706200419.QLYP7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 6 Jul 2005 16:04:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When we are cloning a repository on a local filesystem, it is
faster to just create a hard linkfarm of .git/object hierarchy
and copy the .git/refs files.  By default, the script uses the
clone-pack method, but it can be told with the -l flag to do the
hard linkfarm (falling back on recursive file copy) to replicate
the .git/object hierarchy.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-clone-script |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 67 insertions(+), 1 deletions(-)

2bff57b39b9fd13b1319d0192e2a887eb82fa189
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -1,4 +1,70 @@
 #!/bin/sh
+#
+# Copyright (c) 2005, Linus Torvalds
+# Copyright (c) 2005, Junio C Hamano
+# 
+# Clone a repository into a different directory that does not yet exist.
+
+usage() {
+	echo >&2 "* git clone [-l] <repo> <dir>"
+	exit 1
+}
+
+use_local=no
+while
+	case "$#,$1" in
+	0,*) break ;;
+        *,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
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
+) &&
+test -d "$D" || usage
+
+# We do local magic only when the user tells us to.
+case "$use_local" in
+yes)
+	( cd "$repo/objects" ) || {
+		repo="$repo/.git"
+		( cd "$repo/objects" ) || {
+		    echo >&2 "-l flag seen but $repo is not local."
+		    exit 1
+		}
+	}
+
+	# See if we can hardlink and drop "l" if not.
+	sample_file=$(cd "$repo" && \
+		      find objects -type f -print | sed -e 1q)
+
+	# objects directory should not be empty since we are cloning!
+	test -f "$repo/$sample_file" || exit
+
+	l=
+	if ln "$repo/$sample_file" "$D/.git/objects/sample" 2>/dev/null
+	then
+		l=l
+	fi &&
+	rm -f "$D/.git/objects/sample" &&
+	cp -r$l "$repo/objects" "$D/.git/" || exit 1
+
+	# Make a duplicate of refs and HEAD pointer
+	HEAD=
+	if test -f "$repo/HEAD"
+	then
+		HEAD=HEAD
+	fi
+	tar Ccf "$repo" - refs $HEAD | tar Cxf "$D/.git" - || exit 1
+	exit 0
+	;;
+esac
+
+cd "$D" && git clone-pack "$repo"

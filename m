From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use --objects=self-sufficient flag to rev-list.
Date: Thu, 07 Jul 2005 16:50:57 -0700
Message-ID: <7vackyfa5a.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:52:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgAD-0006tN-T4
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVGGXvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 19:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVGGXvo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 19:51:44 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21417 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262365AbVGGXvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 19:51:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707235057.DWYS16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 19:50:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 07 Jul 2005 16:16:47 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds --self-sufficient flag to git-repack-script, and uses
it when preparing the dumb server material.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This makes things easier for the dumb puller because
*** self-sufficient pack means less falling back on traditional
*** http-pull.

 git-repack-script             |   10 +++++++++-
 git-update-dumb-server-script |    2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

6b0568181ede5540706bcdf69868102f554a2f8a
diff --git a/git-repack-script b/git-repack-script
--- a/git-repack-script
+++ b/git-repack-script
@@ -1,8 +1,16 @@
 #!/bin/sh
 : ${GIT_DIR=.git}
 : ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+
+case "$1" in
+--self-sufficient)
+	objects=--objects=self-sufficient ;;
+*)
+	objects=--objects ;;
+esac
+
 rm -f .tmp-pack-*
-packname=$(git-rev-list --unpacked --objects $(git-rev-parse --all) |
+packname=$(git-rev-list --unpacked $objects $(git-rev-parse --all) |
 	git-pack-objects --non-empty --incremental .tmp-pack) ||
 	exit 1
 if [ -z "$packname" ]; then
diff --git a/git-update-dumb-server-script b/git-update-dumb-server-script
--- a/git-update-dumb-server-script
+++ b/git-update-dumb-server-script
@@ -26,7 +26,7 @@ plain_size=$(
 
 if test $max_plain_size -lt $plain_size >/dev/null
 then
-	git-repack-script && git-prune-packed
+	git-repack-script --self-sufficient && git-prune-packed
 fi &&
 
 git-update-dumb-server &&
------------

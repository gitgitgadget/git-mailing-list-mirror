From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Give --full-objects flag to rev-list when preparing a dumb server.
Date: Thu, 07 Jul 2005 18:03:46 -0700
Message-ID: <7vpstuds7h.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
	<7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 03:04:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqhHy-0005Ol-1n
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 03:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVGHBD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 21:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVGHBD5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 21:03:57 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44987 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262425AbVGHBDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 21:03:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050708010347.BAYX17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 21:03:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org> (Linus Torvalds's message of "Thu, 7 Jul 2005 16:58:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> This is nasty - if you mis-spell "self-sufficient" (easy enough to do) 
LT> you'll never know the end result isn't what you expected. It won't warn 
LT> you in any way, it will just make a non-self-sufficient pack..

To match the change of flag name to --full-objects,...

------------
This adds --full flag to git-repack-script, and uses it when
preparing the dumb server material.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-repack-script             |   10 +++++++++-
 git-update-dumb-server-script |    2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

0617ae867e7e27a7b484827f882fe7b396bea004
diff --git a/git-repack-script b/git-repack-script
--- a/git-repack-script
+++ b/git-repack-script
@@ -1,8 +1,16 @@
 #!/bin/sh
 : ${GIT_DIR=.git}
 : ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+
+case "$1" in
+--full)
+	objects=--full-objects ;;
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
+	git-repack-script --full && git-prune-packed
 fi &&
 
 git-update-dumb-server &&
------------

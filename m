From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 13:30:54 -0700
Message-ID: <7vy88dqe4h.fsf@assigned-by-dhcp.cox.net>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
	<20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>
	<7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>
	<42D2CBA2.8060705@yahoo.com> <7virzhrtfy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bryan.larsen@gmail.com,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 22:40:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds54Q-0008Kc-C6
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 22:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVGKUdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVGKUcV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:32:21 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29111 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262600AbVGKUa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 16:30:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711203052.RAKB550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 16:30:52 -0400
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <7virzhrtfy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon, 11 Jul 2005 13:14:41 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> The only user of "cp -l" in the Linus GIT is git-clone-script
> local optimization.  I could revert it to the version that I
> originally sent to the list, which uses cpio -pld, if your cpio
> groks that flag.

Bryan, does this work for you?

------------
Two changes to git-clone-script local optimization.

 - When local optimization is used, the variable repo has
   already been passed through get_repo_base so there is no need
   to check for .git subdirectory in there.

 - Use cpio -l instead of "cp -l".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -48,11 +48,8 @@ test -d "$D" || usage
 case "$local,$use_local" in
 yes,yes)
 	( cd "$repo/objects" ) || {
-		repo="$repo/.git"
-		( cd "$repo/objects" ) || {
-		    echo >&2 "-l flag seen but $repo is not local."
-		    exit 1
-		}
+		echo >&2 "-l flag seen but $repo is not local."
+		exit 1
 	}
 
 	# See if we can hardlink and drop "l" if not.
@@ -68,7 +65,9 @@ yes,yes)
 		l=l
 	fi &&
 	rm -f "$D/.git/objects/sample" &&
-	cp -r$l "$repo/objects" "$D/.git/" || exit 1
+	cd "$repo" &&
+	find objects -type f -print |
+	cpio -puamd$l "$D/.git/" || exit 1
 
 	# Make a duplicate of refs and HEAD pointer
 	HEAD=

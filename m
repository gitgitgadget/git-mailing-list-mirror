From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make git-prune-script a bit more careful.
Date: Sun, 01 May 2005 14:27:35 -0700
Message-ID: <7vk6miskl4.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtqjxlrv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505010916510.2296@ppc970.osdl.org>
	<7vll6yyiax.fsf@assigned-by-dhcp.cox.net>
	<7vwtqismpn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSM7x-00027W-37
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVEAVmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVEAVa0
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:30:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4571 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262694AbVEAV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 17:27:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501212734.FRP23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 17:27:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vwtqismpn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 01 May 2005 13:41:40 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As discussed on the git list, this patch makes the sample script
git-prune-script a bit more careful by keeping the objects
referenced from the current cache from being reclaimed.

At the same time it also fixes and enhances the following:

 - Optional command line parameters can specify which commit
   heads to start reachablity test from.  Earlier we had a
   hardcoded .git/HEAD.  It now defaults to the contents of
   .git/HEAD and .git/refs/*/* files.

 - It does not assume SHA1_FILE_DIRECTORY is .git/objects/ but
   uses the value from the environment if there is one.

 - It runs xargs with "-r" option to prevent it from making "rm"
   command barf if there is nothing to remove.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

git-prune-script |   32 +++++++++++++++++++++++++++++++-
1 files changed, 31 insertions(+), 1 deletion(-)

# - date handling: handle "AM"/"PM" on time
# + [PATCH] Make git-prune-script a bit more careful.
--- k/git-prune-script
+++ l/git-prune-script
@@ -1,2 +1,32 @@
 #!/bin/sh
-git-fsck-cache --unreachable $(cat .git/HEAD ) | grep unreachable | cut -d' ' -f3 | sed 's:^\(..\):.git/objects/\1/:' | xargs rm
+
+tmp=.git-prune-script-$$
+trap 'rm -f $tmp-*' 0 1 2 3 15 
+
+# Defaulting to include .git/refs/*/* may be debatable from the
+# purist POV but power users can always give explicit parameters
+# to the script anyway.
+case "$#" in
+0) set x $(cat .git/HEAD .git/refs/*/*); shift ;;
+esac
+
+git-fsck-cache --unreachable "$@" |
+sed -ne 's/unreachable [^ ][^ ]* //p' |
+sort >$tmp-unreachable
+
+# This makes extra objects to be kept if the cache has an entry
+# with an unusual name like "this\n0 0123...abcdef 0 file", but
+# we are trying not to discard information and keeping extra in
+# an unusual situation would be OK.
+git-ls-files --stage |
+sed -ne 's|^[0-7][0-7]* \([0-9a-f][0-9a-f]*\) [0-3] .*|\1|p' |
+sort >$tmp-keep
+
+comm -23 $tmp-unreachable $tmp-keep |
+sed -e 's|\(..\)|\1/|' | {
+	case "$SHA1_FILE_DIRECTORY" in
+	'') cd .git/objects/ ;;
+	*) cd "$SHA1_FILE_DIRECTORY" ;;
+	esac || exit
+	xargs -r echo rm -f
+}


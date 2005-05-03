From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Git-prune-script loses blobs referenced from an uncommitted
 cache.
Date: Mon, 02 May 2005 17:37:16 -0700
Message-ID: <7vis21no03.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 02:31:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSlJv-0004k4-5y
	for gcvg-git@gmane.org; Tue, 03 May 2005 02:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVECAha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVECAha
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:37:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56062 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261256AbVECAhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 20:37:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503003715.VUI22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 2 May 2005 20:37:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When a new blob is registered with update-cache, and before the cache
is written as a tree and committed, git-fsck-cache will find the blob
unreachable.  This patch fixes git-prune-script to keep such blob objects
referenced from the cache.

Without this fix, "diff-cache -p --cached" after git-prune-script has
pruned the blob object will fail mysteriously and git-write-tree would
also fail.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

git-prune-script |   32 +++++++++++++++++++++++++++++++-
1 files changed, 31 insertions(+), 1 deletion(-)

--- a/git-prune-script
+++ b/git-prune-script
@@ -1,2 +1,32 @@
 #!/bin/sh
-git-fsck-cache --unreachable $(cat .git/HEAD ) | grep unreachable | cut -d' ' -f3 | sed 's:^\(..\):.git/objects/\1/:' | xargs rm
+
+tmp=.git-prune-script-$$
+trap "rm -f $tmp-*" 0 1 2 3 15 
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


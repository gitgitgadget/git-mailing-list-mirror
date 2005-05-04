From: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] cogito: Add cg-undo command
Date: Tue, 3 May 2005 22:40:07 -0700
Message-ID: <20050503224007.B637@cox.net>
References: <20050503100624.A29266@cox.net> <20050503213204.GC15995@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 07:36:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTCYD-0005O6-SH
	for gcvg-git@gmane.org; Wed, 04 May 2005 07:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVEDFmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 01:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVEDFmW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 01:42:22 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:10185 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262028AbVEDFmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 01:42:10 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050504054208.GUAZ12158.fed1rmmtao11.cox.net@liberty.homelinux.org>;
          Wed, 4 May 2005 01:42:08 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id WAA00787;
	Tue, 3 May 2005 22:40:07 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050503213204.GC15995@pasky.ji.cz>; from pasky@ucw.cz on Tue, May 03, 2005 at 11:32:04PM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 11:32:04PM +0200, Petr Baudis wrote:
> Dear diary, on Tue, May 03, 2005 at 07:06:25PM CEST, I got a letter
> where Matt Porter <mporter@kernel.crashing.org> told me that...
> > +	cg-undo		[COMMIT_ID]
> 
> It doesn't seem very optional now.

Yep, changed.

> > +PARENT=`git-cat-file commit $1 | grep parent | cut -f 2 -d " "`
>
> What's wrong with parent-id?

Missed it...changed to use parent-id.

> > +echo "Undo from $1 to current HEAD"
> > +echo "Reset HEAD to $PARENT"
> 
> You talk way too much, I think. I'd just do
> 
> 	echo "Rewinding $HEAD -> $PARENT" >&2

Done.

> > +git-update-cache --refresh
> 
> You really don't want to do this if the tree has any local
> modifications.

Ugh, yes. I added a check for this. 

> Please make sure the commit you are rewinding to is an ancestor of your
> current HEAD (there should be something like separate cg-branch-rm for
> killing enemy branches).

Added a check for this as well as verifying we have an argument.
 
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

--- aa6233be6d1b8bf42797c409a7c23b50593afc99/Makefile  (mode:100644 sha1:6ae0afa0208a8f755d383281a6d049a4ef90fe63)
+++ ce72371d991b15a0ca8db7c2332d215b59b909af/Makefile  (mode:100644 sha1:6c282aeebe86ecee9e634481b3d51fd53a582791)
@@ -47,7 +47,7 @@
 	cg-add cg-admin-lsobj cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch \
 	cg-patch cg-pull cg-branch-add cg-branch-ls cg-rm cg-seek cg-status \
-	cg-tag cg-tag-ls cg-update cg-Xlib
+	cg-tag cg-tag-ls cg-undo cg-update cg-Xlib
 
 COMMON=	read-cache.o
 
Index: cg-help
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-help  (mode:100755 sha1:1f5d2d79b67490d44ce0f575ff9a4b80134ea47f)
+++ ce72371d991b15a0ca8db7c2332d215b59b909af/cg-help  (mode:100755 sha1:1b75114ee90d2b3b9786fc4f14bf179feef54f87)
@@ -43,6 +43,7 @@
 	cg-status
 	cg-tag		TNAME [COMMIT_ID]
 	cg-tag-ls
+	cg-undo		COMMIT_ID
 	cg-update	[BNAME]
 	cg-version
 
Index: cg-undo
===================================================================
--- /dev/null  (tree:aa6233be6d1b8bf42797c409a7c23b50593afc99)
+++ ce72371d991b15a0ca8db7c2332d215b59b909af/cg-undo  (mode:100644 sha1:7b1cb04c79731b137d88ebd05ee41553af7246d2)
@@ -0,0 +1,32 @@
+#!/usr/bin/env bash
+#
+# Undo a commit or a series of commits
+# Copyright (C) Matt Porter, 2005
+#
+# Takes a commit ID which is the earliest commit to be
+# removed from the repository.
+
+. cg-Xlib
+
+[ "$1" ] || die "usage: cg-undo COMMIT_ID"
+
+HEAD=$(commit-id) || exit 1;
+PARENT=$(parent-id "$1") || exit 1;
+
+git-rev-list $HEAD | grep -q $1 || {
+	echo >&2 "$1: not an ancestor of HEAD"
+	exit 1
+}
+[ "$(git-diff-files -s)" ] && git-update-cache --refresh
+if [ "$(git-diff-files -s)" ] || [ "$(git-diff-cache $(tree-id))" ]; then
+        die "Undo blocked: local changes"
+fi
+
+echo "Rewinding HEAD -> $PARENT" >&2
+echo "$PARENT" > .git/HEAD
+git-read-tree -m "$PARENT" || {
+	echo >&2 "$PARENT: bad commit"
+	exit 1
+}
+git-checkout-cache -f -a
+git-update-cache --refresh

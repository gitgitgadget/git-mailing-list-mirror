From: Linus Torvalds <torvalds@osdl.org>
Subject: Extend "git reset" to take a reset point
Date: Sat, 6 Aug 2005 18:01:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508061746530.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 03:01:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1ZXc-0000Xc-Rn
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 03:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVHGBBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 21:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVHGBBM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 21:01:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261394AbVHGBBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 21:01:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j77114jA019120
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Aug 2005 18:01:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j77113Ck007301;
	Sat, 6 Aug 2005 18:01:03 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This was triggered by a query by Sam Ravnborg, and extends "git reset" to 
reset the index and the .git/HEAD pointer to an arbitrarily named point.

For example

	git reset HEAD^

will just reset the current HEAD to its own parent - leaving the working 
directory untouched, but effectively un-doing the top-most commit. You 
might want to do this if you realize after you committed that you made a 
mistake that you want to fix up: reset your HEAD back to its previous 
state, fix up the working directory and re-do the commit.

If you want to totally un-do the commit (and reset your working directory
to that point too), you'd first use "git reset HEAD^" to reset to the
parent, and then do a "git checkout -f" to reset the working directory
state to that point in time too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is potentially a dangerous command, so maybe we should make it
ask for confirmation first?

On the other hand, it definitely is convenient: I often end up doing this
by hand, and clearly other people have hit the "oops, I want to undo and
then re-do those last five commits, I was just a bit too drunk"

The old "git reset" only reset the index to the current HEAD, which is 
really only useful if you've tried to do a "merge" that failed and that 
you're giving up on. This one is more useful, but also potentially more 
dangerous - doing a

	git reset v0.99.3
	git checkout -f

will basically revert a tree to some old state, and if you didn't save the 
old point, you may not be able to get back to it (git-fsck-cache will help 
you, but..)

Not hugely tested, btw. That strange extra "git-rev-parse" is _meant_ to
make sure that if you reset to a tag, it will always extract the commit ID
from that tag and not reset the HEAD to a tag object.

diff --git a/git-reset-script b/git-reset-script
--- a/git-reset-script
+++ b/git-reset-script
@@ -1,5 +1,7 @@
 #!/bin/sh
 . git-sh-setup-script || die "Not a git archive"
-git-read-tree --reset HEAD
+rev=$(git-rev-parse --revs-only --verify --default HEAD "$@") || exit
+rev=$(git-rev-parse --revs-only --verify $rev^0) || exit
+git-read-tree --reset "$rev" && echo "$rev" > "$GIT_DIR/HEAD"
 git-update-cache --refresh
 rm -f "$GIT_DIR/MERGE_HEAD"

From: Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH] cogito: Add cg-undo command
Date: Tue, 3 May 2005 10:06:25 -0700
Message-ID: <20050503100624.A29266@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 19:03:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT0mp-0007h8-HU
	for gcvg-git@gmane.org; Tue, 03 May 2005 19:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVECRIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVECRIa
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 13:08:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54474 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261398AbVECRIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 13:08:24 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503170820.VUM1367.fed1rmmtao07.cox.net@liberty.homelinux.org>;
          Tue, 3 May 2005 13:08:20 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id KAA29569;
	Tue, 3 May 2005 10:06:25 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds a cg-undo command which takes a commit ID and resets HEAD
to the parent of the commit ID...refreshing the tree. This undoes
a single commit or a series of commits.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

--- a1aff2a6748c0c0d08058c7d74503e724abc5d03/Makefile  (mode:100644 sha1:6ae0afa0208a8f755d383281a6d049a4ef90fe63)
+++ 023d9a7929d2f933d8e008f1679f13a58f7b1229/Makefile  (mode:100644 sha1:6c282aeebe86ecee9e634481b3d51fd53a582791)
@@ -47,7 +47,7 @@
 	cg-add cg-admin-lsobj cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch \
 	cg-patch cg-pull cg-branch-add cg-branch-ls cg-rm cg-seek cg-status \
-	cg-tag cg-tag-ls cg-update cg-Xlib
+	cg-tag cg-tag-ls cg-undo cg-update cg-Xlib
 
 COMMON=	read-cache.o
 
Index: cg-help
===================================================================
--- a1aff2a6748c0c0d08058c7d74503e724abc5d03/cg-help  (mode:100755 sha1:1f5d2d79b67490d44ce0f575ff9a4b80134ea47f)
+++ 023d9a7929d2f933d8e008f1679f13a58f7b1229/cg-help  (mode:100755 sha1:c7dc8f3e03895374cd0dae544570a37a459c2466)
@@ -43,6 +43,7 @@
 	cg-status
 	cg-tag		TNAME [COMMIT_ID]
 	cg-tag-ls
+	cg-undo		[COMMIT_ID]
 	cg-update	[BNAME]
 	cg-version
 
Index: cg-undo
===================================================================
--- /dev/null  (tree:a1aff2a6748c0c0d08058c7d74503e724abc5d03)
+++ 023d9a7929d2f933d8e008f1679f13a58f7b1229/cg-undo  (mode:100755 sha1:7fd6d89158fb5aeee42aa05a93f2c81884d9bd34)
@@ -0,0 +1,20 @@
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
+PARENT=`git-cat-file commit $1 | grep parent | cut -f 2 -d " "`
+echo "Undo from $1 to current HEAD"
+echo "Reset HEAD to $PARENT"
+echo "$PARENT" > .git/HEAD
+git-read-tree -m "$PARENT" || {
+	echo >&2 "$PARENT: bad commit"
+	exit 1
+}
+git-checkout-cache -f -a
+git-update-cache --refresh

From: Michael Frank <msfrank@syntaxjockey.com>
Subject: [COGITO PATCH] mirroring repositories
Date: Sun, 29 May 2005 14:41:23 -0700
Message-ID: <1117402883.8536.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ehuvnRfC69qlKYZk+DtQ"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 23:39:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcVVL-0007LF-79
	for gcvg-git@gmane.org; Sun, 29 May 2005 23:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVE2Vlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVE2Vlu
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 17:41:50 -0400
Received: from Yonetim.Ayvam.Net ([65.19.178.178]:10 "EHLO
	secure.syntaxjockey.com") by vger.kernel.org with ESMTP
	id S261448AbVE2Vl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 17:41:26 -0400
Received: from [192.168.1.100] (207-224-29-220.ptld.qwest.net [207.224.29.220])
	by secure.syntaxjockey.com (Postfix) with ESMTP id B650E9824;
	Sun, 29 May 2005 17:41:24 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ehuvnRfC69qlKYZk+DtQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch adds the two programs cg-mirror-add and
cg-mirror-sync.  Say you do all of your work on your laptop and you want
to make a mirror of your repository available to the public.  You
specify the location of the mirror with cg-mirror-add:

$ cg-mirror-add scp://my.server:/var/www/repos/project.git

which locally creates the file .git/mirrors.  Whenever you want to
upload your changes, you run cg-mirror-sync.

Michael

Signed-off-by: Michael Frank <msfrank@syntaxjockey.com>

--=-ehuvnRfC69qlKYZk+DtQ
Content-Disposition: attachment; filename=mirror.patch
Content-Type: text/x-patch; name=mirror.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pruN cogito.old/cg-mirror-add cogito.new/cg-mirror-add
--- cogito.old/cg-mirror-add	1969-12-31 16:00:00.000000000 -0800
+++ cogito.new/cg-mirror-add	2005-05-26 18:46:16.357489808 -0700
@@ -0,0 +1,22 @@
+#!/usr/bin/env bash
+#
+# Add new mirror to the GIT repository.
+# Copyright (c) Michael Frank, 2005
+#
+# Takes the mirror location as parameter.  Location can be
+# an rsync URI, as in:
+#     $ cg-mirror add rsync://your.server:/path/to/project.git
+#
+# or an scp URI (rsync is still used to copy the files):
+#     $ cg-mirror add scp://user@your.server:/project/path.git
+#
+
+. ${COGITO_LIB}cg-Xlib
+
+location=$1
+
+([ "$location" ]) || die "usage: cg-mirror-add MIRROR_LOC"
+if [ -e $_git/mirrors ]; then
+    grep -xq $location $_git/mirrors && die "mirror already exists"
+fi
+echo "$location" >> $_git/mirrors
diff -pruN cogito.old/cg-mirror-sync cogito.new/cg-mirror-sync
--- cogito.old/cg-mirror-sync	1969-12-31 16:00:00.000000000 -0800
+++ cogito.new/cg-mirror-sync	2005-05-26 18:37:35.408686064 -0700
@@ -0,0 +1,25 @@
+#!/usr/bin/env bash
+#
+# Pushes changes from the local GIT repository to mirrors.
+# Copyright (c) Michael Frank, 2005
+#
+
+. ${COGITO_LIB}cg-Xlib
+
+[ -r $_git/mirrors ] || die "No mirrors to sync!"
+
+uri=
+for mirror in `cat $_git/mirrors`; do
+    if echo $mirror | grep -q "^scp://"; then
+        uri=`echo $mirror | sed -e "s/^scp:\/\///"`
+        echo "syncing $mirror ..."
+        rsync -a -v -z --exclude=mirrors $_git/* $uri
+        echo ""
+    elif echo $mirror | grep -q "^rsync://"; then
+        echo "syncing $mirror ..."
+        rsync -a -v -z --exclude=mirrors $_git/* $mirror
+        echo ""
+    else
+        echo "skipping $mirror; mirror uses unknown transport"
+    fi
+done
diff -pruN cogito.old/Makefile cogito.new/Makefile
--- cogito.old/Makefile	2005-05-26 19:15:25.412593016 -0700
+++ cogito.new/Makefile	2005-05-26 17:44:43.348912448 -0700
@@ -55,7 +55,8 @@ PROG=   git-update-cache git-diff-files 
 SCRIPT=	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch cg-patch \
-	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update
+	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
+	cg-mirror-add cg-mirror-sync
 
 LIB_SCRIPT=cg-Xlib cg-Xdiffdo cg-Xmergefile
 

--=-ehuvnRfC69qlKYZk+DtQ--


From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] Makefile: add quick-install-doc for installing pre-built manpages
Date: Fri, 22 Dec 2006 22:18:02 -0800
Message-ID: <11668546833727-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 23 07:18:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy0D0-0003F4-4C
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 07:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbWLWGSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 01:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLWGSI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 01:18:08 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38620 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513AbWLWGSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 01:18:07 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A63DE7DC02A;
	Fri, 22 Dec 2006 22:18:03 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 22 Dec 2006 22:18:03 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gc902c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35274>

This adds and uses the install-doc-quick.sh file to
Documentation/, which is usable for people who track either the
'html' or 'man' heads in Junio's repository.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/Makefile             |    3 +++
 Documentation/install-doc-quick.sh |   32 ++++++++++++++++++++++++++++++++
 Makefile                           |    2 ++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d68bc4a..d563142 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -112,3 +112,6 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 
 install-webdoc : html
 	sh ./install-webdoc.sh $(WEBDOC_DEST)
+
+quick-install:
+	DESTDIR=$(mandir) sh ./install-doc-quick.sh man
diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
new file mode 100644
index 0000000..44ccf60
--- /dev/null
+++ b/Documentation/install-doc-quick.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# This requires a branch named in $head
+# (usually 'man' or 'html', provided by the git.git repository)
+set -e
+head="$1"
+if ! git-rev-parse --verify "$head" >/dev/null; then
+	echo >&2 "head: $head does not exist in the current repository"
+	exit 1
+fi
+
+if test -z "$DESTDIR"; then
+	echo >&2 'DESTDIR must be set in the environment'
+	exit 1
+fi
+
+GIT_INDEX_FILE=`pwd`/.quick-doc.index
+export GIT_INDEX_FILE
+rm -f "$GIT_INDEX_FILE"
+SUBDIRECTORY_OK=t
+. git-sh-setup
+export GIT_DIR
+git-read-tree $head
+git-checkout-index -a -f --prefix="$DESTDIR"/
+
+if test -n "$GZ"; then
+	cd "$DESTDIR"
+	for i in `git-ls-tree -r --name-only $head`
+	do
+		gzip < $i > $i.gz && rm $i
+	done
+fi
+rm -f "$GIT_INDEX_FILE"
diff --git a/Makefile b/Makefile
index 7651104..5492836 100644
--- a/Makefile
+++ b/Makefile
@@ -830,6 +830,8 @@ install: all
 install-doc:
 	$(MAKE) -C Documentation install
 
+quick-install-doc:
+	$(MAKE) -C Documentation quick-install
 
 
 
-- 
1.4.4.3.gc902c

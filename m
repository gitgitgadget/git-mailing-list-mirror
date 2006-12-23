From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Makefile: add quick-install-doc for installing pre-built manpages
Date: Sat, 23 Dec 2006 08:26:09 -0800
Message-ID: <20061223162609.GA23084@localdomain>
References: <11668546833727-git-send-email-normalperson@yhbt.net> <7virg3t54l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 17:26:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy9hd-00074B-JA
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 17:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbWLWQ0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 11:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbWLWQ0M
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 11:26:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39131 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbWLWQ0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 11:26:12 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C07D37DC02A;
	Sat, 23 Dec 2006 08:26:09 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 23 Dec 2006 08:26:09 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virg3t54l.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35324>

This adds and uses the install-doc-quick.sh file to
Documentation/, which is usable for people who track either the
'html' or 'man' heads in Junio's repository (prefixed with
'origin/' if cloned locally).  You may override this by
specifying DOC_REF in the make environment or in config.mak.

GZ may also be set in the environment (or config.mak) if you
wish to gzip the documentation after installing it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/Makefile             |    4 ++++
 Documentation/install-doc-quick.sh |   31 +++++++++++++++++++++++++++++++
 Makefile                           |    2 ++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d68bc4a..93c7024 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -32,6 +32,7 @@ man7dir=$(mandir)/man7
 # DESTDIR=
 
 INSTALL?=install
+DOC_REF = origin/man
 
 -include ../config.mak.autogen
 
@@ -112,3 +113,6 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 
 install-webdoc : html
 	sh ./install-webdoc.sh $(WEBDOC_DEST)
+
+quick-install:
+	sh ./install-doc-quick.sh $(DOC_REF) $(mandir)
diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
new file mode 100755
index 0000000..a640549
--- /dev/null
+++ b/Documentation/install-doc-quick.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# This requires a branch named in $head
+# (usually 'man' or 'html', provided by the git.git repository)
+set -e
+head="$1"
+mandir="$2"
+SUBDIRECTORY_OK=t
+USAGE='<refname> <target directory>'
+. git-sh-setup
+export GIT_DIR
+
+test -z "$mandir" && usage
+if ! git-rev-parse --verify "$head^0" >/dev/null; then
+	echo >&2 "head: $head does not exist in the current repository"
+	usage
+fi
+
+GIT_INDEX_FILE=`pwd`/.quick-doc.index
+export GIT_INDEX_FILE
+rm -f "$GIT_INDEX_FILE"
+git-read-tree $head
+git-checkout-index -a -f --prefix="$mandir"/
+
+if test -n "$GZ"; then
+	cd "$mandir"
+	for i in `git-ls-tree -r --name-only $head`
+	do
+		gzip < $i > $i.gz && rm $i
+	done
+fi
+rm -f "$GIT_INDEX_FILE"
diff --git a/Makefile b/Makefile
index 4362297..ebc1a17 100644
--- a/Makefile
+++ b/Makefile
@@ -824,6 +824,8 @@ install: all
 install-doc:
 	$(MAKE) -C Documentation install
 
+quick-install-doc:
+	$(MAKE) -C Documentation quick-install
 
 
 
-- 
1.4.4.3.gc902c

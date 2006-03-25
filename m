From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] Add git-explode-packs
Date: Sat, 25 Mar 2006 15:02:24 +0300
Message-ID: <11432881443149-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Sat Mar 25 13:02:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN7Tl-00034u-79
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 13:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWCYMCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 07:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWCYMCq
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 07:02:46 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:53765 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP
	id S1751093AbWCYMCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 07:02:45 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 00198528D; Sat, 25 Mar 2006 15:04:46 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo.ds.co.ug)
	by igloo.ds.co.ug with smtp (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1FN7TM-0001Tw-Ra; Sat, 25 Mar 2006 15:02:24 +0300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17982>

This script does the opposite of git repack -a -d.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 .gitignore                          |    1 +
 Documentation/git-explode-packs.txt |   45 +++++++++++++++++++++++++++++++++++
 Makefile                            |    2 +-
 git-explode-packs.sh                |   26 ++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-explode-packs.txt
 create mode 100755 git-explode-packs.sh

277352dd9a0549cd626242b14454da37acbc72f3
diff --git a/.gitignore b/.gitignore
index b4355b9..0ac74e3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -133,3 +133,4 @@ libgit.a
 *.py[co]
 config.mak
 git-blame
+git-explode-packs
diff --git a/Documentation/git-explode-packs.txt b/Documentation/git-explode-packs.txt
new file mode 100644
index 0000000..9651a4e
--- /dev/null
+++ b/Documentation/git-explode-packs.txt
@@ -0,0 +1,45 @@
+git-explode-packs(1)
+====================
+
+NAME
+----
+git-explode-packs - Script used to explode packs in a repository into objects
+
+
+SYNOPSIS
+--------
+'git-explode-packs'
+
+DESCRIPTION
+-----------
+
+This script is used to explode all packs into the constituent objects.
+
+A pack is a collection of objects, individually compressed, with
+delta compression applied, stored in a single file, with an
+associated index file.
+
+Packs are used to reduce the load on mirror systems, backup
+engines, disk storage, etc.
+
+This script removes all the packs in the repository, replacing them with the
+objects that are stored inside them.
+
+Author
+------
+Written by Martin Atukunda <matlads@dsmagic.com>
+
+Documentation
+--------------
+Documentation by Martin Atukunda <matlads@dsmag.com>
+
+See Also
+--------
+gitlink:git-pack-objects[1]
+gitlink:git-prune-packed[1]
+gitlink:git-repack[1]
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 8d45378..71e31f0 100644
--- a/Makefile
+++ b/Makefile
@@ -125,7 +125,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh git-grep.sh \
-	git-lost-found.sh
+	git-lost-found.sh git-explode-packs.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-explode-packs.sh b/git-explode-packs.sh
new file mode 100755
index 0000000..a7e9761
--- /dev/null
+++ b/git-explode-packs.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Martin Atukunda
+#
+
+USAGE=''
+. git-sh-setup
+
+PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
+PRESDIR="./++preserve"
+
+mkdir "$PRESDIR" && (
+	for p in "$GIT_OBJECT_DIRECTORY"/pack/pack-*.pack; do
+		if test -f "$p"; then
+			mv "$p" "$PRESDIR"
+		fi
+	done
+
+	for p in "$PRESDIR"/pack-*.pack; do
+		if test -f "$p"; then
+			git-unpack-objects <$p
+			rm -- $p
+		fi
+	done
+	rmdir "$PRESDIR"
+)
-- 
1.2.4.gd3e1

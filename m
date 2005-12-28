From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/6] Makefile: use git-describe to mark the git version.
Date: Tue, 27 Dec 2005 16:42:55 -0800
Message-ID: <7v8xu62gs0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:43:28 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErPPa-0003w8-5M
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 01:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVL1Am7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVL1Am6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 19:42:58 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46477 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932434AbVL1Am5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 19:42:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228004209.MFNQ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 19:42:09 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14085>

Note: with this commit, the GIT maintainer workflow must change.
GIT-VERSION-GEN is now the file to munge when the default
version needs to be changed, not Makefile.  The tag needs to be
pushed into the repository to build the official tarball and
binary package beforehand.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Only lightly tested.  Especially bootstrapping might be
   fishy, but I'll be heading off to Japan for fishful new year
   meals in a few days ;-), so...

 .gitignore      |    1 +
 GIT-VERSION-GEN |   18 ++++++++++++++++++
 Makefile        |   10 ++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100755 GIT-VERSION-GEN

8e517cdeb5644b9857c8a9d8ce204ec9b7405297
diff --git a/.gitignore b/.gitignore
index 6bd508e..47d76f4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+GIT-VERSION-FILE
 git
 git-add
 git-am
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
new file mode 100755
index 0000000..196402c
--- /dev/null
+++ b/GIT-VERSION-GEN
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+GVF=GIT-VERSION-FILE
+
+VN=$(git describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
+VN=$(expr "$VN" : v'\(.*\)')
+if test -r $GVF
+then
+	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
+else
+	VC=unset
+fi
+test "$VN" = "$VC" || {
+	echo >&2 "GIT_VERSION = $VN"
+	echo "GIT_VERSION = $VN" >$GVF
+}
+
+
diff --git a/Makefile b/Makefile
index 47e7898..6f1d123 100644
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,9 @@ all:
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-cache perspective.
 
-GIT_VERSION = 1.0.GIT
+GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
+	@sh ./GIT-VERSION-GEN
+-include GIT-VERSION-FILE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
@@ -369,7 +371,7 @@ all: $(ALL_PROGRAMS)
 all:
 	$(MAKE) -C templates
 
-git$X: git.c $(LIB_FILE) Makefile
+git$X: git.c $(LIB_FILE) Makefile GIT-VERSION-FILE
 	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE)
 
@@ -499,6 +501,7 @@ deb: dist
 ### Cleaning rules
 
 clean:
+	rm -f GIT-VERSION-FILE
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o $(LIB_FILE)
 	rm -f $(PROGRAMS) $(SIMPLE_PROGRAMS) git$X
 	rm -f $(filter-out gitk,$(SCRIPTS))
@@ -511,3 +514,6 @@ clean:
 	$(MAKE) -C templates clean
 	$(MAKE) -C t/ clean
 
+.PHONY: all install clean
+.PHONY: .FORCE-GIT-VERSION-FILE
+
-- 
1.0.5-geb9d

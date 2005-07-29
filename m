From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 6/2] Reorder Makefile rules
Date: Fri, 29 Jul 2005 17:50:24 +0200
Message-ID: <20050729155024.GI21909@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 17:53:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyXAX-0005mk-Ct
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 17:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVG2Pwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVG2Pup
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 11:50:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16402 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262633AbVG2Pu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 11:50:27 -0400
Received: (qmail 11876 invoked by uid 2001); 29 Jul 2005 15:50:24 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The Makefile rules were massively reordered so that they are actually
logically grouped now. Captions were added to separate the sections. No
rule contents was touched during the process.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 656a66fe63898954dbc40854dd049dc76eb9b841
tree a5b29a2163c1bbd671a1dc40d0cb6dade3c4aaee
parent ee84cc0f730f0e744fe8d922b24f6f7ebe31d737
author Petr Baudis <pasky@suse.cz> Fri, 29 Jul 2005 17:02:14 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 29 Jul 2005 17:02:14 +0200

 Makefile |   87 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -43,12 +43,16 @@ AR?=ar
 INSTALL?=install
 RPMBUILD?=rpmbuild
 
-#
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
-#
 SPARSE_FLAGS?=-D__BIG_ENDIAN__ -D__powerpc__
 
+
+
+### --- END CONFIGURATION SECTION ---
+
+
+
 SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
 	git-fetch-script git-status-script git-commit-script \
@@ -74,18 +78,12 @@ PROG=   git-update-cache git-diff-files 
 	git-show-index git-daemon git-var git-peek-remote \
 	git-update-server-info git-show-rev-cache git-build-rev-cache
 
-all: $(PROG)
-
-install: $(PROG) $(SCRIPTS)
-	$(INSTALL) -m755 -d $(dest)$(bindir)
-	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
-
-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o path.o \
-	 epoch.o refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h csum-file.h \
 	pack.h pkt-line.h refs.h
+LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
+	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o path.o \
+	 epoch.o refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o
 
 LIB_H += rev-cache.h
 LIB_OBJS += rev-cache.o
@@ -122,17 +120,12 @@ endif
 
 CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)'
 
-$(LIB_FILE): $(LIB_OBJS)
-	$(AR) rcs $@ $(LIB_OBJS)
 
-check:
-	for i in *.c; do sparse $(CFLAGS) $(SPARSE_FLAGS) $$i; done
 
-test-date: test-date.c date.o
-	$(CC) $(CFLAGS) -o $@ test-date.c date.o
+### Build rules
+
+all: $(PROG)
 
-test-delta: test-delta.c diff-delta.o patch-delta.o
-	$(CC) $(CFLAGS) -o $@ $^
 
 git-%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
@@ -148,6 +141,47 @@ git-rev-list: LIBS += -lssl
 $(LIB_OBJS): $(LIB_H)
 $(DIFF_OBJS): diffcore.h
 
+$(LIB_FILE): $(LIB_OBJS)
+	$(AR) rcs $@ $(LIB_OBJS)
+
+doc:
+	$(MAKE) -C Documentation all
+
+
+
+### Testing rules
+
+test: all
+	$(MAKE) -C t/ all
+
+test-date: test-date.c date.o
+	$(CC) $(CFLAGS) -o $@ test-date.c date.o
+
+test-delta: test-delta.c diff-delta.o patch-delta.o
+	$(CC) $(CFLAGS) -o $@ $^
+
+check:
+	for i in *.c; do sparse $(CFLAGS) $(SPARSE_FLAGS) $$i; done
+
+
+
+### Installation rules
+
+install: $(PROG) $(SCRIPTS)
+	$(INSTALL) -m755 -d $(dest)$(bindir)
+	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
+
+install-tools:
+	$(MAKE) -C tools install
+
+install-doc:
+	$(MAKE) -C Documentation install
+
+
+
+
+### Maintainer's dist rules
+
 git-core.spec: git-core.spec.in Makefile
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
 
@@ -163,23 +197,16 @@ dist: git-core.spec git-tar-tree
 rpm: dist
 	$(RPMBUILD) -ta git-core-$(GIT_VERSION).tar.gz
 
-test: all
-	$(MAKE) -C t/ all
 
-doc:
-	$(MAKE) -C Documentation all
+backup: clean
+	cd .. ; tar czvf dircache.tar.gz dir-cache
 
-install-tools:
-	$(MAKE) -C tools install
 
-install-doc:
-	$(MAKE) -C Documentation install
+
+### Cleaning rules
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
 	rm -f git-core-*.tar.gz git-core.spec
 	$(MAKE) -C tools/ clean
 	$(MAKE) -C Documentation/ clean
-
-backup: clean
-	cd .. ; tar czvf dircache.tar.gz dir-cache

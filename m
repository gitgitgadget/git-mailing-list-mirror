From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 4/2] Improve the compilation-time settings interface
Date: Fri, 29 Jul 2005 17:48:26 +0200
Message-ID: <20050729154826.GG21909@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 17:51:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyX8H-0005BV-Ds
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 17:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVG2PuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVG2PuJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 11:50:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13074 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262632AbVG2Psa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 11:48:30 -0400
Received: (qmail 11534 invoked by uid 2001); 29 Jul 2005 15:48:26 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Describe variables which make itself takes and adjusts compilation
accordingly (MOZILLA_SHA1, NO_OPENSSL, PPC_SHA1), and make adding
defines more convenient through the $DEFINES variable. $COPTS includes
-g as well now and is not overriden if it was already declared in the
environment. Also, $CFLAGS is appended to rather than reset, so that if
there was already a $CFLAGS environment variable, it's appended to. Some
more variables are also made overridable through the environment. Renamed
$bin to $bindir which is the name commonly used for this.

This is part of the Cogito Makefile changes port.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 601722751e42dfef8bcd2fe3d6b070b07eb9198e
tree ebe576c5bd841b4daeb855e49635491c02a322b5
parent 8ddefe85adc8e035864be615c87844ef982f4bc6
author Petr Baudis <pasky@suse.cz> Fri, 29 Jul 2005 15:45:42 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 29 Jul 2005 15:45:42 +0200

 Makefile |   56 ++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1,33 +1,53 @@
-# -DCOLLISION_CHECK if you believe that SHA1's
-# 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# Define MOZILLA_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
+# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
+# choice) has very fast version optimized for i586.
 #
-# -DUSE_NSEC if you want git to care about sub-second file mtimes and ctimes.
-# -DUSE_STDEV if you want git to care about st_dev changing
+# Define NO_OPENSSL environment variable if you do not have OpenSSL. You will
+# miss out git-rev-list --merge-order. This also implies MOZILLA_SHA1.
 #
-# Note that you need some new glibc (at least >2.2.4) for this, and it will
-# BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
-# break unless your underlying filesystem supports those sub-second times
-# (my ext3 doesn't).
+# Define PPC_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine optimized for PowerPC.
+
+
+# Define COLLISION_CHECK below if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# sufficient guarantee that no collisions between objects will ever happen.
+
+# DEFINES += -DCOLLISION_CHECK
+
+# Define USE_NSEC below if you want git to care about sub-second file mtimes
+# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
+# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
+# randomly break unless your underlying filesystem supports those sub-second
+# times (my ext3 doesn't).
+
+# DEFINES += -DUSE_NSEC
+
+# Define USE_STDEV below if you want git to care about the underlying device
+# change being considered an inode change from the update-cache perspective.
+
+# DEFINES += -DUSE_STDEV
+
 GIT_VERSION=0.99.2
 
-COPTS=-O2
-CFLAGS=-g $(COPTS) -Wall
+COPTS?=-g -O2
+CFLAGS+=$(COPTS) -Wall $(DEFINES)
 
 prefix=$(HOME)
-bin=$(prefix)/bin
+bindir=$(prefix)/bin
 # dest=
 
-CC=gcc
-AR=ar
-INSTALL=install
-RPMBUILD=rpmbuild
+CC?=gcc
+AR?=ar
+INSTALL?=install
+RPMBUILD?=rpmbuild
 
 #
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
 #
-SPARSE_FLAGS=-D__BIG_ENDIAN__ -D__powerpc__
+SPARSE_FLAGS?=-D__BIG_ENDIAN__ -D__powerpc__
 
 SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
@@ -57,7 +77,7 @@ PROG=   git-update-cache git-diff-files 
 all: $(PROG)
 
 install: $(PROG) $(SCRIPTS)
-	$(INSTALL) -m755 -d $(dest)$(bin)
+	$(INSTALL) -m755 -d $(dest)$(bindir)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \

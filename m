From: Junio C Hamano <junkio@cox.net>
Subject: Deal with $(bindir) and friends with whitespaces.
Date: Mon, 10 Oct 2005 13:52:40 -0700
Message-ID: <7v7jcl3xif.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051010085259.GA18009@diku.dk>
	<7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net> <434A82A0.7060608@zytor.com>
	<7v64s571t5.fsf@assigned-by-dhcp.cox.net> <434AA033.60308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 22:55:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4db-0005sU-45
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVJJUwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVJJUwn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:52:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:11208 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751233AbVJJUwm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:52:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010205226.ZRLL776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 16:52:26 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434AA033.60308@zytor.com> (H. Peter Anvin's message of "Mon, 10
	Oct 2005 10:09:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9933>

... using HPA's shellquote macro.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 I only tested that this passes "Anna's Home" test:

	make	HOME="/tmp/Anna's Home" \
		PERL_PATH="Anna's Home/Program Directory/perl"  \
		PYTHON_PATH="Anna's Home/Program Directory/python" \
		test install

 Makefile               |   34 ++++++++++++++++++++--------------
 git-merge-recursive.py |    2 +-
 t/Makefile             |    8 +++++++-
 templates/Makefile     |   10 ++++++++--
 4 files changed, 36 insertions(+), 18 deletions(-)

applies-to: a35b27b04d18022ea4731941ea2a1bedce998092
8f77be8002b9e254ccb5cc3ed3ad1b9240289f7c
diff --git a/Makefile b/Makefile
index ac384c7..f7eee47 100644
--- a/Makefile
+++ b/Makefile
@@ -163,6 +163,12 @@ LIB_OBJS = \
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
+# Shell quote;
+# Result of this needs to be placed inside ''
+shq = $(subst ','\'',$(1))
+# This has surrounding ''
+shellquote = '$(call shq,$(1))'
+
 #
 # Platform specific tweaks
 #
@@ -235,7 +241,7 @@ ifndef NO_OPENSSL
 		OPENSSL_LINK =
 	endif
 else
-	DEFINES += '-DNO_OPENSSL'
+	DEFINES += -DNO_OPENSSL
 	MOZILLA_SHA1 = 1
 	OPENSSL_LIBSSL =
 endif
@@ -294,7 +300,7 @@ endif
 endif
 endif
 
-DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'
+DEFINES += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER))
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
@@ -311,7 +317,7 @@ all:
 
 git: git.sh Makefile
 	rm -f $@+ $@
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH)|' \
+	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@X@@/$(X)/g' \
 	    $(GIT_LIST_TWEAK) <$@.sh >$@+
@@ -320,22 +326,22 @@ git: git.sh Makefile
 
 $(filter-out git,$(patsubst %.sh,%,$(SCRIPT_SH))) : % : %.sh
 	rm -f $@
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH)|' \
+	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.sh >$@
 	chmod +x $@
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
 	rm -f $@
-	sed -e '1s|#!.*perl|#!$(PERL_PATH)|' \
+	sed -e '1s|#!.*perl|#!$(call shq,$(PERL_PATH))|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@
 	chmod +x $@
 
 $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
 	rm -f $@
-	sed -e '1s|#!.*python|#!$(PYTHON_PATH)|' \
-	    -e 's|@@GIT_PYTHON_PATH@@|$(GIT_PYTHON_DIR)|g' \
+	sed -e '1s|#!.*python|#!$(call shq,$(PYTHON_PATH))|' \
+	    -e 's|@@GIT_PYTHON_PATH@@|$(call shq,$(GIT_PYTHON_DIR))|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.py >$@
 	chmod +x $@
@@ -365,7 +371,7 @@ git-rev-list$X: LIBS += $(OPENSSL_LIBSSL
 
 init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
-		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir)"' $*.c
+		-DDEFAULT_GIT_TEMPLATE_DIR=$(call shellquote,"$(template_dir)") $*.c
 
 $(LIB_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H)
@@ -397,13 +403,13 @@ check:
 ### Installation rules
 
 install: $(PROGRAMS) $(SCRIPTS)
-	$(INSTALL) -d -m755 $(DESTDIR)$(bindir)
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
-	$(INSTALL) git-revert $(DESTDIR)$(bindir)/git-cherry-pick
-	sh ./cmd-rename.sh $(DESTDIR)$(bindir)
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) git-revert $(call shellquote,$(DESTDIR)$(bindir)/git-cherry-pick)
+	sh ./cmd-rename.sh $(call shellquote,$(DESTDIR)$(bindir))
 	$(MAKE) -C templates install
-	$(INSTALL) -d -m755 $(DESTDIR)$(GIT_PYTHON_DIR)
-	$(INSTALL) $(PYMODULES) $(DESTDIR)$(GIT_PYTHON_DIR)
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
+	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 
 install-doc:
 	$(MAKE) -C Documentation install
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index b80a860..626d854 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -4,7 +4,7 @@ import sys, math, random, os, re, signal
 from heapq import heappush, heappop
 from sets import Set
 
-sys.path.append('@@GIT_PYTHON_PATH@@')
+sys.path.append('''@@GIT_PYTHON_PATH@@''')
 from gitMergeCommon import *
 
 originalIndexFile = os.environ.get('GIT_INDEX_FILE',
diff --git a/t/Makefile b/t/Makefile
index e71da77..5c76aff 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -7,10 +7,16 @@
 SHELL_PATH ?= $(SHELL)
 TAR ?= $(TAR)
 
+# Shell quote;
+# Result of this needs to be placed inside ''
+shq = $(subst ','\'',$(1))
+# This has surrounding ''
+shellquote = '$(call shq,$(1))'
+
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
 all:
-	@$(foreach t,$T,echo "*** $t ***"; $(SHELL_PATH) $t $(GIT_TEST_OPTS) || exit; )
+	@$(foreach t,$T,echo "*** $t ***"; $(call shellquote,$(SHELL_PATH)) $t $(GIT_TEST_OPTS) || exit; )
 	@rm -fr trash
 
 clean:
diff --git a/templates/Makefile b/templates/Makefile
index c23aee8..07e928e 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -6,6 +6,12 @@ prefix ?= $(HOME)
 template_dir ?= $(prefix)/share/git-core/templates/
 # DESTDIR=
 
+# Shell quote;
+# Result of this needs to be placed inside ''
+shq = $(subst ','\'',$(1))
+# This has surrounding ''
+shellquote = '$(call shq,$(1))'
+
 all: boilerplates.made custom
 	find blt
 
@@ -38,6 +44,6 @@ clean:
 	rm -rf blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m755 $(DESTDIR)$(template_dir)
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(template_dir))
 	(cd blt && $(TAR) cf - .) | \
-	(cd $(DESTDIR)$(template_dir) && $(TAR) xf -)
+	(cd $(call shellquote,$(DESTDIR)$(template_dir)) && $(TAR) xf -)
---
0.99.8.GIT

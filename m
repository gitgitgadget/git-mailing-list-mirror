From: Junio C Hamano <junkio@cox.net>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 18:13:54 -0700
Message-ID: <7vwtl78dyl.fsf@assigned-by-dhcp.cox.net>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
	<7vmzm4duf8.fsf@assigned-by-dhcp.cox.net>
	<20050923121705.GA11377@sunq05.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Sean" <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Sep 24 03:14:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIycG-0005z9-0D
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 03:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVIXBN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 21:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVIXBN7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 21:13:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65232 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751356AbVIXBN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 21:13:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924011356.YAMQ6597.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 21:13:56 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9217>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> GCC is not complaining.  :-)
>
> My current make command is like this:
>
> gmake NO_STRCASESTR=YesPlease CURLDIR=/opt/sfw/  \
>       SHELL_PATH=/bin/bash INSTALL=ginstall install
>
> There are two problems:
>
> * First of all there really needs to be a TAR variable, 
>   since Solaris tar doesn't like the C option. 
>
> * Secondly I've noticed that git.sh and gitk don't get 
>   their /bin/sh line changed during install.

Thanks.

Would something like the attached patch, on top of what I sent
out, look good?  I do not think bash vs ksh vs bourne makes a
difference in the case of gitk.

------------
[PATCH] Solaris: give a bit more built-in defaults.

Taking the make command line Peter Eriksen uses, give defaults
to SHELL_PATH, TAR, CURLDIR, NO_STRCASESTR, and INSTALL.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile           |   43 ++++++++++++++++++++++++++-----------------
 git-clone.sh       |    3 ++-
 templates/Makefile |   10 ++++++----
 3 files changed, 34 insertions(+), 22 deletions(-)

49cbdf77449687da471ee9289796f7c480e7bd73
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -27,8 +27,6 @@
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 #
-# Define NO_GETDOMAINNAME if your library lack it (SunOS, Patrick Mauritz).
-#
 # Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
 #
 # Define COLLISION_CHECK below if you believe that SHA1's
@@ -63,6 +61,7 @@ GIT_PYTHON_DIR = $(prefix)/share/git-cor
 
 CC = gcc
 AR = ar
+TAR = tar
 INSTALL = install
 RPMBUILD = rpmbuild
 
@@ -133,17 +132,6 @@ ifdef WITH_SEND_EMAIL
 	SCRIPT_PERL += git-send-email.perl
 endif
 
-ifndef NO_CURL
-	ifdef CURLDIR
-		# This is still problematic -- gcc does not want -R.
-		CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
-	else
-		CURL_LIBCURL = -lcurl
-	endif
-	PROGRAMS += git-http-fetch
-endif
-
 LIB_FILE=libgit.a
 
 LIB_H = \
@@ -166,6 +154,9 @@ LIB_OBJS = \
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
+#
+# Platform specific tweaks
+#
 ifeq ($(shell uname -s),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
@@ -173,12 +164,28 @@ endif
 ifeq ($(shell uname -s),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
+	SHELL_PATH = /bin/bash
+	NO_STRCASESTR = YesPlease
+	CURLDIR = /opt/sfw
+	INSTALL = ginstall
+	TAR = gtar
 	PLATFORM_DEFINES += -D__EXTENSIONS__
 endif
 ifneq (,$(findstring arm,$(shell uname -m)))
 	ARM_SHA1 = YesPlease
 endif
 
+ifndef NO_CURL
+	ifdef CURLDIR
+		# This is still problematic -- gcc does not want -R.
+		CFLAGS += -I$(CURLDIR)/include
+		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
+	else
+		CURL_LIBCURL = -lcurl
+	endif
+	PROGRAMS += git-http-fetch
+endif
+
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
 endif
@@ -245,6 +252,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  gitk
 
+export TAR INSTALL DESTDIR
 ### Build rules
 
 all: $(PROGRAMS) $(SCRIPTS)
@@ -254,7 +262,8 @@ all:
 
 git: git.sh Makefile
 	rm -f $@+ $@
-	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' <$@.sh >$@+
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH)|' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' <$@.sh >$@+
 	chmod +x $@+
 	mv $@+ $@
 
@@ -356,7 +365,7 @@ dist: git-core.spec git-tar-tree
 	./git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
 	@cp git-core.spec $(GIT_TARNAME)
-	tar rf $(GIT_TARNAME).tar $(GIT_TARNAME)/git-core.spec
+	$(TAR) rf $(GIT_TARNAME).tar $(GIT_TARNAME)/git-core.spec
 	@rm -rf $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
@@ -365,7 +374,7 @@ rpm: dist
 
 deb: dist
 	rm -rf $(GIT_TARNAME)
-	tar zxf $(GIT_TARNAME).tar.gz
+	$(TAR) zxf $(GIT_TARNAME).tar.gz
 	dpkg-source -b $(GIT_TARNAME)
 	cd $(GIT_TARNAME) && fakeroot debian/rules binary
 
@@ -380,5 +389,5 @@ clean:
 	rm -f git-core_$(GIT_VERSION)-*.deb git-core_$(GIT_VERSION)-*.dsc
 	rm -f git-tk_$(GIT_VERSION)-*.deb
 	$(MAKE) -C Documentation/ clean
-	$(MAKE) -C templates/ clean
+	$(MAKE) -C templates clean
 	$(MAKE) -C t/ clean
diff --git a/git-clone.sh b/git-clone.sh
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -139,7 +139,8 @@ yes,yes)
 	then
 		HEAD=HEAD
 	fi
-	tar Ccf "$repo" - refs $HEAD | tar Cxf "$D/.git" - || exit 1
+	(cd "$repo" && tar cf - refs $HEAD) |
+	(cd "$D/.git" && tar xf -) || exit 1
 	;;
 *)
 	case "$repo" in
diff --git a/templates/Makefile b/templates/Makefile
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -1,8 +1,9 @@
 # make and install sample templates
 
-INSTALL=install
-prefix=$(HOME)
-template_dir=$(prefix)/share/git-core/templates/
+INSTALL ?= install
+TAR ?= tar
+prefix ?= $(HOME)
+template_dir ?= $(prefix)/share/git-core/templates/
 # DESTDIR=
 
 all: boilerplates custom
@@ -35,4 +36,5 @@ clean:
 
 install: all
 	$(INSTALL) -d -m755 $(DESTDIR)$(template_dir)
-	tar Ccf blt - . | tar Cxf $(DESTDIR)$(template_dir) -
+	(cd blt && $(TAR) cf - .) | \
+	(cd $(DESTDIR)$(template_dir) && $(TAR) xf -)

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/5] Fixes for ancient versions of GNU make
Date: Sat, 18 Feb 2006 12:40:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602181236210.694@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602171522020.24274@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wy1upn3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 12:40:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAQRy-0001X8-7i
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 12:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWBRLkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 06:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWBRLkY
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 06:40:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42131 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750998AbWBRLkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 06:40:24 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 093F21467AA; Sat, 18 Feb 2006 12:40:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EED0CA53;
	Sat, 18 Feb 2006 12:40:22 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C1FC21467AA; Sat, 18 Feb 2006 12:40:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wy1upn3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16407>


Some versions of GNU make do not understand $(call), and have problems to
interpret rules like this:

some_target: CFLAGS += -Dsome=defs

Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>

---

	On Fri, 17 Feb 2006, Junio C Hamano wrote:

	> I am not opposed to avoiding $(call), but subst everywhere look
	> ugly ;-).

	Agreed. But I think it is a minor hassle for few, and an 
	improvement for	more.

	> You inherited this problem, but these two symbols in different
	> Makefiles with the same name mean two completely different
	> things, which confused me quite badly.

	Fixed. Tested. Works.


 Makefile   |   69 ++++++++++++++++++++++++++++++++++++++----------------------
 t/Makefile |    7 ++----
 2 files changed, 46 insertions(+), 30 deletions(-)

165dab0734398530da84da3ae6df37f33293c660
diff --git a/Makefile b/Makefile
index d7d79de..0a978c2 100644
--- a/Makefile
+++ b/Makefile
@@ -203,12 +203,6 @@ LIB_OBJS = \
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
-# Shell quote;
-# Result of this needs to be placed inside ''
-shq = $(subst ','\'',$(1))
-# This has surrounding ''
-shellquote = '$(call shq,$(1))'
-
 #
 # Platform specific tweaks
 #
@@ -413,7 +407,22 @@ endif
 endif
 endif
 
-ALL_CFLAGS += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER)) $(COMPAT_CFLAGS)
+# Shell quote (do not use $(call) to accomodate ancient setups);
+
+SHA1_HEADER_QUOTED = $(subst ','\'',$(SHA1_HEADER))
+template_dir_QUOTED = $(subst ','\'',$(template_dir))
+
+SHELL_PATH_QUOTED = $(subst ','\'',$(SHELL_PATH))
+PERL_PATH_QUOTED = $(subst ','\'',$(PERL_PATH))
+PYTHON_PATH_QUOTED = $(subst ','\'',$(PYTHON_PATH))
+GIT_PYTHON_DIR_QUOTED = $(subst ','\'',$(GIT_PYTHON_DIR))
+
+# prepend DESTDIR to these
+DESTDIR_bindir_QUOTED = $(subst ','\'',$(DESTDIR)$(bindir))
+DESTDIR_gitexecdir_QUOTED = $(subst ','\'',$(DESTDIR)$(gitexecdir))
+DESTDIR_GIT_PYTHON_DIR_QUOTED = $(subst ','\'',$(DESTDIR)$(GIT_PYTHON_DIR))
+
+ALL_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_QUOTED)' $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
@@ -432,7 +441,7 @@ git$X: git.c $(LIB_FILE)
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	rm -f $@
-	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_QUOTED)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    $@.sh >$@
@@ -440,15 +449,15 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
 	rm -f $@
-	sed -e '1s|#!.*perl|#!$(call shq,$(PERL_PATH))|' \
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_QUOTED)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@
 	chmod +x $@
 
 $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
 	rm -f $@
-	sed -e '1s|#!.*python|#!$(call shq,$(PYTHON_PATH))|' \
-	    -e 's|@@GIT_PYTHON_PATH@@|$(call shq,$(GIT_PYTHON_DIR))|g' \
+	sed -e '1s|#!.*python|#!$(PYTHON_PATH_QUOTED)|' \
+	    -e 's|@@GIT_PYTHON_PATH@@|$(GIT_PYTHON_DIR_QUOTED)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.py >$@
 	chmod +x $@
@@ -474,32 +483,42 @@ git$X git.spec \
 %.o: %.S
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
-exec_cmd.o: ALL_CFLAGS += -DGIT_EXEC_PATH=\"$(gitexecdir)\"
+exec_cmd.o: exec_cmd.c
+	$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_EXEC_PATH=\"$(gitexecdir)\" $<
 
 git-%$X: %.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-mailinfo$X : SIMPLE_LIB += $(LIB_4_ICONV)
 $(SIMPLE_PROGRAMS) : $(LIB_FILE)
 $(SIMPLE_PROGRAMS) : git-%$X : %.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIB_FILE) $(SIMPLE_LIB)
 
-git-http-fetch$X: fetch.o http.o
-git-http-push$X: http.o
+git-mailinfo$X: mailinfo.o $(LIB_FILE)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIB_FILE) $(SIMPLE_LIB) $(LIB_4_ICONV)
+
 git-local-fetch$X: fetch.o
 git-ssh-fetch$X: rsh.o fetch.o
 git-ssh-upload$X: rsh.o
 git-ssh-pull$X: rsh.o fetch.o
 git-ssh-push$X: rsh.o
 
-git-http-fetch$X: LIBS += $(CURL_LIBCURL)
-git-http-push$X: LIBS += $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
-git-rev-list$X: LIBS += $(OPENSSL_LIBSSL)
+git-http-fetch$X: fetch.o http.o http-fetch.o
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL)
+
+git-http-push$X: http.o http-push.o
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
+git-rev-list$X: rev-list.o
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(OPENSSL_LIBSSL)
 
 init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
-		-DDEFAULT_GIT_TEMPLATE_DIR=$(call shellquote,"$(template_dir)") $*.c
+		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_QUOTED)"' $*.c
 
 $(LIB_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H)
@@ -531,13 +550,13 @@ check:
 ### Installation rules
 
 install: all
-	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(gitexecdir))
-	$(INSTALL) $(ALL_PROGRAMS) $(call shellquote,$(DESTDIR)$(gitexecdir))
-	$(INSTALL) git$X gitk $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) -d -m755 '$(DESTDIR_bindir_QUOTED)'
+	$(INSTALL) -d -m755 '$(DESTDIR_gitexecdir_QUOTED)'
+	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_gitexecdir_QUOTED)'
+	$(INSTALL) git$X gitk $(DESTDIR_bindir_QUOTED)'
 	$(MAKE) -C templates install
-	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
-	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
+	$(INSTALL) -d -m755 '$(DESTDIR_GIT_PYTHON_DIR_QUOTED)'
+	$(INSTALL) $(PYMODULES) '$(DESTDIR_GIT_PYTHON_DIR_QUOTED)'
 
 install-doc:
 	$(MAKE) -C Documentation install
diff --git a/t/Makefile b/t/Makefile
index 5c5a620..e7e4229 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -8,17 +8,14 @@ SHELL_PATH ?= $(SHELL)
 TAR ?= $(TAR)
 
 # Shell quote;
-# Result of this needs to be placed inside ''
-shq = $(subst ','\'',$(1))
-# This has surrounding ''
-shellquote = '$(call shq,$(1))'
+SHELL_PATH_QUOTED = $(subst ','\'',$(SHELL_PATH))
 
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
 all: $(T) clean
 
 $(T):
-	@echo "*** $@ ***"; $(call shellquote,$(SHELL_PATH)) $@ $(GIT_TEST_OPTS)
+	@echo "*** $@ ***"; '$(SHELL_PATH_QUOTED)' $@ $(GIT_TEST_OPTS)
 
 clean:
 	rm -fr trash
-- 
1.2.1.geb73

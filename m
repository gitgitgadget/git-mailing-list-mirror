From: Yakov Lerner <iler.ml@gmail.com>
Subject: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild
 to avoid broken install
Date: Wed, 14 Jun 2006 22:26 +0300
Message-ID: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: iler.ml@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 14 21:26:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqb0A-0007Ll-EJ
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 21:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWFNT0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 15:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWFNT0D
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 15:26:03 -0400
Received: from mxout2.netvision.net.il ([194.90.9.21]:53727 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id S1751010AbWFNT0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 15:26:00 -0400
Received: from main ([84.108.4.5]) by mxout2.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0J0V00LDR7B9BU00@mxout2.netvision.net.il> for
 git@vger.kernel.org; Wed, 14 Jun 2006 22:25:58 +0300 (IDT)
To: git@vger.kernel.org
X-Mailer: Mail::SendEasy/1.2 Perl/5.008008-linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21856>

Many times, I mistakenly used 'make prefix=... install' where prefix value
was different from prefix value during build. This resulted in broken
install. This patch adds auto-detection of $prefix change to the Makefile.
This results in correct install whenever prefix is changed.

Signed-off-by: Yakov Lerner <iler.ml@gmail.com>
---
 Makefile |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 2a1e639..015c9b2 100644
--- a/Makefile
+++ b/Makefile
@@ -464,6 +464,7 @@ DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
+prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -484,7 +485,7 @@ all:
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
-git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) .git.prefix
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
@@ -516,7 +517,7 @@ common-cmds.h: Documentation/git-*.txt
 	chmod +x $@+
 	mv $@+ $@
 
-$(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
+$(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py .git.prefix
 	rm -f $@ $@+
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|@@GIT_PYTHON_PATH@@|$(GIT_PYTHON_DIR_SQ)|g' \
@@ -540,19 +541,19 @@ git$X git.spec \
 	$(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	: GIT-VERSION-FILE
 
-%.o: %.c
+%.o: %.c .git.prefix
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.o: %.S
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
-exec_cmd.o: exec_cmd.c
+exec_cmd.o: exec_cmd.c .git.prefix
 	$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
 
-http.o: http.c
+http.o: http.c .git.prefix
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
 ifdef NO_EXPAT
-http-fetch.o: http-fetch.c http.h
+http-fetch.o: http-fetch.c http.h .git.prefix
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
 endif
 
@@ -609,6 +610,14 @@ tags:
 	rm -f tags
 	find . -name '*.[hcS]' -print | xargs ctags -a
 
+### Detect prefix changes
+.git.prefix: .FORCE-git.prefix
+	@PREFIXES='$(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)';\
+	    if test x"$$PREFIXES" != x"`cat .git.prefix 2>/dev/null`" ; then \
+		echo 1>&2 "    * prefix changed"; \
+		echo "$$PREFIXES" >.git.prefix; \
+            fi
+
 ### Testing rules
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -632,6 +641,12 @@ test-dump-cache-tree$X: dump-cache-tree.
 check:
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
+test-prefix-change:
+	mkdir -p "`pwd`/tmp1" "`pwd`/tmp2"
+	$(MAKE) clean install prefix="`pwd`/tmp1"
+	$(MAKE) install prefix="`pwd`/tmp2"
+	@grep -r "`pwd`/tmp1" "`pwd`/tmp2" >/dev/null; if test $$? = 0 ; then\
+	    echo Error, test failed; exit 1; else echo Ok, test passed; fi
 
 
 ### Installation rules
@@ -714,7 +729,7 @@ clean:
 	rm -f GIT-VERSION-FILE
 
 .PHONY: all install clean strip
-.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags
+.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags .FORCE-git.prefix
 
 ### Check documentation
 #
-- 
1.4.0

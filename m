From: Yakov Lerner <iler.ml@gmail.com>
Subject: [PATCH] auto-detect changed prefix and/or changed build flags
Date: Thu, 15 Jun 2006 01:36 +0300
Message-ID: <0J0V00MESG3L3J00@mxout2.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: iler.ml@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 15 00:35:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqdxm-0004Fz-Pr
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 00:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWFNWfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWFNWfs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 18:35:48 -0400
Received: from mxout2.netvision.net.il ([194.90.9.21]:9079 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id S964926AbWFNWfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 18:35:47 -0400
Received: from main ([84.108.4.5]) by mxout2.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0J0V00MERG3L3J00@mxout2.netvision.net.il> for
 git@vger.kernel.org; Thu, 15 Jun 2006 01:35:46 +0300 (IDT)
To: git@vger.kernel.org
X-Mailer: Mail::SendEasy/1.2 Perl/5.008008-linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21869>

Detect changed prefix and/or changed build flags in the middle
of the build (or between 'make' and 'make install'), and if change
is detected, make sure all objects are compiled with same build 
flags and same prefix, thus avoiding inconsistent/broken build.

Signed-off-by: Yakov Lerner <iler.ml@gmail.com>
---
 Makefile |   36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)


--- a/Makefile
+++ b/Makefile
@@ -464,6 +464,7 @@
 bindir_SQ = $(subst ','\'',$(bindir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
+prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -484,7 +485,7 @@
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
-git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) GIT-CFLAGS
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
@@ -516,7 +517,7 @@
 	chmod +x $@+
 	mv $@+ $@
 
-$(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
+$(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py GIT-CFLAGS
 	rm -f $@ $@+
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|@@GIT_PYTHON_PATH@@|$(GIT_PYTHON_DIR_SQ)|g' \
@@ -540,19 +541,19 @@
 	$(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	: GIT-VERSION-FILE
 
-%.o: %.c
+%.o: %.c GIT-CFLAGS
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.o: %.S
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
-exec_cmd.o: exec_cmd.c
+exec_cmd.o: exec_cmd.c GIT-CFLAGS
 	$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
 
-http.o: http.c
+http.o: http.c GIT-CFLAGS
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
 ifdef NO_EXPAT
-http-fetch.o: http-fetch.c http.h
+http-fetch.o: http-fetch.c http.h GIT-CFLAGS
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
 endif
 
@@ -609,6 +610,17 @@
 	rm -f tags
 	find . -name '*.[hcS]' -print | xargs ctags -a
 
+### Detect prefix changes
+TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):$(GIT_VERSION):\
+             $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
+
+GIT-CFLAGS: .FORCE-GIT-CFLAGS
+	@FLAGS='$(TRACK_CFLAGS)'; \
+	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
+		echo 1>&2 "    * new build flags or prefix"; \
+		echo "$$FLAGS" >GIT-CFLAGS; \
+            fi
+
 ### Testing rules
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -632,6 +644,12 @@
 check:
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
+test-prefix-change:
+	mkdir -p "`pwd`/tmp1" "`pwd`/tmp2"
+	$(MAKE) clean install prefix="`pwd`/tmp1"
+	$(MAKE) install prefix="`pwd`/tmp2"
+	@grep -r "`pwd`/tmp1" "`pwd`/tmp2" >/dev/null; if test $$? = 0 ; then\
+	    echo Error, test failed; exit 1; else echo Ok, test passed; fi
 
 
 ### Installation rules
@@ -705,16 +723,16 @@
 		$(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
-	rm -rf $(GIT_TARNAME) .doc-tmp-dir
+	rm -rf $(GIT_TARNAME) .doc-tmp-dir tmp1 tmp2
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(MAKE) -C templates clean
 	$(MAKE) -C t/ clean
-	rm -f GIT-VERSION-FILE
+	rm -f GIT-VERSION-FILE GIT-CFLAGS
 
 .PHONY: all install clean strip
-.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags
+.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags .FORCE-GIT-CFLAGS
 
 ### Check documentation
 #

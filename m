From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Make 'make' quieter while building git
Date: Tue, 6 Mar 2007 01:35:01 -0500
Message-ID: <20070306063501.GA24355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 07:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOTGT-0008VY-Ig
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 07:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbXCFGfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 01:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbXCFGfK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 01:35:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44764 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932677AbXCFGfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 01:35:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOTGJ-00057l-Hp; Tue, 06 Mar 2007 01:35:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A65C20FBAE; Tue,  6 Mar 2007 01:35:02 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41541>

I find it difficult to see compiler warnings amongst the massive
spewing produced by GNU make as it works through our productions.
This is especially true if CFLAGS winds up being rather long, due
to a large number of -W options being enabled and due to a number
of -D options being configured/required by my platform.

By defining QUIET_MAKE (e.g. make QUIET_MAKE=YesPlease) during
compilation users will get a less verbose output, such as:

    ...
    CC builtin-grep.c
builtin-grep.c:187: warning: 'external_grep' defined but not used
    CC builtin-init-db.c
    CC builtin-log.c
    CC builtin-ls-files.c
    CC builtin-ls-tree.c
    ...

The verbose (normal make) output is still the default.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile           |   86 +++++++++++++++++++++++++++++----------------------
 perl/Makefile      |    8 ++++-
 templates/Makefile |   10 ++++--
 3 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index a221bdc..66ab992 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,8 @@
 # The default target of this Makefile is...
 all::
 
+# Define QUIET_MAKE to have a less verbose compile.
+#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies MOZILLA_SHA1.
 #
@@ -602,6 +604,19 @@ endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
+ifdef QUIET_MAKE
+	QUIET_CC       = @echo '   ' CC $<;
+	QUIET_AR       = @echo '   ' AR $@;
+	QUIET_LINK     = @echo '   ' LINK $@;
+	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
+	QUIET_GEN      = @echo '   ' GEN $@;
+	QUIET_SUBDIR0  = @subdir=
+	QUIET_SUBDIR1  = ;echo '   ' SUBDIR $$subdir; $(MAKE) -C$$subdir
+	export QUIET_MAKE
+else
+	QUIET_SUBDIR0  = $(MAKE) -C
+	QUIET_SUBDIR1  =
+endif
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
@@ -637,35 +652,34 @@ ifneq (,$X)
 endif
 
 all::
-	$(MAKE) -C git-gui all
-	$(MAKE) -C perl PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
-	$(MAKE) -C templates
+	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
+	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) GIT-CFLAGS
-	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
+	$(QUIET_LINK)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 help.o: common-cmds.h
 
 $(BUILT_INS): git$X
-	rm -f $@ && ln git$X $@
+	$(QUIET_BUILT_IN)rm -f $@ && ln git$X $@
 
 common-cmds.h: Documentation/git-*.txt
-	./generate-cmdlist.sh > $@+
-	mv $@+ $@
+	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
-	rm -f $@ $@+
+	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    $@.sh >$@+
-	chmod +x $@+
+	    $@.sh >$@+ && \
+	chmod +x $@+ && \
 	mv $@+ $@
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
@@ -674,7 +688,7 @@ perl/perl.mak: GIT-CFLAGS
 	$(MAKE) -C perl PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
-	rm -f $@ $@+
+	$(QUIET_GEN)rm -f $@ $@+ && \
 	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
@@ -685,20 +699,18 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e '}' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+
-	chmod +x $@+
+	    $@.perl >$@+ && \
+	chmod +x $@+ && \
 	mv $@+ $@
 
 git-cherry-pick: git-revert
-	cp $< $@+
-	mv $@+ $@
+	$(QUIET_GEN)cp $< $@+ && mv $@+ $@
 
 git-status: git-commit
-	cp $< $@+
-	mv $@+ $@
+	$(QUIET_GEN)cp $< $@+ && mv $@+ $@
 
 gitweb/gitweb.cgi: gitweb/gitweb.perl
-	rm -f $@ $@+
+	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -716,12 +728,12 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	    $< >$@+
-	chmod +x $@+
+	    $< >$@+ && \
+	chmod +x $@+ && \
 	mv $@+ $@
 
 git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
-	rm -f $@ $@+
+	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
@@ -729,15 +741,15 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
-	    $@.sh > $@+
-	chmod +x $@+
+	    $@.sh > $@+ && \
+	chmod +x $@+ && \
 	mv $@+ $@
 
 configure: configure.ac
-	rm -f $@ $<+
+	$(QUIET_GEN)rm -f $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $< > $<+
-	autoconf -o $@ $<+
+	    $< > $<+ && \
+	autoconf -o $@ $<+ && \
 	rm -f $<+
 
 # These can record GIT_VERSION
@@ -747,25 +759,25 @@ git$X git.spec \
 	: GIT-VERSION-FILE
 
 %.o: %.c GIT-CFLAGS
-	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.o: %.S
-	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
-	$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
 http.o: http.c GIT-CFLAGS
-	$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
 ifdef NO_EXPAT
 http-fetch.o: http-fetch.c http.h GIT-CFLAGS
-	$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
 endif
 
 git-%$X: %.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 ssh-pull.o: ssh-fetch.c
 ssh-push.o: ssh-upload.c
@@ -779,11 +791,11 @@ git-imap-send$X: imap-send.o $(LIB_FILE)
 
 http.o http-fetch.o http-push.o: http.h
 git-http-fetch$X: fetch.o http.o http-fetch.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS) fetch.o: $(LIB_H)
@@ -791,7 +803,7 @@ $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
-	rm -f $@ && $(AR) rcs $@ $(LIB_OBJS)
+	$(QUIET_AR)rm -f $@ && $(AR) rcs $@ $(LIB_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o
@@ -799,7 +811,7 @@ $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
+	$(QUIET_AR)rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
 perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
diff --git a/perl/Makefile b/perl/Makefile
index 099beda..2fceff2 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -6,11 +6,15 @@ makfile:=perl.mak
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 prefix_SQ = $(subst ','\'',$(prefix))
 
+ifdef QUIET_MAKE
+	QUIET = @
+endif
+
 all install instlibdir: $(makfile)
-	$(MAKE) -f $(makfile) $@
+	$(QUIET)$(MAKE) -f $(makfile) $@
 
 clean:
-	test -f $(makfile) && $(MAKE) -f $(makfile) $@ || exit 0
+	$(QUIET)test -f $(makfile) && $(MAKE) -f $(makfile) $@ || exit 0
 	$(RM) ppport.h
 	$(RM) $(makfile)
 	$(RM) $(makfile).old
diff --git a/templates/Makefile b/templates/Makefile
index 0eeee43..81bd86c 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -1,5 +1,9 @@
 # make and install sample templates
 
+ifdef QUIET_MAKE
+	QUIET = @
+endif
+
 INSTALL ?= install
 TAR ?= tar
 prefix ?= $(HOME)
@@ -18,7 +22,7 @@ all: boilerplates.made custom
 
 bpsrc = $(filter-out %~,$(wildcard *--*))
 boilerplates.made : $(bpsrc)
-	ls *--* 2>/dev/null | \
+	$(QUIET)ls *--* 2>/dev/null | \
 	while read boilerplate; \
 	do \
 		case "$$boilerplate" in *~) continue ;; esac && \
@@ -29,13 +33,13 @@ boilerplates.made : $(bpsrc)
 		*--) ;; \
 		*) cp $$boilerplate blt/$$dst ;; \
 		esac || exit; \
-	done || exit
+	done && \
 	date >$@
 
 # If you need build-tailored templates, build them into blt/
 # directory yourself here.
 custom:
-	: no custom templates yet
+	$(QUIET): no custom templates yet
 
 clean:
 	rm -rf blt boilerplates.made
-- 
1.5.0.3.863.gf0989

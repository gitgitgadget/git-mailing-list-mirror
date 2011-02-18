From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/3] Move non-builtin git commands and script libraries to a
 subdirectory
Date: Thu, 17 Feb 2011 23:04:05 -0600
Message-ID: <20110218050405.GJ15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218045139.GG15643@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 06:04:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqIVu-000793-U5
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 06:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750Ab1BRFEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 00:04:14 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52783 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1BRFEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 00:04:12 -0500
Received: by gwj20 with SMTP id 20so1443586gwj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 21:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Byjh7S4PCy4oj5/2WI9zskjZikV64s+l//36FId4Hwk=;
        b=GaDaWg4/dUrg8MsBUnJhp1tZK4C6YGM6DH/0ewm0T6Ex2+e7CkjzKl4D6MAwUzaFts
         X218jQP2H+ep1iNhe0pTLom7d8xVCNjUCziMcfqdz/+7uV/U4sNZsqiWGZNACNEPLFOO
         ZFS0WrA5ekrS6ukrBGjBEZJhrz0nQvdTnBeCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IJB/ROo8pb7ZBL7s1AC0N8ilV8iePmzRqPDDBGY5dq+sGLmq0SwDfbs+DJoDPqT+Va
         E4eklcNbgHAyGF0YBIQzYDW6BQygETQvUAjnfacYvmQcDmOiJ9jgk/RPCkPGS3NXtblQ
         T43bJoy0xFCbca9zsB6JreOhK5yGyK3wHyFRs=
Received: by 10.150.158.4 with SMTP id g4mr443060ybe.214.1298005451311;
        Thu, 17 Feb 2011 21:04:11 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id q33sm1168624yba.19.2011.02.17.21.04.08
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 21:04:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218045139.GG15643@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167174>

Create a nonbuiltin/ directory for the standalone programs, scripts,
and script libraries that are installed in gitexecdir and implement
non-builtin git commands.

So now each file git-subcommand in /usr/libexec/git-core is a hard
link to git, a copy of scripts/unimplemented.sh, or builtin from a
file named nonbuiltin/subcommand.<something>, where <something> is c,
sh, or perl.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The patch would probably be cleaner if

	BUILT_SCRIPT_SH := $(patsubst %.sh,%,$(SCRIPT_SH))

et al were factored out first.

 Makefile                                           |  137 ++++++++++----------
 [ ... and a bunch of renames ... ]
 44 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/Makefile b/Makefile
index 1c10e29..6f8a11c 100644
--- a/Makefile
+++ b/Makefile
@@ -358,44 +358,44 @@ TEST_PROGRAMS_NEED_X =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-am.sh
-SCRIPT_SH += git-bisect.sh
-SCRIPT_SH += git-difftool--helper.sh
-SCRIPT_SH += git-filter-branch.sh
-SCRIPT_SH += git-lost-found.sh
-SCRIPT_SH += git-merge-octopus.sh
-SCRIPT_SH += git-merge-one-file.sh
-SCRIPT_SH += git-merge-resolve.sh
-SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-pull.sh
-SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-rebase--interactive.sh
-SCRIPT_SH += git-rebase.sh
-SCRIPT_SH += git-repack.sh
-SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-stash.sh
-SCRIPT_SH += git-submodule.sh
-SCRIPT_SH += git-web--browse.sh
+SCRIPT_SH += nonbuiltin/am.sh
+SCRIPT_SH += nonbuiltin/bisect.sh
+SCRIPT_SH += nonbuiltin/difftool--helper.sh
+SCRIPT_SH += nonbuiltin/filter-branch.sh
+SCRIPT_SH += nonbuiltin/lost-found.sh
+SCRIPT_SH += nonbuiltin/merge-octopus.sh
+SCRIPT_SH += nonbuiltin/merge-one-file.sh
+SCRIPT_SH += nonbuiltin/merge-resolve.sh
+SCRIPT_SH += nonbuiltin/mergetool.sh
+SCRIPT_SH += nonbuiltin/pull.sh
+SCRIPT_SH += nonbuiltin/quiltimport.sh
+SCRIPT_SH += nonbuiltin/rebase--interactive.sh
+SCRIPT_SH += nonbuiltin/rebase.sh
+SCRIPT_SH += nonbuiltin/repack.sh
+SCRIPT_SH += nonbuiltin/request-pull.sh
+SCRIPT_SH += nonbuiltin/stash.sh
+SCRIPT_SH += nonbuiltin/submodule.sh
+SCRIPT_SH += nonbuiltin/web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-sh-setup
 
-SCRIPT_PERL += git-add--interactive.perl
-SCRIPT_PERL += git-difftool.perl
-SCRIPT_PERL += git-archimport.perl
-SCRIPT_PERL += git-cvsexportcommit.perl
-SCRIPT_PERL += git-cvsimport.perl
-SCRIPT_PERL += git-cvsserver.perl
-SCRIPT_PERL += git-relink.perl
-SCRIPT_PERL += git-send-email.perl
-SCRIPT_PERL += git-svn.perl
+SCRIPT_PERL += nonbuiltin/add--interactive.perl
+SCRIPT_PERL += nonbuiltin/difftool.perl
+SCRIPT_PERL += nonbuiltin/archimport.perl
+SCRIPT_PERL += nonbuiltin/cvsexportcommit.perl
+SCRIPT_PERL += nonbuiltin/cvsimport.perl
+SCRIPT_PERL += nonbuiltin/cvsserver.perl
+SCRIPT_PERL += nonbuiltin/relink.perl
+SCRIPT_PERL += nonbuiltin/send-email.perl
+SCRIPT_PERL += nonbuiltin/svn.perl
 
-SCRIPT_PYTHON += git-remote-testgit.py
+SCRIPT_PYTHON += nonbuiltin/remote-testgit.py
 
-SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
-	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
-	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
+SCRIPTS = $(patsubst nonbuiltin/%.sh,git-%,$(SCRIPT_SH)) \
+	  $(patsubst nonbuiltin/%.perl,git-%,$(SCRIPT_PERL)) \
+	  $(patsubst nonbuiltin/%.py,git-%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
@@ -406,15 +406,15 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
-PROGRAM_OBJS += daemon.o
-PROGRAM_OBJS += fast-import.o
-PROGRAM_OBJS += imap-send.o
-PROGRAM_OBJS += shell.o
-PROGRAM_OBJS += show-index.o
-PROGRAM_OBJS += upload-pack.o
-PROGRAM_OBJS += http-backend.o
+PROGRAM_OBJS += nonbuiltin/daemon.o
+PROGRAM_OBJS += nonbuiltin/fast-import.o
+PROGRAM_OBJS += nonbuiltin/imap-send.o
+PROGRAM_OBJS += nonbuiltin/shell.o
+PROGRAM_OBJS += nonbuiltin/show-index.o
+PROGRAM_OBJS += nonbuiltin/upload-pack.o
+PROGRAM_OBJS += nonbuiltin/http-backend.o
 
-PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
+PROGRAMS += $(patsubst nonbuiltin/%.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
@@ -1267,12 +1267,12 @@ else
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
-	PROGRAM_OBJS += http-fetch.o
+	PROGRAM_OBJS += nonbuiltin/http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
-			PROGRAM_OBJS += http-push.o
+			PROGRAM_OBJS += nonbuiltin/http-push.o
 		endif
 	endif
 	ifndef NO_EXPAT
@@ -1710,25 +1710,25 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
-    $@.sh >$@+
+    $< >$@+
 endef
 
-$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
+$(patsubst nonbuiltin/%.sh,git-%,$(SCRIPT_SH)) : git-% : nonbuiltin/%.sh
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-$(SCRIPT_LIB) : % : %.sh
+$(SCRIPT_LIB) : git-% : nonbuiltin/%.sh
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
 ifndef NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
+$(patsubst nonbuiltin/%.perl,git-%,$(SCRIPT_PERL)): perl/perl.mak
 
 perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
+$(patsubst nonbuiltin/%.perl,git-%,$(SCRIPT_PERL)): git-% : nonbuiltin/%.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
@@ -1739,7 +1739,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e '	x' \
 	    -e '}' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+ && \
+	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
@@ -1774,18 +1774,18 @@ gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
 endif # CSSMIN
 
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
+git-instaweb: nonbuiltin/instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
-	    $@.sh > $@+ && \
+	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : scripts/unimplemented.sh
+$(patsubst nonbuiltin/%.perl,git-%,$(SCRIPT_PERL)) git-instaweb: git-% : scripts/unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
@@ -1795,8 +1795,8 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : scripts/unimplemented.sh
 endif # NO_PERL
 
 ifndef NO_PYTHON
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
+$(patsubst nonbuiltin/%.py,git-%,$(SCRIPT_PYTHON)): GIT-CFLAGS
+$(patsubst nonbuiltin/%.py,git-%,$(SCRIPT_PYTHON)): git-% : nonbuiltin/%.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
 		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
@@ -1804,11 +1804,11 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-	    $@.py >$@+ && \
+	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : scripts/unimplemented.sh
+$(patsubst nonbuiltin/%.py,git-%,$(SCRIPT_PYTHON)): git-% : scripts/unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
@@ -1826,15 +1826,15 @@ configure: configure.ac
 
 # These can record GIT_VERSION
 git.o git.spec \
-	$(patsubst %.sh,%,$(SCRIPT_SH)) \
-	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	$(patsubst nonbuiltin/%.sh,git-%,$(SCRIPT_SH)) \
+	$(patsubst nonbuiltin/%.perl,git-%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
 TEST_OBJS := $(patsubst test-%$X,test-programs/test-%.o,$(TEST_PROGRAMS))
 GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	git.o
 ifndef NO_CURL
-	GIT_OBJS += http.o http-walker.o remote-curl.o
+	GIT_OBJS += http.o http-walker.o nonbuiltin/remote-curl.o
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
@@ -1960,9 +1960,11 @@ builtin/log.o builtin/shortlog.o: include/shortlog.h
 builtin/prune.o builtin/reflog.o libgit/reachable.o: include/reachable.h
 builtin/commit.o builtin/revert.o libgit/wt-status.o: include/wt-status.h
 builtin/tar-tree.o libgit/archive-tar.o: include/tar.h
-libgit/connect.o libgit/transport.o http-backend.o: include/url.h
-http-fetch.o http-walker.o remote-curl.o libgit/transport.o libgit/walker.o: include/walker.h
-http.o http-walker.o http-push.o http-fetch.o remote-curl.o: include/http.h include/url.h
+libgit/connect.o libgit/transport.o nonbuiltin/http-backend.o: include/url.h
+nonbuiltin/http-fetch.o nonbuiltin/remote-curl.o http-walker.o: include/walker.h
+libgit/transport.o libgit/walker.o: include/walker.h
+nonbuiltin/http-push.o nonbuiltin/http-fetch.o: include/http.h include/url.h
+nonbuiltin/remote-curl.o http.o http-walker.o: include/http.h include/url.h
 
 libgit/xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
@@ -2005,17 +2007,17 @@ compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
 endif
 
-git-%$X: %.o $(GITLIBS)
+git-%$X: nonbuiltin/%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(GITLIBS)
+git-imap-send$X: nonbuiltin/imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-git-http-fetch$X: libgit/revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
+git-http-fetch$X: libgit/revision.o http.o http-walker.o nonbuiltin/http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
-git-http-push$X: libgit/revision.o http.o http-push.o $(GITLIBS)
+git-http-push$X: libgit/revision.o http.o nonbuiltin/http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2025,7 +2027,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): nonbuiltin/remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2321,8 +2323,9 @@ distclean: clean
 	$(RM) configure
 
 clean:
-	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
-		libgit/*.o builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o
+	$(RM) libgit/*.o builtin/*.o nonbuiltin/*.o
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) test-programs/*.o $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
diff --git a/git-add--interactive.perl b/nonbuiltin/add--interactive.perl
similarity index 100%
rename from git-add--interactive.perl
rename to nonbuiltin/add--interactive.perl
diff --git a/git-am.sh b/nonbuiltin/am.sh
similarity index 100%
rename from git-am.sh
rename to nonbuiltin/am.sh
diff --git a/git-archimport.perl b/nonbuiltin/archimport.perl
similarity index 100%
rename from git-archimport.perl
rename to nonbuiltin/archimport.perl
diff --git a/git-bisect.sh b/nonbuiltin/bisect.sh
similarity index 100%
rename from git-bisect.sh
rename to nonbuiltin/bisect.sh
diff --git a/check-racy.c b/nonbuiltin/check-racy.c
similarity index 100%
rename from check-racy.c
rename to nonbuiltin/check-racy.c
diff --git a/git-cvsexportcommit.perl b/nonbuiltin/cvsexportcommit.perl
similarity index 100%
rename from git-cvsexportcommit.perl
rename to nonbuiltin/cvsexportcommit.perl
diff --git a/git-cvsimport.perl b/nonbuiltin/cvsimport.perl
similarity index 100%
rename from git-cvsimport.perl
rename to nonbuiltin/cvsimport.perl
diff --git a/git-cvsserver.perl b/nonbuiltin/cvsserver.perl
similarity index 100%
rename from git-cvsserver.perl
rename to nonbuiltin/cvsserver.perl
diff --git a/daemon.c b/nonbuiltin/daemon.c
similarity index 100%
rename from daemon.c
rename to nonbuiltin/daemon.c
diff --git a/git-difftool--helper.sh b/nonbuiltin/difftool--helper.sh
similarity index 100%
rename from git-difftool--helper.sh
rename to nonbuiltin/difftool--helper.sh
diff --git a/git-difftool.perl b/nonbuiltin/difftool.perl
similarity index 100%
rename from git-difftool.perl
rename to nonbuiltin/difftool.perl
diff --git a/fast-import.c b/nonbuiltin/fast-import.c
similarity index 100%
rename from fast-import.c
rename to nonbuiltin/fast-import.c
diff --git a/git-filter-branch.sh b/nonbuiltin/filter-branch.sh
similarity index 100%
rename from git-filter-branch.sh
rename to nonbuiltin/filter-branch.sh
diff --git a/http-backend.c b/nonbuiltin/http-backend.c
similarity index 100%
rename from http-backend.c
rename to nonbuiltin/http-backend.c
diff --git a/http-fetch.c b/nonbuiltin/http-fetch.c
similarity index 100%
rename from http-fetch.c
rename to nonbuiltin/http-fetch.c
diff --git a/http-push.c b/nonbuiltin/http-push.c
similarity index 100%
rename from http-push.c
rename to nonbuiltin/http-push.c
diff --git a/imap-send.c b/nonbuiltin/imap-send.c
similarity index 100%
rename from imap-send.c
rename to nonbuiltin/imap-send.c
diff --git a/git-instaweb.sh b/nonbuiltin/instaweb.sh
similarity index 100%
rename from git-instaweb.sh
rename to nonbuiltin/instaweb.sh
diff --git a/git-lost-found.sh b/nonbuiltin/lost-found.sh
similarity index 100%
rename from git-lost-found.sh
rename to nonbuiltin/lost-found.sh
diff --git a/git-merge-octopus.sh b/nonbuiltin/merge-octopus.sh
similarity index 100%
rename from git-merge-octopus.sh
rename to nonbuiltin/merge-octopus.sh
diff --git a/git-merge-one-file.sh b/nonbuiltin/merge-one-file.sh
similarity index 100%
rename from git-merge-one-file.sh
rename to nonbuiltin/merge-one-file.sh
diff --git a/git-merge-resolve.sh b/nonbuiltin/merge-resolve.sh
similarity index 100%
rename from git-merge-resolve.sh
rename to nonbuiltin/merge-resolve.sh
diff --git a/git-mergetool--lib.sh b/nonbuiltin/mergetool--lib.sh
similarity index 100%
rename from git-mergetool--lib.sh
rename to nonbuiltin/mergetool--lib.sh
diff --git a/git-mergetool.sh b/nonbuiltin/mergetool.sh
similarity index 100%
rename from git-mergetool.sh
rename to nonbuiltin/mergetool.sh
diff --git a/git-parse-remote.sh b/nonbuiltin/parse-remote.sh
similarity index 100%
rename from git-parse-remote.sh
rename to nonbuiltin/parse-remote.sh
diff --git a/git-pull.sh b/nonbuiltin/pull.sh
similarity index 100%
rename from git-pull.sh
rename to nonbuiltin/pull.sh
diff --git a/git-quiltimport.sh b/nonbuiltin/quiltimport.sh
similarity index 100%
rename from git-quiltimport.sh
rename to nonbuiltin/quiltimport.sh
diff --git a/git-rebase--interactive.sh b/nonbuiltin/rebase--interactive.sh
similarity index 100%
rename from git-rebase--interactive.sh
rename to nonbuiltin/rebase--interactive.sh
diff --git a/git-rebase.sh b/nonbuiltin/rebase.sh
similarity index 100%
rename from git-rebase.sh
rename to nonbuiltin/rebase.sh
diff --git a/git-relink.perl b/nonbuiltin/relink.perl
similarity index 100%
rename from git-relink.perl
rename to nonbuiltin/relink.perl
diff --git a/remote-curl.c b/nonbuiltin/remote-curl.c
similarity index 100%
rename from remote-curl.c
rename to nonbuiltin/remote-curl.c
diff --git a/git-remote-testgit.py b/nonbuiltin/remote-testgit.py
similarity index 100%
rename from git-remote-testgit.py
rename to nonbuiltin/remote-testgit.py
diff --git a/git-repack.sh b/nonbuiltin/repack.sh
similarity index 100%
rename from git-repack.sh
rename to nonbuiltin/repack.sh
diff --git a/git-request-pull.sh b/nonbuiltin/request-pull.sh
similarity index 100%
rename from git-request-pull.sh
rename to nonbuiltin/request-pull.sh
diff --git a/git-send-email.perl b/nonbuiltin/send-email.perl
similarity index 100%
rename from git-send-email.perl
rename to nonbuiltin/send-email.perl
diff --git a/git-sh-setup.sh b/nonbuiltin/sh-setup.sh
similarity index 100%
rename from git-sh-setup.sh
rename to nonbuiltin/sh-setup.sh
diff --git a/shell.c b/nonbuiltin/shell.c
similarity index 100%
rename from shell.c
rename to nonbuiltin/shell.c
diff --git a/show-index.c b/nonbuiltin/show-index.c
similarity index 100%
rename from show-index.c
rename to nonbuiltin/show-index.c
diff --git a/git-stash.sh b/nonbuiltin/stash.sh
similarity index 100%
rename from git-stash.sh
rename to nonbuiltin/stash.sh
diff --git a/git-submodule.sh b/nonbuiltin/submodule.sh
similarity index 100%
rename from git-submodule.sh
rename to nonbuiltin/submodule.sh
diff --git a/git-svn.perl b/nonbuiltin/svn.perl
similarity index 100%
rename from git-svn.perl
rename to nonbuiltin/svn.perl
diff --git a/upload-pack.c b/nonbuiltin/upload-pack.c
similarity index 100%
rename from upload-pack.c
rename to nonbuiltin/upload-pack.c
diff --git a/git-web--browse.sh b/nonbuiltin/web--browse.sh
similarity index 100%
rename from git-web--browse.sh
rename to nonbuiltin/web--browse.sh
-- 
1.7.4.1

From: Jeff King <peff@peff.net>
Subject: Re: Topics currently in the Stalled category
Date: Tue, 27 Nov 2012 22:11:18 -0500
Message-ID: <20121128031118.GB27772@sigill.intra.peff.net>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
 <7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
 <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
 <CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
 <20121128025928.GA27772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdY3j-0002ir-Lm
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab2K1DLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:11:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58922 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab2K1DLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:11:20 -0500
Received: (qmail 1611 invoked by uid 107); 28 Nov 2012 03:12:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 22:12:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 22:11:18 -0500
Content-Disposition: inline
In-Reply-To: <20121128025928.GA27772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210682>

On Tue, Nov 27, 2012 at 09:59:28PM -0500, Jeff King wrote:

> > >  Renaming of remote-testgit feels to be a mistake.  It probably
> > >  should keep its source in remote-testgit.bash and generate it,
> > 
> > Why generate it? There's nothing to generate. python's source code
> > needs regeneration, bash's code doesn't.
> 
> We fix up the #!-lines on all of the existing shell scripts (as well as
> python and perl). Wouldn't we want to do the same for people who have
> bash in an alternate location?
> 
> As the series is now, people with bash in their PATH, but not in
> /bin/bash, will fail t5801 (the prereq to skip the test uses "type", but
> git-remote-testgit hardcodes /bin/bash).

We could improve the test in t5801, but it is nice to let people on such
systems test it, as well. And the infrastructure might be useful if we
ever acquire more bash scripts.

There's a fair bit of boilerplate, but I think this squashable patch
would do it:

diff --git a/.gitignore b/.gitignore
index 46595db..3b636bd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -124,6 +124,7 @@
 /git-remote-ftps
 /git-remote-fd
 /git-remote-ext
+/git-remote-testgit
 /git-remote-testsvn
 /git-remote-testpy
 /git-repack
diff --git a/Makefile b/Makefile
index 68f1ac2..19f6fd2 100644
--- a/Makefile
+++ b/Makefile
@@ -424,6 +424,7 @@ PROGRAM_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
+SCRIPT_BASH =
 SCRIPT_SH =
 SCRIPT_LIB =
 TEST_PROGRAMS_NEED_X =
@@ -473,9 +474,12 @@ SCRIPT_PERL += git-svn.perl
 SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
+SCRIPT_BASH += git-remote-testgit.bash
+
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
+	  $(patsubst %.bash,%,$(SCRIPT_BASH)) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
@@ -571,9 +575,13 @@ endif
 ifndef PYTHON_PATH
 	PYTHON_PATH = /usr/bin/python
 endif
+ifndef BASH_PATH
+	BASH_PATH = /bin/bash
+endif
 
 export PERL_PATH
 export PYTHON_PATH
+export BASH_PATH
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
@@ -1931,6 +1939,10 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON=NoThanks
 endif
 
+ifeq ($(BASH_PATH),)
+NO_BASH=NoThanks
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -2006,6 +2018,7 @@ gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
+BASH_PATH_SQ = $(subst ','\'',$(BASH_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 
@@ -2267,6 +2280,15 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PYTHON
 
+ifndef NO_BASH
+$(patsubst %.bash,%,$(SCRIPT_BASH)):
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1s|#!.*/bash|#!$(BASH_PATH_SQ)|' \
+	    $@.bash >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+endif
+
 configure: configure.ac GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -2599,6 +2621,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
+	@echo NO_BASH=\''$(subst ','\'',$(subst ','\'',$(NO_BASH)))'\' >>$@
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
 ifdef GIT_TEST_OPTS
 	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@
diff --git a/git-remote-testgit b/git-remote-testgit.bash
similarity index 100%
rename from git-remote-testgit
rename to git-remote-testgit.bash
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 456303b..d6ebc5e 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -7,7 +7,7 @@ test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
 
-if ! type "${BASH-bash}" >/dev/null 2>&1; then
+if ! test_have_prereq BASH; then
 	skip_all='skipping remote-testgit tests, bash not available'
 	test_done
 fi
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 489bc80..5300fa9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -675,6 +675,7 @@ esac
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
+test -z "$NO_BASH" && test_set_prereq BASH
 test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 

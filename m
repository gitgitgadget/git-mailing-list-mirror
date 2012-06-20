From: Jeff King <peff@peff.net>
Subject: [PATCHv3 11/11] Makefile: move GIT-VERSION-FILE dependencies closer
 to use
Date: Wed, 20 Jun 2012 14:32:22 -0400
Message-ID: <20120620183222.GK30995@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPhk-00082g-16
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506Ab2FTSc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:32:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39042
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932390Ab2FTSc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:32:26 -0400
Received: (qmail 27021 invoked by uid 107); 20 Jun 2012 18:32:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:32:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:32:22 -0400
Content-Disposition: inline
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200324>

There is a list of all of the targets which depend on
GIT-VERSION-FILE, but it can be quite far from the actual
point where the targets actually use $(GIT_VERSION). This
can make it hard to verify that each use of $(GIT_VERSION)
has a matching dependency.

This patch moves the dependency closer to the actual build
instructions, which makes verification easier.  This also
fixes the generation of "configure", which did not properly
mark the dependency.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 592e6cb..6b8bfa4 100644
--- a/Makefile
+++ b/Makefile
@@ -1995,7 +1995,7 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
-version.sp version.s version.o: GIT-USER-AGENT
+version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
 	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
@@ -2051,7 +2051,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
+$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
@@ -2108,18 +2108,13 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PYTHON
 
-configure: configure.ac
+configure: configure.ac GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $< > $<+ && \
 	autoconf -o $@ $<+ && \
 	$(RM) $<+
 
-# These can record GIT_VERSION
-version.o git.spec \
-	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
-	: GIT-VERSION-FILE
-
 TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	git.o
@@ -2663,7 +2658,7 @@ quick-install-html:
 
 ### Maintainer's dist rules
 
-git.spec: git.spec.in
+git.spec: git.spec.in GIT-VERSION-FILE
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
 	mv $@+ $@
 
-- 
1.7.11.5.gc0eeaa8

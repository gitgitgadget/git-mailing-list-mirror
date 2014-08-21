From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] Makefile: drop CHECK_HEADER_DEPENDENCIES code
Date: Thu, 21 Aug 2014 04:31:03 -0400
Message-ID: <20140821083103.GB25763@peff.net>
References: <20140821082440.GA16402@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:31:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKNm4-0000Aw-48
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 10:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbaHUIbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 04:31:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:56089 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753813AbaHUIbE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 04:31:04 -0400
Received: (qmail 5890 invoked by uid 102); 21 Aug 2014 08:31:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 03:31:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 04:31:03 -0400
Content-Disposition: inline
In-Reply-To: <20140821082440.GA16402@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255603>

This code was useful when we kept a static list of header
files, and it was easy to forget to update it. Since the last
commit, we generate the list dynamically.

Technically this could still be used to find a dependency
that our dynamic check misses (e.g., a header file without a
".h" extension).  But that is reasonably unlikely to be
added, and even less likely to be noticed by this tool
(because it has to be run manually)., It is not worth
carrying around the cruft in the Makefile.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm open to leaving this, as it's not hurting anything aside from
clutter, and it could possibly be used to cross-check the dynamic rule.
I just couldn't resist that all-deletion diffstat.

 Makefile | 59 -----------------------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/Makefile b/Makefile
index 08dd973..65ff772 100644
--- a/Makefile
+++ b/Makefile
@@ -317,9 +317,6 @@ all::
 # dependency rules.  The default is "auto", which means to use computed header
 # dependencies if your compiler is detected to support it.
 #
-# Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-coded
-# dependency rules.
-#
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
 #
 # Define XDL_FAST_HASH to use an alternative line-hashing method in
@@ -904,11 +901,6 @@ sysconfdir = etc
 endif
 endif
 
-ifdef CHECK_HEADER_DEPENDENCIES
-COMPUTE_HEADER_DEPENDENCIES = no
-USE_COMPUTED_HEADER_DEPENDENCIES =
-endif
-
 ifndef COMPUTE_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES = auto
 endif
@@ -1809,29 +1801,13 @@ $(dep_dirs):
 missing_dep_dirs := $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
 dep_file = $(dir $@).depend/$(notdir $@).d
 dep_args = -MF $(dep_file) -MQ $@ -MMD -MP
-ifdef CHECK_HEADER_DEPENDENCIES
-$(error cannot compute header dependencies outside a normal build. \
-Please unset CHECK_HEADER_DEPENDENCIES and try again)
-endif
 endif
 
 ifneq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
-ifndef CHECK_HEADER_DEPENDENCIES
 dep_dirs =
 missing_dep_dirs =
 dep_args =
 endif
-endif
-
-ifdef CHECK_HEADER_DEPENDENCIES
-ifndef PRINT_HEADER_DEPENDENCIES
-missing_deps = $(filter-out $(notdir $^), \
-	$(notdir $(shell $(MAKE) -s $@ \
-		CHECK_HEADER_DEPENDENCIES=YesPlease \
-		USE_COMPUTED_HEADER_DEPENDENCIES=YesPlease \
-		PRINT_HEADER_DEPENDENCIES=YesPlease)))
-endif
-endif
 
 ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
@@ -1839,45 +1815,10 @@ C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
 .SUFFIXES:
 
-ifdef PRINT_HEADER_DEPENDENCIES
-$(C_OBJ): %.o: %.c FORCE
-	echo $^
-$(ASM_OBJ): %.o: %.S FORCE
-	echo $^
-
-ifndef CHECK_HEADER_DEPENDENCIES
-$(error cannot print header dependencies during a normal build. \
-Please set CHECK_HEADER_DEPENDENCIES and try again)
-endif
-endif
-
-ifndef PRINT_HEADER_DEPENDENCIES
-ifdef CHECK_HEADER_DEPENDENCIES
-$(C_OBJ): %.o: %.c $(dep_files) FORCE
-	@set -e; echo CHECK $@; \
-	missing_deps="$(missing_deps)"; \
-	if test "$$missing_deps"; \
-	then \
-		echo missing dependencies: $$missing_deps; \
-		false; \
-	fi
-$(ASM_OBJ): %.o: %.S $(dep_files) FORCE
-	@set -e; echo CHECK $@; \
-	missing_deps="$(missing_deps)"; \
-	if test "$$missing_deps"; \
-	then \
-		echo missing dependencies: $$missing_deps; \
-		false; \
-	fi
-endif
-endif
-
-ifndef CHECK_HEADER_DEPENDENCIES
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
-endif
 
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
-- 
2.1.0.346.ga0367b9

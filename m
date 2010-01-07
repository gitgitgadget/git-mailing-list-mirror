From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 5/5] Teach Makefile to check header dependencies
Date: Thu, 7 Jan 2010 01:30:11 -0600
Message-ID: <20100107073010.GF11777@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20100101090550.6117@nanako3.lavabit.com>
 <20100107071305.GA11777@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 08:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSmp2-0004mS-VY
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 08:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab0AGHaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 02:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822Ab0AGHaK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 02:30:10 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:61645 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab0AGHaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 02:30:09 -0500
Received: by ywh6 with SMTP id 6so18238526ywh.4
        for <multiple recipients>; Wed, 06 Jan 2010 23:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zfBiDa5iVN9jMfb7Tqti5a7ZkI+NqAHQSC4WqfJoTjA=;
        b=ZIWsuGI07qUr0cOtBbrlSOWQ8nJni4kqRbcIPtPYKoG9DeKYPVPhU+R0DJIhdBDqhA
         SvSOEx2h2acHa6mLVcTYfK72xNPbe1KrxNcJ+slED9hI3tXEtiv9PUpDaZ6S7OEcHM0c
         6lMytkhqXm4B6sCKE7tn9NP9BPRTYnM35mHzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CTFN5/YYOf9f6cplsGXwYdE3KT5kMMl32vZdxeSFbskw7YOlKEDOWvBcO8KLwj9B/7
         UxBnPqyIs1uFmHZxLNQxCj/gQn8JUY2Ro8zfgKGLMfsGs+ZKt+/OkNKJMB9MnSJB/2Kl
         Tk60oorBj9ORO/dnQU0Z66Z+SyjvGlhcm9tQQ=
Received: by 10.101.28.29 with SMTP id f29mr31471389anj.195.1262849408726;
        Wed, 06 Jan 2010 23:30:08 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm20262476iwn.5.2010.01.06.23.30.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 23:30:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100107071305.GA11777@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136332>

Portability means we cannot completely switch over to
automatically generated dependencies on header files, since some
compilers do not support them.  This would seem to lead to a
dangerous situation in which the hand-written dependency rules
are needed for some configurations but poorly maintained because
most configurations do not use them.

Luckily, there is a way out: as part of testing git, ask the
build system to verify that the hand-written dependency rules are
consistent with the automatically generated ones.  This patch is
a start towards that goal.

The actual patch requires a few steps:

 1. Separate out a USE_COMPUTED_HEADER_DEPENDENCIES option to
    tell make to use the makefile snippets stored in deps/*
    without necessarily regenerating them;

 2. Add a PRINT_HEADER_DEPENDENCIES option to turn on
    USE_COMPUTED_HEADER_DEPENDENCIES and make the %.o: %.c rule
    print its prerequisites instead of compiling anything;

 3. Add a CHECK_HEADER_DEPENDENCIES option to turn off
    USE_COMPUTED_HEADER_DEPENDENCIES and make the %.o: %.c rule
    check that its prerequisites includes all files listed by
    'make -s PRINT_HEADER_DEPENDENCIES=YesPlease $@' instead of
    compiling anything.

With this patch applied,

	echo COMPUTE_HEADER_DEPENDENCIES=YesPlease >> config.mak
	make clean
	make
	make CHECK_HEADER_DEPENDENCIES=YesPlease

produces a useful error message:

	CHECK fast-import.o
	missing dependencies: exec_cmd.h
	make: *** [fast-import.o] Error 1

Probably we should check for missing deps/%.o.d files to avoid
false negatives if some are missing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I look forward to your thoughts.

This is a bit clunky, but it is useful enough to detect a few problems
with the current dependency rules.  Patches should follow soon.

 Makefile |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 578843c..e642a24 100644
--- a/Makefile
+++ b/Makefile
@@ -224,6 +224,8 @@ all::
 #
 # Define COMPUTE_HEADER_DEPENDENCIES if you want to avoid rebuilding objects
 # when an unrelated header file changes and your compiler supports it.
+#
+# Define CHECK_HEADER_DEPENDENCIES after a successful build to find problems.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1064,6 +1066,28 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifdef PRINT_HEADER_DEPENDENCIES
+CHECK_HEADER_DEPENDENCIES = YesPlease
+endif
+
+ifdef CHECK_HEADER_DEPENDENCIES
+ifndef COMPUTE_HEADER_DEPENDENCIES
+$(error checking dependencies requires build with COMPUTE_HEADER_DEPENDENCIES)
+endif
+endif
+
+ifdef COMPUTE_HEADER_DEPENDENCIES
+ifdef CHECK_HEADER_DEPENDENCIES
+ifdef PRINT_HEADER_DEPENDENCIES
+USE_COMPUTED_HEADER_DEPENDENCIES = YesPlease
+else
+USE_COMPUTED_HEADER_DEPENDENCIES =
+endif
+else
+USE_COMPUTED_HEADER_DEPENDENCIES = YesPlease
+endif
+endif
+
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
@@ -1669,14 +1693,48 @@ endif
 
 .SUFFIXES:
 
+ifdef CHECK_HEADER_DEPENDENCIES
+
+ifdef PRINT_HEADER_DEPENDENCIES
+$(C_OBJ): %.o: %.c FORCE
+	echo $^
+$(ASM_OBJ): %.o: %.S FORCE
+	echo $^
+else
+missing_deps = $(filter-out $^, \
+	$(shell $(MAKE) -s PRINT_HEADER_DEPENDENCIES=1 $@))
+
+$(C_OBJ): %.o: %.c FORCE
+	@set -e; echo CHECK $@; \
+	missing_deps="$(missing_deps)"; \
+	if test "$$missing_deps"; \
+	then \
+		echo missing dependencies: $$missing_deps; \
+		false; \
+	fi
+$(ASM_OBJ): %.o: %.S FORCE
+	@set -e; echo CHECK $@; \
+	missing_deps="$(missing_deps)"; \
+	if test "$$missing_deps"; \
+	then \
+		echo missing dependencies: $$missing_deps; \
+		false; \
+	fi
+endif
+
+else
+
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(dep_dir_dep)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
-%.s: %.c GIT-CFLAGS FORCE
-	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(dep_dir_dep)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
 
-ifdef COMPUTE_HEADER_DEPENDENCIES
+endif
+
+%.s: %.c GIT-CFLAGS FORCE
+	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
+
+ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's dependency generation
 # See <http://gcc.gnu.org/gcc-3.0/features.html>.
 dep_files := $(wildcard $(foreach f,$(OBJECTS),$(dir f)deps/$(notdir $f).d))
@@ -1684,9 +1742,6 @@ dep_files := $(wildcard $(foreach f,$(OBJECTS),$(dir f)deps/$(notdir $f).d))
 ifneq ($(dep_files),)
 include $(dep_files)
 endif
-
-dep_file = $(dir $@)deps/$(notdir $@).d
-dep_args = -MF $(dep_file) -MMD -MP
 else
 $(GIT_OBJS): $(LIB_H)
 http.o http-walker.o http-push.o: http.h
@@ -1695,7 +1750,12 @@ builtin-revert.o wt-status.o: wt-status.h
 
 $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
+endif
 
+ifdef COMPUTE_HEADER_DEPENDENCIES
+dep_file = $(dir $@)deps/$(notdir $@).d
+dep_args = -MF $(dep_file) -MMD -MP
+else
 dep_args =
 endif
 
@@ -1823,7 +1883,7 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-parse-options$X: parse-options.o
 
-ifndef COMPUTE_HEADER_DEPENDENCIES
+ifndef USE_COMPUTED_HEADER_DEPENDENCIES
 test-parse-options.o: parse-options.h
 endif
 
-- 
1.6.6.rc2

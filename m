From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] Makefile: lazily compute header dependencies
Date: Thu, 7 Jan 2010 01:23:03 -0600
Message-ID: <20100107072303.GE11777@progeny.tock>
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
X-From: git-owner@vger.kernel.org Thu Jan 07 08:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSmiI-0000wk-M0
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 08:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab0AGHXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 02:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756185Ab0AGHXH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 02:23:07 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:51107 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab0AGHXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 02:23:02 -0500
Received: by yxe26 with SMTP id 26so17454789yxe.4
        for <multiple recipients>; Wed, 06 Jan 2010 23:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aajRYymg03V0X1Lg6ryxFrFaRrIGjRJkGiFNplJU8rk=;
        b=scGt4TJgOL9jrfzdRBref8a3BLdbzhNe1aK+JMD8o2NuR8SjyD9xZ+/qCWN1J31QM4
         M7PxmbD/GRGMv9qfFRe9sqfkhlRd2y0mrFtRS09i5WfZNR2lAgbLrVnVKiwGEiS+hJSB
         MxRlCaOqmPukWxmgClZFmwQEj7K0u3c+bfwDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OvXzQLP3NZdI5EUnyPN4ulhpU53ASMVfgaVc0t8m80izuWE2nEqgg2II3CR8sPABzd
         v3h/S23dNv5/kG7cu84vnawWRTdtNM/q8aVUOltclnW0GS3EyJb7XGMAOHhd0pKMZ9zv
         bGxVpXP2JCQTfaIdCptjqap8mAwJBQqkCHN+s=
Received: by 10.150.120.10 with SMTP id s10mr13761599ybc.12.1262848981912;
        Wed, 06 Jan 2010 23:23:01 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm20157852iwn.14.2010.01.06.23.23.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 23:23:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100107071305.GA11777@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136331>

Use the gcc -MMD -MP -MF options to generate dependency rules as
a byproduct when building .o files.

This feature has to be optional (MSVC does not seem to support
anything like this), so unfortunately it does not make the
Makefile much easier to maintain.  The feature is enabled by the
COMPUTE_HEADER_DEPENDENCIES variable, which is unset by default.

The generated Makefile fragments are saved in deps/
subdirectories of each directory containing object files.  These
directories are generated if missing at the start of each build.
A dependency on $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
avoids needlessly regenerating files when the directories'
timestamps change.

gcc learned the -MMD -MP -MF options in version 3.0, so most gcc
users should have them by now.

The dependencies this option computes are more specific than the
rough estimate hard-coded in the Makefile, greatly speeding up
rebuilds when only a little-used header file has changed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Timings:

for arg in YesPlease ""
do
	{
		echo NO_CURL=1
		echo NO_TCLTK=1
		echo NO_PERL=1
		echo COMPUTE_HEADER_DEPENDENCIES="$arg"
	} >config.mak
	make
	make clean

	time -p make
	touch levenshtein.h
	time -p make

	make clean
done >/dev/null

Build	COMPUTE_HEADER_DEPENDENCIES	real	user	sys
first	YesPlease			55.06	45.13	5.23
second	YesPlease			3.13	2.04	0.79
first					55.45	45.49	4.99
second					53.14	43.19	4.70

 .gitignore |    1 +
 Makefile   |   40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index ac02a58..803247f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -170,6 +170,7 @@
 *.exe
 *.[aos]
 *.py[co]
+*.o.d
 *+
 /config.mak
 /autom4te.cache
diff --git a/Makefile b/Makefile
index 87de3c3..578843c 100644
--- a/Makefile
+++ b/Makefile
@@ -221,6 +221,9 @@ all::
 #   DEFAULT_EDITOR='~/bin/vi',
 #   DEFAULT_EDITOR='$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork'
+#
+# Define COMPUTE_HEADER_DEPENDENCIES if you want to avoid rebuilding objects
+# when an unrelated header file changes and your compiler supports it.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1653,15 +1656,38 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
+ifdef COMPUTE_HEADER_DEPENDENCIES
+dep_dirs := $(addsuffix deps,$(sort $(dir $(OBJECTS))))
+dep_dir_dep := $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
+
+$(dep_dirs):
+	mkdir -p $@
+else
+dep_dirs =
+dep_dir_dep =
+endif
+
 .SUFFIXES:
 
-$(C_OBJ): %.o: %.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+$(C_OBJ): %.o: %.c GIT-CFLAGS $(dep_dir_dep)
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
-$(ASM_OBJ): %.o: %.S GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(dep_dir_dep)
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
+
+ifdef COMPUTE_HEADER_DEPENDENCIES
+# Take advantage of gcc's dependency generation
+# See <http://gcc.gnu.org/gcc-3.0/features.html>.
+dep_files := $(wildcard $(foreach f,$(OBJECTS),$(dir f)deps/$(notdir $f).d))
 
+ifneq ($(dep_files),)
+include $(dep_files)
+endif
+
+dep_file = $(dir $@)deps/$(notdir $@).d
+dep_args = -MF $(dep_file) -MMD -MP
+else
 $(GIT_OBJS): $(LIB_H)
 http.o http-walker.o http-push.o: http.h
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(wildcard */*.h)
@@ -1670,6 +1696,9 @@ builtin-revert.o wt-status.o: wt-status.h
 $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
+dep_args =
+endif
+
 exec_cmd.s exec_cmd.o: ALL_CFLAGS += \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
@@ -1794,7 +1823,9 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-parse-options$X: parse-options.o
 
+ifndef COMPUTE_HEADER_DEPENDENCIES
 test-parse-options.o: parse-options.h
+endif
 
 .PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 
@@ -1954,6 +1985,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
+	$(RM) -r $(dep_dirs)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
-- 
1.6.6.rc2

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/12] Makefile: lazily compute header dependencies
Date: Tue, 26 Jan 2010 09:52:49 -0600
Message-ID: <20100126155249.GK4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:52:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnio-00045f-5X
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab0AZPwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194Ab0AZPwu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:52:50 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50770 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab0AZPws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:52:48 -0500
Received: by yxe17 with SMTP id 17so3739662yxe.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EKnKywS8mtSQu7uM+IWAV6Y6KJtPRV+SSLExzeOhpe4=;
        b=SgCqieBQ0JyHW8Wxn9je6bsdL8R+KkFHklDZUkfXLTT3EAY+ozLw7ktdHRWX9fLLe2
         1GSDgVKYGvZ09WIpTcOflGCxHmxQ8EJFi6AMisdw/hitEwvyatP+ragvrryBVuANbUF5
         7uF74z6FPAb9Xna2xVSCokI1VmyfTvhO1tbqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ikei3oNAjX+OP3/KlBVGssmzJJSsm9Q4aWCgQyIzaUy4qjvTXo7uRGv3t6SlTLTGXs
         19XwVN4nZLSlaoD89vV1aKARKqxrw9c1wvvmBOnk08Oisw8x1mz+T13MSsuGB8bATUSH
         fMsC8BxSr2Zlam6rb4FTafT6yAJyLvwfLHhKg=
Received: by 10.101.135.38 with SMTP id m38mr9938143ann.239.1264521167620;
        Tue, 26 Jan 2010 07:52:47 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6022243iwn.6.2010.01.26.07.52.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:52:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138050>

Use the gcc -MMD -MP -MF options to generate dependency rules as
a byproduct when building .o files if the
COMPUTE_HEADER_DEPENDENCIES variable is defined.  That variable
is left undefined by default for now.

As each object file is built, write a makefile fragment
containing its dependencies in the deps/ subdirectory of its
containing directory.  The deps/ directories should be generated
if they are missing at the start of each build.  So let each
object file depend on $(missing_dep_dirs), which lists only the
directories of this kind that are missing to avoid needlessly
regenerating files when the directories' timestamps change.

gcc learned the -MMD -MP -MF options in version 3.0, so most gcc
users should have them by now.

The dependencies this option computes are more specific than the
rough estimates hard-coded in the Makefile, greatly speeding up
rebuilds when only a little-used header file has changed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 .gitignore |    1 +
 Makefile   |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8df8f88..7b3acb7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,6 +177,7 @@
 *.exe
 *.[aos]
 *.py[co]
+*.o.d
 *+
 /config.mak
 /autom4te.cache
diff --git a/Makefile b/Makefile
index 0e4e8ff..2e75f05 100644
--- a/Makefile
+++ b/Makefile
@@ -217,6 +217,10 @@ all::
 #   DEFAULT_EDITOR='~/bin/vi',
 #   DEFAULT_EDITOR='$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork'
+#
+# Define COMPUTE_HEADER_DEPENDENCIES if your compiler supports the -MMD option
+# and you want to avoid rebuilding objects when an unrelated header file
+# changes.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1677,14 +1681,48 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
+ifdef COMPUTE_HEADER_DEPENDENCIES
+dep_dirs := $(addsuffix deps,$(sort $(dir $(OBJECTS))))
+$(dep_dirs):
+	mkdir -p $@
+
+missing_dep_dirs := $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
+else
+dep_dirs =
+missing_dep_dirs =
+endif
+
 .SUFFIXES:
 
-$(C_OBJ): %.o: %.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
-$(ASM_OBJ): %.o: %.S GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
+
+ifdef COMPUTE_HEADER_DEPENDENCIES
+# Take advantage of gcc's on-the-fly dependency generation
+# See <http://gcc.gnu.org/gcc-3.0/features.html>.
+dep_files := $(wildcard $(foreach f,$(OBJECTS),$(dir f)deps/$(notdir $f).d))
+ifneq ($(dep_files),)
+include $(dep_files)
+endif
+
+dep_file = $(dir $@)deps/$(notdir $@).d
+dep_args = -MF $(dep_file) -MMD -MP
+else
+dep_args =
+
+# Dependencies on header files, for platforms that do not support
+# the gcc -MMD option.
+#
+# Dependencies on automatically generated headers such as common-cmds.h
+# should _not_ be included here, since they are necessary even when
+# building an object for the first time.
+#
+# XXX. Please check occasionally that these include all dependencies
+# gcc detects!
 
 $(GIT_OBJS): $(LIB_H)
 builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o transport.o: branch.h
@@ -1700,10 +1738,10 @@ builtin-pack-objects.o: thread-utils.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o remote-curl.o: http.h
 
-
 xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
+endif
 
 exec_cmd.s exec_cmd.o: ALL_CFLAGS += \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
@@ -2011,6 +2049,7 @@ clean:
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
+	$(RM) -r $(dep_dirs)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
-- 
1.6.6

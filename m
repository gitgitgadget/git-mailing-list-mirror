From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/12] Teach Makefile to check header dependencies
Date: Tue, 26 Jan 2010 09:57:15 -0600
Message-ID: <20100126155714.GM4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:57:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnn6-00066E-Rw
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab0AZP5Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 10:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022Ab0AZP5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:57:16 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:48586 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab0AZP5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:57:15 -0500
Received: by gxk24 with SMTP id 24so5861161gxk.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iKBnw0Z4oGAAqqhL5TYLU8hqjKHBDMt+EE5x4RKF/P0=;
        b=viw/UErjnOWmjRVr27A/383SfiZeZCx7QOy9oN09jkIZ6xptt/oEvqHsBRp1LrYvSO
         UqhDvEUyUUx2us5G8FY+P4r+z+omqRF3yFS8J7qgW1ByhCjXssj64hGV9PF1jyU/wAEU
         t0trwP51kN7xnHgQxDfi7DdlqdslmJaObzEcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=h98pKCmVlKCcnk/T3Qd/mPe7xQWcL5xwzHpqWCoQxKyBW8CJyiib/Rr5YG69OewcNs
         6sJ8dappV1/JkDRBCD5Qdb6XDoODbPpTCrI0AiIvA8npqaAQfGLdz3QotHyBcrxY9XD1
         S0dBD2YJJJzOO/24bcMlVBkYovgNWX54k92es=
Received: by 10.150.5.6 with SMTP id 6mr4256761ybe.194.1264521433850;
        Tue, 26 Jan 2010 07:57:13 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 39sm2071720yxd.9.2010.01.26.07.57.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:57:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138053>

Add a target to use the gcc-generated makefile snippets for
dependencies on header files to check the hard-coded dependencies.

With this patch applied, if any dependencies are missing, then

	make clean
	make COMPUTE_HEADER_DEPENDENCIES=3DYesPlease
	make CHECK_HEADER_DEPENDENCIES=3DYesPlease

will produce an error message like the following:

	CHECK fast-import.o
	missing dependencies: exec_cmd.h
	make: *** [fast-import.o] Error 1

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Thanks for reading.

 Makefile |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++--=
--------
 1 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index ceaae1c..be357a8 100644
--- a/Makefile
+++ b/Makefile
@@ -221,6 +221,9 @@ all::
 # Define COMPUTE_HEADER_DEPENDENCIES if your compiler supports the -MM=
D option
 # and you want to avoid rebuilding objects when an unrelated header fi=
le
 # changes.
+#
+# Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-c=
oded
+# dependency rules.
=20
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1088,6 +1091,14 @@ endif
 -include config.mak.autogen
 -include config.mak
=20
+ifdef CHECK_HEADER_DEPENDENCIES
+USE_COMPUTED_HEADER_DEPENDENCIES =3D
+endif
+
+ifdef COMPUTE_HEADER_DEPENDENCIES
+USE_COMPUTED_HEADER_DEPENDENCIES =3D YesPlease
+endif
+
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ =3D $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX =3D 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $=
(SANE_TOOL_PATH_SQ)|'
@@ -1683,9 +1694,7 @@ XDIFF_OBJS =3D xdiff/xdiffi.o xdiff/xprepare.o xd=
iff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS)
=20
-ASM_SRC :=3D $(wildcard $(OBJECTS:o=3DS))
-ASM_OBJ :=3D $(ASM_SRC:S=3Do)
-C_OBJ :=3D $(filter-out $(ASM_OBJ),$(OBJECTS))
+dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f)deps/$(notdir $f).d)
=20
 ifdef COMPUTE_HEADER_DEPENDENCIES
 dep_dirs :=3D $(addsuffix deps,$(sort $(dir $(OBJECTS))))
@@ -1693,33 +1702,89 @@ $(dep_dirs):
 	mkdir -p $@
=20
 missing_dep_dirs :=3D $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs)=
)
-else
+dep_file =3D $(dir $@)deps/$(notdir $@).d
+dep_args =3D -MF $(dep_file) -MMD -MP
+ifdef CHECK_HEADER_DEPENDENCIES
+$(error cannot compute header dependencies outside a normal build. \
+Please unset CHECK_HEADER_DEPENDENCIES and try again)
+endif
+endif
+
+ifndef COMPUTE_HEADER_DEPENDENCIES
+ifndef CHECK_HEADER_DEPENDENCIES
 dep_dirs =3D
 missing_dep_dirs =3D
+dep_args =3D
+endif
+endif
+
+ifdef CHECK_HEADER_DEPENDENCIES
+ifndef PRINT_HEADER_DEPENDENCIES
+missing_deps =3D $(filter-out $(notdir $^), \
+	$(notdir $(shell $(MAKE) -s $@ \
+		CHECK_HEADER_DEPENDENCIES=3DYesPlease \
+		USE_COMPUTED_HEADER_DEPENDENCIES=3DYesPlease \
+		PRINT_HEADER_DEPENDENCIES=3DYesPlease)))
+endif
 endif
=20
+ASM_SRC :=3D $(wildcard $(OBJECTS:o=3DS))
+ASM_OBJ :=3D $(ASM_SRC:S=3Do)
+C_OBJ :=3D $(filter-out $(ASM_OBJ),$(OBJECTS))
+
 .SUFFIXES:
=20
+ifdef PRINT_HEADER_DEPENDENCIES
+$(C_OBJ): %.o: %.c FORCE
+	echo $^
+$(ASM_OBJ): %.o: %.S FORCE
+	echo $^
+
+ifndef CHECK_HEADER_DEPENDENCIES
+$(error cannot print header dependencies during a normal build. \
+Please set CHECK_HEADER_DEPENDENCIES and try again)
+endif
+endif
+
+ifndef PRINT_HEADER_DEPENDENCIES
+ifdef CHECK_HEADER_DEPENDENCIES
+$(C_OBJ): %.o: %.c $(dep_files) FORCE
+	@set -e; echo CHECK $@; \
+	missing_deps=3D"$(missing_deps)"; \
+	if test "$$missing_deps"; \
+	then \
+		echo missing dependencies: $$missing_deps; \
+		false; \
+	fi
+$(ASM_OBJ): %.o: %.S $(dep_files) FORCE
+	@set -e; echo CHECK $@; \
+	missing_deps=3D"$(missing_deps)"; \
+	if test "$$missing_deps"; \
+	then \
+		echo missing dependencies: $$missing_deps; \
+		false; \
+	fi
+endif
+endif
+
+ifndef CHECK_HEADER_DEPENDENCIES
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
-%.s: %.c GIT-CFLAGS FORCE
-	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
+endif
=20
-ifdef COMPUTE_HEADER_DEPENDENCIES
+%.s: %.c GIT-CFLAGS FORCE
+	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
+
+ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
 # See <http://gcc.gnu.org/gcc-3.0/features.html>.
-dep_files :=3D $(wildcard $(foreach f,$(OBJECTS),$(dir f)deps/$(notdir=
 $f).d))
-ifneq ($(dep_files),)
-include $(dep_files)
+dep_files_present :=3D $(wildcard $(dep_files))
+ifneq ($(dep_files_present),)
+include $(dep_files_present)
 endif
-
-dep_file =3D $(dir $@)deps/$(notdir $@).d
-dep_args =3D -MF $(dep_file) -MMD -MP
 else
-dep_args =3D
-
 # Dependencies on header files, for platforms that do not support
 # the gcc -MMD option.
 #
--=20
1.6.6

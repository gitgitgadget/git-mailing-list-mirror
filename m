From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 2/2 v3] Makefile: lazily compute header dependencies
Date: Sat, 28 Nov 2009 03:29:48 -0600
Message-ID: <20091128092948.GA8515@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20091127175043.GC3461@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 28 10:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEJRL-0000kb-VL
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 10:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbZK1JRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Nov 2009 04:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbZK1JRj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 04:17:39 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:33583 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbZK1JRg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 04:17:36 -0500
Received: by yxe26 with SMTP id 26so1833731yxe.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 01:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HoCCn8JvFpYCv8Y3rPdxd+Poy4HclavahGTyj5BSk28=;
        b=kcQ0+GEPG8jBOVoEH8TIN/MfxOMEwKV0ikEJLM1dpBqNHw0XgjJF8rKhbNPxgzjnA7
         7qfbXqM4tAYK5is01slKd7hGF+iKAOr4Rx6NIhRc1HE3CBstMCIkiYuk0Yj8KfqTrdRi
         x015ACXuEiy2py5HVcbyEirX/o2YIf54fbz78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SLpzVId/wQ/V5Y7gXY7oPheUL3CnfQdWcvBq6s+XkLzasG0kcu8ax4eYIOVrd9V8uY
         vwKqOE1iXHyBOpGOPSSqXCMYQINKEeeDpFoPHsPDxrqniPZtWF3OXY4BSZBM44637mff
         MpXbUwZeWyzgXmeS4Usdgv10eRCu5pYKcWQ8Q=
Received: by 10.150.89.3 with SMTP id m3mr3221239ybb.186.1259399861546;
        Sat, 28 Nov 2009 01:17:41 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm21876gxk.10.2009.11.28.01.17.39
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 01:17:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091127175043.GC3461@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133947>

Use the gcc -MMD -MP -MF options to generate dependencies as a
byproduct of building .o files.

This feature has to be optional (I don=E2=80=99t think MSVC, for exampl=
e,
supports anything like this), so unless someone hooks in a rule
to check the static header dependencies for correctness, this
won=E2=80=99t help much with header dependency maintainance.  It is
enabled by setting the COMPUTE_HEADER_DEPENDENCIES variable,
unset by default.

The scope of the %.o: %.c pattern rule has been restricted to
make it easier to tell if a new object file has not been hooked
into the dependency generation machinery.

An unrelated fix also snuck in: the %.s: %.c pattern rule to
generate an assembler listing did not have correct dependencies.
It is meant to be invoked by hand and should always run.

To avoid litering the build directory with even more build
products, the generated Makefile fragments are squirreled away
into deps/ subdirectories of each directory containing object
files.  These directories are currently generated as a
side-effect of the GIT-CFLAGS rule, to guarantee they will be
available whenever the %.o: %.c and %.o: %.S pattern rules are
being used.  This is really not ideal, especially because it
requires hard-coding the list of directories with objects.

gcc learned the -MMD -MP -MF options in version 3.0, so most gcc
users should have them by now.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I=E2=80=99ll send the .c.s and dependency fixes separately.

Thoughts? Advice?

Thanks,
Jonathan

 .gitignore |    1 +
 Makefile   |   63 ++++++++++++++++++++++++++++++++++++++++++----------=
-------
 2 files changed, 46 insertions(+), 18 deletions(-)

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
index ed0f461..fb20302 100644
--- a/Makefile
+++ b/Makefile
@@ -216,6 +216,9 @@ all::
 #   DEFAULT_EDITOR=3D'~/bin/vi',
 #   DEFAULT_EDITOR=3D'$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR=3D'"C:\Program Files\Vim\gvim.exe" --nofork'
+#
+# Define COMPUTE_HEADER_DEPENDENCIES if you want to avoid rebuilding o=
bjects
+# when an unrelated header file changes and your compiler supports it.
=20
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1559,12 +1562,42 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
=20
-%.o: %.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
-%.s: %.c GIT-CFLAGS
+GIT_OBJS :=3D http.o http-walker.o http-push.o \
+	$(LIB_OBJS) $(BUILTIN_OBJS) \
+	$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o
+
+OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS)
+
+ifndef COMPUTE_HEADER_DEPENDENCIES
+$(GIT_OBJS): $(LIB_H)
+
+$(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xt=
ypes.h \
+	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
+
+http.o http-walker.o http-push.o: http.h
+
+builtin-revert.o wt-status.o: wt-status.h
+
+$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(wildcard */*.h)
+else
+dep_files :=3D $(wildcard $(foreach f,$(OBJECTS),$(dir $f)deps/$(notdi=
r $f).d))
+
+ifneq ($(dep_files),)
+include $(dep_files)
+endif
+
+# Take advantage of gcc's dependency generation.
+# See <http://gcc.gnu.org/gcc-3.0/features.html>.
+dep_args =3D -MF $(dep_file) -MMD -MP
+dep_file =3D $(dir $@)deps/$(notdir $@).d
+endif
+
+$(OBJECTS): %.o: %.c GIT-CFLAGS
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
+%.s: %.c GIT-CFLAGS .FORCE-LISTING
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
-%.o: %.S
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+$(OBJECTS): %.o: %.S GIT-CFLAGS
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
=20
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
 exec_cmd.o: ALL_CFLAGS +=3D \
@@ -1594,10 +1627,6 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
=20
-http.o http-walker.o http-push.o: http.h
-
-http.o http-walker.o: $(LIB_H)
-
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLI=
BS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
 		$(LIBS) $(CURL_LIBCURL)
@@ -1609,22 +1638,15 @@ git-remote-curl$X: remote-curl.o http.o http-wa=
lker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
=20
-$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
-builtin-revert.o wt-status.o: wt-status.h
-
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
=20
 XDIFF_OBJS=3Dxdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemi=
t.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-$(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xt=
ypes.h \
-	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
=20
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
=20
-
 doc:
 	$(MAKE) -C Documentation all
=20
@@ -1657,6 +1679,9 @@ TRACK_CFLAGS =3D $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ)
=20
 GIT-CFLAGS: .FORCE-GIT-CFLAGS
+	mkdir -p deps block-sha1/deps ppc/deps compat/deps \
+		compat/regex/deps compat/nedmalloc/deps compat/fnmatch/deps \
+		xdiff/deps
 	@FLAGS=3D'$(TRACK_CFLAGS)'; \
 	    if test x"$$FLAGS" !=3D x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
 		echo 1>&2 "    * new build flags or prefix"; \
@@ -1873,8 +1898,10 @@ distclean: clean
 	$(RM) configure
=20
 clean:
-	$(RM) *.o block-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdif=
f/*.o \
+	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
+	$(RM) -r deps block-sha1/deps ppc/deps compat/deps \
+		compat/*/deps xdiff/deps
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags csco=
pe*
@@ -1899,7 +1926,7 @@ endif
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
-.PHONY: .FORCE-GIT-BUILD-OPTIONS
+.PHONY: .FORCE-GIT-BUILD-OPTIONS .FORCE-LISTING
=20
 ### Check documentation
 #
--=20
1.6.5.3

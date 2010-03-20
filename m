From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: Fix occasional GIT-CFLAGS breakage
Date: Fri, 19 Mar 2010 22:20:12 -0500
Message-ID: <20100320031937.GA18894@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 04:19:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NspDy-0006Gw-4w
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 04:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab0CTDT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 23:19:26 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:60146 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab0CTDTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 23:19:25 -0400
Received: by yxe12 with SMTP id 12so889683yxe.33
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=6c5RuOOtwHRWM0zlAdCwr+7pm0HA5UrI1kh7gQxno9g=;
        b=dUcBRTPIG2HgbRdk9lSMhfFbCZnxrIIWimYGsW8r9Thoy+oqNKpb09KSAMF5F8laVN
         vHcrxMMF+5DsVWhwmmYlooLmEgPdRVfxxw7TAGaJDRCgoWzg5r80P3hmQU1lab4JyHO/
         37FUSXPwTSg5rIw9+a37sLhObfG3vkGDadD2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=ZnQHXszHtZV3bjS1FOe3zqIUcei35jNcIC/nh1K48g6LTiGy2Nj4okX9c+sNmA3FY9
         Oypx082st4AMJ1fGDph7hWsRxt2bZuAeRtb95lPqNZs369twaT5lw/qkfsjzdU4/6j8z
         0NXxGFJrrpozG3L5bxFqWTX++9O3Gv2FlrsN4=
Received: by 10.100.62.11 with SMTP id k11mr8044533ana.6.1269055162467;
        Fri, 19 Mar 2010 20:19:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm208573iwn.8.2010.03.19.20.19.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 20:19:21 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142678>

GNU make=E2=80=99s target-specific variables facility has one weird fac=
et: any
variables set for a given target apply to all of its dependencies,
too.  For example, when running =E2=80=9Cmake exec_cmd.o=E2=80=9D, sinc=
e exec_cmd.o
depends on GIT-CFLAGS, the variable assignment in

	exec_cmd.s exec_cmd.o: ALL_CFLAGS +=3D \
		'-DGIT_EXEC_PATH=3D"$(gitexecdir_SQ)"' \
		'-DBINDIR=3D"$(bindir_relative_SQ)"' \
		'-DPREFIX=3D"$(prefix_SQ)"'

applies when refreshing GIT-CFLAGS, and the extra options get included
in the tracked compiler flags.  If an object file like this is the
first target built, GIT-CFLAGS will appear to be out of date,
resulting in useless rebuilds and the dreaded =E2=80=9Cnew build flags =
or
prefix=E2=80=9D message.

This does not happen with every build because GIT-CFLAGS is only
refreshed once in a given =E2=80=9Cmake=E2=80=9D run, and usually the f=
irst target
does not set any variables.  When this problem does rear its head, it
is very annoying.

So put target-specific flags in a separate EXTRA_CPPFLAGS variable
that is not included in $(TRACK_CFLAGS).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Ran into this today.  Reproducible by running "make tag.o" and then
"make exec_cmd.o".  Presumably caused by my commit 373a5ed (Makefile:
use target-specific variable to pass flags to cc, 2010-01-06); sorry.

 Makefile |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 7c616f8..fc03436 100644
--- a/Makefile
+++ b/Makefile
@@ -316,6 +316,7 @@ BUILTIN_OBJS =3D
 BUILT_INS =3D
 COMPAT_CFLAGS =3D
 COMPAT_OBJS =3D
+EXTRA_CPPFLAGS =3D
 LIB_H =3D
 LIB_OBJS =3D
 PROGRAM_OBJS =3D
@@ -1480,7 +1481,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
=20
 git.o: common-cmds.h
-git.s git.o: ALL_CFLAGS +=3D -DGIT_VERSION=3D'"$(GIT_VERSION)"' \
+git.s git.o: EXTRA_CPPFLAGS =3D -DGIT_VERSION=3D'"$(GIT_VERSION)"' \
 	'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"'
=20
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
@@ -1488,7 +1489,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
=20
 builtin/help.o: common-cmds.h
-builtin/help.s builtin/help.o: ALL_CFLAGS +=3D \
+builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
 	'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH=3D"$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH=3D"$(infodir_SQ)"'
@@ -1714,13 +1715,13 @@ endif
=20
 ifndef CHECK_HEADER_DEPENDENCIES
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
-	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAG=
S) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
-	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAG=
S) $<
 endif
=20
 %.s: %.c GIT-CFLAGS FORCE
-	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
=20
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
@@ -1760,20 +1761,20 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 endif
=20
-exec_cmd.s exec_cmd.o: ALL_CFLAGS +=3D \
+exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
 	'-DGIT_EXEC_PATH=3D"$(gitexecdir_SQ)"' \
 	'-DBINDIR=3D"$(bindir_relative_SQ)"' \
 	'-DPREFIX=3D"$(prefix_SQ)"'
=20
-builtin/init-db.s builtin/init-db.o: ALL_CFLAGS +=3D \
+builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS =3D \
 	-DDEFAULT_GIT_TEMPLATE_DIR=3D'"$(template_dir_SQ)"'
=20
-config.s config.o: ALL_CFLAGS +=3D -DETC_GITCONFIG=3D'"$(ETC_GITCONFIG=
_SQ)"'
+config.s config.o: EXTRA_CPPFLAGS =3D -DETC_GITCONFIG=3D'"$(ETC_GITCON=
=46IG_SQ)"'
=20
-http.s http.o: ALL_CFLAGS +=3D -DGIT_USER_AGENT=3D'"git/$(GIT_VERSION)=
"'
+http.s http.o: EXTRA_CPPFLAGS =3D -DGIT_USER_AGENT=3D'"git/$(GIT_VERSI=
ON)"'
=20
 ifdef NO_EXPAT
-http-walker.s http-walker.o: ALL_CFLAGS +=3D -DNO_EXPAT
+http-walker.s http-walker.o: EXTRA_CPPFLAGS =3D -DNO_EXPAT
 endif
=20
 git-%$X: %.o $(GITLIBS)
--=20
1.7.0

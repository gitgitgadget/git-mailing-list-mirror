From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/3] Move git_version_string to help.c before diff changes
Date: Fri, 10 Feb 2012 17:39:30 +0100
Message-ID: <1328891972-23695-2-git-send-email-zbyszek@in.waw.pl>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
 <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 10 17:40:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvtWd-0000m2-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 17:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab2BJQkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 11:40:39 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52361 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977Ab2BJQki (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 11:40:38 -0500
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RvtWV-0000kd-W0; Fri, 10 Feb 2012 17:40:36 +0100
X-Mailer: git-send-email 1.7.9.263.g8cced
In-Reply-To: <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190417>

git_version_string lives in git.c. When diff.c starts to use functions
from help.c, which in turn use git_version_string, linking against
libgit.a will fail. This is because git_version_string is physically
located in git.o, and this object file is not part of libgit.a. One
option would be to add git.o to libgit.a, but git.o is biggish. The
second, better option is to move git_version_string to somewhere where
it'll become part of libgit.a. This variable is only used in a couple
of places, help.c being one of them, so it let's move
git_version_string from git.c to help.c. The git binary is linked with
help.o, so it is not affected by this move.

Without this change the next commit would fail with:
$ gcc  -g -O0 -I. -DUSE_LIBPCRE  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DSHA1_H=
EADER=3D'<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS -o git-daemon   d=
aemon.o libgit.a xdiff/lib.a  -lpcre -lz  -lcrypto -lpthread
libgit.a(help.o): In function `cmd_version':
/home/zbyszek/git/git/help.c:435: undefined reference to `git_version_s=
tring'

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 Makefile |    5 +++--
 git.c    |    2 --
 help.c   |    2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4817157..ccafb95 100644
--- a/Makefile
+++ b/Makefile
@@ -1890,7 +1890,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
=20
 git.o: common-cmds.h
-git.sp git.s git.o: EXTRA_CPPFLAGS =3D -DGIT_VERSION=3D'"$(GIT_VERSION=
)"' \
+git.sp git.s git.o: EXTRA_CPPFLAGS =3D \
 	'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH=3D"$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH=3D"$(infodir_SQ)"'
@@ -1899,7 +1899,8 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIB=
S)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
=20
-help.sp help.o: common-cmds.h
+help.o: common-cmds.h
+help.sp help.o: EXTRA_CPPFLAGS =3D -DGIT_VERSION=3D'"$(GIT_VERSION)"'
=20
 builtin/help.sp builtin/help.o: common-cmds.h
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
diff --git a/git.c b/git.c
index 3805616..a24a0fd 100644
--- a/git.c
+++ b/git.c
@@ -256,8 +256,6 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	return ret;
 }
=20
-const char git_version_string[] =3D GIT_VERSION;
-
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
 #define USE_PAGER		(1<<2)
diff --git a/help.c b/help.c
index cbbe966..bc15066 100644
--- a/help.c
+++ b/help.c
@@ -409,6 +409,8 @@ const char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
=20
+const char git_version_string[] =3D GIT_VERSION;
+
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
 	printf("git version %s\n", git_version_string);
--=20
1.7.9.263.g4be11.dirty

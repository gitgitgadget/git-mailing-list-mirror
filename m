From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/4] Move git_version_string to help.c in preparation for diff changes
Date: Fri, 10 Feb 2012 00:58:38 +0100
Message-ID: <1328831921-27272-2-git-send-email-zbyszek@in.waw.pl>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:24:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RveIF-0004cD-5j
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758487Ab2BJAYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:24:48 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52319 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842Ab2BJAYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 19:24:46 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RvdtP-0001gR-TD; Fri, 10 Feb 2012 00:59:12 +0100
X-Mailer: git-send-email 1.7.9.rc2.127.gcb239
In-Reply-To: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190352>

git_version_string is declared in builtins.h, but lived in git.c.

When diff.c starts to use functions from help.c, linking against
libgit.a will fail, unless git.o containing git_version_string is
linked too. This variable is only used in a couple of places, help.c
being one of them. git.o is biggish, so it let's move
git_version_string to help.c.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 Makefile |    5 +++--
 git.c    |    2 --
 help.c   |    2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index a782409..264fe4f 100644
--- a/Makefile
+++ b/Makefile
@@ -1851,7 +1851,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
=20
 git.o: common-cmds.h
-git.sp git.s git.o: EXTRA_CPPFLAGS =3D -DGIT_VERSION=3D'"$(GIT_VERSION=
)"' \
+git.sp git.s git.o: EXTRA_CPPFLAGS =3D \
 	'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH=3D"$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH=3D"$(infodir_SQ)"'
@@ -1860,7 +1860,8 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIB=
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
1.7.9.rc2.127.gcb239

From: Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>
Subject: Patch which adds syslog support to git-shell
Date: Wed, 23 Dec 2009 18:32:00 +0100
Organization: ascolab GmbH
Message-ID: <200912231832.03541.gerhard.gappmeier@ascolab.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3496915.bWk2GEllnY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 18:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1NNV58-0002oo-4C
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 18:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbZLWRcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 12:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574AbZLWRcH
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 12:32:07 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:60702 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbZLWRcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 12:32:06 -0500
Received: from mail.ascolab.com ([213.95.4.186])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lb96v-1NqYV33C6T-00lF0n; Wed, 23 Dec 2009 18:32:04 +0100
Received: from lt_gergap.localnet (unknown [192.168.0.13])
	by mail.ascolab.com (Postfix) with ESMTP id 9C3BDAAD7
	for <git@vger.kernel.org>; Wed, 23 Dec 2009 18:32:04 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-gentoo-r6; KDE/4.3.4; i686; ; )
X-Provags-ID: V01U2FsdGVkX18B3Wzm+f0CYpPsbfMUty0QCyGVBqwYruEblxf
 bDxKSksHzY6Qbbi/6XVDY9/1fmnVuwEBZDK7G75OY9CqR7Htz7
 +TBlYWB0YY4QjKi+H2d0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135624>

--nextPart3496915.bWk2GEllnY
Content-Type: multipart/mixed;
  boundary="Boundary-01=_QQlMLKKCmqHNHwy"
Content-Transfer-Encoding: 7bit


--Boundary-01=_QQlMLKKCmqHNHwy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

I'm not sure if this is the right list, but here is my first GIT patch.

I had a problem with git-shell and wanted to analyze it.
Unfortunately it does not contain any trace capabilities.
So I cloned git and added some basic syslog support.
After that I recognized that the current git version just works ;-)
but the syslog functionality is always a nice thing I think.
So here is the patch.

Merry X-Mas.

=2D-=20

mit freundlichen Gr=FC=DFen / best regards

Gerhard Gappmeier
ascolab GmbH - automation system communication laboratory
Tel.: +49 9131 691 123
=46ax: +49 9131 691 128
Web: http://www.ascolab.com
GPG Key-Id: 5AAC50C4
GPG Fingerprint: 967A 15F1 2788 164D CCA3 6C46 07CD 6F82 5AAC 50C4

--Boundary-01=_QQlMLKKCmqHNHwy
Content-Type: text/x-patch;
  charset="utf-8";
  name="0001-Added-syslog-functionality-to-git-shell.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Added-syslog-functionality-to-git-shell.patch"

=46rom 0683e3a249419620abcf4363086cd53ec34972e8 Mon Sep 17 00:00:00 2001
=46rom: Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>
Date: Wed, 23 Dec 2009 17:19:34 +0100
Subject: [PATCH] Added syslog functionality to git-shell.

=2D--
 shell.c |  192 ++++++++++++++++++++++++++++++++++++++---------------------=
=2D---
 1 files changed, 115 insertions(+), 77 deletions(-)

diff --git a/shell.c b/shell.c
index e4864e0..4cdf385 100644
=2D-- a/shell.c
+++ b/shell.c
@@ -1,103 +1,141 @@
+#include <syslog.h>
+#include <errno.h>
 #include "cache.h"
 #include "quote.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
=20
+/* Syslog defines */
+#define GIT_SYSLOG_IDENT    "git-shell"
+#define GIT_SYSLOG_OPTION   0
+#define GIT_SYSLOG_FACILITY LOG_LOCAL0
+
 static int do_generic_cmd(const char *me, char *arg)
 {
=2D	const char *my_argv[4];
+    const char *my_argv[4];
+    int ret =3D 0;
+   =20
+    setup_path();
+    if (!arg || !(arg =3D sq_dequote(arg))) {
+        syslog(LOG_INFO, "bad argument");
+        die("bad argument");
+    }
+    if (prefixcmp(me, "git-")) {
+        syslog(LOG_INFO, "bad command");
+        die("bad command");
+    }
+
+    my_argv[0] =3D me + 4;
+    my_argv[1] =3D arg;
+    my_argv[2] =3D NULL;
=20
=2D	setup_path();
=2D	if (!arg || !(arg =3D sq_dequote(arg)))
=2D		die("bad argument");
=2D	if (prefixcmp(me, "git-"))
=2D		die("bad command");
+    syslog(LOG_INFO, "Executing '%s' '%s'.", my_argv[0], my_argv[1]);
=20
=2D	my_argv[0] =3D me + 4;
=2D	my_argv[1] =3D arg;
=2D	my_argv[2] =3D NULL;
+    ret =3D  execv_git_cmd(my_argv);
+    if (ret =3D=3D -1) {
+        syslog(LOG_ERR, " execv_git_cmd failed: %s\n", strerror(errno));
+    }
=20
=2D	return execv_git_cmd(my_argv);
+    return ret;
 }
=20
 static int do_cvs_cmd(const char *me, char *arg)
 {
=2D	const char *cvsserver_argv[3] =3D {
=2D		"cvsserver", "server", NULL
=2D	};
+    const char *cvsserver_argv[3] =3D {
+        "cvsserver", "server", NULL
+    };
+    int ret =3D 0;
+
+    if (!arg || strcmp(arg, "server")) {
+        syslog(LOG_INFO, "git-cvsserver only handles server: %s", arg);
+        die("git-cvsserver only handles server: %s", arg);
+    }
+
+    setup_path();
=20
=2D	if (!arg || strcmp(arg, "server"))
=2D		die("git-cvsserver only handles server: %s", arg);
+    syslog(LOG_INFO, "Executing '%s' '%s'.", cvsserver_argv[0], cvsserver_=
argv[1]);
=20
=2D	setup_path();
=2D	return execv_git_cmd(cvsserver_argv);
+    ret =3D execv_git_cmd(cvsserver_argv);
+    if (ret =3D=3D -1) {
+        syslog(LOG_ERR, " execv_git_cmd failed: %s\n", strerror(errno));
+    }
+
+    return ret;
 }
=20
=20
 static struct commands {
=2D	const char *name;
=2D	int (*exec)(const char *me, char *arg);
+    const char *name;
+    int (*exec)(const char *me, char *arg);
 } cmd_list[] =3D {
=2D	{ "git-receive-pack", do_generic_cmd },
=2D	{ "git-upload-pack", do_generic_cmd },
=2D	{ "git-upload-archive", do_generic_cmd },
=2D	{ "cvs", do_cvs_cmd },
=2D	{ NULL },
+    { "git-receive-pack", do_generic_cmd },
+    { "git-upload-pack", do_generic_cmd },
+    { "git-upload-archive", do_generic_cmd },
+    { "cvs", do_cvs_cmd },
+    { NULL },
 };
=20
 int main(int argc, char **argv)
 {
=2D	char *prog;
=2D	struct commands *cmd;
=2D	int devnull_fd;
=2D
=2D	/*
=2D	 * Always open file descriptors 0/1/2 to avoid clobbering files
=2D	 * in die().  It also avoids not messing up when the pipes are
=2D	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
=2D	 */
=2D	devnull_fd =3D open("/dev/null", O_RDWR);
=2D	while (devnull_fd >=3D 0 && devnull_fd <=3D 2)
=2D		devnull_fd =3D dup(devnull_fd);
=2D	if (devnull_fd =3D=3D -1)
=2D		die_errno("opening /dev/null failed");
=2D	close (devnull_fd);
=2D
=2D	/*
=2D	 * Special hack to pretend to be a CVS server
=2D	 */
=2D	if (argc =3D=3D 2 && !strcmp(argv[1], "cvs server"))
=2D		argv--;
=2D
=2D	/*
=2D	 * We do not accept anything but "-c" followed by "cmd arg",
=2D	 * where "cmd" is a very limited subset of git commands.
=2D	 */
=2D	else if (argc !=3D 3 || strcmp(argv[1], "-c"))
=2D		die("What do you think I am? A shell?");
=2D
=2D	prog =3D argv[2];
=2D	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
=2D		/* Accept "git foo" as if the caller said "git-foo". */
=2D		prog[3] =3D '-';
=2D
=2D	for (cmd =3D cmd_list ; cmd->name ; cmd++) {
=2D		int len =3D strlen(cmd->name);
=2D		char *arg;
=2D		if (strncmp(cmd->name, prog, len))
=2D			continue;
=2D		arg =3D NULL;
=2D		switch (prog[len]) {
=2D		case '\0':
=2D			arg =3D NULL;
=2D			break;
=2D		case ' ':
=2D			arg =3D prog + len + 1;
=2D			break;
=2D		default:
=2D			continue;
=2D		}
=2D		exit(cmd->exec(cmd->name, arg));
=2D	}
=2D	die("unrecognized command '%s'", prog);
+    char *prog;
+    struct commands *cmd;
+    int devnull_fd;
+
+    /* Open syslog. */
+    openlog(GIT_SYSLOG_IDENT, GIT_SYSLOG_OPTION, GIT_SYSLOG_FACILITY);
+
+    /*
+     * Always open file descriptors 0/1/2 to avoid clobbering files
+     * in die().  It also avoids not messing up when the pipes are
+     * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
+     */
+    devnull_fd =3D open("/dev/null", O_RDWR);
+    while (devnull_fd >=3D 0 && devnull_fd <=3D 2)
+        devnull_fd =3D dup(devnull_fd);
+    if (devnull_fd =3D=3D -1)
+        die_errno("opening /dev/null failed");
+    close (devnull_fd);
+
+    /*
+     * Special hack to pretend to be a CVS server
+     */
+    if (argc =3D=3D 2 && !strcmp(argv[1], "cvs server"))
+        argv--;
+
+    /*
+     * We do not accept anything but "-c" followed by "cmd arg",
+     * where "cmd" is a very limited subset of git commands.
+     */
+    else if (argc !=3D 3 || strcmp(argv[1], "-c")) {
+        syslog(LOG_WARNING, "Invalid parameter '%s'", argv[1]);
+        die("What do you think I am? A shell?");
+    }
+
+    prog =3D argv[2];
+    if (!strncmp(prog, "git", 3) && isspace(prog[3]))
+        /* Accept "git foo" as if the caller said "git-foo". */
+        prog[3] =3D '-';
+
+    for (cmd =3D cmd_list ; cmd->name ; cmd++) {
+        int len =3D strlen(cmd->name);
+        char *arg;
+        if (strncmp(cmd->name, prog, len))
+            continue;
+        arg =3D NULL;
+        switch (prog[len]) {
+        case '\0':
+            arg =3D NULL;
+            break;
+        case ' ':
+            arg =3D prog + len + 1;
+            break;
+        default:
+            continue;
+        }
+        exit(cmd->exec(cmd->name, arg));
+    }
+
+    syslog(LOG_WARNING, "Somebody tried to execute an unallowed command '%=
s'", prog);
+    die("unrecognized command '%s'", prog);
 }
+
=2D-=20
1.6.4.4


--Boundary-01=_QQlMLKKCmqHNHwy--

--nextPart3496915.bWk2GEllnY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAksyVBMACgkQB81vglqsUMSJ3wCgnzITlzm9cbERgopsdaHWmEDw
XeoAoJKkaatvbDN3HfmxCcfG7moZ1/A3
=if6+
-----END PGP SIGNATURE-----

--nextPart3496915.bWk2GEllnY--

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] gc: reject if another gc is running, unless --force is given
Date: Mon,  5 Aug 2013 21:19:14 +0700
Message-ID: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
References: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 05 16:18:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6LcY-0002j2-9o
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 16:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab3HEOSq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Aug 2013 10:18:46 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37072 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab3HEOSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 10:18:44 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so3308115pdc.33
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WJTilPfze4xdhpp1Nao77DyGFVuh+raW8MuFlFVgzmM=;
        b=B5FXdMWCyF1lMG+5UmYaksRnHTpj76wUmq1XzwdnrPM9h0oSM5HwszWg/kzzNoqiKn
         Z+fqeVkrHqMY5unlM1uOZWO2Xs8BCaFfB+36pSZCTWg9eUw7EFA3Q8leoAQjNp47coGH
         YhI5YRdiIi4t1RVNTHe0z1Km5CaJkaYZrnd/xZumNicyzJc01QWgTzHXYZ/uVQ90Kaq2
         JurGqnXsZwX4Wa+L/+QMH/euxYdSy4yJYfxhE7jilfVV7zPcRsAgo00A/5o+sENS2j/i
         9DdnJlEbDiEDTOKBY/YrbfzymdJshb1l0ict9AqjxLpvEgYLqL+UnGFhq3A+OKB7NDKd
         GI4A==
X-Received: by 10.66.232.101 with SMTP id tn5mr25467395pac.132.1375712323709;
        Mon, 05 Aug 2013 07:18:43 -0700 (PDT)
Received: from lanh ([115.73.200.117])
        by mx.google.com with ESMTPSA id iu7sm27758348pbc.8.2013.08.05.07.18.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 Aug 2013 07:18:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 05 Aug 2013 21:19:19 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231650>

This may happen when `git gc --auto` is run automatically, then the
user, to avoid wait time, switches to a new terminal, keeps working
and `git gc --auto` is started again because the first gc instance has
not clean up the repository.

This patch tries to avoid multiple gc running, especially in --auto
mode. In the worst case, gc may be delayed 12 hours if a daemon reuses
the pid stored in gc-%s.pid.

uname() and kill(..,0) are added to MinGW compatibility layer so that
it'll work on Windows. Actually uname() is stub so it won't prevent
multiple gc running on a shared repo. But that's for Windows
contributors to step in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 - new code is taken out in a separate function for clarity
 - file locking
 - implementing kill(pid, 0) on windows (but not tested)

 Documentation/git-gc.txt |  6 ++++-
 builtin/gc.c             | 62 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 compat/mingw.c           |  6 +++++
 compat/mingw.h           |  6 +++++
 git-compat-util.h        |  1 +
 5 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 2402ed6..e158a3b 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the loc=
al repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | --no-pr=
une]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | --no-pr=
une] [--force]
=20
 DESCRIPTION
 -----------
@@ -72,6 +72,10 @@ automatic consolidation of packs.
 --quiet::
 	Suppress all progress reports.
=20
+--force::
+	Force `git gc` to run even if there may be another `git gc`
+	instance running on this repository.
+
 Configuration
 -------------
=20
diff --git a/builtin/gc.c b/builtin/gc.c
index 6be6c8d..1f33908 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -167,11 +167,66 @@ static int need_to_gc(void)
 	return 1;
 }
=20
+static int gc_running(int force)
+{
+	static struct lock_file lock;
+	struct utsname utsname;
+	struct stat st;
+	uintmax_t pid;
+	FILE *fp;
+	int fd, should_exit;
+
+	if (uname(&utsname))
+		strcpy(utsname.nodename, "unknown");
+
+	fd =3D hold_lock_file_for_update(&lock,
+			git_path("gc-%s.pid", utsname.nodename), 0);
+	if (!force) {
+		if (fd < 0)
+			return 1;
+
+		fp =3D fopen(git_path("gc-%s.pid", utsname.nodename), "r");
+		should_exit =3D
+			fp !=3D NULL &&
+			!fstat(fileno(fp), &st) &&
+			/*
+			 * 12 hour limit is very generous as gc should
+			 * never take that long. On the other hand we
+			 * don't really need a strict limit here,
+			 * running gc --auto one day late is not a big
+			 * problem. --force can be used in manual gc
+			 * after the user verifies that no gc is
+			 * running.
+			 */
+			time(NULL) - st.st_mtime <=3D 12 * 3600 &&
+			fscanf(fp, "%"PRIuMAX, &pid) =3D=3D 1 &&
+			!kill(pid, 0);
+		if (fp !=3D NULL)
+			fclose(fp);
+		if (should_exit) {
+			if (fd >=3D 0)
+				rollback_lock_file(&lock);
+			return 1;
+		}
+	}
+
+	if (fd >=3D 0) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_addf(&sb, "%"PRIuMAX"\n", (uintmax_t) getpid());
+		write_in_full(fd, sb.buf, sb.len);
+		strbuf_release(&sb);
+		commit_lock_file(&lock);
+	}
+
+	return 0;
+}
+
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int aggressive =3D 0;
 	int auto_gc =3D 0;
 	int quiet =3D 0;
+	int force =3D 0;
=20
 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -180,6 +235,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOLEAN(0, "aggressive", &aggressive, N_("be more thorough (incr=
eased runtime)")),
 		OPT_BOOLEAN(0, "auto", &auto_gc, N_("enable auto-gc mode")),
+		OPT_BOOL(0, "force", &force, N_("force running gc even if there may =
be another gc running")),
 		OPT_END()
 	};
=20
@@ -225,6 +281,12 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 	} else
 		add_repack_all_option();
=20
+	if (gc_running(force)) {
+		if (auto_gc)
+			return 0; /* be quiet on --auto */
+		die(_("gc is already running (use --force if not)"));
+	}
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
=20
diff --git a/compat/mingw.c b/compat/mingw.c
index bb92c43..22ee9ef 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1086,6 +1086,12 @@ int mingw_kill(pid_t pid, int sig)
 		errno =3D err_win_to_posix(GetLastError());
 		CloseHandle(h);
 		return -1;
+	} else if (pid > 0 && sig =3D=3D 0) {
+		HANDLE h =3D OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, pid);
+		if (h) {
+			CloseHandle(h);
+			return 0;
+		}
 	}
=20
 	errno =3D EINVAL;
diff --git a/compat/mingw.h b/compat/mingw.h
index bd0a88b..2c25d2d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -68,6 +68,10 @@ struct itimerval {
 };
 #define ITIMER_REAL 0
=20
+struct utsname {
+	char nodename[128];
+};
+
 /*
  * sanitize preprocessor namespace polluted by Windows headers definin=
g
  * macros which collide with git local versions
@@ -86,6 +90,8 @@ static inline int fchmod(int fildes, mode_t mode)
 { errno =3D ENOSYS; return -1; }
 static inline pid_t fork(void)
 { errno =3D ENOSYS; return -1; }
+static inline int uname(struct utsname *buf)
+{ errno =3D ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
diff --git a/git-compat-util.h b/git-compat-util.h
index 115cb1d..c6a53cb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -139,6 +139,7 @@
 #include <sys/resource.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#include <sys/utsname.h>
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
--=20
1.8.2.83.gc99314b

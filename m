From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] gc: reject if another gc is running, unless --force is given
Date: Sat,  3 Aug 2013 13:21:30 +0700
Message-ID: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
References: <1375503605-32480-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 08:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5VDV-0002Nb-56
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 08:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181Ab3HCGVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 02:21:00 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38780 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab3HCGU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 02:20:59 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so1405520pad.18
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hj4AXFiA3GREIW3fGuLhoFWWoV1w0U+cIgv70BaN6UE=;
        b=eqh3uUWLByEUW+82HqyMZr4HY84jmrVPdu4YAyOaX8ow+IySgQ1aS8ZYNVc2OKOCbp
         kmurdHIGNRqwViIiZa1WzrCtnqS9RmGXmUjVlQP//m3nO37vzcoC4ga+rqClHqCy8G38
         QJfHG792TEQ1L+WcRj3f6LP6UxRAMJJf1IZBkpn+nLGEM4s9OqlTzqImdf/s2i/NOA71
         M1q4vUybu3mDH+FlLnCpfixTD0F35zM2x63o4wAE/MZQYOzjcamwavB85HputX5aHwXu
         2m43TwNoMC0pCRXSaJe0u+8y83aCdj0/PzcLapg8VdUq2FDUOpUdjywgXckEy2/J68Ow
         yL9w==
X-Received: by 10.66.232.73 with SMTP id tm9mr13828397pac.159.1375510858949;
        Fri, 02 Aug 2013 23:20:58 -0700 (PDT)
Received: from lanh ([115.73.207.46])
        by mx.google.com with ESMTPSA id ep4sm14302685pbd.35.2013.08.02.23.20.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 23:20:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 03 Aug 2013 13:21:32 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1375503605-32480-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231562>

This may happen when `git gc --auto` is run automatically, then the
user, to avoid wait time, switches to a new terminal, keeps working
and `git gc --auto` is started again because the first gc instance has
not clean up the repository.

This patch tries to avoid multiple gc running, especially in --auto
mode. In the worst case, gc may be delayed 12 hours if a daemon reuses
the pid stored in gc-%s.pid.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2 deals with the stored pid taken by another process and takes
 shared repository into account (sort of, it only makes sure gc is not
 run multiple times on the same machine, not only one gc instance acros=
s
 multiple machines)

 I changed mingw.h to add a stub uname() because I don't think MinGW
 port has that function, but that's totally untested.

 Documentation/git-gc.txt |  6 +++++-
 builtin/gc.c             | 35 +++++++++++++++++++++++++++++++++++
 compat/mingw.h           |  6 ++++++
 git-compat-util.h        |  1 +
 4 files changed, 47 insertions(+), 1 deletion(-)

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
index 6be6c8d..8a7f24a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -172,6 +172,10 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 	int aggressive =3D 0;
 	int auto_gc =3D 0;
 	int quiet =3D 0;
+	int force =3D 0;
+	FILE *fp;
+	struct utsname utsname;
+	struct stat st;
=20
 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -180,6 +184,7 @@ int cmd_gc(int argc, const char **argv, const char =
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
@@ -225,6 +230,34 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 	} else
 		add_repack_all_option();
=20
+	if (uname(&utsname))
+		strcpy(utsname.nodename, "unknown");
+
+	if (!force &&
+	    (fp =3D fopen(git_path("gc-%s.pid", utsname.nodename), "r")) !=3D=
 NULL &&
+	    !fstat(fileno(fp), &st) &&
+	    /*
+	     * 12 hour limit is very generous as gc should never take
+	     * that long. On the other hand we don't really need a
+	     * strict limit here, running gc --auto one day late is
+	     * not a big problem. --force can be used in manual gc
+	     * after the user verifies that no gc is running.
+	     */
+	    time(NULL) - st.st_mtime <=3D 12 * 3600) {
+		uintmax_t pid;
+		if (fscanf(fp, "%"PRIuMAX, &pid) =3D=3D 1 && !kill(pid, 0)) {
+			if (auto_gc)
+				return 0; /* be quiet on --auto */
+			die(_("gc is already running"));
+		}
+		fclose(fp);
+	}
+
+	if ((fp =3D fopen(git_path("gc-%s.pid", utsname.nodename), "w")) !=3D=
 NULL) {
+		fprintf(fp, "%"PRIuMAX"\n", (uintmax_t) getpid());
+		fclose(fp);
+	}
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
=20
@@ -249,5 +282,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
=20
+	unlink(git_path("gc-%s.pid", utsname.nodename));
+
 	return 0;
 }
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

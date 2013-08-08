From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Thu,  8 Aug 2013 18:05:38 +0700
Message-ID: <1375959938-6395-1-git-send-email-pclouds@gmail.com>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 13:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7O1m-0001Xp-LV
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 13:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183Ab3HHLFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Aug 2013 07:05:04 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53445 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133Ab3HHLFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 07:05:02 -0400
Received: by mail-ie0-f180.google.com with SMTP id aq17so1533411iec.11
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Dpc0FX/aVh6IEVGBuoixHaBGGUlYwjuwH0ZwjcaIY50=;
        b=eDdBecu8pAWEXsYuq9j5ELZnhS5nuQ7YT5030eDP9tF+Z0+lHzhOJwK5kV7LkYrERY
         TFLPZAo37ywqkEqAUBxicJpjdwzqS1K/t9VIGBZtk8VSh1c9J39ZGXKeUfX7kcC8GOAO
         MRKagyOjDOakhoQZYKDFIpXYc29qonOiv3pqlKEuKu372zmRr4krCPH5sPZVPA7t6R49
         XYEcV7GKu8GWbOPw2x4wpN9brXYFkT1iCnabIIQsjAgGsPC6l1ZP/m0eQLV8xWx12nNm
         urpzVew0uh3GsaDDmwr8txu3bp3DDva6mxCs3huxdqMYwRKJbixXrgQbI9hq+6nknoqC
         YPGw==
X-Received: by 10.50.26.103 with SMTP id k7mr1887713igg.8.1375959901423;
        Thu, 08 Aug 2013 04:05:01 -0700 (PDT)
Received: from lanh ([115.73.221.215])
        by mx.google.com with ESMTPSA id y2sm5452739igl.10.2013.08.08.04.04.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 04:05:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 08 Aug 2013 18:05:40 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231871>

This may happen when `git gc --auto` is run automatically, then the
user, to avoid wait time, switches to a new terminal, keeps working
and `git gc --auto` is started again because the first gc instance has
not clean up the repository.

This patch tries to avoid multiple gc running, especially in --auto
mode. In the worst case, gc may be delayed 12 hours if a daemon reuses
the pid stored in gc.pid.

kill(pid, 0) support is added to MinGW port so it should work on
Windows too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 this patch is getting cooler:

 - uname() is dropped in favor of gethostbyname(), which is supported
   by MinGW port.
 - host name is stored in gc.pid as junio suggested so...
 - now we can say "gc is already running on _this host_ with _this pid_=
=2E.."

 Documentation/git-gc.txt |  6 ++++-
 builtin/gc.c             | 67 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 compat/mingw.c           |  6 +++++
 3 files changed, 78 insertions(+), 1 deletion(-)

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
index 6be6c8d..99682f0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -167,11 +167,69 @@ static int need_to_gc(void)
 	return 1;
 }
=20
+/* return NULL on success, else hostname running the gc */
+static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
+{
+	static struct lock_file lock;
+	static char locking_host[128];
+	char my_host[128];
+	struct strbuf sb =3D STRBUF_INIT;
+	struct stat st;
+	uintmax_t pid;
+	FILE *fp;
+	int fd, should_exit;
+
+	if (gethostname(my_host, sizeof(my_host)))
+		strcpy(my_host, "unknown");
+
+	fd =3D hold_lock_file_for_update(&lock, git_path("gc.pid"),
+				       LOCK_DIE_ON_ERROR);
+	if (!force) {
+		fp =3D fopen(git_path("gc.pid"), "r");
+		memset(locking_host, 0, sizeof(locking_host));
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
+			fscanf(fp, "%"PRIuMAX" %127c", &pid, locking_host) =3D=3D 2 &&
+			!strcmp(locking_host, my_host) &&
+			!kill(pid, 0);
+		if (fp !=3D NULL)
+			fclose(fp);
+		if (should_exit) {
+			if (fd >=3D 0)
+				rollback_lock_file(&lock);
+			*ret_pid =3D pid;
+			return locking_host;
+		}
+	}
+
+	strbuf_addf(&sb, "%"PRIuMAX" %s",
+		    (uintmax_t) getpid(), my_host);
+	write_in_full(fd, sb.buf, sb.len);
+	strbuf_release(&sb);
+	commit_lock_file(&lock);
+
+	return NULL;
+}
+
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int aggressive =3D 0;
 	int auto_gc =3D 0;
 	int quiet =3D 0;
+	int force =3D 0;
+	const char *name;
+	pid_t pid;
=20
 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -180,6 +238,7 @@ int cmd_gc(int argc, const char **argv, const char =
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
@@ -225,6 +284,14 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 	} else
 		add_repack_all_option();
=20
+	name =3D lock_repo_for_gc(force, &pid);
+	if (name) {
+		if (auto_gc)
+			return 0; /* be quiet on --auto */
+		die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use --f=
orce if not)"),
+		    name, (uintmax_t)pid);
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
--=20
1.8.2.83.gc99314b

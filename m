From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [Alt. PATCH v5] gc: save log from daemonized gc --auto and print it next time
Date: Sat, 19 Sep 2015 12:14:25 +0700
Message-ID: <1442639665-25692-1-git-send-email-pclouds@gmail.com>
References: <1442108202-25746-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 19 07:14:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdATV-0003nG-Cx
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 07:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbbISFOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Sep 2015 01:14:08 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33845 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbISFOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2015 01:14:07 -0400
Received: by padhy16 with SMTP id hy16so68132227pad.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 22:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4FCGndHzZr86hgXmu1a8UOcN/4WPLLwvwAF8Of+9xSU=;
        b=ErUeC7dJ7CWcuS/zYGoBF4+2ECFuF49qgPYCe2DyEXZHpKwI1TXgAOH0wy/m0UQ+5f
         dP+9qYfVjTJ95TnOIv2JJ7BHKOwEVC0J3AWjHgNe+f2rdR7IpCPqESu5DLR+Hs1swYBw
         fbZeL1vhVfFZ4WIsdTZtgz6HDKoMVBjrAwHoSLPKMX0Xjr5ZRiUBDWkncM2p7OtEfiA9
         1fTfn6PUc+twc8FUJp3H6uvRHS7h1z6bfBpc7v1IXaHcldsrHAB1D+44SnCABs7RZKwD
         mvHJFAQs7WZKu9MdFItNKgZ9+u32xev0yaAIuRWoFDLpMqpR8E/4TNVCNlgh+S7qLeu9
         n7ug==
X-Received: by 10.66.235.67 with SMTP id uk3mr1964235pac.100.1442639645805;
        Fri, 18 Sep 2015 22:14:05 -0700 (PDT)
Received: from lanh ([171.232.94.243])
        by smtp.gmail.com with ESMTPSA id uy4sm11988901pbc.69.2015.09.18.22.14.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2015 22:14:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 19 Sep 2015 12:14:32 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442108202-25746-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278231>

While commit 9f673f9 (gc: config option for running --auto in
background - 2014-02-08) helps reduce some complaints about 'gc
--auto' hogging the terminal, it creates another set of problems.

The latest in this set is, as the result of daemonizing, stderr is
closed and all warnings are lost. This warning at the end of cmd_gc()
is particularly important because it tells the user how to avoid "gc
--auto" running repeatedly. Because stderr is closed, the user does
not know, naturally they complain about 'gc --auto' wasting CPU.

Daemonized gc now saves stderr to $GIT_DIR/gc.log. Following gc --auto
will not run and gc.log printed out until the user removes gc.log.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The lock-based version has an advantage that the following gc runs
 will never see partial gc.log. But it requires some more hook at
 atexit() and maybe signal handler.
=20
 This version avoids that, and gc.log can be kept even if gc is
 SIGKILL'd (unlikely because gc itself does not do anything that can
 upset the kernel), but then it's racy.

 I think I perfer the lock-based version.

 builtin/gc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcc75d9..3d42ef7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,6 +43,8 @@ static struct argv_array prune_worktrees =3D ARGV_ARR=
AY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
 static char *pidfile;
+static struct strbuf log_filename =3D STRBUF_INIT;
+static int daemonized;
=20
 static void remove_pidfile(void)
 {
@@ -253,6 +255,41 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
 	return NULL;
 }
=20
+static int report_last_gc_error(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret;
+
+	if (!access(git_path("gc.pid"), R_OK))
+		/*
+		 * Either background gc is still running, or we have a stale
+		 * gc.pid.
+		 *
+		 * If the former, it's not the right time to look at gc.log
+		 * yet. We'll exit shortly after lock_repo_for_gc().
+		 *
+		 * If the latter, we'll run gc --auto one more time. But
+		 * because gc.log is appended, the old log (if exists) won't
+		 * be lost. One extra gc run is not that big a deal to avoid.
+		 */
+		return 0;
+
+	ret =3D strbuf_read_file(&sb, git_path("gc.log"), 0);
+	if (ret > 0)
+		return error(_("The last gc run reported the following. "
+			       "Please correct the root cause\n"
+			       "and remove %s. Automatic cleanup will not "
+			       "be performed\n"
+			       "until the file is removed.\n\n"
+			       "%s"),
+			     git_path("gc.log"), sb.buf);
+	else if (!ret)
+		/* racy, but in the worst case we waste one more gc run */
+		unlink(git_path("gc.log"));
+	strbuf_release(&sb);
+	return 0;
+}
+
 static int gc_before_repack(void)
 {
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
@@ -330,13 +367,16 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
 		}
 		if (detach_auto) {
+			if (report_last_gc_error())
+				return -1;
+
 			if (gc_before_repack())
 				return -1;
 			/*
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonize();
+			daemonized =3D !daemonize();
 		}
 	} else
 		add_repack_all_option();
@@ -349,6 +389,18 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		    name, (uintmax_t)pid);
 	}
=20
+	if (daemonized) {
+		int fd;
+
+		strbuf_git_path(&log_filename, "gc.log");
+		fd =3D open(log_filename.buf, O_WRONLY | O_CREAT | O_APPEND, 0644);
+		if (fd >=3D 0) {
+			dup2(fd, 2);
+			close(fd);
+		} else
+			strbuf_release(&log_filename);
+	}
+
 	if (gc_before_repack())
 		return -1;
=20
@@ -376,6 +428,17 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
=20
+	/*
+	 * Opportunistic cleanup in the good case (which most likely
+	 * produce empty gc.log), otherwise empty gc.log will be
+	 * deleted at the next auto gc run.
+	 */
+	if (daemonized && log_filename.len) {
+		struct stat st;
+
+		fflush(stderr);
+		if (!stat(log_filename.buf, &st) && !st.st_size)
+			unlink(log_filename.buf);
+	}
 	return 0;
 }
--=20
2.3.0.rc1.137.g477eb31

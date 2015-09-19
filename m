From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5] gc: save log from daemonized gc --auto and print it next time
Date: Sat, 19 Sep 2015 12:13:23 +0700
Message-ID: <1442639603-25568-1-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Sep 19 07:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdASq-0002fh-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 07:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbbISFNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Sep 2015 01:13:01 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33536 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbbISFM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2015 01:12:59 -0400
Received: by pacex6 with SMTP id ex6so68192014pac.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=l/wwUNfvIOaooAvN6nQHg86mpqH7QwMV5v1y0jQuVAE=;
        b=dEbY+FY11/RpQO90BuuSN2q1GX7lF/cWDHdfNbOCcLrvTWDq1mvMoSvZezyC8N6VVx
         y5gLAqwo98YRNOHHkquFrUNmA1ZytgRYWblKlWcjOnmT4PA2N9eFtVflK8ZTmmoCHEwI
         78Ed2woGjAAs0sTxNX/B9m4DrHQfH+VliBclsKHuyLStVKNizDN2E243x64bNXEskK2R
         tIR5MTx5sNP9scuw12CbD52j0bN98cGqTOxfGLpbKcaqEjLQR7paTNUou5hqU9cbVO0e
         4tvmj5b9EHHbuVcpjMhZ66K4EBSitRunhPj2Dvi1xI/j9eUgyf9XEvFrPyU00n3IpLVm
         vzyg==
X-Received: by 10.68.243.99 with SMTP id wx3mr33223pbc.33.1442639579328;
        Fri, 18 Sep 2015 22:12:59 -0700 (PDT)
Received: from lanh ([171.232.94.243])
        by smtp.gmail.com with ESMTPSA id rz10sm12045864pab.42.2015.09.18.22.12.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2015 22:12:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 19 Sep 2015 12:13:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442108202-25746-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278230>

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
 This is the lock-based version. I'm sending an alternative that does
 not need atexit() with comparison between the two.

 builtin/gc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcc75d9..4e738fa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,6 +43,7 @@ static struct argv_array prune_worktrees =3D ARGV_ARR=
AY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
 static char *pidfile;
+static struct lock_file log_lock;
=20
 static void remove_pidfile(void)
 {
@@ -57,6 +58,28 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
=20
+static void process_log_file(void)
+{
+	struct stat st;
+	if (!fstat(log_lock.fd, &st) && st.st_size)
+		commit_lock_file(&log_lock);
+	else
+		rollback_lock_file(&log_lock);
+}
+
+static void process_log_file_at_exit(void)
+{
+	fflush(stderr);
+	process_log_file();
+}
+
+static void process_log_file_on_signal(int signo)
+{
+	process_log_file();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static void git_config_date_string(const char *key, const char **outpu=
t)
 {
 	if (git_config_get_string_const(key, output))
@@ -253,6 +276,24 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
 	return NULL;
 }
=20
+static int report_last_gc_error(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret;
+
+	ret =3D strbuf_read_file(&sb, git_path("gc.log"), 0);
+	if (ret > 0)
+		return error(_("The last gc run reported the following. "
+			       "Please correct the root cause\n"
+			       "and remove %s.\n"
+			       "Automatic cleanup will not be performed "
+			       "until the file is removed.\n\n"
+			       "%s"),
+			     git_path("gc.log"), sb.buf);
+	strbuf_release(&sb);
+	return 0;
+}
+
 static int gc_before_repack(void)
 {
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
@@ -274,6 +315,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	int force =3D 0;
 	const char *name;
 	pid_t pid;
+	int daemonized =3D 0;
=20
 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -330,13 +372,16 @@ int cmd_gc(int argc, const char **argv, const cha=
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
@@ -349,6 +394,15 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		    name, (uintmax_t)pid);
 	}
=20
+	if (daemonized) {
+		hold_lock_file_for_update(&log_lock,
+					  git_path("gc.log"),
+					  LOCK_DIE_ON_ERROR);
+		dup2(log_lock.fd, 2);
+		sigchain_push_common(process_log_file_on_signal);
+		atexit(process_log_file_at_exit);
+	}
+
 	if (gc_before_repack())
 		return -1;
=20
--=20
2.3.0.rc1.137.g477eb31

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/21] checkout: clean up half-prepared directories in --to mode
Date: Sat, 14 Dec 2013 17:55:01 +0700
Message-ID: <1387018507-21999-16-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmpy-0001Fn-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab3LNKwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:42 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62963 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab3LNKwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:41 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so3509343pdj.39
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G/Oir/VP4Z1pYVoKHHpxcjQsEe5Jrp5d6nHjdYJ0cQE=;
        b=n+o6kpySSl10x44LUfRKQj6lMOpqmEMr2kHI9rAF2B1OJZWADK1ioEMFRoKIk6d+b2
         xVsrOOpN8IKQRBlUh3Cbxyu6qAbDLNJIoVXiZxFOcchxTIyWc/nO8hXOAVUx2Qqe8j66
         e/jxqPESB7M3EdqDf1os4yXYhPGupwu1TBftWXQhJ86M1J2hSw/lDWWxAExfUgxje0gJ
         9FgqSnt619UBPGb3MaFkwcEs0ojPLRajci7t3JSUXqg0Otbc4k1kBPrha1plwnwQFCXq
         yiE0uj421OGdMmVuf01wv/pD9MMuSzZR+Chvva3rQ1hxk95HQ87XFU5nXWKrudFFVpeG
         sYCw==
X-Received: by 10.67.5.233 with SMTP id cp9mr8543263pad.147.1387018361546;
        Sat, 14 Dec 2013 02:52:41 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id pe3sm11423340pbc.23.2013.12.14.02.52.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:34 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239297>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 95a1a61..6353557 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -20,6 +20,7 @@
 #include "resolve-undo.h"
 #include "submodule.h"
 #include "argv-array.h"
+#include "sigchain.h"
=20
 static const char * const checkout_usage[] =3D {
 	N_("git checkout [options] <branch>"),
@@ -826,6 +827,35 @@ static void write_to_file(const char *path, const =
char *fmt, ...)
 	fclose(fp);
 }
=20
+static const char *junk_work_tree;
+static const char *junk_git_dir;
+static int is_junk;
+static pid_t junk_pid;
+
+static void remove_junk(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	if (!is_junk || getpid() !=3D junk_pid)
+		return;
+	if (junk_git_dir) {
+		strbuf_addstr(&sb, junk_git_dir);
+		remove_dir_recursively(&sb, 0);
+		strbuf_reset(&sb);
+	}
+	if (junk_work_tree) {
+		strbuf_addstr(&sb, junk_work_tree);
+		remove_dir_recursively(&sb, 0);
+		strbuf_reset(&sb);
+	}
+}
+
+static void remove_junk_on_signal(int signo)
+{
+	remove_junk();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static int checkout_new_worktree(const struct checkout_opts *opts,
 				 struct branch_info *new)
 {
@@ -835,7 +865,7 @@ static int checkout_new_worktree(const struct check=
out_opts *opts,
 	struct stat st;
 	const char *name;
 	struct child_process cp;
-	int counter =3D 0, len;
+	int counter =3D 0, len, ret;
=20
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -860,13 +890,21 @@ static int checkout_new_worktree(const struct che=
ckout_opts *opts,
 		strbuf_addf(&sb_repo, "%d", counter);
 	}
 	name =3D sb_repo.buf + len - strlen(name);
+
+	junk_pid =3D getpid();
+	atexit(remove_junk);
+	sigchain_push_common(remove_junk_on_signal);
+
 	if (mkdir(sb_repo.buf, 0777))
 		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
+	junk_git_dir =3D sb_repo.buf;
+	is_junk =3D 1;
=20
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
+	junk_work_tree =3D path;
=20
 	write_to_file(sb_git.buf, "gitsuper: %s\ngitdir: %s\n",
 		      real_path(get_git_dir()), name);
@@ -887,7 +925,14 @@ static int checkout_new_worktree(const struct chec=
kout_opts *opts,
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd =3D 1;
 	cp.argv =3D opts->saved_argv;
-	return run_command(&cp);
+	ret =3D run_command(&cp);
+	if (!ret)
+		is_junk =3D 0;
+	strbuf_release(&sb);
+	strbuf_release(&sb_repo);
+	strbuf_release(&sb_git);
+	return ret;
+
 }
=20
 static int git_checkout_config(const char *var, const char *value, voi=
d *cb)
--=20
1.8.5.1.77.g42c48fa

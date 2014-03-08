From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 23/28] checkout: clean up half-prepared directories in --to mode
Date: Sat,  8 Mar 2014 09:48:15 +0700
Message-ID: <1394246900-31535-24-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:50:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7LD-00067n-1J
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbaCHCuP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:50:15 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:57270 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbaCHCuN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:50:13 -0500
Received: by mail-pb0-f47.google.com with SMTP id up15so4937919pbc.6
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BFZXdf6aHNDnSmRx0NCxHxdHx9FwiKeURSeIgL9UX3c=;
        b=Idd0ni+MjZGuCDTpaCEwDdWIvXFD7krBW6KXTvRjH920I1kq02grouonj5Y+kAxyk7
         u/iwXv549/G4vIyGnXeWfsOTgNLMlpGchpf4Fk6SKOE+g4a3HFExjc7lxUo4L76kyq9L
         tWN/jncFkERPwU2mvaQ4nLwz77F3n4p+2DWSQ2GQ5AdO8sf2Q+8Hj2JxM12oFEJYKd7j
         LJbBgldAcQiZNEczhggQqfgLBZFH8FLRXlnc2gdt/4ZKuV9/uw2PTI/zayGMQTSHKmG9
         nBK6MP6NZuMVWsekepITiXE2jsw4GyQuR0VtyVI3iEY2YQXh5tYtLx4VRHJNah6hVHFU
         CviA==
X-Received: by 10.66.142.233 with SMTP id rz9mr26101294pab.71.1394247013407;
        Fri, 07 Mar 2014 18:50:13 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id tu3sm18682191pab.1.2014.03.07.18.50.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:50:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:50:46 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243664>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index aa4ffd1..97fdfcc 100644
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
@@ -815,6 +816,35 @@ static int switch_branches(const struct checkout_o=
pts *opts,
 	return ret || writeout_error;
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
+	}
+	strbuf_release(&sb);
+}
+
+static void remove_junk_on_signal(int signo)
+{
+	remove_junk();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static int prepare_linked_checkout(const struct checkout_opts *opts,
 				   struct branch_info *new)
 {
@@ -823,7 +853,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	const char *path =3D opts->new_worktree, *name;
 	struct stat st;
 	struct child_process cp;
-	int counter =3D 0, len;
+	int counter =3D 0, len, ret;
=20
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -849,13 +879,21 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
 		strbuf_addf(&sb_repo, "%d", counter);
 	}
 	name =3D strrchr(sb_repo.buf, '/') + 1;
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
 	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
 		   real_path(get_git_common_dir()), name);
@@ -880,7 +918,14 @@ static int prepare_linked_checkout(const struct ch=
eckout_opts *opts,
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
1.9.0.40.gaa8c3ea

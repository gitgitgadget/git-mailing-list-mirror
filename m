From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 22/27] checkout: clean up half-prepared directories in --to mode
Date: Sat,  1 Mar 2014 19:12:58 +0700
Message-ID: <1393675983-3232-23-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiww-0002kU-E5
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbaCAMXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:23:11 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:45623 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbaCAMXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:23:06 -0500
Received: by mail-pb0-f43.google.com with SMTP id um1so1901615pbc.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zmapybQbj1BEKbpNVET2HEpQeEMuuk+4ngz+XtCLL6I=;
        b=g1Ko3f6ZGBxTrLnGOzHxlKdKR4gyq/MnyYLB6EniMJe1+63m36ReYJtOF0O3AHNYyV
         exx1uifl9GK3YRCtl74aExXiRDg3E/M0oXKtjtiHjhOWsG1+srDwe4wxAvR7Pa7ENVR/
         MXsQp9G504ENPBgjS6DjjE/MPsZCoDUTilMO/p0Iwxhpsexr0ueUffx16EpIyZ8itCeF
         CNFjdeFfaYTE77M6GHpiqL7XCO6s1jxIW8V3ysMyYzkB80JaXxRqhkwgoZsmletHr/hf
         18+wHt3tisTM40+L+5eyUMjwibRJHrdA6NWSJMNNOJMXpLQ96vkwgblTTftfaVm+zLdZ
         jJgg==
X-Received: by 10.66.102.39 with SMTP id fl7mr9131017pab.43.1393676585558;
        Sat, 01 Mar 2014 04:23:05 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id oa3sm15927750pbb.15.2014.03.01.04.23.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:23:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:23:30 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243086>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fa7b54a..28f9ac1 100644
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
@@ -814,6 +815,35 @@ static int switch_branches(const struct checkout_o=
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
 static int prepare_linked_checkout(const struct checkout_opts *opts,
 				   struct branch_info *new)
 {
@@ -822,7 +852,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	const char *path =3D opts->new_worktree, *name;
 	struct stat st;
 	struct child_process cp;
-	int counter =3D 0, len;
+	int counter =3D 0, len, ret;
=20
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -848,13 +878,21 @@ static int prepare_linked_checkout(const struct c=
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
@@ -879,7 +917,14 @@ static int prepare_linked_checkout(const struct ch=
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

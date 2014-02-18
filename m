From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 22/25] checkout: clean up half-prepared directories in --to mode
Date: Tue, 18 Feb 2014 20:40:11 +0700
Message-ID: <1392730814-19656-23-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:42:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkwh-0000pO-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbaBRNmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:42:32 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57985 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbaBRNm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:42:26 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so16625258pbc.26
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oMvt9JdPNQs8f4wNMzqSzPKQVC+95vDx4GlQFua9HLs=;
        b=UkyN2RZdIq/25DnLTDocEGZtp2XNBgnC4uHqRWMPFW98mNf8Tzdwl1QrM7/wqGxAQy
         M6bbZjgz83QOuWZgec3Bz5STtZHMkLxK6CsIiEL16GBq7rZGLAc5h1w8NV6VZI0hn8yC
         /3isLptJiOBdo9KULZTG4wsLorAI2JZfLXmU0tpkybrGMMfASO3+QuVCLe9QtxQLTxRt
         sJnvydQh+4xyaGfwEtLP3g0AhnCld/geVmdOUd+S2+NHbzjI39o/Lsrr80uOJT3WjG/9
         sgcsW1+FLkv34BMZfNEv4yuvDvu8tR4gJPFUCSFd2ZH9BhvNUyVA2L218Vge55tE90rJ
         tjyA==
X-Received: by 10.66.26.10 with SMTP id h10mr32833745pag.24.1392730945904;
        Tue, 18 Feb 2014 05:42:25 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id yz5sm142604782pac.9.2014.02.18.05.42.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:42:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:39 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242319>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b856a6..f961604 100644
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
@@ -823,7 +853,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	struct stat st;
 	const char *name;
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
 	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
 		   real_path(get_git_dir()), name);
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
1.8.5.2.240.g8478abd

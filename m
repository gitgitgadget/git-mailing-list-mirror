From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 25/32] checkout: clean up half-prepared directories in --to mode
Date: Wed,  9 Jul 2014 14:33:10 +0700
Message-ID: <1404891197-18067-26-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:35:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mPs-0004Ja-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbaGIHfo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:35:44 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46203 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbaGIHfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:35:42 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so8568482pdi.37
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=umWUmjfBpf8MOA+Ps1jbC63w4vYe+l27VK5Qb5wN3R8=;
        b=cDmqutUgH8qEmBY3QiqoVFlWmBIZl8QhgmLCiGoL4ZGbi025U9YFCwYtVSxgcE3yKe
         tyMte1NDWNxq5pvo3SKKAOxNzWhrU76Qykqxvs3DeIMcII93L0ONpwCTSsScsomdy22t
         MyDO8I6jXpci1wP+Bq09bS1NDONmJ6jU4O6D+a4xHY2LWssYLNRNLolrh+qfzIGeDrad
         Ffb5xX0LPxyBwoLdbCldOJ0HUl6+/zBHIhm3upwCl9YoZUwxkxrdEMMWDVAGrc2zXy2l
         B0zPy2rW0U3AOYaZ7GOhQ2lsl61pPAWEftvAfkDt1Up0ZFVuvZqzCDws/EteUu5+dcC4
         PX8A==
X-Received: by 10.66.179.111 with SMTP id df15mr38356565pac.52.1404891342107;
        Wed, 09 Jul 2014 00:35:42 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id hm4sm2123696pbb.88.2014.07.09.00.35.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:35:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:35:38 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253100>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7df586a..5a52da4 100644
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
1.9.1.346.ga2b5940

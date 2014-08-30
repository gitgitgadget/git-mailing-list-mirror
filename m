From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/32] checkout: clean up half-prepared directories in --to mode
Date: Sat, 30 Aug 2014 15:33:53 +0700
Message-ID: <1409387642-24492-24-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe8s-00031L-6P
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbaH3IgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39551 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaH3If6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:35:58 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so8104219pab.15
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kfN11nGjk3JOaaVzUXS0v9TjDNIfkQoOowK+zE/Ctn0=;
        b=Yng1TDf7x4m5UC6bo1pbmld1Dt+C2HQQJQw5oknTaiVU0OFkb22Ovwvn58H/nuI/jQ
         VOu7v3J/kehsSQEzE/S/KXOFvLtiH9Ymz4bYJbp7LpvE7yo0utZlR3/yt/L+LCdVZHrr
         c5Ye8cmjiaOAGobPo974hBdIyN3tGWf/T2cOYgBL1AZJ1lCP5YU0R3TP2XLo0+5236OR
         fO3BVULxDN2bLUQp4TYVwLTvz/sBBEq6w917WSe51ABzs1X3ioOo4pmobOC+FTYPpO2w
         KorcM8DXTykLFkAJ22NJ8akPSkr97dmZHvoEehKtCyw9bv2Kf3i8oOinGo1NZ2aZaUrz
         NH0w==
X-Received: by 10.70.7.1 with SMTP id f1mr22829361pda.22.1409387757918;
        Sat, 30 Aug 2014 01:35:57 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id ev5sm3133062pdb.79.2014.08.30.01.35.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:35:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:07 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256233>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 54 ++++++++++++++++++++++++++++++++++++++++++=
++++++--
 t/t2025-checkout-to.sh |  6 ++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6373823..4ae925a 100644
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
+static char *junk_work_tree;
+static char *junk_git_dir;
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
@@ -850,13 +880,21 @@ static int prepare_linked_checkout(const struct c=
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
+	junk_git_dir =3D xstrdup(sb_repo.buf);
+	is_junk =3D 1;
=20
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
+	junk_work_tree =3D xstrdup(path);
=20
 	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
 		   real_path(get_git_common_dir()), name);
@@ -881,7 +919,19 @@ static int prepare_linked_checkout(const struct ch=
eckout_opts *opts,
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd =3D 1;
 	cp.argv =3D opts->saved_argv;
-	return run_command(&cp);
+	ret =3D run_command(&cp);
+	if (!ret) {
+		is_junk =3D 0;
+		free(junk_work_tree);
+		free(junk_git_dir);
+		junk_work_tree =3D NULL;
+		junk_git_dir =3D NULL;
+	}
+	strbuf_release(&sb);
+	strbuf_release(&sb_repo);
+	strbuf_release(&sb_git);
+	return ret;
+
 }
=20
 static int git_checkout_config(const char *var, const char *value, voi=
d *cb)
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 8c73b18..75ac420 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -17,6 +17,12 @@ test_expect_success 'checkout --to an existing workt=
ree' '
 	test_must_fail git checkout --detach --to existing master
 '
=20
+test_expect_success 'checkout --to refuses to checkout locked branch' =
'
+	test_must_fail git checkout --to zere master &&
+	! test -d zere &&
+	! test -d .git/repos/zere
+'
+
 test_expect_success 'checkout --to a new worktree' '
 	git checkout --to here master &&
 	(
--=20
2.1.0.rc0.78.gc0d8480

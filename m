From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 25/32] checkout: clean up half-prepared directories in --to mode
Date: Thu, 11 Sep 2014 05:42:01 +0700
Message-ID: <1410388928-32265-26-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqck-0002MS-Ft
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbaIJWoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:22 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39287 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:21 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so8032465pab.40
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XsEQSAErSTRHb26zC1K3/tDDuc/2kr8Acr29p7JuIwk=;
        b=MJErdxvX4VzrVcUMoYOHCqp14arDHh+eye7Lswucl4JBlwKCn1oBrT5+ucqdT+PUyV
         juX2Un3ye9eIB4wZNGJOyOnZlFGVrLon9OVzqbcZUI+8n/5cgudZaRdsG3yzJQTWFshZ
         D75f+JykW8d6XgdktCJbcfC4dSAie2Os1pO0zyyx4+LtZkgNA2Oam9OsvEfWEGEnhyq1
         jusZiWnief5g5FmbtS5MCdIIxdm4XiDp0XKJQ1sILgwxSU55qmQ/bKw0mCf3XMuzfrYy
         AgYrPqLVq3cvK72DzTBwb7+9P//81P8/Qn2jBbXuxqYuOGJg03+gQZ/Fgu47mZ/EwPnh
         cPcQ==
X-Received: by 10.70.127.238 with SMTP id nj14mr7098466pdb.156.1410389061175;
        Wed, 10 Sep 2014 15:44:21 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id f3sm12946924pdk.6.2014.09.10.15.44.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:44:40 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256802>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 48 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 t/t2025-checkout-to.sh |  6 ++++++
 2 files changed, 54 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6d623fa..f419ddf 100644
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
@@ -819,6 +820,35 @@ static int switch_branches(const struct checkout_o=
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
@@ -855,8 +885,15 @@ static int prepare_linked_checkout(const struct ch=
eckout_opts *opts,
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
 	/*
 	 * lock the incomplete repo so prune won't delete it, unlock
@@ -869,6 +906,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
+	junk_work_tree =3D xstrdup(path);
=20
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
@@ -898,9 +936,19 @@ static int prepare_linked_checkout(const struct ch=
eckout_opts *opts,
 	cp.git_cmd =3D 1;
 	cp.argv =3D opts->saved_argv;
 	ret =3D run_command(&cp);
+	if (!ret) {
+		is_junk =3D 0;
+		free(junk_work_tree);
+		free(junk_git_dir);
+		junk_work_tree =3D NULL;
+		junk_git_dir =3D NULL;
+	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
+	strbuf_release(&sb);
+	strbuf_release(&sb_repo);
+	strbuf_release(&sb_git);
 	return ret;
 }
=20
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index afa8a62..5d28f9e 100755
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
+	! test -d .git/worktrees/zere
+'
+
 test_expect_success 'checkout --to a new worktree' '
 	git rev-parse HEAD >expect &&
 	git checkout --detach --to here master &&
--=20
2.1.0.rc0.78.gc0d8480

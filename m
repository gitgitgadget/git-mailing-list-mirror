From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 25/32] checkout: clean up half-prepared directories in --to mode
Date: Sun, 28 Sep 2014 08:22:39 +0700
Message-ID: <1411867366-3821-26-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Ek-0002k3-0R
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbaI1BZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:25:10 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50604 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:25:07 -0400
Received: by mail-pa0-f47.google.com with SMTP id rd3so4870455pab.20
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V5q/ZlmWCn9XGwEDZHBCJVeaLWYPKnAb6+2LFQIV7vM=;
        b=nDqV8EpPU0eALxscNr1j0yr7EwKrwi38XLfCjkSgqNUsyH9vOtgwaXmQMxbJay7KVj
         42CD2hDhCstjLD28WGgZqKLRxzmBiIfrqdDfUxaBS0Me0IVqH3Kl2eolnu+l8qHiXTD+
         gMGRHTRfFg9OEfO3N+yUBKNYtXYYZZR1G8pn8aHTnz6FPNk1P18kTg/Ah2rFwM1FCpfr
         iDWX7KrL6LaKBdG0nwH49GmhHrRk/TPX9ckVNqFVH/sTnCIHLQB3iZtWt/KDSphEquyi
         n0KdYO/kCLPpOPwvRpcUOCoKEQle4OwtWDT2vUfObZnTnjGY35fW9drga+H3c1yLTHb2
         cT0w==
X-Received: by 10.66.191.7 with SMTP id gu7mr46566356pac.32.1411867507545;
        Sat, 27 Sep 2014 18:25:07 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id u6sm2302333pbs.7.2014.09.27.18.25.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:25:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:25:10 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257584>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 48 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 t/t2025-checkout-to.sh |  6 ++++++
 2 files changed, 54 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6d68913..bd0e2d5 100644
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
@@ -823,6 +824,35 @@ static int switch_branches(const struct checkout_o=
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
@@ -859,8 +889,15 @@ static int prepare_linked_checkout(const struct ch=
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
@@ -873,6 +910,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
+	junk_work_tree =3D xstrdup(path);
=20
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
@@ -902,9 +940,19 @@ static int prepare_linked_checkout(const struct ch=
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
index edd3404..e2db078 100755
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

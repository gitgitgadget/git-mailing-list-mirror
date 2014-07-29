From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/8] checkout --to: fix dangling pointers in remove_junk()
Date: Tue, 29 Jul 2014 20:50:28 +0700
Message-ID: <1406641831-2390-6-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:53:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7q0-0005kg-6t
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbaG2NxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:53:00 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59435 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbaG2Nw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:52:59 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so12448907pab.28
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ON+wGd4CvwPr+TbxFreGpUPN8jOea8jVZjV002xyVDI=;
        b=D+TIWlbTT5rHSiUl0p02yJRbmsAEqORLfaJDfw0mrOUpsqTZBSwaxIJJZwDkJL94mU
         cE4pbThPZnB+bGurh7NkimIeJ1frElhEcJ1gT5UPwu5g/I1uUYg/WMT6mwevEBEICVvz
         byGT4wrchmFpfN4jH9840ywLVtat3DX8EHL5c2VqPBuPF0YJ7cdeQU1FE18QzLcyeH2F
         7wvcT2YJLWZC+2ioIxqx/BlwBkFWApQKnwLmW9oR7r1O6Sk0JPavxBj792r9yxDD0gkN
         2zHWlfh/gpfHyigKqEev/5TXMsw/33Xj6hbv4ruKs4UUju9oK9SwFPbF2FVMeF7Jqz60
         DmIQ==
X-Received: by 10.66.66.35 with SMTP id c3mr2177435pat.79.1406641978803;
        Tue, 29 Jul 2014 06:52:58 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id da14sm77947742pac.24.2014.07.29.06.52.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:52:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:53:01 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254438>

junk_git_dir is set to sb_repo.buf. By the end of prepare_linked_checko=
ut(),
sb_repo is freed and so junk_git_dir points to nowhere. If the second
checkout command fails, is_junk remains non-zero, remove_junk() will
be called and try to clean junk_git_dir, which could be anything now
(if it does not crash the program).

The new test may pass even without this patch. But it does fail under
valgrind (without this patch) with "Invalid read of size 8" at the
right line.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 15 ++++++++++-----
 t/t2025-checkout-to.sh |  6 ++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0714856..173aab1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -820,8 +820,8 @@ static int switch_branches(const struct checkout_op=
ts *opts,
 	return ret || writeout_error;
 }
=20
-static const char *junk_work_tree;
-static const char *junk_git_dir;
+static char *junk_work_tree;
+static char *junk_git_dir;
 static int is_junk;
 static pid_t junk_pid;
=20
@@ -890,7 +890,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
=20
 	if (mkdir(sb_repo.buf, 0777))
 		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
-	junk_git_dir =3D sb_repo.buf;
+	junk_git_dir =3D xstrdup(sb_repo.buf);
 	is_junk =3D 1;
=20
 	/*
@@ -904,7 +904,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
-	junk_work_tree =3D path;
+	junk_work_tree =3D xstrdup(path);
=20
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
@@ -934,8 +934,13 @@ static int prepare_linked_checkout(const struct ch=
eckout_opts *opts,
 	cp.git_cmd =3D 1;
 	cp.argv =3D opts->saved_argv;
 	ret =3D run_command(&cp);
-	if (!ret)
+	if (!ret) {
 		is_junk =3D 0;
+		free(junk_work_tree);
+		free(junk_git_dir);
+		junk_work_tree =3D NULL;
+		junk_git_dir =3D NULL;
+	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index c6601a4..8a00310 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -12,6 +12,12 @@ test_expect_success 'checkout --to not updating path=
s' '
 	test_must_fail git checkout --to -- init.t
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
 	git rev-parse HEAD >expect &&
 	git checkout --detach --to here master &&
--=20
2.1.0.rc0.78.gc0d8480

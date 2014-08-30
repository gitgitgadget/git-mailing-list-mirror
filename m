From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/32] checkout: don't require a work tree when checking out into a new one
Date: Sat, 30 Aug 2014 15:34:01 +0700
Message-ID: <1409387642-24492-32-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe9O-0003WY-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbaH3Igl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54137 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbaH3Igj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:39 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so8126866pac.19
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x6iaGjAwMskqSl3I0u7RsXZ6Cpk9fvOjeB0np+eUdEw=;
        b=X5aotqNjeKKt5LKaoObKZaQemTnBEzFKr1VXTem1tr5L+4Y2/+75yCITtXNISRXyoL
         FmtxvsSnvqKTMeAHbG7GxbCDeKq14VfHHoYK2zSCKcpwXNSHUrU4W46weKZBta+IR9A/
         RzKzl0XJsH3//MpiUzoHg3IEJQ/A5VA2/FhIZqPSIJrmpA6I1qbanJjYczK7MwzgB6M2
         CRJsmR5mUqGLiwBNdehbeHx8UxDiVPhuY62eTSJI61V6WwQrittF8107kq8bdWhoI/uE
         ul3CvM5kon8buBX9mbjce/GiaAjQXBAe2Z/yvHTVDjCiIch4kUth7Rjpq2R5B7rj5ih0
         aZxw==
X-Received: by 10.68.139.99 with SMTP id qx3mr21844587pbb.75.1409387798725;
        Sat, 30 Aug 2014 01:36:38 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id pm1sm3171627pdb.58.2014.08.30.01.36.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:47 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256241>

=46rom: Dennis Kaarsemaker <dennis@kaarsemaker.net>

=46or normal use cases, it does not make sense for 'checkout' to work o=
n
a bare repository, without a worktree. But "checkout --to" is an
exception because it _creates_ a new worktree. Allow this option to
run on bare repositories.

People who check out from a bare repository should remember that
core.logallrefupdates is off by default and it should be turned back
on. `--to` cannot do this automatically behind the user's back because
some user may deliberately want no reflog.

=46or people interested in repository setup/discovery code,
is_bare_repository_cfg (aka "core.bare") is unchanged by this patch,
which means 'true' by default for bare repos. Fortunately when we get
the repo through a linked checkout, is_bare_repository_cfg is never
used. So all is still good.

[nd: commit message]

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     |  3 +++
 git.c                  |  2 +-
 t/t2025-checkout-to.sh | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f28b4a..b88c646 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1361,6 +1361,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	if (opts.new_worktree_mode)
 		opts.new_worktree =3D NULL;
=20
+	if (!opts.new_worktree)
+		setup_work_tree();
+
 	if (conflict_style) {
 		opts.merge =3D 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/git.c b/git.c
index 5b6c761..7426651 100644
--- a/git.c
+++ b/git.c
@@ -383,7 +383,7 @@ static struct cmd_struct commands[] =3D {
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format },
-	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout", cmd_checkout, RUN_SETUP },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 796472b..9f701a1 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -81,4 +81,19 @@ test_expect_success 'not die on re-checking out curr=
ent branch' '
 	)
 '
=20
+test_expect_success 'checkout --to from a bare repo' '
+	(
+		git clone --bare . bare &&
+		cd bare &&
+		git checkout --to ../there2 -b bare-master master
+	)
+'
+
+test_expect_success 'checkout from a bare repo without --to' '
+	(
+		cd bare &&
+		test_must_fail git checkout master
+	)
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480

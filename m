From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 32/32] checkout: don't require a work tree when checking out into a new one
Date: Wed,  9 Jul 2014 14:33:17 +0700
Message-ID: <1404891197-18067-33-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mQS-0004gN-SF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbaGIHgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:36:20 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:65123 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbaGIHgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:36:19 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so8819253pad.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=56h5S0ppezW3mwrEGTjgqL0Ds6aV0dIa4Uj2UH0knI8=;
        b=WMnpcathEizmyNPoDGvkhvOXSMZgV01eQ7Sitvb3DWCoqowrJAowVog+Ne/tWgRgPc
         LfcXBlIvd7oVSSjIMXn8io0SrdLVwJODT8inNTR5CZ8XWZuceohk9lnR31B/Jra9iES0
         KFEUoHz0l56HwTuRiBVN2qlq8glSSVVOPei5KeKuyqk3XSxZBzlsAS9sNDrOLx89j9dW
         Ey1PQgwI1lKBmGjnk1h5vNlqd8qa/0SrMs/NE3ag/dlT7/Vja2e+hvUK7l9wKFVWjpRl
         9w9GwoFvHD6aBFiQ0NAHR7jypRSRjHW2Fm3ygVxctWRkLKBjESwdPXBHp0EYB0mTn1sW
         FOmg==
X-Received: by 10.66.191.9 with SMTP id gu9mr39591472pac.27.1404891379415;
        Wed, 09 Jul 2014 00:36:19 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id py7sm57920227pbb.78.2014.07.09.00.36.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:36:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:36:16 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253107>

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
index 98a2f5f..fd89d93 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1353,6 +1353,9 @@ int cmd_checkout(int argc, const char **argv, con=
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
index d6b4a55..04d6c88 100644
--- a/git.c
+++ b/git.c
@@ -384,7 +384,7 @@ static struct cmd_struct commands[] =3D {
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format },
-	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout", cmd_checkout, RUN_SETUP },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 2d35a9b..a219851 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -54,4 +54,19 @@ test_expect_success 'detach if the same branch is al=
ready checked out' '
 	)
 '
=20
+test_expect_success 'checkout --to from a bare repo' '
+	(
+		git clone --bare . bare &&
+		cd bare &&
+		git checkout --to ../there2 master
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
1.9.1.346.ga2b5940

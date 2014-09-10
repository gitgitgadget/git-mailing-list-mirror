From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 31/32] checkout: don't require a work tree when checking out into a new one
Date: Thu, 11 Sep 2014 05:42:07 +0700
Message-ID: <1410388928-32265-32-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqdG-0002g7-4X
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbaIJWoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:54 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34816 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWox (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:53 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so7185854pde.40
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sfAhJGXXNbpC4b8XDF8rV2vxCp+daj2id3RUyW3+h94=;
        b=fArDuI4vnnHFcGnlzlGv655qEG0S6CDeyze8+5+kXeNL0//CJgRNzMid3YlUE2ZpYV
         CzS1Lj85vSsk2m36NOwqGfdJf77J2ghgr2ntEvxrPv3f0IqgyEn3Xl3sIuBO9VtBanU+
         SBV/tSxtceEOR4FkUbvHLNAzhfPo0gWq6q/JMjOU85NwCIhYVmM/VWSuKLVntrgO0jzO
         e8XD/SZUhhUbjZex2oGuDZUBIG2rmvEnFe3f4S8QqPvJNvRTJpSZqB6Acnya9r+MIZ08
         3K9LyfUyIOiPSKi6uQ8WWo35h0E+wTCUAKt2qceID920/iwQ5W7R0chVGZw46fdX2Xgo
         9JXw==
X-Received: by 10.68.203.5 with SMTP id km5mr41100768pbc.91.1410389093219;
        Wed, 10 Sep 2014 15:44:53 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id ka1sm14782782pbd.70.2014.09.10.15.44.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:45:12 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256808>

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
index f419ddf..6106b81 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1360,6 +1360,9 @@ int cmd_checkout(int argc, const char **argv, con=
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
index 5d28f9e..2cddbf1 100755
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

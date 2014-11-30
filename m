From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/34] checkout: do not fail if target is an empty directory
Date: Sun, 30 Nov 2014 15:24:58 +0700
Message-ID: <1417335899-27307-34-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:30:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuztx-0000nS-UR
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbaK3Iai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:30:38 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:39831 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbaK3Iah (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:30:37 -0500
Received: by mail-pd0-f181.google.com with SMTP id v10so3603877pde.26
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Nnr8tRqRnGe/bMqSLrNWbhiHqtzpCc1o4kqojYCBfv4=;
        b=oLKyZizn0NxXhMfx1R4fAXDg9Tn7nAAlE7W/n8MCA0M5Zrq9RAezVrHkDiUXKIvt33
         cqrLiXADHeX29mOYw5w9z508a5jpQ21Krimavt8tj4ZUHnyMtcvXCAD4G2p5WsM5Hwew
         BSbGLexdIHXrEIoH3B/l5t6TFcQfk0HgfCksZYmz1cQGDLe+cV3LEBqFIabHb+3e2HJb
         tELBWjC+zOY/7nQxGAJ94GY5a+kTGkWM5dLOu/65UThvGHDq3xJ7UqOkVf9ocs8va++h
         z4PcuZexIKuz0ASZviqzBxBaaT0yE3Ht/BBDjQ/eZ6Rwe7jh7zlXk3xoJ9USTGvc3jZh
         RoEA==
X-Received: by 10.68.189.136 with SMTP id gi8mr89353324pbc.54.1417336236976;
        Sun, 30 Nov 2014 00:30:36 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ps2sm14339300pdb.62.2014.11.30.00.30.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:30:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:30:34 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260420>

=46rom: Max Kirillov <max@max630.net>

Non-recursive checkout creates empty directpries in place of submodules=
=2E
If then I try to "checkout --to" submodules there, it refuses to do so,
because directory already exists.

=46ix by allowing checking out to empty directory. Add test and modify =
the
existing one so that it uses non-empty directory.

Signed-off-by: Max Kirillov <max@max630.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 2 +-
 t/t2025-checkout-to.sh | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c5276c..953b763 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -865,7 +865,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
=20
 	if (!new->commit)
 		die(_("no branch specified"));
-	if (file_exists(path))
+	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
=20
 	len =3D strlen(path);
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index eddd325..915b506 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -13,10 +13,15 @@ test_expect_success 'checkout --to not updating pat=
hs' '
 '
=20
 test_expect_success 'checkout --to an existing worktree' '
-	mkdir existing &&
+	mkdir -p existing/subtree &&
 	test_must_fail git checkout --detach --to existing master
 '
=20
+test_expect_success 'checkout --to an existing empty worktree' '
+	mkdir existing_empty &&
+	git checkout --detach --to existing_empty master
+'
+
 test_expect_success 'checkout --to refuses to checkout locked branch' =
'
 	test_must_fail git checkout --to zere master &&
 	! test -d zere &&
--=20
2.1.0.rc0.78.gc0d8480

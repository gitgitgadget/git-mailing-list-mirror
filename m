From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] reset: optionally setup worktree and refresh index on --mixed
Date: Sun, 16 Feb 2014 09:28:03 +0700
Message-ID: <1392517683-29518-1-git-send-email-pclouds@gmail.com>
References: <1392455661-20665-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, patrick@parcs.ath.cx,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 03:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WErT0-0006IC-FD
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 03:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbaBPC1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 21:27:55 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40836 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbaBPC1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 21:27:54 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so13922498pab.38
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 18:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dLeK7Qn5MeLVMJMwmdpFyjap8hDN/VwWf0s07H72b5Y=;
        b=LSXivqJKhP/Zh0+hZyiDK/UpXT+VmAnSqK+zoecEFfEdvKBpKYuRsPxSKIsqa3qDUK
         I9Yhq1OgSU0jTzs0Ykdo8SqWq/Vxki9BcPE8or8pyVK9fm9RCIN5ixT4D5OTxKysnDlI
         YIJ7LUtKbG75r16yfTVHS39Fb2ujjDU7kEwd+/ZLsDj9NGh6IJ/CBnxIHunfMitQBJgx
         GhEtzWY5WrQyoUj27hQyT1+/17PBbCvQBt0X7S+ignZ4pZZBOdL8L4xHZHs5S7rHeEw/
         uoCuSp/b2lRTdIO7xPWcbMPxppLX3FKPGuIxu00i7cBkZxE8kiZulEskdd9eRm41DQQA
         MmPA==
X-Received: by 10.68.185.1 with SMTP id ey1mr18393698pbc.33.1392517673679;
        Sat, 15 Feb 2014 18:27:53 -0800 (PST)
Received: from lanh ([115.73.213.123])
        by mx.google.com with ESMTPSA id jk16sm31570818pbb.34.2014.02.15.18.27.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 18:27:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Feb 2014 09:28:03 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392455661-20665-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242206>

Refreshing index requires work tree. So we have to options: always set
up work tree (and refuse to reset if failing to do so), or make
refreshing index optional.

As refreshing index is not the main task, it makes more sense to make
it optional.

Reported-by: Patrick Palka <patrick@parcs.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reset.c  |  7 ++++---
 t/t7102-reset.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6004803..a991344 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	if (reset_type =3D=3D NONE)
 		reset_type =3D MIXED; /* by default */
=20
-	if (reset_type !=3D SOFT && reset_type !=3D MIXED)
+	if (reset_type !=3D SOFT && (reset_type !=3D MIXED || get_git_work_tr=
ee()))
 		setup_work_tree();
=20
 	if (reset_type =3D=3D MIXED && is_bare_repository())
@@ -340,8 +340,9 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 			int flags =3D quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, sha1))
 				return 1;
-			refresh_index(&the_index, flags, NULL, NULL,
-				      _("Unstaged changes after reset:"));
+			if (get_git_work_tree())
+				refresh_index(&the_index, flags, NULL, NULL,
+					      _("Unstaged changes after reset:"));
 		} else {
 			int err =3D reset_index(sha1, reset_type, quiet);
 			if (reset_type =3D=3D KEEP && !err)
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 8d4b50d..ee117e2 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -535,4 +535,15 @@ test_expect_success 'reset with paths accepts tree=
' '
 	git diff HEAD --exit-code
 '
=20
+test_expect_success 'reset --mixed sets up work tree' '
+	git init mixed_worktree &&
+	(
+		cd mixed_worktree &&
+		test_commit dummy
+	) &&
+	: >expect &&
+	git --git-dir=3Dmixed_worktree/.git --work-tree=3Dmixed_worktree rese=
t >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd

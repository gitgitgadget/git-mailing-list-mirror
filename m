From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup: do not create $X/gitdir unnecessarily when accessing git file $X
Date: Mon,  2 Nov 2015 20:08:26 +0100
Message-ID: <1446491306-13493-1-git-send-email-pclouds@gmail.com>
References: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
	kyle@kyleam.com, sunshine@sunshineco.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 20:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtKTU-0005rp-A0
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 20:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbbKBTIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 14:08:55 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35713 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbKBTIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 14:08:40 -0500
Received: by wmll128 with SMTP id l128so69371937wml.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=n6b2Ag80is91GZRph0hcCRwjGDJurWROgTzwOpSFZdk=;
        b=w/EEg6PkfkWS3C0ug5tesx1iO2eia+Ku+nJfDVePhmVCi3tL2ADXUXCET3R48FuBoA
         7hCdanHpyOXmrU95M5BVqFcv86lutoEGFOaUCm3aNcSf5XBZoET1wgxC8Riz0wh8NyiM
         zdvSt/k0UBdDMyfXekihLXSegXBx7kYF3IzTCDZ/Ovd5Z6ur+v2X3FY8IGKIVI3wzfLD
         YdQWq5sQ5yALN1wRx9eHoPfISQM4dLxJEultJRn+Jrv8ZPq+8u1m6THxKALRNxXaKo/L
         CDfPb9BuHkCO/hQwc2Slh5KZ9M9SkfBBaW/jHtN/7WSA9xsg42MS4lPZgEEE8yOMTjP7
         wvpg==
X-Received: by 10.28.132.13 with SMTP id g13mr15521198wmd.71.1446491319099;
        Mon, 02 Nov 2015 11:08:39 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id m143sm19632191wmb.1.2015.11.02.11.08.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Nov 2015 11:08:37 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280709>

$X/gitdir is created, or refreshed, in order to keep a linked worktree
from being pruned. But while git file is used as the foundation for
linked worktrees, it's used for other purposes as well and we should
not create $X/gitdir in those cases.

Tighten the check. Only update an existing file, which is an
indication this is a linked worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c            | 2 +-
 t/t0002-gitfile.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index d343725..b30d923 100644
--- a/setup.c
+++ b/setup.c
@@ -440,7 +440,7 @@ static void update_linked_gitdir(const char *gitfil=
e, const char *gitdir)
 	struct stat st;
=20
 	strbuf_addf(&path, "%s/gitdir", gitdir);
-	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
+	if (!stat(path.buf, &st) && st.st_mtime + 24 * 3600 < time(NULL))
 		write_file(path.buf, "%s", gitfile);
 	strbuf_release(&path);
 }
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 9670e8c..b1b59f2 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -99,6 +99,13 @@ test_expect_success 'check rev-list' '
 	test "$SHA" =3D "$(git rev-list HEAD)"
 '
=20
+test_expect_success '$REAL/gitdir is not created on ordinary git file'=
 '
+	echo "gitdir: $REAL" >expected &&
+	test_cmp expected .git &&
+	git status &&
+	! test -f "$REAL"/gitdir
+'
+
 test_expect_success 'setup_git_dir twice in subdir' '
 	git init sgd &&
 	(
--=20
2.2.0.513.g477eb31

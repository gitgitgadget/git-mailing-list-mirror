From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 5/6] clone: allow --local from a linked checkout
Date: Mon, 28 Sep 2015 20:06:15 +0700
Message-ID: <1443445576-29526-6-git-send-email-pclouds@gmail.com>
References: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
 <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 15:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgY8p-0005wa-1R
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933681AbbI1NGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 09:06:45 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33497 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933585AbbI1NGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:06:45 -0400
Received: by pacex6 with SMTP id ex6so174503014pac.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2GmJrN8tsE46KlcD01Ss8DYu0x7eqI0VNtRAdWs3qtk=;
        b=o5MbjBeVztQG9wUT2Sj0roiV9tTW29WfdnbBM2IvbRmt+kbWFZaO7HXFkUUB/Jm/fH
         YH006QIEqlLaK9fomkRcOi8KzKZVtcJ2mjUX0UaFUApWlSz9HT6TYyl2bkykgykwySpZ
         R+bvMdaNqz0++1Ort2fEFazuIDuLP+jBEqCOwssSdkDv1laqRWJs5pr1FlEyZaffoDen
         s0aF6vxN/LN8tjnk80NOLFcEEld3fz9bK8TDxYFfiA04BSFn4Yl/ohhYxPkve19nHtWF
         gXJWbuheG6bLbTsVRpKb7aoM3AsZVEFYGPFtFUYuuRKcn6cQg3NLV+UtJ2Zi5YdnTy8x
         PrGQ==
X-Received: by 10.68.216.193 with SMTP id os1mr11570171pbc.110.1443445604683;
        Mon, 28 Sep 2015 06:06:44 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id ey3sm19399857pbd.28.2015.09.28.06.06.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 06:06:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 20:07:19 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278720>

Noticed-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c         | 6 ++++--
 t/t2025-worktree-add.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 578da85..39d4adf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -424,8 +424,10 @@ static void clone_local(const char *src_repo, cons=
t char *dest_repo)
 	} else {
 		struct strbuf src =3D STRBUF_INIT;
 		struct strbuf dest =3D STRBUF_INIT;
-		strbuf_addf(&src, "%s/objects", src_repo);
-		strbuf_addf(&dest, "%s/objects", dest_repo);
+		get_common_dir(&src, src_repo);
+		get_common_dir(&dest, dest_repo);
+		strbuf_addstr(&src, "/objects");
+		strbuf_addstr(&dest, "/objects");
 		copy_or_link_directory(&src, &dest, src_repo, src.len);
 		strbuf_release(&src);
 		strbuf_release(&dest);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 8267411..3694174 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -193,4 +193,9 @@ test_expect_success '"add" -B/--detach mutually exc=
lusive' '
 	test_must_fail git worktree add -B poodle --detach bamboo master
 '
=20
+test_expect_success 'local clone from linked checkout' '
+	git clone --local here here-clone &&
+	( cd here-clone && git fsck )
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31

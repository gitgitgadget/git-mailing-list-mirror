From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/5] clone: allow --local from a linked checkout
Date: Sun, 13 Sep 2015 08:02:27 +0700
Message-ID: <1442106148-22895-5-git-send-email-pclouds@gmail.com>
References: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
 <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavgk-0006lM-IP
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbbIMBCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:02:33 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34191 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802AbbIMBCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:02:31 -0400
Received: by padhy16 with SMTP id hy16so108622777pad.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2GmJrN8tsE46KlcD01Ss8DYu0x7eqI0VNtRAdWs3qtk=;
        b=dxlbMH+xJIymy47j1m6OBUz4zI+K36xoGfZ1PFpZNbtbTMFOkUJZuXtpGyDSs4pX+x
         YwA2PS2kbr9fiuAcg275BE8JCLA8Z39MsSn2SlJ6m6i50ChP/hlwWS3QI9ywFvRNtz9n
         fdnqbNeHBhsQ9d2OUSqxKNntiecBA2MjJjAKT71GQsAS2Le3rJezr6bMmKdkTF5DvXv7
         ejofnupIyAek/2+WNP0KKtWmeFMy3fKiPbtbH5wNSv6DBOswU2yUesjYok/dHvVzJ6xS
         B/uJHCJD81GyHz9bpy1AxlHQhZhumczIrrFpjrQ4zkIwhkBDiPak7oli0SiaL2wUnlfJ
         0z4A==
X-Received: by 10.68.69.40 with SMTP id b8mr16346416pbu.84.1442106151462;
        Sat, 12 Sep 2015 18:02:31 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id fm5sm7958043pbb.60.2015.09.12.18.02.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:02:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:02:50 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277746>

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

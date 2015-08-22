From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/5] clone: allow --local from a linked checkout
Date: Sat, 22 Aug 2015 07:40:01 +0700
Message-ID: <1440204002-7638-5-git-send-email-pclouds@gmail.com>
References: <20150715132552.GA28574@lanh>
 <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 02:41:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSwsA-0005UL-D8
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbbHVAlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 20:41:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33001 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbbHVAlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:41:21 -0400
Received: by pacgr6 with SMTP id gr6so4505393pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F4nZY8m1E+rZM+/O6x0ZTQ6i8t8r3+eH3wRjqoQZYDU=;
        b=Ig7/RCnLZ/79G5iCU9RhkKQoCw251L9TAIjQGweocLuhlfUZZGgVWVpIIM5VDncnsp
         RtYgh0cLM6/uutUZGe9QBcQ4jadtKKHQrsc7YvzJXDF8NnDuOwBsRJNgm7xInOKRCXUH
         hSAE/SGDFoHmTVbsOasUYQW/HQHPJwJ1sxYNLoEpOWTLQY0aG1OpnAf3d0L4dusDOzrU
         kGLnAFIg/shP0Gp3RQJQ5Xn0eL6nKkhtU4LQC2gEhFr6BB0KgsKNFpxYJ91avYc6TYoC
         vW7r1R3Oq1Zx7I1iV2daq/kMnpsbLs4KkD+U+AtZGg34Snb9kGp0aziqVKFzD4e1/aFR
         4OXQ==
X-Received: by 10.66.144.200 with SMTP id so8mr22132401pab.63.1440204080990;
        Fri, 21 Aug 2015 17:41:20 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id rg10sm9095435pbc.33.2015.08.21.17.41.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 17:41:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 07:41:18 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276350>

Noticed-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c         | 6 ++++--
 t/t2025-worktree-add.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 578da85..836fb64 100644
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
+		strbuf_addf(&dest, "/objects");
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

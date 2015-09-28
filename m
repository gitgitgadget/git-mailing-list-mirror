From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 6/6] clone: better error when --reference is a linked checkout
Date: Mon, 28 Sep 2015 20:06:16 +0700
Message-ID: <1443445576-29526-7-git-send-email-pclouds@gmail.com>
References: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
 <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 15:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgY8u-00068E-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933717AbbI1NGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 09:06:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36015 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933585AbbI1NGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:06:50 -0400
Received: by pablk4 with SMTP id lk4so77594195pab.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0DZIfJWsiCyOFS4K1C9W4Mgs82fwUvUqqi2G5yo7MEI=;
        b=0E9TrWyUY5coxORUPnXV637/eW1O/BqV7Xg77VhCNpWCGybhosSyffar0MRbedDK7S
         gXPmU1nDU5pZdbOrMYKH4Q/EqIfxs5HJQLbYudiVuC2xW7nxbhFJIFe92i4BfLbLCaj0
         2aVsIXu5XP2sGGJ0ZoYzxU4Oi4QdGPMxHPxEva/b2gSpxiamndtdQwFrU0vPILxBkDdL
         S2yyT5QVdjvVjvu7ZD4qfrUsP8Vs4ul5BvlHjQB4J8ABPpuMfTbz9lAExo4zT1lWouKh
         P4Id6lL7QlAE0dt8zi1Om0HzjcAyNz7TXJG4WUqc6IU/6hpaVOv3kR5j4KjCp8wEQncT
         xjOA==
X-Received: by 10.68.96.197 with SMTP id du5mr26392157pbb.32.1443445610030;
        Mon, 28 Sep 2015 06:06:50 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id hq8sm19537828pad.35.2015.09.28.06.06.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 06:06:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 20:07:24 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278722>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 39d4adf..3e14491 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -294,9 +294,14 @@ static int add_one_reference(struct string_list_it=
em *item, void *cb_data)
 		char *ref_git_git =3D mkpathdup("%s/.git", ref_git);
 		free(ref_git);
 		ref_git =3D ref_git_git;
-	} else if (!is_directory(mkpath("%s/objects", ref_git)))
+	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
+		struct strbuf sb =3D STRBUF_INIT;
+		if (get_common_dir(&sb, ref_git))
+			die(_("reference repository '%s' as a linked checkout is not suppor=
ted yet."),
+			    item->string);
 		die(_("reference repository '%s' is not a local repository."),
 		    item->string);
+	}
=20
 	if (!access(mkpath("%s/shallow", ref_git), F_OK))
 		die(_("reference repository '%s' is shallow"), item->string);
--=20
2.3.0.rc1.137.g477eb31

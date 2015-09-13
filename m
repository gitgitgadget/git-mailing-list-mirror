From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/5] clone: better error when --reference is a linked checkout
Date: Sun, 13 Sep 2015 08:02:28 +0700
Message-ID: <1442106148-22895-6-git-send-email-pclouds@gmail.com>
References: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
 <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:02:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavgp-0006w9-84
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbbIMBCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:02:37 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35353 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbbIMBCg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:02:36 -0400
Received: by pacfv12 with SMTP id fv12so110682660pac.2
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0DZIfJWsiCyOFS4K1C9W4Mgs82fwUvUqqi2G5yo7MEI=;
        b=EkxwafiRmo06NjLhc4O0q8tbVD0x1s9EnaaySy1o7QVzQoylgVP1l/i6QHo20KU089
         5+u5wyUhIphwYdjYA140bjKC0Bju+CXqPovDbQzKUOfpYsY2ZyV0LJn5AtmI8PCkyiEg
         584fM1xFINwijvd6vSOFKqaVFNe7OvAxMp2EgJyStjNzr4El/xeYyL4pL14QNt5XfhvR
         tmFjbz4ACKbCO2TYLwLAKst0jupJEHTBiCxIqZg10zWNXpTlG+7HG4j8eD7RdO/FhVCf
         Mw2OUXl71SlAw+YbToN/YkcuUGxpXv1RRapdJLbLV3A5MG3l+sU3GFGbfZactkifK8io
         D0TA==
X-Received: by 10.69.26.5 with SMTP id iu5mr3186535pbd.12.1442106156563;
        Sat, 12 Sep 2015 18:02:36 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id e6sm7992642pas.35.2015.09.12.18.02.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:02:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:02:55 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277748>

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

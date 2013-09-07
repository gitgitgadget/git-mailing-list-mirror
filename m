From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/12] index-pack: skip looking for ofs-deltas in v4 as they are not allowed
Date: Sat,  7 Sep 2013 17:43:18 +0700
Message-ID: <1378550599-25365-12-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFxV-0003BW-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab3IGKli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:38 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:53655 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:37 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so4391606pab.10
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wooU6CGAImlTwYf9zTj05JJ4EFGOMjjXKVuiVvcwwXE=;
        b=K0WE9WmsqHco34h14Fo5hpGPIL22NF/Pnev41b3tNqTEq5HtEVZ6miSV0TtSBO6v1h
         21idaXmbCygnwRXyambgOuge5vmmWB8m8HTwQTrImIZ9OGtNsYaXKEBSYnMAbcuObGrq
         1x8oXXng9shBsqiN9yoYokIAgNGXn584aE0SjZjGdHFSwhuP5kW52mjoQB7xbbTwElX0
         87dyGRl6LeW3YNoPFVo6/2hhibo9onyqMZe0WAlXny66IVoR1AwPf0kNTWcrWCCjcjUH
         6Ckk2WvRh+V5RNHHhvp6agpC76UxY2H170Mm2kZm/vrRJHUFaNvaK+AB7NDaJY9t5x9s
         Giig==
X-Received: by 10.67.4.197 with SMTP id cg5mr8912725pad.10.1378550496602;
        Sat, 07 Sep 2013 03:41:36 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id ef10sm3972269pac.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:44 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234129>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 33722e1..1fa74f4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1171,10 +1171,13 @@ static struct base_data *find_unresolved_deltas=
_1(struct base_data *base,
 		find_delta_children(&base_spec,
 				    &base->ref_first, &base->ref_last, OBJ_REF_DELTA);
=20
-		memset(&base_spec, 0, sizeof(base_spec));
-		base_spec.offset =3D base->obj->idx.offset;
-		find_delta_children(&base_spec,
-				    &base->ofs_first, &base->ofs_last, OBJ_OFS_DELTA);
+		if (!packv4) {
+			memset(&base_spec, 0, sizeof(base_spec));
+			base_spec.offset =3D base->obj->idx.offset;
+			find_delta_children(&base_spec,
+					    &base->ofs_first, &base->ofs_last,
+					    OBJ_OFS_DELTA);
+		}
=20
 		if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
 			free(base->data);
--=20
1.8.2.83.gc99314b

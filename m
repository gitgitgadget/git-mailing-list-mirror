From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pack-objects: no crc check when the cached version is used
Date: Fri, 13 Sep 2013 18:03:00 +0700
Message-ID: <1379070180-15947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 13:00:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKR6U-0006au-9K
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 12:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab3IMK7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Sep 2013 06:59:54 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56741 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab3IMK7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 06:59:53 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so1104619pdi.14
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=7ACSS+40frXw8U0FLDFJBoZ9yTBFrxhCQIMJmyQwIHY=;
        b=OdvHLPvev1hBD+J7KQ2XiDBRwbdBrXv0JkzhcAHXKzHIkfyvYu7DHYqrIQEKLG8liC
         TNsnY4tQCkhxHTXBQ+GzPuXRsAQI1PNVPqhaHIouO1pyokN6gQHBjimJgg312cyQW5As
         A/3UWvsqwXHxJcZj7eSRMbycKPSxdj1LyxXZeg2dHZPNs2jOlM0GNy5QFOrDg2+5aX9l
         ueT3HIp5dGKwUbqIolY1wW8cyMyd0/9wLlAKuvnRlv7EF2XkjUyN3oZbUouNcmjkjOUd
         FRMR+6fGPAj8vQtV7+MsyOwrKj1TIOKJOkmi40VbiedY2OcnW3Brf8Kxsi9vO/gF1crq
         JS5Q==
X-Received: by 10.68.106.99 with SMTP id gt3mr12853782pbb.116.1379069993269;
        Fri, 13 Sep 2013 03:59:53 -0700 (PDT)
Received: from lanh ([115.73.255.86])
        by mx.google.com with ESMTPSA id xn12sm17271743pac.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 03:59:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Sep 2013 18:03:07 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234741>

Current code makes pack-objects always do check_pack_crc() in
unpack_entry() even if right after that we find out there's a cached
version and pack access is not needed. Swap two code blocks, search
for cached version first, then check crc.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8c2d1ed..4955724 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2126,6 +2126,16 @@ void *unpack_entry(struct packed_git *p, off_t o=
bj_offset,
 		int i;
 		struct delta_base_cache_entry *ent;
=20
+		ent =3D get_delta_base_cache_entry(p, curpos);
+		if (eq_delta_base_cache_entry(ent, p, curpos)) {
+			type =3D ent->type;
+			data =3D ent->data;
+			size =3D ent->size;
+			clear_delta_base_cache_entry(ent);
+			base_from_cache =3D 1;
+			break;
+		}
+
 		if (do_check_packed_object_crc && p->index_version > 1) {
 			struct revindex_entry *revidx =3D find_pack_revindex(p, obj_offset)=
;
 			unsigned long len =3D revidx[1].offset - obj_offset;
@@ -2140,16 +2150,6 @@ void *unpack_entry(struct packed_git *p, off_t o=
bj_offset,
 			}
 		}
=20
-		ent =3D get_delta_base_cache_entry(p, curpos);
-		if (eq_delta_base_cache_entry(ent, p, curpos)) {
-			type =3D ent->type;
-			data =3D ent->data;
-			size =3D ent->size;
-			clear_delta_base_cache_entry(ent);
-			base_from_cache =3D 1;
-			break;
-		}
-
 		type =3D unpack_object_header(p, &w_curs, &curpos, &size);
 		if (type !=3D OBJ_OFS_DELTA && type !=3D OBJ_REF_DELTA)
 			break;
--=20
1.8.2.82.gc24b958

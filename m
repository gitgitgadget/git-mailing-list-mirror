From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/21] pack-objects: recognize v4 as pack source
Date: Wed, 11 Sep 2013 13:06:10 +0700
Message-ID: <1378879582-15372-10-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdas-0005vW-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab3IKGH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:58 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:58719 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab3IKGH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:58 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so8612127pbc.16
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+Yj7qLFlhekfiLl9ZmJc94eeXkDfeulpIbzBozO7fXY=;
        b=OxKDpy/wWDDTrCTFBuOGAGRKE7ITMZVmLFp9yGbabRg/6jNUHaFTpAJuNmv9/R7JEH
         uv9UWI45wyaK7xIzypkh014Mbt5LcJKHTry9zM7DIZbPpgjRK9i4q0bSd18u05E13F5w
         6nLPagRqBYBWvfhs80dNuVP5uxuE5RlLkGeLdfdct5NQ6kenCClcr5dxXfuWRSR+LgN1
         9QltVSpbn9/Dhxp0ohuLZcq5m9iE977zr5CpoT5W/iJB7gGrn8zDx22/wMNb7Ah7jQSz
         atXyelbuQQeLrGLzgnNvIEU/7nbtAdoysNsOqfLwNDPpbAs4czTSHS5TcZG1EN/GW/gD
         hL5A==
X-Received: by 10.68.201.69 with SMTP id jy5mr28870598pbc.6.1378879677661;
        Tue, 10 Sep 2013 23:07:57 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ve9sm27450085pbc.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:50 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234533>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 28 +++++++++++++++++++++++++---
 packv4-parse.h         |  2 ++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 63c9b9e..ac25973 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -19,6 +19,8 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packv4-create.h"
+#include "packv4-parse.h"
+#include "varint.h"
=20
 static const char *pack_usage[] =3D {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-lis=
t]"),
@@ -1397,9 +1399,14 @@ static void check_object(struct object_entry *en=
try)
 		 * We want in_pack_type even if we do not reuse delta
 		 * since non-delta representations could still be reused.
 		 */
-		used =3D unpack_object_header_buffer(buf, avail,
-						   &entry->in_pack_type,
-						   &entry->size);
+		if (p->version < 4)
+			used =3D unpack_object_header_buffer(buf, avail,
+							   &entry->in_pack_type,
+							   &entry->size);
+		else
+			used =3D pv4_unpack_object_header_buffer(buf, avail,
+							       &entry->in_pack_type,
+							       &entry->size);
 		if (used =3D=3D 0)
 			goto give_up;
=20
@@ -1417,7 +1424,22 @@ static void check_object(struct object_entry *en=
try)
 				goto give_up;
 			unuse_pack(&w_curs);
 			return;
+		case OBJ_PV4_COMMIT:
+		case OBJ_PV4_TREE:
+			entry->type =3D entry->in_pack_type - 8;
+			entry->in_pack_header_size =3D used;
+			unuse_pack(&w_curs);
+			return;
 		case OBJ_REF_DELTA:
+			if (p->version =3D=3D 4) {
+				const unsigned char *sha1, *cp;
+				cp =3D buf + used;
+				sha1 =3D get_sha1ref(p, &cp);
+				entry->in_pack_header_size =3D cp - buf;;
+				if (reuse_delta && !entry->preferred_base)
+					base_ref =3D sha1;
+				break;
+			}
 			if (reuse_delta && !entry->preferred_base)
 				base_ref =3D use_pack(p, &w_curs,
 						entry->in_pack_offset + used, NULL);
diff --git a/packv4-parse.h b/packv4-parse.h
index 52f52f5..d674a3f 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -14,6 +14,8 @@ unsigned long pv4_unpack_object_header_buffer(const u=
nsigned char *base,
 					      unsigned long len,
 					      enum object_type *type,
 					      unsigned long *sizep);
+const unsigned char *get_sha1ref(struct packed_git *p,
+				 const unsigned char **bufp);
=20
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs=
,
 		     off_t offset, unsigned long size);
--=20
1.8.2.82.gc24b958

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/11] pack-write.c: add pv4_encode_in_pack_object_header
Date: Sun,  8 Sep 2013 22:04:14 +0700
Message-ID: <1378652660-6731-6-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgUv-0003MZ-B0
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab3IHPBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:01:53 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34727 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3IHPBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:01:52 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5196527pdj.15
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fvvuRpMQOxnH8Oc2YAz1rs2qLNveFEcYi8tpnMPuxnc=;
        b=wVuSGWE3IJpwE7VMQ6dGNmcIf2ptcoe0Kv37UOAUCZ2zWbVMU0LEziwp1LsCk7+Ikf
         vB5hjg/kXfCPbbbJY4Ycreq1GVWx8QLuyumGKvdjt5ZZAWlWIy5NAsbksCa/X2a0zt7Y
         8Tr3vHFx3rOEfKoFwzG+JUthNXcKXf1HyOme6e8JXp+XcbIvH1LVOpHHh+LW5mC0NOln
         gpjW9gLVbTtRRG5Xaab4rS+9v3eg2LO+GhymbzhGBOTDUdD/GyHYFecFrmxqwUquL3k2
         bhv20xlq25wznq4yD9qeJ05xM9qR7Mp4d1CVMb9j2rERq9jcH5SiTCkxMkWGz5mg5Fsw
         itiA==
X-Received: by 10.66.152.102 with SMTP id ux6mr14767567pab.79.1378652512130;
        Sun, 08 Sep 2013 08:01:52 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id gg10sm10440480pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:01:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:05:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234244>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pack-write.c | 29 +++++++++++++++++++++++++++++
 pack.h       |  1 +
 2 files changed, 30 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 88e4788..6f11104 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "varint.h"
=20
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -340,6 +341,34 @@ int encode_in_pack_object_header(enum object_type =
type, uintmax_t size, unsigned
 	return n;
 }
=20
+/*
+ * The per-object header is a pretty dense thing, which is
+ *  - first byte: low four bits are "size", then three bits of "type",
+ *    and the high bit is "size continues".
+ *  - each byte afterwards: low seven bits are size continuation,
+ *    with the high bit being "size continues"
+ */
+int pv4_encode_in_pack_object_header(enum object_type type,
+				     uintmax_t size, unsigned char *hdr)
+{
+	uintmax_t val;
+	if (type < OBJ_COMMIT || type > OBJ_PV4_TREE || type =3D=3D OBJ_OFS_D=
ELTA)
+		die("bad type %d", type);
+
+	/*
+	 * We allocate 4 bits in the LSB for the object type which
+	 * should be good for quite a while, given that we effectively
+	 * encodes only 5 object types: commit, tree, blob, delta,
+	 * tag.
+	 */
+	val =3D size;
+	if (MSB(val, 4))
+		die("fixme: the code doesn't currently cope with big sizes");
+	val <<=3D 4;
+	val |=3D type;
+	return encode_varint(val, hdr);
+}
+
 struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 {
 	char tmpname[PATH_MAX];
diff --git a/pack.h b/pack.h
index 855f6c6..38f869d 100644
--- a/pack.h
+++ b/pack.h
@@ -83,6 +83,7 @@ extern off_t write_pack_header(struct sha1file *f, in=
t, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
+extern int pv4_encode_in_pack_object_header(enum object_type, uintmax_=
t, unsigned char *);
=20
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
--=20
1.8.2.83.gc99314b

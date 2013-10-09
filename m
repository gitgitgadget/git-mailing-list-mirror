From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/9] pv4_tree_desc: don't bother looking for v4 trees if no v4 packs are present
Date: Wed,  9 Oct 2013 21:46:14 +0700
Message-ID: <1381329976-32082-8-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuzI-0007dY-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab3JIOng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:43:36 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:48366 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669Ab3JIOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:43:35 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so1029001pdi.19
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+7Kj9s1rko0WO7EK9emsUuMSaPHUTHYa1q1Aa0m734Y=;
        b=lC9+j6wywpB/XRmaRt+CinmHCJLIFAciBGPw8336BBw1s531doj6bZaCaYKVqXsEce
         D4vONvRGEmVJzToN4vAw5b8r5GqJWFr6VD+gPn/nctXb+c/9UKo4dy//TyMO7o9FMfGs
         VH2gt9O3JT/e+QUA8IipMn/PN5zdpkBImK1RcULYiMaFGhbhHevnoWYtuUSZUy+G2gXK
         wWmJ9b93CuYxHPixShRznvxrKXY2dPvesQy0WGTAUgLplFuGVtEwALs0kpHBeJTlH9Gk
         2G8nNd2OQtBfmJFjFlOVGJCH8jKnklDS/dEc7tgIh0nnsPgGd3a7t76D1MEyzYultgwi
         D40g==
X-Received: by 10.66.25.173 with SMTP id d13mr9774951pag.146.1381329815130;
        Wed, 09 Oct 2013 07:43:35 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id fl3sm55406261pad.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:43:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:47:17 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235821>

This is mostly to avoid overhead on v2 only systems.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 5 ++++-
 sha1_file.c    | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 7d257af..4354ee3 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -12,6 +12,8 @@
 #include "packv4-parse.h"
 #include "varint.h"
=20
+int packv4_available;
+
 const unsigned char *get_sha1ref(struct packed_git *p,
 				 const unsigned char **bufp)
 {
@@ -749,7 +751,8 @@ int pv4_tree_desc_from_sha1(struct pv4_tree_desc *d=
esc,
 	strbuf_init(&desc->buf, 0);
=20
 	memset(&oi, 0, sizeof(oi));
-	if (!sha1_object_info_extended(sha1, &oi) &&
+	if (packv4_available &&
+	    !sha1_object_info_extended(sha1, &oi) &&
 	    oi.whence =3D=3D OI_PACKED &&
 	    oi.u.packed.real_type =3D=3D OBJ_PV4_TREE &&
 	    oi.u.packed.pack->version >=3D 4) {
diff --git a/sha1_file.c b/sha1_file.c
index 5848008..4744132 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -40,6 +40,7 @@ const unsigned char null_sha1[20];
=20
 static const char *no_log_pack_access =3D "no_log_pack_access";
 static const char *log_pack_access;
+extern int packv4_available;
=20
 /*
  * This is meant to hold a *small* number of objects that you would
@@ -763,6 +764,8 @@ void free_pack_by_name(const char *pack_name)
 				close(p->pack_fd);
 				pack_open_fds--;
 			}
+			if (p->version >=3D 4)
+				packv4_available--;
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			pv4_free_dict(p->ident_dict);
@@ -856,6 +859,8 @@ static int open_packed_git_1(struct packed_git *p)
 			" supported (try upgrading GIT to a newer version)",
 			p->pack_name, ntohl(hdr.hdr_version));
 	p->version =3D ntohl(hdr.hdr_version);
+	if (p->version >=3D 4)
+		packv4_available++;
=20
 	/* Verify the pack matches its index. */
 	if (p->num_objects !=3D ntohl(hdr.hdr_entries))
--=20
1.8.2.83.gc99314b

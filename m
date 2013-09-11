From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/21] pack v4: move pv4 objhdr parsing code to packv4-parse.c
Date: Wed, 11 Sep 2013 13:06:08 +0700
Message-ID: <1378879582-15372-8-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdae-0005Zr-PS
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab3IKGHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:44 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:60511 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab3IKGHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:44 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so8659718pdj.18
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Vm38rqkjpP+DNhLLPdTSS1r/cIHaeeBT2jOsVolGmec=;
        b=PSMdZG8lEXpLH6jNSYwy8E9Gf5Z5beXyKzNKrfwnFbUMw8ofqHUCt7bc5UJNIO2Ltd
         wZn0viddGBj1Y3267sId94Ci8D2X1h+RGr099TAJNvGgf2qTd8TK8SAtX1FqY1WiNDGG
         xLWyxe5PAiDG8bZftT3BmvmmplQAAmtpfB1yTw4hXr8xCgaUn+lawTRoSgLbh5xztU5D
         fPzSS7JU2yFbub02Viy0RZMLEE4LiUBBbp80FkJdDBv+8euGOpgKGz6/uKSXHThA+fdb
         Lcw6sX3m7aOtzn0fJ2kOqt5SY+Y3QKjW2hd9zsmc7k2eA2LK7jjExAUxpFf/+ls3jLK9
         dETQ==
X-Received: by 10.66.144.73 with SMTP id sk9mr1281946pab.172.1378879662271;
        Tue, 10 Sep 2013 23:07:42 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id yo2sm1105298pab.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:35 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234531>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 12 ++++++++++++
 packv4-parse.h |  5 +++++
 sha1_file.c    |  9 ++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 80ad6fc..7a43635 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -570,3 +570,15 @@ void *pv4_get_tree(struct packed_git *p, struct pa=
ck_window **w_curs,
 	}
 	return dst;
 }
+
+unsigned long pv4_unpack_object_header_buffer(const unsigned char *bas=
e,
+					      unsigned long len,
+					      enum object_type *type,
+					      unsigned long *sizep)
+{
+	const unsigned char *cp =3D base;
+	uintmax_t val =3D decode_varint(&cp);
+	*type =3D val & 0xf;
+	*sizep =3D val >> 4;
+	return cp - base;
+}
diff --git a/packv4-parse.h b/packv4-parse.h
index e6719f6..52f52f5 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -10,6 +10,11 @@ struct packv4_dict {
 struct packv4_dict *pv4_create_dict(const unsigned char *data, int dic=
t_size);
 void pv4_free_dict(struct packv4_dict *dict);
=20
+unsigned long pv4_unpack_object_header_buffer(const unsigned char *bas=
e,
+					      unsigned long len,
+					      enum object_type *type,
+					      unsigned long *sizep);
+
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs=
,
 		     off_t offset, unsigned long size);
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
diff --git a/sha1_file.c b/sha1_file.c
index 1528e28..038e22e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1736,13 +1736,8 @@ int unpack_object_header(struct packed_git *p,
 	base =3D use_pack(p, w_curs, *curpos, &left);
 	if (p->version < 4) {
 		used =3D unpack_object_header_buffer(base, left, &type, sizep);
-	} else {
-		const unsigned char *cp =3D base;
-		uintmax_t val =3D decode_varint(&cp);
-		used =3D cp - base;
-		type =3D val & 0xf;
-		*sizep =3D val >> 4;
-	}
+	} else
+		used =3D pv4_unpack_object_header_buffer(base, left, &type, sizep);
 	if (!used) {
 		type =3D OBJ_BAD;
 	} else
--=20
1.8.2.82.gc24b958

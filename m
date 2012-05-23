From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/6] index-pack: factor out unpack core from get_data_from_pack
Date: Wed, 23 May 2012 21:09:48 +0700
Message-ID: <1337782191-10091-3-git-send-email-pclouds@gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:14:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCKa-0001ky-ES
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759942Ab2EWOOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 10:14:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59120 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab2EWOOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 10:14:12 -0400
Received: by dady13 with SMTP id y13so9808350dad.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3pdl6vULo3rQy09sqsXtqWDQM3OTMczIjDYCQWqkmVY=;
        b=JqG6Em4cM6kgBeUHFiO6yC59wadJcDEGyKNx+qDAzKk+tjAPHiATFJHVBheHnMdNMG
         TYqwTEl6OP/+S32/tIw1vDG9ddT4f+ZosmOdwn/vvWfrG/fS2+pQ1qpTQUiw0fRC2H+p
         OwMXDNbHq9sI5HszIEUAPLxu4l57Pc+l8nJUVtpEIIAgbkyhIyxPIrUzyhU6O2ms8siN
         IVnp1Oh8lS0bdKpQCgKP2ptBnmpZw7M/GJMwx4RjcaQkc/wQGQezcz5zU/l9OnLw07Jp
         qrd7hEtY6GoCFUmFNGtjIfPUos6JlH3a+wtM9cQp9aOkD6QYOu0oJtIqu6BGzkl7Nslx
         a8Hg==
Received: by 10.68.203.73 with SMTP id ko9mr10963599pbc.66.1337782450868;
        Wed, 23 May 2012 07:14:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.52.77])
        by mx.google.com with ESMTPS id os2sm1995931pbc.12.2012.05.23.07.14.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 07:14:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 May 2012 21:10:12 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198288>

This allows caller to consume large inflated object with a fixed
amount of memory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 for streaming collision test..

 builtin/index-pack.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c7c2b88..9129299 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -504,7 +504,9 @@ static void *unpack_raw_entry(struct object_entry *=
obj,
 	return data;
 }
=20
-static void *get_data_from_pack(struct object_entry *obj)
+static void *unpack_data(struct object_entry *obj,
+			 int (*consume)(const unsigned char *, unsigned long, void *),
+			 void *cb_data)
 {
 	off_t from =3D obj[0].idx.offset + obj[0].hdr_size;
 	unsigned long len =3D obj[1].idx.offset - from;
@@ -512,15 +514,16 @@ static void *get_data_from_pack(struct object_ent=
ry *obj)
 	git_zstream stream;
 	int status;
=20
-	data =3D xmalloc(obj->size);
+	data =3D xmalloc(consume ? 64*1024 : obj->size);
 	inbuf =3D xmalloc((len < 64*1024) ? len : 64*1024);
=20
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
 	stream.next_out =3D data;
-	stream.avail_out =3D obj->size;
+	stream.avail_out =3D consume ? 64*1024 : obj->size;
=20
 	do {
+		unsigned char *last_out =3D stream.next_out;
 		ssize_t n =3D (len < 64*1024) ? len : 64*1024;
 		n =3D pread(pack_fd, inbuf, n, from);
 		if (n < 0)
@@ -535,6 +538,15 @@ static void *get_data_from_pack(struct object_entr=
y *obj)
 		stream.next_in =3D inbuf;
 		stream.avail_in =3D n;
 		status =3D git_inflate(&stream, 0);
+		if (consume) {
+			if (consume(last_out, stream.next_out - last_out, cb_data)) {
+				free(inbuf);
+				free(data);
+				return NULL;
+			}
+			stream.next_out =3D data;
+			stream.avail_out =3D 64*1024;
+		}
 	} while (len && status =3D=3D Z_OK && !stream.avail_in);
=20
 	/* This has been inflated OK when first encountered, so... */
@@ -543,9 +555,18 @@ static void *get_data_from_pack(struct object_entr=
y *obj)
=20
 	git_inflate_end(&stream);
 	free(inbuf);
+	if (consume) {
+		free(data);
+		data =3D NULL;
+	}
 	return data;
 }
=20
+static void *get_data_from_pack(struct object_entry *obj)
+{
+	return unpack_data(obj, NULL, NULL);
+}
+
 static int compare_delta_bases(const union delta_base *base1,
 			       const union delta_base *base2,
 			       enum object_type type1,
--=20
1.7.10.2.549.g9354186

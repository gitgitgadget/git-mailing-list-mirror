From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/21] unpack-objects: read v4 dictionaries
Date: Wed, 11 Sep 2013 13:06:14 +0700
Message-ID: <1378879582-15372-14-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdbQ-0006gr-JQ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217Ab3IKGIc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:08:32 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:49849 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab3IKGIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:08:31 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so8554749pbc.36
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NcRDdh0pkguA15yYJh2GA0tvGbWnuHfHjuc+GNTqlrk=;
        b=0XbkiQXlhrflHCPsGwq6GAM3XnJg8hudVJTYGJ0H/NDB4aXXjXGt6HZ2WA/F1kj4+k
         KLYs0pJRSaWki0nN9nRqA62Dsv/6TzUPWIJQ6PwSvf+Ex0XAAhYfSOu6S2biRcBwndCc
         Mq6FAYcEXOngOkhpMi5g26hIAihckAe5TRbsP35cmVgcr0ov4beZ1gq6LahzsTLpGyr+
         UCpKdqIrYSJrIq3WWx5cUYycD2FuP8cwUMi/aeBdety/j9c0jYP9RQZLLtUXuMVAOo+x
         2Mg+GrKGq+MiHH2g7Q7yF8lsHVNFKkZQkq2VCRiDYsJ8vwUGQMoqhWh0Jjylv9ONMe4r
         Valw==
X-Received: by 10.66.194.13 with SMTP id hs13mr1669212pac.163.1378879708812;
        Tue, 10 Sep 2013 23:08:28 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id tz3sm27451894pbc.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:08:21 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234537>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 50 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 50 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index c9eb31d..1a3c30e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -10,6 +10,7 @@
 #include "tree-walk.h"
 #include "progress.h"
 #include "decorate.h"
+#include "packv4-parse.h"
 #include "fsck.h"
=20
 static int dry_run, quiet, recover, has_errors, strict;
@@ -20,7 +21,10 @@ static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static git_SHA_CTX ctx;
+
 static int packv4;
+static unsigned char *sha1_table;
+static struct packv4_dict *name_dict, *path_dict;
=20
 /*
  * When running under --strict mode, objects whose reachability are
@@ -89,6 +93,28 @@ static void use(int bytes)
 	consumed_bytes +=3D bytes;
 }
=20
+static inline void *fill_and_use(int bytes)
+{
+	void *p =3D fill(bytes);
+	use(bytes);
+	return p;
+}
+
+static uintmax_t read_varint(void)
+{
+	unsigned char c =3D *(char*)fill_and_use(1);
+	uintmax_t val =3D c & 127;
+	while (c & 128) {
+		val +=3D 1;
+		if (!val || MSB(val, 7))
+			die("offset overflow in read_varint at %lu",
+			    (unsigned long)consumed_bytes);
+		c =3D *(char*)fill_and_use(1);
+		val =3D (val << 7) + (c & 127);
+	}
+	return val;
+}
+
 static void *get_data(unsigned long size)
 {
 	git_zstream stream;
@@ -470,6 +496,20 @@ static int unpack_one(unsigned nr)
 	return 0;
 }
=20
+static struct packv4_dict *read_dict(void)
+{
+	unsigned long size;
+	unsigned char *data;
+	struct packv4_dict *dict;
+
+	size =3D read_varint();
+	data =3D get_data(size);
+	dict =3D pv4_create_dict(data, size);
+	if (!dict)
+		die("unable to parse dictionary");
+	return dict;
+}
+
 static void unpack_all(void)
 {
 	int i;
@@ -486,6 +526,16 @@ static void unpack_all(void)
 	packv4 =3D ntohl(hdr->hdr_version) =3D=3D 4;
 	use(sizeof(struct pack_header));
=20
+	if (packv4) {
+		sha1_table =3D xmalloc(20 * nr_objects);
+		for (i =3D 0; i < nr_objects; i++) {
+			unsigned char *p =3D sha1_table + i * 20;
+			hashcpy(p, fill_and_use(20));
+		}
+		name_dict =3D read_dict();
+		path_dict =3D read_dict();
+	}
+
 	if (!quiet)
 		progress =3D start_progress("Unpacking objects", nr_objects);
 	obj_list =3D xcalloc(nr_objects, sizeof(*obj_list));
--=20
1.8.2.82.gc24b958

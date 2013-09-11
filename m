From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/21] unpack-objects: decode v4 ref-delta
Date: Wed, 11 Sep 2013 13:06:16 +0700
Message-ID: <1378879582-15372-16-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdbe-0006yc-8h
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab3IKGIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:08:46 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48609 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab3IKGIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:08:45 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so8836139pad.9
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZDLhYISs6UC1m9kWizTivjA4bd0lcowlv0IL81JSWP4=;
        b=F7wWk8I2e0kIwAZKyCY7N+ZR3hZkxZvOp6nLlReGTHgsTgndUIFzx8Xpe8TxTUpzSu
         BMBAAyi96SBNcwtbO6l6wC38gaAI79jL7J79pZv7oSQLRcCRcAkCGgNCpXF1hobLb0Cr
         UqK2jBA7kZA8BUQkZKZx9z7pVkmBnZNqO9XSfWFrcozP837VmittoPU2xLyOobJjxRUy
         8uGq4QdjfJL1V+sYFaWfDIGOVh3p5NfYwE4N9Zqu2OLp/Fk4JTu4zTDxHoGHEMI+CrNw
         5MmQO6rXl/0jHXlhJOFX0ARpgAUJ8xCJRbGUT4XQ1SDG2cOmlx0AfCsRn1WwV+03ZoXZ
         /OmQ==
X-Received: by 10.66.192.132 with SMTP id hg4mr1825420pac.84.1378879724946;
        Tue, 10 Sep 2013 23:08:44 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id tg7sm27432794pbc.36.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:08:37 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234539>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index a906a98..f8442f4 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -23,6 +23,7 @@ static off_t consumed_bytes;
 static git_SHA_CTX ctx;
=20
 static int packv4;
+static unsigned nr_objects;
 static unsigned char *sha1_table;
 static struct packv4_dict *name_dict, *path_dict;
=20
@@ -115,6 +116,21 @@ static uintmax_t read_varint(void)
 	return val;
 }
=20
+static const unsigned char *read_sha1ref(void)
+{
+	unsigned int index =3D read_varint();
+	if (!index) {
+		static unsigned char sha1[20];
+		hashcpy(sha1, fill_and_use(20));
+		return sha1;
+	}
+	index--;
+	if (index >=3D nr_objects)
+		die("bad index in read_sha1ref at %lu",
+		    (unsigned long)consumed_bytes);
+	return sha1_table + index * 20;
+}
+
 static void *get_data(unsigned long size)
 {
 	git_zstream stream;
@@ -185,7 +201,6 @@ struct obj_info {
 #define FLAG_WRITTEN (1u<<21)
=20
 static struct obj_info *obj_list;
-static unsigned nr_objects;
=20
 /*
  * Called only from check_object() after it verified this object
@@ -361,8 +376,12 @@ static void unpack_delta_entry(enum object_type ty=
pe, unsigned long delta_size,
 	unsigned char base_sha1[20];
=20
 	if (type =3D=3D OBJ_REF_DELTA) {
-		hashcpy(base_sha1, fill(20));
-		use(20);
+		if (packv4)
+			hashcpy(base_sha1, read_sha1ref());
+		else {
+			hashcpy(base_sha1, fill(20));
+			use(20);
+		}
 		delta_data =3D get_data(delta_size);
 		if (dry_run || !delta_data) {
 			free(delta_data);
--=20
1.8.2.82.gc24b958

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table size
Date: Mon,  9 Sep 2013 20:58:06 +0700
Message-ID: <1378735087-4813-16-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:57:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1xb-0004YK-9N
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab3IIN4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:56:55 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42316 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab3IIN4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:56:54 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so6301972pad.37
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JmtcH1/kJBuRp76kRx6TFEdnR5ynKsb3LMQDh4Xd3fM=;
        b=VyYVT9uJMxCxr5bWR2J0pt2s1n3YF1AMFk2wCz5muB1RUL2GlUYAqj6+IOdN9OlTRf
         dHgUwjCT9myD1RBscEel46r2geifc9wexUqMzUxSTqsUnuADje+lqfNwgEkpsKx4qmBb
         m3gV+euhYDjuiCWI/TjOsrmED802X6skHXhX690x58K5kcDEOh6sQ57DLBldsF1fJSzQ
         6KkbHnovadiWWaP3+Kf6LNVqWHs1rcYzIKZaR+4e3gqGROVae+mEooSRUAWCV/+v6eqW
         PsveN+YzTShubqQSgnSwl5MeYPa5FF69y3jcNHuw1WS3lNM1h/qyGO//090Yht/i2kGF
         SFIA==
X-Received: by 10.68.232.134 with SMTP id to6mr3173377pbc.163.1378735013768;
        Mon, 09 Sep 2013 06:56:53 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id qa9sm16458720pbc.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:56:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 21:00:03 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234343>

nr_objects in the next patch is used to reflect the number of actual
objects in the stream, which may be smaller than the number recorded
in pack header.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9036f3e..dc9961b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -80,6 +80,7 @@ static int nr_objects;
 static int nr_deltas;
 static int nr_resolved_deltas;
 static int nr_threads;
+static int nr_objects_final;
=20
 static int from_stdin;
 static int strict;
@@ -297,7 +298,7 @@ static void check_against_sha1table(const unsigned =
char *sha1)
 	if (!packv4)
 		return;
=20
-	found =3D bsearch(sha1, sha1_table, nr_objects, 20,
+	found =3D bsearch(sha1, sha1_table, nr_objects_final, 20,
 			(int (*)(const void *, const void *))hashcmp);
 	if (!found)
 		die(_("object %s not found in SHA-1 table"),
@@ -331,7 +332,7 @@ static const unsigned char *read_sha1ref(void)
 		return sha1;
 	}
 	index--;
-	if (index >=3D nr_objects)
+	if (index >=3D nr_objects_final)
 		bad_object(consumed_bytes,
 			   _("bad index in read_sha1ref"));
 	return sha1_table + index * 20;
@@ -340,7 +341,7 @@ static const unsigned char *read_sha1ref(void)
 static const unsigned char *read_sha1table_ref(void)
 {
 	const unsigned char *sha1 =3D read_sha1ref();
-	if (sha1 < sha1_table || sha1 >=3D sha1_table + nr_objects * 20)
+	if (sha1 < sha1_table || sha1 >=3D sha1_table + nr_objects_final * 20=
)
 		check_against_sha1table(sha1);
 	return sha1;
 }
@@ -392,7 +393,7 @@ static void parse_pack_header(void)
 		die(_("pack version %"PRIu32" unsupported"),
 			ntohl(hdr->hdr_version));
=20
-	nr_objects =3D ntohl(hdr->hdr_entries);
+	nr_objects_final =3D nr_objects =3D ntohl(hdr->hdr_entries);
 	use(sizeof(struct pack_header));
 }
=20
@@ -1472,9 +1473,9 @@ static void parse_dictionaries(void)
 	if (!packv4)
 		return;
=20
-	sha1_table =3D xmalloc(20 * nr_objects);
+	sha1_table =3D xmalloc(20 * nr_objects_final);
 	hashcpy(sha1_table, fill_and_use(20));
-	for (i =3D 1; i < nr_objects; i++) {
+	for (i =3D 1; i < nr_objects_final; i++) {
 		unsigned char *p =3D sha1_table + i * 20;
 		hashcpy(p, fill_and_use(20));
 		if (hashcmp(p - 20, p) >=3D 0)
--=20
1.8.2.83.gc99314b

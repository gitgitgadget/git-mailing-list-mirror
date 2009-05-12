From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Fix type-punning issues
Date: Mon, 11 May 2009 20:17:38 -0500
Message-ID: <1242091058-25197-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 03:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3gcy-0006UU-5u
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 03:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZELBRm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 21:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZELBRm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 21:17:42 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:15341 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZELBRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 21:17:41 -0400
Received: by an-out-0708.google.com with SMTP id d40so10895703and.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=jtlih27WxQUI85OUk55UW27/M8mnk87P5qDOsn1RV6k=;
        b=nCscHY/F9PTYP7zIWNvt1C+5yS+FUflTICNKRO6wlSaFDrl0vB+XZiCSvxNok2E4IL
         ct8B9D0BHb3u0R1CTAT7HOVnUUKxG/KQHVarFYAEdKXlj4Qb3pV9SWDFsELb/1U0z5Ta
         E7mqPniBnYei1I1QPRvyfyNjarSaRw/2gCf60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BmuWK10d/ijoNuji/VCIkIlDjBAg/Syo9kQgjoV7cMw6Vx4xRc/P7xlTJe4tbRJ9B7
         VH4bXzJXwVebFe6YYiPfbp55feVsnU8U2wblpkvml1ro/3mhmaUDi1drrkjwJzhcHuKy
         ZMsEXShCPSR1NiwUzhCAwT6R6czyucb0Z+ggM=
Received: by 10.100.248.16 with SMTP id v16mr18804750anh.60.1242091061480;
        Mon, 11 May 2009 18:17:41 -0700 (PDT)
Received: from localhost (adsl-76-197-235-156.dsl.chcgil.sbcglobal.net [76.197.235.156])
        by mx.google.com with ESMTPS id b14sm18801784ana.36.2009.05.11.18.17.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 18:17:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118865>

In these two places we are casting part of our unsigned char sha1 array=
 into
an unsigned int, which violates GCCs strict-aliasing rules (and probabl=
y
other compilers). In addition, we had two hashing functions defined in
object.c. Keep the one function that is "correct" and adopt the other o=
nes
to fit.

decorate.c: In function =E2=80=98hash_obj=E2=80=99:
decorate.c:11: warning: dereferencing type-punned pointer will break
strict-aliasing rules

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Let me know if this patch is completely off-base. A quick glance at the
generated assembly seems to show this isn't much of a performance hit,
especially given that these functions are inlined anyway. As an FYI the=
 above
warning came when compiling with GCC 4.4; I'm not sure if <4.4 showed t=
his
behavior.

-Dan

 decorate.c |    7 ++++---
 object.c   |   20 +++++++-------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/decorate.c b/decorate.c
index 82d9e22..bf83750 100644
--- a/decorate.c
+++ b/decorate.c
@@ -8,7 +8,8 @@
=20
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
-	unsigned int hash =3D *(unsigned int *)obj->sha1;
+	unsigned int hash;
+	memcpy(&hash, obj->sha1, sizeof(unsigned int));
 	return hash % n;
 }
=20
@@ -16,7 +17,7 @@ static void *insert_decoration(struct decoration *n, =
const struct object *base,
 {
 	int size =3D n->size;
 	struct object_decoration *hash =3D n->hash;
-	int j =3D hash_obj(base, size);
+	unsigned int j =3D hash_obj(base, size);
=20
 	while (hash[j].base) {
 		if (hash[j].base =3D=3D base) {
@@ -68,7 +69,7 @@ void *add_decoration(struct decoration *n, const stru=
ct object *obj,
 /* Lookup a decoration pointer */
 void *lookup_decoration(struct decoration *n, const struct object *obj=
)
 {
-	int j;
+	unsigned int j;
=20
 	/* nothing to lookup */
 	if (!n->size)
diff --git a/object.c b/object.c
index 7e6a92c..96ef32d 100644
--- a/object.c
+++ b/object.c
@@ -43,15 +43,16 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
=20
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+static unsigned int hash_char(const unsigned char *sha1, unsigned int =
n)
 {
-	unsigned int hash =3D *(unsigned int *)obj->sha1;
-	return hash % n;
+	unsigned int i;
+	memcpy(&i, sha1, sizeof(unsigned int));
+	return (int)(i % n);
 }
=20
 static void insert_obj_hash(struct object *obj, struct object **hash, =
unsigned int size)
 {
-	int j =3D hash_obj(obj, size);
+	unsigned int j =3D hash_char(obj->sha1, size);
=20
 	while (hash[j]) {
 		j++;
@@ -61,22 +62,15 @@ static void insert_obj_hash(struct object *obj, str=
uct object **hash, unsigned i
 	hash[j] =3D obj;
 }
=20
-static int hashtable_index(const unsigned char *sha1)
-{
-	unsigned int i;
-	memcpy(&i, sha1, sizeof(unsigned int));
-	return (int)(i % obj_hash_size);
-}
-
 struct object *lookup_object(const unsigned char *sha1)
 {
-	int i;
+	unsigned int i;
 	struct object *obj;
=20
 	if (!obj_hash)
 		return NULL;
=20
-	i =3D hashtable_index(sha1);
+	i =3D hash_char(sha1, obj_hash_size);
 	while ((obj =3D obj_hash[i]) !=3D NULL) {
 		if (!hashcmp(sha1, obj->sha1))
 			break;
--=20
1.6.2.4

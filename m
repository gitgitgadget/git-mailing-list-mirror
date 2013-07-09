From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/15] for-each-ref: improve responsiveness of %(upstream:track)
Date: Tue,  9 Jul 2013 16:02:24 +0530
Message-ID: <1373365946-9230-14-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVI2-0007Kh-9a
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab3GIKgu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:50 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54376 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab3GIKgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:47 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so5140890pdi.27
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RmTz8MoxrcajT0ByX1ttIF6hvmkZx4oYSJks+sYpmJY=;
        b=eG0rkWOr9LuP8AOEX9vuJpNFyaQJafJYMhS0K/9e9s4MJPBxjW9plALcT6OU7DM+WH
         K97P9RgN3yaPuxd2QZj56IzuTz+jKcnjgrg1YTmQUERJ1Frx6yIeHFrQOqOxEF30IM1r
         UHbIeRaYCT+Qkg9pKqq4+hILOczS5ZuwhmC5aBpLuJWPqqkA6FUJMCp3e+SBE+gmKxxd
         DT/g9OF/U1ApwhIBi66Gs72K5U61jy6ErQZpHqIJ2FuuMvMoBPCXXb641hSY522+Kqrc
         zS2SFrNpfchkZu+KAULXcL45fBrGfVskmWeZQ+msgpqpzE/3LOk1pHYYTOhpxjp2/Wo9
         6aaA==
X-Received: by 10.66.141.71 with SMTP id rm7mr27523866pab.90.1373366206237;
        Tue, 09 Jul 2013 03:36:46 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229942>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Before anything is printed, for-each-ref sorts all refs first.  As
part of the sorting, populate_value() is called to fill the values in
for all atoms/placeholders per entry. By the time sort_refs() is done,
pretty much all data is already retrieved.

This works fine when data can be cheaply retrieved before
%(upstream:track) comes into the picture. It may take a noticeable
amount of time to process %(upstream:track) for each entry. All
entries add up and make --format=3D'%(refname)%(upstream:track)' seem
hung for a few seconds, then display everything at once.

Improve the responsiveness by only processing the one atom (*) at a
time so that processing one atom for all entries (e.g. sorting) won't
cause much delay (unless you choose a "heavy" atom to process).

(*) This is not entirely correct. If you sort by an atom that needs
object database access, then it will fill all atoms that need odb.
Which is not a bad thing. We don't want to access odb once at sorting
phase and again at display phase.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 49 +++++++++++++++++++++++++-----------------=
-------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 72b33ee..25764aa 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -565,20 +565,6 @@ static void grab_sub_body_contents(struct atom_val=
ue *val, int deref, struct obj
 }
=20
 /*
- * We want to have empty print-string for field requests
- * that do not apply (e.g. "authordate" for a tag object)
- */
-static void fill_missing_values(struct atom_value *val)
-{
-	int i;
-	for (i =3D 0; i < used_atom_cnt; i++) {
-		struct atom_value *v =3D &val[i];
-		if (v->s =3D=3D NULL)
-			v->s =3D "";
-	}
-}
-
-/*
  * val is a list of atom_value to hold returned values.  Extract
  * the values for atoms in used_atom array out of (obj, buf, sz).
  * when deref is false, (obj, buf, sz) is the object that is
@@ -621,7 +607,7 @@ static inline char *copy_advance(char *dst, const c=
har *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct refinfo *ref, int only_this_atom)
 {
 	void *buf;
 	struct object *obj;
@@ -630,13 +616,15 @@ static void populate_value(struct refinfo *ref)
 	const unsigned char *tagged;
 	int upstream_present =3D 0;
=20
-	ref->value =3D xcalloc(sizeof(struct atom_value), used_atom_cnt);
+	if (!ref->value) {
+		ref->value =3D xcalloc(sizeof(struct atom_value), used_atom_cnt);
=20
-	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
-		unsigned char unused1[20];
-		ref->symref =3D resolve_refdup(ref->refname, unused1, 1, NULL);
-		if (!ref->symref)
-			ref->symref =3D "";
+		if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
+			unsigned char unused1[20];
+			ref->symref =3D resolve_refdup(ref->refname, unused1, 1, NULL);
+			if (!ref->symref)
+				ref->symref =3D "";
+		}
 	}
=20
 	/* Fill in specials first */
@@ -648,6 +636,9 @@ static void populate_value(struct refinfo *ref)
 		const char *formatp;
 		struct branch *branch;
=20
+		if (only_this_atom !=3D -1 && only_this_atom !=3D i)
+			continue;
+
 		if (*name =3D=3D '*') {
 			deref =3D 1;
 			name++;
@@ -754,6 +745,10 @@ static void populate_value(struct refinfo *ref)
=20
 	for (i =3D 0; i < used_atom_cnt; i++) {
 		struct atom_value *v =3D &ref->value[i];
+
+		if (only_this_atom !=3D -1 && only_this_atom !=3D i)
+			continue;
+
 		if (v->s =3D=3D NULL)
 			goto need_obj;
 	}
@@ -809,9 +804,15 @@ static void populate_value(struct refinfo *ref)
  */
 static void get_value(struct refinfo *ref, int atom, struct atom_value=
 **v)
 {
-	if (!ref->value) {
-		populate_value(ref);
-		fill_missing_values(ref->value);
+	if (!ref->value || !ref->value[atom].s) {
+		populate_value(ref, atom);
+		/*
+		 * We want to have empty print-string for field
+		 * requests that do not apply (e.g. "authordate" for a
+		 * tag object)
+		 */
+		if (!ref->value[atom].s)
+			ref->value[atom].s =3D "";
 	}
 	*v =3D &ref->value[atom];
 }
--=20
1.8.3.2.736.g869de25

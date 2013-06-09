From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 13/15] for-each-ref: improve responsiveness of %(upstream:track)
Date: Sun,  9 Jun 2013 23:24:32 +0530
Message-ID: <1370800474-8940-14-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljrl-0006hW-57
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab3FIR5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:57:09 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47932 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab3FIR5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:57:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so951749pab.8
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W26s6ormVhzGGBfciRs0+ttp0ohr+mUj86fYn2/s2gU=;
        b=vSTiBgFZKcQDpfQh5C9wgZpwfQOHvFtX1SMghMV96JSBfmuLBlFUiLnex1OfidYxuK
         2F12e78CZyiAniUOtLAM3yDcDrtnIm/bGb0ud4ae1bFEi4Ru15y5b8ZtPBnfMF4NuwrS
         QH15BWQn3zOKfsCnkaM9cjAg6KCVth1qUchcpymOVIj6CL7ELjCFI51gfrYqJa+beS7X
         tgfjKURdwhvMoNq0YO7l4lGX2T5SIReiaE3CBsECs7D7c4JLuV8+t0+DLOZBHXO96ktg
         ymmy+60WaiRlXQriJ5CJAu0yoF08Ware3vGHgS0LSGUIql2fcQ/5yA7WUcfk6/F+FkIJ
         5a8Q==
X-Received: by 10.66.49.104 with SMTP id t8mr10758088pan.65.1370800627155;
        Sun, 09 Jun 2013 10:57:07 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.57.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:57:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227068>

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
1.8.3.247.g485169c

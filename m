From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/2] find_pack_entry(): do not keep packed_git pointer locally
Date: Wed,  1 Feb 2012 20:48:55 +0700
Message-ID: <1328104135-475-2-git-send-email-pclouds@gmail.com>
References: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 <1328104135-475-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 14:45:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsaVR-0000TT-8q
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 14:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab2BANpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 08:45:40 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56245 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab2BANpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 08:45:30 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so1092678pbd.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 05:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pmbFebGvbGaYK2Wefc+nAqif1CS0M+SVoJjUFGF6gVw=;
        b=N968/UQMOuanJGUpesrfRComSk+YryS/97S8/BDrKuPhdxcYf5gT6CcBJw33K4A/7P
         8gNskIkCM0zyFn8lFlU0PyWZ22uCF0tPqH8SQkr4vl9gYo6V4b8XWe+garmCe7Kwobjw
         SOp71yNiwgL4EEhmxvW+m1+58ZcgTl/ZAdfPc=
Received: by 10.68.216.227 with SMTP id ot3mr25784036pbc.18.1328103929865;
        Wed, 01 Feb 2012 05:45:29 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id x6sm34966293pbf.7.2012.02.01.05.45.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 05:45:28 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 01 Feb 2012 20:49:05 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328104135-475-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189512>

Commit f7c22cc (always start looking up objects in the last used pack
first - 2007-05-30) introduce a static packed_git* pointer as an
optimization.  The kept pointer however may become invalid if
free_pack_by_name() happens to free that particular pack.

Current code base does not access packs after calling
free_pack_by_name() so it should not be a problem. Anyway, move the
pointer out so that free_pack_by_name() can reset it to avoid running
into troubles in future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Since Junio's already done the hard work. It'd be silly of me not to
 take advantage and credit for free :)

 The new loop looks much better.

 sha1_file.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ff5bf42..ebe77b3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -54,6 +54,8 @@ static struct cached_object empty_tree =3D {
 	0
 };
=20
+static struct packed_git *last_found_pack;
+
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
 	int i;
@@ -720,6 +722,8 @@ void free_pack_by_name(const char *pack_name)
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp =3D p->next;
+			if (last_found_pack =3D=3D p)
+				last_found_pack =3D NULL;
 			free(p);
 			return;
 		}
@@ -2044,27 +2048,22 @@ static int find_pack_entry_1(const unsigned cha=
r *sha1,
=20
 static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
 {
-	static struct packed_git *last_found =3D (void *)1;
 	struct packed_git *p;
=20
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
-	p =3D (last_found =3D=3D (void *)1) ? packed_git : last_found;
=20
-	do {
-		if (find_pack_entry_1(sha1, p, e)) {
-			last_found =3D p;
-			return 1;
-		}
+	if (last_found_pack && find_pack_entry_1(sha1, last_found_pack, e))
+		return 1;
=20
-		if (p =3D=3D last_found)
-			p =3D packed_git;
-		else
-			p =3D p->next;
-		if (p =3D=3D last_found)
-			p =3D p->next;
-	} while (p);
+	for (p =3D packed_git; p; p =3D p->next) {
+		if (p =3D=3D last_found_pack || !find_pack_entry_1(sha1, p, e))
+			continue;
+
+		last_found_pack =3D p;
+		return 1;
+	}
 	return 0;
 }
=20
--=20
1.7.8.36.g69ee2

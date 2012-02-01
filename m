From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/2] Factor find_pack_entry()'s core out
Date: Wed,  1 Feb 2012 20:48:54 +0700
Message-ID: <1328104135-475-1-git-send-email-pclouds@gmail.com>
References: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 14:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsaVK-0000ON-7S
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 14:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab2BANpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 08:45:20 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56245 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2BANpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 08:45:20 -0500
Received: by pbdu11 with SMTP id u11so1092678pbd.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 05:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m1Xnq2o68Wbm5mCIcAGPbTrG/rdRbDfZIqnXjWX00lE=;
        b=VhfrBs0+RjURnYn55w40MSu5323fMWMgFhUZUpJQk0HEPNlaksVLBEvUWSD/3aZ1O8
         Rrnh0pDv4lUvZlpsR2HXEAwnL+ktNNsK/trvUIyylHuccalCQVKxGowF/V8DCtoH/mOa
         ibwe0IYTuhudDsEwiSG2WxUD+peLQCTqYBBAQ=
Received: by 10.68.235.103 with SMTP id ul7mr60547923pbc.46.1328103919801;
        Wed, 01 Feb 2012 05:45:19 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id c5sm63489907pbq.13.2012.02.01.05.45.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 05:45:18 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 01 Feb 2012 20:48:56 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189511>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c |   59 +++++++++++++++++++++++++++++++++------------------=
--------
 1 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 88f2151..ff5bf42 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2010,11 +2010,42 @@ int is_pack_valid(struct packed_git *p)
 	return !open_packed_git(p);
 }
=20
+static int find_pack_entry_1(const unsigned char *sha1,
+			     struct packed_git *p, struct pack_entry *e)
+{
+	off_t offset;
+	if (p->num_bad_objects) {
+		unsigned i;
+		for (i =3D 0; i < p->num_bad_objects; i++)
+			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+				return 0;
+	}
+
+	offset =3D find_pack_entry_one(sha1, p);
+	if (!offset)
+		return 0;
+
+	/*
+	 * We are about to tell the caller where they can locate the
+	 * requested object.  We better make sure the packfile is
+	 * still here and can be accessed before supplying that
+	 * answer, as it may have been deleted since the index was
+	 * loaded!
+	 */
+	if (!is_pack_valid(p)) {
+		warning("packfile %s cannot be accessed", p->pack_name);
+		return 0;
+	}
+	e->offset =3D offset;
+	e->p =3D p;
+	hashcpy(e->sha1, sha1);
+	return 1;
+}
+
 static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
 {
 	static struct packed_git *last_found =3D (void *)1;
 	struct packed_git *p;
-	off_t offset;
=20
 	prepare_packed_git();
 	if (!packed_git)
@@ -2022,35 +2053,11 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 	p =3D (last_found =3D=3D (void *)1) ? packed_git : last_found;
=20
 	do {
-		if (p->num_bad_objects) {
-			unsigned i;
-			for (i =3D 0; i < p->num_bad_objects; i++)
-				if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
-					goto next;
-		}
-
-		offset =3D find_pack_entry_one(sha1, p);
-		if (offset) {
-			/*
-			 * We are about to tell the caller where they can
-			 * locate the requested object.  We better make
-			 * sure the packfile is still here and can be
-			 * accessed before supplying that answer, as
-			 * it may have been deleted since the index
-			 * was loaded!
-			 */
-			if (!is_pack_valid(p)) {
-				warning("packfile %s cannot be accessed", p->pack_name);
-				goto next;
-			}
-			e->offset =3D offset;
-			e->p =3D p;
-			hashcpy(e->sha1, sha1);
+		if (find_pack_entry_1(sha1, p, e)) {
 			last_found =3D p;
 			return 1;
 		}
=20
-		next:
 		if (p =3D=3D last_found)
 			p =3D packed_git;
 		else
--=20
1.7.8.36.g69ee2

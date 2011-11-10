From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] find_pack_entry(): do not keep packed_git pointer locally
Date: Thu, 10 Nov 2011 14:12:31 +0700
Message-ID: <1320909155-4575-2-git-send-email-pclouds@gmail.com>
References: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:12:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROOnv-0003jv-KO
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394Ab1KJHMC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 02:12:02 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46234 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab1KJHMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:12:00 -0500
Received: by ywf7 with SMTP id 7so2627513ywf.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 23:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ar3V7j6JIOl49WG79B47W0I5vKDcI0ADhmRWakSGOpQ=;
        b=Lp+/35dstQp8uEjrCXf1yoJqtKGXxn2RGBV2iBxYKIsPhoJGeEhXq/tn5Y9yZ58rq9
         yK1eav0Ww2ycCaOuz4wdH3xmrQOXT2kzFbTJnVQPJdo/QhHEfic9ywMKksjEG+LOaeJU
         CAGNSCC8otApA8O+vdv194O1DIbI6+P7gyOig=
Received: by 10.68.10.39 with SMTP id f7mr12095149pbb.107.1320909119620;
        Wed, 09 Nov 2011 23:11:59 -0800 (PST)
Received: from tre ([115.73.226.96])
        by mx.google.com with ESMTPS id c3sm19265880pbt.12.2011.11.09.23.11.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 23:11:58 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 10 Nov 2011 14:12:42 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185191>

Commit f7c22cc (always start looking up objects in the last used pack
first - 2007-05-30) introduce a static packed_git* pointer as an
optimization.

However keeping the pointer may become invalid if free_pack_by_name()
happens to free that particular pack.

Move the pointer out and reset the pointer in free_pack_by_name() if we
free it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3401301..155c808 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -53,6 +53,8 @@ static struct cached_object empty_tree =3D {
 	0
 };
=20
+static struct packed_git *find_pack_entry_last_found =3D (void *)1;
+
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
 	int i;
@@ -719,6 +721,8 @@ void free_pack_by_name(const char *pack_name)
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp =3D p->next;
+			if (find_pack_entry_last_found =3D=3D p)
+				find_pack_entry_last_found =3D (void*)1;
 			free(p);
 			return;
 		}
@@ -2010,14 +2014,13 @@ static int is_pack_valid(struct packed_git *p)
=20
 static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
 {
-	static struct packed_git *last_found =3D (void *)1;
 	struct packed_git *p;
 	off_t offset;
=20
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
-	p =3D (last_found =3D=3D (void *)1) ? packed_git : last_found;
+	p =3D (find_pack_entry_last_found =3D=3D (void *)1) ? packed_git : fi=
nd_pack_entry_last_found;
=20
 	do {
 		if (p->num_bad_objects) {
@@ -2044,16 +2047,16 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 			e->offset =3D offset;
 			e->p =3D p;
 			hashcpy(e->sha1, sha1);
-			last_found =3D p;
+			find_pack_entry_last_found =3D p;
 			return 1;
 		}
=20
 		next:
-		if (p =3D=3D last_found)
+		if (p =3D=3D find_pack_entry_last_found)
 			p =3D packed_git;
 		else
 			p =3D p->next;
-		if (p =3D=3D last_found)
+		if (p =3D=3D find_pack_entry_last_found)
 			p =3D p->next;
 	} while (p);
 	return 0;
--=20
1.7.4.74.g639db

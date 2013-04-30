From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] unpack_entry: invalidate newly added cache entry in case of error
Date: Tue, 30 Apr 2013 09:29:52 +0700
Message-ID: <1367288992-14979-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 04:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX0Jd-0002xx-5F
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 04:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759875Ab3D3C3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 22:29:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60373 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759543Ab3D3C3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 22:29:06 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx1so76576pab.40
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 19:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=he0FxksrcWn83j46/rMMeHc+vaPt5FsIdLnRhAHd+Lw=;
        b=OVi8m+BaDwnuaFvXTSCycJ2/uRI5be/x+FtYUgfiB0RW54zADXVPqrjHx96XTJ8hZQ
         7hklNyzpF4AZbQ+6J3P734eDwMbHQs0E6PeQ8eRU7kB/aUJBv9N6JeUWo24yknO7u9PM
         OHU1qVYWAs1BoTbs+0goAzOchQ5zpE6pkCaBA/cRaEULngOCTsw1QnMj0zjKjiiNCe12
         AThbOQLzBeAsB5XSGl/jVvHMN/TxqQo3NixMtNUo0UnTwee4oLRm/oymPxi4Urm9JL1E
         ybJ6+k+Ra7p0ruPsGEwlMlcFJCFpvkLk77Uk5CTi8pfzfhSW4OsbruJ5g6qTGvNo7u4W
         Sjxg==
X-Received: by 10.68.138.7 with SMTP id qm7mr75325258pbb.169.1367288945240;
        Mon, 29 Apr 2013 19:29:05 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id ze11sm28319541pab.22.2013.04.29.19.29.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 19:29:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 09:29:54 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222892>

In this particular code path, we add "base" to the delta base
cache. Then decide to free it, but we forgot about a dangling pointer
in the cache. Invalidate that entry when we free "base".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Some of my changes triggered a double free fault at "free(base);" in
 t5303. This looks like a correct thing to do, but I may be missing
 something (I'm not even sure how it happened). Please check.

 sha1_file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 64228a2..99ead7c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1912,7 +1912,8 @@ void clear_delta_base_cache(void)
 		release_delta_base_cache(&delta_base_cache[p]);
 }
=20
-static void add_delta_base_cache(struct packed_git *p, off_t base_offs=
et,
+static struct delta_base_cache_entry *
+add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
 	unsigned long hash =3D pack_entry_hash(p, base_offset);
@@ -1947,6 +1948,7 @@ static void add_delta_base_cache(struct packed_gi=
t *p, off_t base_offset,
 	ent->lru.prev =3D delta_base_cache_lru.prev;
 	delta_base_cache_lru.prev->next =3D &ent->lru;
 	delta_base_cache_lru.prev =3D &ent->lru;
+	return ent;
 }
=20
 static void *read_object(const unsigned char *sha1, enum object_type *=
type,
@@ -2086,12 +2088,13 @@ void *unpack_entry(struct packed_git *p, off_t =
obj_offset,
 		void *delta_data;
 		void *base =3D data;
 		unsigned long delta_size, base_size =3D size;
+		struct delta_base_cache_entry *ent =3D NULL;
 		int i;
=20
 		data =3D NULL;
=20
 		if (base)
-			add_delta_base_cache(p, obj_offset, base, base_size, type);
+			ent =3D add_delta_base_cache(p, obj_offset, base, base_size, type);
=20
 		if (!base) {
 			/*
@@ -2129,6 +2132,8 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 			      "at offset %"PRIuMAX" from %s",
 			      (uintmax_t)curpos, p->pack_name);
 			free(base);
+			if (ent)
+				ent->data =3D NULL;
 			data =3D NULL;
 			continue;
 		}
--=20
1.8.2.83.gc99314b

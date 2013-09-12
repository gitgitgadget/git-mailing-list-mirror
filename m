From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] pack v4: add v4_size to struct delta_base_cache_entry
Date: Thu, 12 Sep 2013 17:38:02 +0700
Message-ID: <1378982284-7848-2-git-send-email-pclouds@gmail.com>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 12:37:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4HM-0008OV-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab3ILKhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 06:37:36 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:40657 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab3ILKhg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:37:36 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so10370399pbc.26
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u3brLdXiKwISHaOYLEBFxAp9i++Gh54p73cNsgRyUCk=;
        b=JKATuwcE9w9ykp2cuqLeH40twkeEtLPwkNY+3pcA/OSURKXE8cG+itCr04nyGU7WCK
         49E95zDXGEZ+996aYrrgro2odaqw50h89bgsbaHM5gt79pYLrcA0GsAFhGPIe+jY6D6z
         +cK042SjD1wYwtMCh/9dCx2XifSzgd73SKGKgs3km25RSwjw0aKFb4e8dwRqNWugMJ7f
         E4KAjba3cLIyWN7xFADU4VNZX475mnE0KuxCDHfJFevXkKVjxiL0FbpbdYbKads+FTUO
         rvI8BZluxsj3KQzI+s0Yhuhc3u+uJHuOIaMD0C7jMBOk4FWVjfI7PPVMPB4aCj+e1Sj0
         59mA==
X-Received: by 10.68.135.35 with SMTP id pp3mr671016pbb.190.1378982255518;
        Thu, 12 Sep 2013 03:37:35 -0700 (PDT)
Received: from lanh ([115.73.201.215])
        by mx.google.com with ESMTPSA id cx4sm3939395pbc.24.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 03:37:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 12 Sep 2013 17:40:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234641>

The intention is to store flat v4 trees in delta base cache to avoid
repeatedly expanding copy sequences in v4 trees. When the user needs
to unpack a v4 tree and the tree is found in the cache, the tree will
be converted back to canonical format. Future tree_desc interface may
skip canonical format and read v4 trees directly.

=46or that to work we need to keep track of v4 tree size after all copy
sequences are expanded, which is the purpose of this new field.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 038e22e..03c66bb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1934,6 +1934,7 @@ static struct delta_base_cache_entry {
 	struct packed_git *p;
 	off_t base_offset;
 	unsigned long size;
+	unsigned long v4_size;
 	enum object_type type;
 } delta_base_cache[MAX_DELTA_CACHE];
=20
@@ -2015,7 +2016,8 @@ void clear_delta_base_cache(void)
 }
=20
 static void add_delta_base_cache(struct packed_git *p, off_t base_offs=
et,
-	void *base, unsigned long base_size, enum object_type type)
+	void *base, unsigned long base_size, unsigned long v4_size,
+	enum object_type type)
 {
 	unsigned long hash =3D pack_entry_hash(p, base_offset);
 	struct delta_base_cache_entry *ent =3D delta_base_cache + hash;
@@ -2045,6 +2047,7 @@ static void add_delta_base_cache(struct packed_gi=
t *p, off_t base_offset,
 	ent->type =3D type;
 	ent->data =3D base;
 	ent->size =3D base_size;
+	ent->v4_size =3D v4_size;
 	ent->lru.next =3D &delta_base_cache_lru;
 	ent->lru.prev =3D delta_base_cache_lru.prev;
 	delta_base_cache_lru.prev->next =3D &ent->lru;
@@ -2208,7 +2211,7 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 		data =3D NULL;
=20
 		if (base)
-			add_delta_base_cache(p, obj_offset, base, base_size, type);
+			add_delta_base_cache(p, obj_offset, base, base_size, 0, type);
=20
 		if (!base) {
 			/*
--=20
1.8.2.83.gc99314b

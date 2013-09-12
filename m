From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] pack v4: make use of cached v4 trees when unpacking
Date: Thu, 12 Sep 2013 17:38:04 +0700
Message-ID: <1378982284-7848-4-git-send-email-pclouds@gmail.com>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 12:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4HY-00008Y-GF
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab3ILKhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 06:37:48 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:62652 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3ILKhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:37:48 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so10465877pdi.5
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iQTugad60ixmgtylrzErhKHwCfswUNQIemB9qAzdvRg=;
        b=kvSRU7MjwPYmzKXchup3RApsA5GFDaN1wAWHeSSXFqPZ8gkmp96G1k3He0qqiZOIJf
         yN2/aXWwUE63fvXxhg7RT3Z7V82lQpC0+JsN3v6YNV4eRnnTOTchcJvrjsgQ2tURt5Cq
         b+AgVbP3rZy4QdGpYL0ZkQfAa3n8cFB94bOJLoep4U0vggqbGtQCFiafniHvo1CgTU94
         7Cmfqhmk2Hj5jaV2T4DDxvF9Iwah5NPimX6Sdl8JAcNCCx4JjleoRAEAiWk7HwqHB7K6
         AfE7nz2NYpu9Th/u4odt9/XlV18cbtSm5NHHF3Hw3NpjAVu6j9Aix0O2jMxvVXbSvPRA
         g6xw==
X-Received: by 10.66.169.172 with SMTP id af12mr8818968pac.23.1378982267636;
        Thu, 12 Sep 2013 03:37:47 -0700 (PDT)
Received: from lanh ([115.73.201.215])
        by mx.google.com with ESMTPSA id ve9sm3949634pbc.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 03:37:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 12 Sep 2013 17:41:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234643>

"git rev-list --objects v1.8.4" time is reduced from 29s to 10s with
this patch. But it is still a long way to catch up with v2: 4s.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The problem I see with decode_entries() is that given n copy
 sequences, it re-reads the same base n times. 30+ copy sequences are
 not unusual at all with git.git.

 I'm thinking of adding a cache to deal with one-base trees, which is
 all we have now. If we know in advance what base a tree needs without
 parsing the tree, we could unpack from base up like we do with
 ref-deltas. Because in this case we know the base is always flat, we
 could have a more efficient decode_entries that only goes through the
 base once. I want to get the timing down to as close as possible to
 v2 before adding v4-aware interface.

 Pack cache is an idea being cooked for a while by Jeff. Maybe we
 could merge his work to pack v4 or require it when pack v4 is finally
 merged to 'next'.

 packv4-parse.c | 17 +++++++++++++++--
 packv4-parse.h |  2 ++
 sha1_file.c    | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 5002f42..b8855b0 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -415,8 +415,20 @@ static int decode_entries(struct packed_git *p, st=
ruct pack_window **w_curs,
 	unsigned int nb_entries;
 	const unsigned char *src, *scp;
 	off_t copy_objoffset =3D 0;
+	const void *cached =3D NULL;
+	unsigned long cached_size, cached_v4_size;
+
+	if (hdr)	      /* we need offset point at obj header */
+		cached =3D get_cached_v4_tree(p, offset,
+					    &cached_size, &cached_v4_size);
+
+	if (cached) {
+		src =3D cached;
+		avail =3D cached_v4_size;
+		hdr =3D 0;
+	} else
+		src =3D use_pack(p, w_curs, offset, &avail);
=20
-	src =3D use_pack(p, w_curs, offset, &avail);
 	scp =3D src;
=20
 	if (hdr) {
@@ -452,7 +464,8 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 	while (count) {
 		unsigned int what;
=20
-		if (avail < 20) {
+		/* fixme: need to put bach the out-of-bound check when cached =3D=3D=
 1 */
+		if (!cached && avail < 20) {
 			src =3D use_pack(p, w_curs, offset, &avail);
 			if (avail < 20)
 				return -1;
diff --git a/packv4-parse.h b/packv4-parse.h
index 647b73c..f584c31 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -16,6 +16,8 @@ unsigned long pv4_unpack_object_header_buffer(const u=
nsigned char *base,
 					      unsigned long *sizep);
 const unsigned char *get_sha1ref(struct packed_git *p,
 				 const unsigned char **bufp);
+const void *get_cached_v4_tree(struct packed_git *p, off_t base_offset=
,
+			 unsigned long *size, unsigned long *v4_size);
=20
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs=
,
 		     off_t offset, unsigned long size);
diff --git a/sha1_file.c b/sha1_file.c
index b176316..82570be 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1967,6 +1967,20 @@ static int in_delta_base_cache(struct packed_git=
 *p, off_t base_offset)
 	return eq_delta_base_cache_entry(ent, p, base_offset);
 }
=20
+const void *get_cached_v4_tree(struct packed_git *p, off_t base_offset=
,
+			 unsigned long *size, unsigned long *v4_size)
+{
+	struct delta_base_cache_entry *ent;
+	ent =3D get_delta_base_cache_entry(p, base_offset);
+
+	if (!eq_delta_base_cache_entry(ent, p, base_offset) ||
+	    ent->type !=3D OBJ_PV4_TREE)
+		return NULL;
+	*size =3D ent->size;
+	*v4_size =3D ent->v4_size;
+	return ent->data;
+}
+
 static void clear_delta_base_cache_entry(struct delta_base_cache_entry=
 *ent)
 {
 	ent->data =3D NULL;
--=20
1.8.2.83.gc99314b

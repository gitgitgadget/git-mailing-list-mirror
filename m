From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/32] split-index: strip pathname of on-disk replaced entries
Date: Fri, 13 Jun 2014 19:19:43 +0700
Message-ID: <1402661991-14977-25-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:22:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQV3-0004Sb-6F
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbaFMMWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:25 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:63324 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbaFMMWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:24 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2135066pab.29
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9QXSHLXWQ7gZ54rh6F3B1jn8VOfIQ8Gk1xqgvC4wFkQ=;
        b=vpyahjW8vxpJZtELmLiaOekHzDAyZ/hfPtLY8FBnBMMU/yvFvRmkfMW7DbUSqCfXPD
         T4YWKhwWU8L7G6CgGXR+FObLFrLKECds+d+9PNHZl+rL5QoJ37YeLrp93faMmXSSO66w
         /1MPHkCGvoFth5YZCSVt2Rl/5BkY6AlMY8Ag3RqP/UBqp4Tf86Rc0fNfXuhiLyW+KeBF
         +qLifD9QKtJy65exy+MIppDbKovFHKAS3lTtKJPSNRYAkD2V2u36shXaQr6zqOmuOI2r
         7BmaMD4EhtXLOBok1rY2Icv4pomSpgiRjRzHY+XPVPOj6jouVMK2HKG4gNw1pJKG5Gov
         UBoQ==
X-Received: by 10.66.132.70 with SMTP id os6mr2906137pab.110.1402662143845;
        Fri, 13 Jun 2014 05:22:23 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id kl10sm3409740pbd.20.2014.06.13.05.22.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:23 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251580>

We know the positions of replaced entries via the replace bitmap in
"link" extension, so the "name" path does not have to be stored (it's
still in the shared index). With this, we also have a way to
distinguish additions vs replacements at load time and can catch
broken "link" extensions.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |  1 +
 read-cache.c  | 10 ++++++++++
 split-index.c | 14 ++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 70fd8ed..ddb7cd2 100644
--- a/cache.h
+++ b/cache.h
@@ -170,6 +170,7 @@ struct cache_entry {
 #define CE_MATCHED           (1 << 26)
=20
 #define CE_UPDATE_IN_BASE    (1 << 27)
+#define CE_STRIP_NAME        (1 << 28)
=20
 /*
  * Extended on-disk flags
diff --git a/read-cache.c b/read-cache.c
index d5f70a0..af475dc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1787,9 +1787,15 @@ static int ce_write_entry(git_SHA_CTX *c, int fd=
, struct cache_entry *ce,
 {
 	int size;
 	struct ondisk_cache_entry *ondisk;
+	int saved_namelen =3D saved_namelen; /* compiler workaround */
 	char *name;
 	int result;
=20
+	if (ce->ce_flags & CE_STRIP_NAME) {
+		saved_namelen =3D ce_namelen(ce);
+		ce->ce_namelen =3D 0;
+	}
+
 	if (!previous_name) {
 		size =3D ondisk_ce_size(ce);
 		ondisk =3D xcalloc(1, size);
@@ -1821,6 +1827,10 @@ static int ce_write_entry(git_SHA_CTX *c, int fd=
, struct cache_entry *ce,
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
 	}
+	if (ce->ce_flags & CE_STRIP_NAME) {
+		ce->ce_namelen =3D saved_namelen;
+		ce->ce_flags &=3D ~CE_STRIP_NAME;
+	}
=20
 	result =3D ce_write(c, fd, ondisk, size);
 	free(ondisk);
diff --git a/split-index.c b/split-index.c
index 33c0c4b..ee3246f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -89,6 +89,7 @@ static void replace_entry(size_t pos, void *data)
 	struct index_state *istate =3D data;
 	struct split_index *si =3D istate->split_index;
 	struct cache_entry *dst, *src;
+
 	if (pos >=3D istate->cache_nr)
 		die("position for replacement %d exceeds base index size %d",
 		    (int)pos, istate->cache_nr);
@@ -100,10 +101,14 @@ static void replace_entry(size_t pos, void *data)
 		die("entry %d is marked as both replaced and deleted",
 		    (int)pos);
 	src =3D si->saved_cache[si->nr_replacements];
+	if (ce_namelen(src))
+		die("corrupt link extension, entry %d should have "
+		    "zero length name", (int)pos);
 	src->index =3D pos + 1;
 	src->ce_flags |=3D CE_UPDATE_IN_BASE;
-	free(dst);
-	dst =3D src;
+	src->ce_namelen =3D dst->ce_namelen;
+	copy_cache_entry(dst, src);
+	free(src);
 	si->nr_replacements++;
 }
=20
@@ -131,6 +136,9 @@ void merge_base_index(struct index_state *istate)
 		remove_marked_cache_entries(istate);
=20
 	for (i =3D si->nr_replacements; i < si->saved_cache_nr; i++) {
+		if (!ce_namelen(si->saved_cache[i]))
+			die("corrupt link extension, entry %d should "
+			    "have non-zero length name", i);
 		add_index_entry(istate, si->saved_cache[i],
 				ADD_CACHE_OK_TO_ADD |
 				ADD_CACHE_KEEP_CACHE_TREE |
@@ -213,6 +221,7 @@ void prepare_to_write_split_index(struct index_stat=
e *istate)
 				ewah_set(si->delete_bitmap, i);
 			else if (ce->ce_flags & CE_UPDATE_IN_BASE) {
 				ewah_set(si->replace_bitmap, i);
+				ce->ce_flags |=3D CE_STRIP_NAME;
 				ALLOC_GROW(entries, nr_entries+1, nr_alloc);
 				entries[nr_entries++] =3D ce;
 			}
@@ -222,6 +231,7 @@ void prepare_to_write_split_index(struct index_stat=
e *istate)
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		ce =3D istate->cache[i];
 		if ((!si->base || !ce->index) && !(ce->ce_flags & CE_REMOVE)) {
+			assert(!(ce->ce_flags & CE_STRIP_NAME));
 			ALLOC_GROW(entries, nr_entries+1, nr_alloc);
 			entries[nr_entries++] =3D ce;
 		}
--=20
1.9.1.346.ga2b5940

From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] move prune_cache() to git lib
Date: Wed,  8 Apr 2009 20:05:27 +1000
Message-ID: <1239185133-4181-3-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:08:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUhz-0005bq-FU
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764069AbZDHKGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764005AbZDHKGp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:06:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763968AbZDHKGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:06:44 -0400
Received: by rv-out-0506.google.com with SMTP id f9so37692rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=142SIS2PJt3N+quumPCJFC7iGsHqTn4BohGrqNhBA0g=;
        b=tIvhYVZGO8/cCv0NcGe6mJNRRI3YQTtyZpa47qNS3gkEhKfM4GeihR3Up9+GsQp5No
         2jaJZDn2p7Cgrte2C05aj6iBu3l50iohr0Y69fcVdIWYqwl2Zszbv/AT9XcZbQItdd4t
         BMR3dn0SGxVnaLQmmW0jpG6s2luNj20PNstyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aRIX/u8jK6JXzZPC4LIY8aCMFEkpFmbX2ZDouCaAeI8/fR2gksywoX8H8grizYWNrV
         ND8X4UDEeFSjVuTse7pZhh4kGKspbRbp6f/1RKXI0kouCi17utZekKUuKLVFMvBvtAW7
         XoiG3yYfDcQlBuR0AfUF2A/tX9rDM6zCo8/+4=
Received: by 10.141.201.1 with SMTP id d1mr461940rvq.230.1239185203617;
        Wed, 08 Apr 2009 03:06:43 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id g31sm3502814rvb.38.2009.04.08.03.06.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:06:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:06:37 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116070>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c |   29 +----------------------------
 cache.h            |    2 ++
 read-cache.c       |   27 +++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 88e2697..0151647 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -206,33 +206,6 @@ static void show_files(struct dir_struct *dir, con=
st char *prefix)
 	}
 }
=20
-/*
- * Prune the index to only contain stuff starting with "prefix"
- */
-static void prune_cache(const char *prefix)
-{
-	int pos =3D cache_name_pos(prefix, prefix_len);
-	unsigned int first, last;
-
-	if (pos < 0)
-		pos =3D -pos-1;
-	memmove(active_cache, active_cache + pos,
-		(active_nr - pos) * sizeof(struct cache_entry *));
-	active_nr -=3D pos;
-	first =3D 0;
-	last =3D active_nr;
-	while (last > first) {
-		int next =3D (last + first) >> 1;
-		struct cache_entry *ce =3D active_cache[next];
-		if (!strncmp(ce->name, prefix, prefix_len)) {
-			first =3D next+1;
-			continue;
-		}
-		last =3D next;
-	}
-	active_nr =3D last;
-}
-
 static const char *verify_pathspec(const char *prefix)
 {
 	const char **p, *n, *prev;
@@ -541,7 +514,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		show_cached =3D 1;
=20
 	if (prefix)
-		prune_cache(prefix);
+		prune_cache(prefix, prefix_len);
 	if (with_tree) {
 		/*
 		 * Basic sanity check; show-stages and show-unmerged
diff --git a/cache.h b/cache.h
index ab1294d..54660a5 100644
--- a/cache.h
+++ b/cache.h
@@ -335,6 +335,7 @@ static inline void remove_name_hash(struct cache_en=
try *ce)
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st=
), (options))
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&t=
he_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_in=
dex, (name), (namelen))
+#define prune_cache(prefix, prefix_len) prune_index((prefix), (prefix_=
len), &the_index);
 #endif
=20
 enum object_type {
@@ -455,6 +456,7 @@ extern int add_file_to_index(struct index_state *, =
const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const u=
nsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char =
*, int);
+extern void prune_index(const char *prefix, int prefix_len, struct ind=
ex_state *istate);
=20
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index 3f58711..74f889e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1706,3 +1706,30 @@ int index_name_is_other(const struct index_state=
 *istate, const char *name,
 	}
 	return 1;
 }
+
+/*
+ * Prune the index to only contain stuff starting with "prefix"
+ */
+void prune_index(const char *prefix, int prefix_len, struct index_stat=
e *istate)
+{
+	int pos =3D index_name_pos(istate, prefix, prefix_len);
+	unsigned int first, last;
+
+	if (pos < 0)
+		pos =3D -pos-1;
+	memmove(istate->cache, istate->cache + pos,
+		(istate->cache_nr - pos) * sizeof(struct cache_entry *));
+	istate->cache_nr -=3D pos;
+	first =3D 0;
+	last =3D istate->cache_nr;
+	while (last > first) {
+		int next =3D (last + first) >> 1;
+		struct cache_entry *ce =3D istate->cache[next];
+		if (!strncmp(ce->name, prefix, prefix_len)) {
+			first =3D next+1;
+			continue;
+		}
+		last =3D next;
+	}
+	istate->cache_nr =3D last;
+}
--=20
1.6.2.2.602.g83ee9f

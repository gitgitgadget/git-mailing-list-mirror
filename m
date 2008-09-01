From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Extend index to save more flags
Date: Mon,  1 Sep 2008 21:16:25 +0700
Message-ID: <1220278585-26969-1-git-send-email-pclouds@gmail.com>
References: <48BBE881.1050206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 16:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaAE6-0005Yx-FY
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 16:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbYIAOQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 10:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYIAOQs
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 10:16:48 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:18928 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYIAOQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 10:16:47 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1889783wfd.4
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9NRjRvl8QTPEAF49l/Lo7tF6TUKUK/D+Vz2Jv9mcczY=;
        b=IDJTmLhyEoM7c2lzcm2j2ljVhyOZAibXCY4BZlMlmzq7Uduzu5BGUdnQMttP6qI9U0
         9/Nzdd1HODqiwt3TVKHkcr9O76zPfqxQGiasovfwhY5bjvVq4fF9Kk2c1PkFzD6sYYzU
         /QzWCmwb8CKlpNqOezxOCDyS5aU+ieDbiatxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i62J0aPvKChrCrqGWRRrcrdqwPvQOi/7zmTOwAPP6Mu3VbC7SVvxxeS5nHsRtWZJz8
         Te85XoZB3GVE3JttozDbqrr2kBc/LSEH0koTudcb48x0ArVqM6apVKx3MeoGeQ7ekGng
         PgAkDfBvZy6tTHvihTlzbl+BFozUNJWQ0LMk0=
Received: by 10.143.8.10 with SMTP id l10mr2117002wfi.340.1220278606956;
        Mon, 01 Sep 2008 07:16:46 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.54.222])
        by mx.google.com with ESMTPS id 27sm9686050wff.3.2008.09.01.07.16.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Sep 2008 07:16:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  1 Sep 2008 21:16:25 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <48BBE881.1050206@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94587>

The on-disk format of index only saves 16 bit flags, nearly all have
been used. The last bit (CE_EXTENDED) is used to for future extension.

This patch extends index entry format to save more flags in future.
The new entry format will be used when CE_EXTENDED bit is 1.

Because older implementation may not understand CE_EXTENDED bit and
misread the new format, if there is any extended entry in index, index
header version will turn 3, which makes it incompatible for older git.
If there is none, header version will return to 2 again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On 9/1/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
 >  > +/* Extended flags in ondisk_cache_entry_extended */
 >  > +#define CE_EXTENDED2 (0x80000000)
 >  > +#define CE_EXTENDED_MASK (CE_EXTENDED2)
 > =20
 > =20
 > Wouldn't it be better, from a maintainance point of view, to have
 > =20
 >  #define CE_EXTENDED_MASK 0xffff0000
 > =20
 >  right from the beginning?

 Actually it's not 16 bits. We have 16 bits on disk, but will not use
 all of them until cache_entry is adjusted. But I think extending the m=
ask
 makes sense.

 >  > +             /* For future extension: we do not understand the l=
ast bit yet */
 >  > +             if (ce->ce_flags & CE_EXTENDED2)
 >  > +                     die("Unknown index entry format");
 > =20
 > =20
 > At this point, we do not understand the CE_EXTENDED2 flag; but we do=
 not
 >  understand any of the other 15 extended flags, either. So, you shou=
ld
 >  error out if *any* of them is non-zero.
=20
 Fixed with CE_KNOWN_EXTENDED_FLAGS

 cache.h      |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 read-cache.c |   49 +++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 89 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index f725783..f8578d1 100644
--- a/cache.h
+++ b/cache.h
@@ -109,6 +109,26 @@ struct ondisk_cache_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
=20
+/*
+ * This struct is used when CE_EXTENDED bit is 1
+ * The struct must match ondisk_cache_entry exactly from
+ * ctime till flags
+ */
+struct ondisk_cache_entry_extended {
+	struct cache_time ctime;
+	struct cache_time mtime;
+	unsigned int dev;
+	unsigned int ino;
+	unsigned int mode;
+	unsigned int uid;
+	unsigned int gid;
+	unsigned int size;
+	unsigned char sha1[20];
+	unsigned short flags;
+	unsigned short flags2;
+	char name[FLEX_ARRAY]; /* more */
+};
+
 struct cache_entry {
 	unsigned int ce_ctime;
 	unsigned int ce_mtime;
@@ -130,7 +150,15 @@ struct cache_entry {
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
=20
-/* In-memory only */
+/*
+ * Range 0xFFFF0000 in ce_flags is divided into
+ * two parts: in-memory flags and on-disk ones.
+ * Flags in CE_EXTENDED_MASK will get saved on-disk
+ * so if you want an in-memory flag, remove it
+ * from CE_EXTENDED_MASK.
+ *
+ * In-memory only flags
+ */
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
 #define CE_UPTODATE  (0x40000)
@@ -140,6 +168,20 @@ struct cache_entry {
 #define CE_UNHASHED  (0x200000)
=20
 /*
+ * We'll be careful on new extended on-disk flags,
+ * Git will refuse to read unknown flags. When you
+ * add a new flag, add it to CE_KNOWN_EXTENDED_FLAGS.
+ * CE_EXTENDED2 is for future extension, so it will
+ * remain unknown until future is set.
+ *
+ * Extended on-disk flags
+ */
+#define CE_EXTENDED2 (0x80000000)
+
+#define CE_KNOWN_EXTENDED_FLAGS (0)
+#define CE_EXTENDED_MASK (0xFFC00000)
+
+/*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
  */
@@ -171,7 +213,9 @@ static inline size_t ce_namelen(const struct cache_=
entry *ce)
 }
=20
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
-#define ondisk_ce_size(ce) ondisk_cache_entry_size(ce_namelen(ce))
+#define ondisk_ce_size(ce) (((ce)->ce_flags & CE_EXTENDED) ? \
+			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
+			    ondisk_cache_entry_size(ce_namelen(ce)))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT=
)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
@@ -214,8 +258,10 @@ static inline int ce_to_dtype(const struct cache_e=
ntry *ce)
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
=20
-#define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (l=
en) + 8) & ~7)
-#define ondisk_cache_entry_size(len) ((offsetof(struct ondisk_cache_en=
try,name) + (len) + 8) & ~7)
+#define flexible_size(STRUCT,len) ((offsetof(struct STRUCT,name) + (le=
n) + 8) & ~7)
+#define cache_entry_size(len) flexible_size(cache_entry,len)
+#define ondisk_cache_entry_size(len) flexible_size(ondisk_cache_entry,=
len)
+#define ondisk_cache_entry_extended_size(len) flexible_size(ondisk_cac=
he_entry_extended,len)
=20
 struct index_state {
 	struct cache_entry **cache;
diff --git a/read-cache.c b/read-cache.c
index c5a8659..3bba6f7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1096,7 +1096,7 @@ static int verify_hdr(struct cache_header *hdr, u=
nsigned long size)
=20
 	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
 		return error("bad signature");
-	if (hdr->hdr_version !=3D htonl(2))
+	if (hdr->hdr_version !=3D htonl(2) && hdr->hdr_version !=3D htonl(3))
 		return error("bad index version");
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, size - 20);
@@ -1131,6 +1131,7 @@ int read_index(struct index_state *istate)
 static void convert_from_disk(struct ondisk_cache_entry *ondisk, struc=
t cache_entry *ce)
 {
 	size_t len;
+	const char *name;
=20
 	ce->ce_ctime =3D ntohl(ondisk->ctime.sec);
 	ce->ce_mtime =3D ntohl(ondisk->mtime.sec);
@@ -1143,19 +1144,29 @@ static void convert_from_disk(struct ondisk_cac=
he_entry *ondisk, struct cache_en
 	/* On-disk flags are just 16 bits */
 	ce->ce_flags =3D ntohs(ondisk->flags);
=20
-	/* For future extension: we do not understand this entry yet */
-	if (ce->ce_flags & CE_EXTENDED)
-		die("Unknown index entry format");
 	hashcpy(ce->sha1, ondisk->sha1);
=20
 	len =3D ce->ce_flags & CE_NAMEMASK;
+
+	if (ce->ce_flags & CE_EXTENDED) {
+		struct ondisk_cache_entry_extended *ondisk2;
+		ondisk2 =3D (struct ondisk_cache_entry_extended *)ondisk;
+		ce->ce_flags |=3D (ntohs(ondisk2->flags2) << 16) & CE_EXTENDED_MASK;
+		/* We do not understand any bit out of CE_KNOWN_EXTENDED_FLAGS */
+		if (ce->ce_flags & (CE_EXTENDED_MASK & ~CE_KNOWN_EXTENDED_FLAGS))
+			die("Unknown index entry format");
+		name =3D ondisk2->name;
+	}
+	else
+		name =3D ondisk->name;
+
 	if (len =3D=3D CE_NAMEMASK)
-		len =3D strlen(ondisk->name);
+		len =3D strlen(name);
 	/*
 	 * NEEDSWORK: If the original index is crafted, this copy could
 	 * go unchecked.
 	 */
-	memcpy(ce->name, ondisk->name, len + 1);
+	memcpy(ce->name, name, len + 1);
 }
=20
 static inline size_t estimate_cache_size(size_t ondisk_size, unsigned =
int entries)
@@ -1415,6 +1426,7 @@ static int ce_write_entry(SHA_CTX *c, int fd, str=
uct cache_entry *ce)
 {
 	int size =3D ondisk_ce_size(ce);
 	struct ondisk_cache_entry *ondisk =3D xcalloc(1, size);
+	char *name;
=20
 	ondisk->ctime.sec =3D htonl(ce->ce_ctime);
 	ondisk->ctime.nsec =3D 0;
@@ -1428,7 +1440,15 @@ static int ce_write_entry(SHA_CTX *c, int fd, st=
ruct cache_entry *ce)
 	ondisk->size =3D htonl(ce->ce_size);
 	hashcpy(ondisk->sha1, ce->sha1);
 	ondisk->flags =3D htons(ce->ce_flags);
-	memcpy(ondisk->name, ce->name, ce_namelen(ce));
+	if (ce->ce_flags & CE_EXTENDED) {
+		struct ondisk_cache_entry_extended *ondisk2;
+		ondisk2 =3D (struct ondisk_cache_entry_extended *)ondisk;
+		ondisk2->flags2 =3D htons((ce->ce_flags & CE_EXTENDED_MASK) >> 16);
+		name =3D ondisk2->name;
+	}
+	else
+		name =3D ondisk->name;
+	memcpy(name, ce->name, ce_namelen(ce));
=20
 	return ce_write(c, fd, ondisk, size);
 }
@@ -1437,16 +1457,25 @@ int write_index(const struct index_state *istat=
e, int newfd)
 {
 	SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed;
+	int i, err, removed, extended;
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
=20
-	for (i =3D removed =3D 0; i < entries; i++)
+	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
=20
+		/* reduce extended entries if possible */
+		cache[i]->ce_flags &=3D ~CE_EXTENDED;
+		if (cache[i]->ce_flags & CE_EXTENDED_MASK) {
+			extended++;
+			cache[i]->ce_flags |=3D CE_EXTENDED;
+		}
+	}
+
 	hdr.hdr_signature =3D htonl(CACHE_SIGNATURE);
-	hdr.hdr_version =3D htonl(2);
+	/* for extended format, increase version so older git won't try to re=
ad it */
+	hdr.hdr_version =3D htonl(extended ? 3 : 2);
 	hdr.hdr_entries =3D htonl(entries - removed);
=20
 	SHA1_Init(&c);
--=20
1.6.0.96.g2fad1.dirty

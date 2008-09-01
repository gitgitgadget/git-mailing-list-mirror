From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Extend index to save more flags
Date: Mon,  1 Sep 2008 18:32:38 +0700
Message-ID: <1220268758-29550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 01 13:34:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka7fg-0006lL-30
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 13:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbYIALdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 07:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbYIALdD
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 07:33:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:56690 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYIALdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 07:33:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1837311wfd.4
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=KJ4CDiURaFBf/E6utzoRvM6BVWolaCKcW5g+bMw+oLM=;
        b=Z39nK6FLgiuAVnHeRxJx6REN2QyIJM8A0bZpLcpHgDvKAGuthoCv2V+AZKO/LG7RXX
         9N2sjL1Lbf4w/R/eYLb1OTxgSgFAVPdJJjwUtuOQ5aur2/zjFxCsyq7yyNfF8tOe8VnC
         nfdlNd0lZHEk1xRlW1nImeQSfD5l53vqPw+P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HU5EI1K6Uf/0RUnJWNEVw6HaRC2/N+0G9F9NaqRhCXTLB+pgagBCJ8AKXBR6/kmTdR
         IxTAUWelPmOZGrxgnwrMZxl7u0SedmTdZbaDDgscFcTjbbfdFdg9ovTPVMcgxgheTDBt
         n1MggpKkZZ7qxG7cvLhK+m0W4UiXte0vA1N5I=
Received: by 10.142.245.6 with SMTP id s6mr2068002wfh.187.1220268779577;
        Mon, 01 Sep 2008 04:32:59 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.54.222])
        by mx.google.com with ESMTPS id 30sm9828674wfd.1.2008.09.01.04.32.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Sep 2008 04:32:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  1 Sep 2008 18:32:38 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94575>

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
 > Ok.  We would need to use an extra bit for this.
 >
 > The bit 0x4000 is the last one available, so we would want to use it=
 as
 > "this index entry uses more bits than the traditional format" bit, a=
nd
 > define a backward incompatible on-disk index entry format to actuall=
y
 > record CE_NO_CHECKOUT and other flags we will invent in the future.
 >
 > Perhaps ondisk_cache_entry structure will have an extra "unsigned in=
t
 > flags2" after "flags" when that bit is on, and we can have 31 more b=
its in
 > flags2, with the highest bit of flags2 signalling the presense of fl=
ags3
 > word in the future, or something like that.

 I was about to add a new field in cache_entry in order to have 31 new =
bits,
 but that led to initialization nightmare because there is no common ro=
utine
 to initialize cache_entry, the new field must be initialized too many =
places.

 So new ondisk bits will stay in cache_entry.ce_flags. That means 9 bit=
s left
 for both new on-disk bits and in-memory ones. Narrow/sparse checkout w=
ill
 use 2. The remaining 7 bits will probably be enough for coming years?

 cache.h      |   34 +++++++++++++++++++++++++++++++---
 read-cache.c |   49 +++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index f725783..120ed07 100644
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
@@ -139,6 +159,10 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Extended flags in ondisk_cache_entry_extended */
+#define CE_EXTENDED2 (0x80000000)
+#define CE_EXTENDED_MASK (CE_EXTENDED2)
+
 /*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
@@ -171,7 +195,9 @@ static inline size_t ce_namelen(const struct cache_=
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
@@ -214,8 +240,10 @@ static inline int ce_to_dtype(const struct cache_e=
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
index c5a8659..a5bfa8e 100644
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
+		/* For future extension: we do not understand the last bit yet */
+		if (ce->ce_flags & CE_EXTENDED2)
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

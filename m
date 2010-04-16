From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC 3/5] cache: Added index extension "NORM".
Date: Fri, 16 Apr 2010 18:10:00 +0200
Message-ID: <ced9c9c5e0a40223f71b64187e9049d3d367f66c.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 18:43:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ods-0005I4-Dw
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557Ab0DPQnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 12:43:16 -0400
Received: from mail.roxen.com ([212.247.29.220]:36684 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757833Ab0DPQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:43:15 -0400
X-Greylist: delayed 1981 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2010 12:43:15 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 54E1C62821A
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aA-ZLIou1sxw for <git@vger.kernel.org>;
	Fri, 16 Apr 2010 18:10:06 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id CAB1A62822F
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:06 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3GGA6Ot021800;
	Fri, 16 Apr 2010 18:10:06 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3GGA6Vf021799;
	Fri, 16 Apr 2010 18:10:06 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145077>

The index can now store and retrieve the ce_norm_sha1 data.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 cache.h      |    7 +++++++
 read-cache.c |   49 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 536697d..0cb3110 100644
--- a/cache.h
+++ b/cache.h
@@ -157,6 +157,13 @@ struct cache_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
=20
+struct ondisk_norm_sha1 {
+	unsigned int entry_no;
+	unsigned int norm_flags;
+	unsigned int norm_size;
+	unsigned char norm_sha1[20];
+};
+
 #define NORM_CONV_CRLF	0x0001
 #define NORM_CONV_GUESS	0x0002
 #define NORM_CONV_IDENT	0x0004
diff --git a/read-cache.c b/read-cache.c
index f1f789b..002160e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,6 +27,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_NORM_SHA1 0x4e4f524d	/* "NORM" */
=20
 struct index_state the_index;
=20
@@ -1178,6 +1179,21 @@ static int verify_hdr(struct cache_header *hdr, =
unsigned long size)
 	return 0;
 }
=20
+static int norm_sha1_read(struct cache_entry **cache, unsigned int ent=
ries,
+			  const struct ondisk_norm_sha1 *data, unsigned long sz)
+{
+	while (sz >=3D sizeof(*data)) {
+		unsigned int entry_no =3D ntohl(data->entry_no);
+		if (entry_no < entries) {
+			cache[entry_no]->norm_flags =3D ntohl(data->norm_flags);
+			memcpy(cache[entry_no]->norm_sha1, data->norm_sha1, 20);
+		}
+		sz -=3D sizeof(*data);
+		data++;
+	}
+	return 0;
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1188,6 +1204,9 @@ static int read_index_extension(struct index_stat=
e *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_NORM_SHA1:
+		return norm_sha1_read(istate->cache, istate->cache_nr, data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1511,6 +1530,16 @@ static void ce_smudge_racily_clean_entry(struct =
cache_entry *ce)
 	}
 }
=20
+static void norm_sha1_write(struct strbuf *sb, const struct cache_entr=
y *ce,
+			    int entry_no)
+{
+	struct ondisk_norm_sha1 entry;
+	entry.entry_no =3D htonl(entry_no);
+	entry.norm_flags =3D htonl(ce->norm_flags);
+	memcpy(entry.norm_sha1, ce->norm_sha1, 20);
+	strbuf_add(sb, &entry, sizeof(entry));
+}
+
 static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *=
ce)
 {
 	int size =3D ondisk_ce_size(ce);
@@ -1546,10 +1575,11 @@ int write_index(struct index_state *istate, int=
 newfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended;
+	int i, j, err, removed, extended;
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
 	struct stat st;
+	struct strbuf sb =3D STRBUF_INIT;
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1572,7 +1602,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
=20
-	for (i =3D 0; i < entries; i++) {
+	for (i =3D j =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
@@ -1580,12 +1610,21 @@ int write_index(struct index_state *istate, int=
 newfd)
 			ce_smudge_racily_clean_entry(ce);
 		if (ce_write_entry(&c, newfd, ce) < 0)
 			return -1;
+		if (ce->norm_flags)
+			norm_sha1_write(&sb, ce, j);
+		j++;
 	}
=20
 	/* Write extension data here */
+	if (sb.len) {
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_NORM_SHA1,
+					     sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 	if (istate->cache_tree) {
-		struct strbuf sb =3D STRBUF_INIT;
-
 		cache_tree_write(&sb, istate->cache_tree);
 		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < =
0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
@@ -1594,8 +1633,6 @@ int write_index(struct index_state *istate, int n=
ewfd)
 			return -1;
 	}
 	if (istate->resolve_undo) {
-		struct strbuf sb =3D STRBUF_INIT;
-
 		resolve_undo_write(&sb, istate->resolve_undo);
 		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0
--=20
1.7.0.4.369.g81e89

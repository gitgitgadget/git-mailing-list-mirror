From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 4/5] cache: Add index extension "CONV".
Date: Tue,  1 Jun 2010 16:41:54 +0200
Message-ID: <6b41ac9d06d0180b3a03b99449f8307530804eb9.1275309129.git.grubba@grubba.org>
References: <cover.1275309129.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 16:42:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJSft-0004VS-SC
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 16:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445Ab0FAOmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 10:42:23 -0400
Received: from mail.roxen.com ([212.247.29.220]:56710 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755995Ab0FAOmW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 10:42:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id B1764628236
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:42:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D90gWqO2eRIk for <git@vger.kernel.org>;
	Tue,  1 Jun 2010 16:42:20 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 8B848628234
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:42:20 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.14.4+Sun/8.14.4) with ESMTP id o51EgAG6021831;
	Tue, 1 Jun 2010 16:42:10 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.14.4+Sun/8.14.4/Submit) id o51EgAYf021830;
	Tue, 1 Jun 2010 16:42:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1275309129.git.grubba@grubba.org>
In-Reply-To: <cover.1275309129.git.grubba@grubba.org>
References: <cover.1275309129.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148122>

The index can now store and retrieve the ce_conv_flags data.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
The on disk format has changed slightly due to the changes in the
previous patch, but the change should have minimal impact, since
it typically only would force a one-time reindex.

 read-cache.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++-----
 1 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index eeda928..630e001 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,6 +27,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_CONV 0x434f4e56	/* "CONV" */
=20
 struct index_state the_index;
=20
@@ -1209,6 +1210,34 @@ static int verify_hdr(struct cache_header *hdr, =
unsigned long size)
 	return 0;
 }
=20
+/* The on disk format is the default conversion flags followed
+ * by alternating cache entry numbers and corresponding flags.
+ */
+static int conv_read(struct cache_entry **cache, unsigned int entries,
+		     const unsigned int *data, unsigned long sz)
+{
+	unsigned int entry_no;
+	unsigned int default_conv_flags;
+	if (sz < sizeof(*data))
+		return 0;
+	default_conv_flags =3D ntohl(*data);
+	data++;
+	sz -=3D sizeof(*data);
+	if (default_conv_flags) {
+		for (entry_no =3D 0; entry_no < entries; entry_no++)
+			cache[entry_no]->ce_conv_flags =3D default_conv_flags;
+	}
+	while (sz >=3D 2*sizeof(*data)) {
+		entry_no =3D ntohl(*data);
+		data++;
+		if (entry_no >=3D entries) break;
+		cache[entry_no]->ce_conv_flags =3D ntohl(*data);
+		data++;
+		sz -=3D 2*sizeof(*data);
+	}
+	return 0;
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1219,6 +1248,9 @@ static int read_index_extension(struct index_stat=
e *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_CONV:
+		return conv_read(istate->cache, istate->cache_nr, data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1542,6 +1574,15 @@ static void ce_smudge_racily_clean_entry(struct =
cache_entry *ce)
 	}
 }
=20
+static void conv_write(struct strbuf *sb, const struct cache_entry *ce=
,
+		       int entry_no)
+{
+	unsigned int entry[2];
+	entry[0] =3D htonl(entry_no);
+	entry[1] =3D htonl(ce->ce_conv_flags);
+	strbuf_add(sb, &entry, sizeof(entry));
+}
+
 static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *=
ce)
 {
 	int size =3D ondisk_ce_size(ce);
@@ -1577,10 +1618,12 @@ int write_index(struct index_state *istate, int=
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
+	unsigned int default_conv_flags;
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1603,7 +1646,10 @@ int write_index(struct index_state *istate, int =
newfd)
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
=20
-	for (i =3D 0; i < entries; i++) {
+	default_conv_flags =3D git_conv_flags("");
+	strbuf_add_uint32(&sb, default_conv_flags);
+
+	for (i =3D j =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
@@ -1611,12 +1657,21 @@ int write_index(struct index_state *istate, int=
 newfd)
 			ce_smudge_racily_clean_entry(ce);
 		if (ce_write_entry(&c, newfd, ce) < 0)
 			return -1;
+		if (ce->ce_conv_flags !=3D default_conv_flags)
+			conv_write(&sb, ce, j);
+		j++;
 	}
=20
 	/* Write extension data here */
+	if (default_conv_flags || sb.len > sizeof(default_conv_flags)) {
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_CONV, sb.len) < =
0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	} else
+		strbuf_release(&sb);
 	if (istate->cache_tree) {
-		struct strbuf sb =3D STRBUF_INIT;
-
 		cache_tree_write(&sb, istate->cache_tree);
 		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < =
0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
@@ -1625,8 +1680,6 @@ int write_index(struct index_state *istate, int n=
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

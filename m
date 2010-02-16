From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v3 3/4] Refactoring: move duplicated code from builtin-pack-objects.c and fast-import.c to sha1_file.c
Date: Tue, 16 Feb 2010 23:42:54 +0000
Message-ID: <19aeabff19266007077131b437571b047ef4c9e3.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:43:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhX56-0007Y0-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933562Ab0BPXn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:43:28 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50258 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504Ab0BPXn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:43:26 -0500
Received: by mail-bw0-f219.google.com with SMTP id 19so5008472bwz.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 15:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=qPa2H3dhmGe1JrmKeSJxRemUgoRJXe7dtEfdJf6fCtU=;
        b=LXARZ/Ph0zBAjBNXUr1Umy0QUXVrKJYYFmNaKfgDn4dfKhrdM46AP0ewN5GalikqkN
         Y7drw97/czfrXo1PxY4QLF1ipboIZFGH6W1SeAwuz3q//p9WLNiXrjQZlNHmc1NfTb60
         8pUseUAg46U8sC61cplpkbuKPRi7SBVT2DOvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nz3dbLCN0q4kWNS7Quji+jqTwdoJG1oWzF+mPLx5JWb2Ls0KiZC5gKWZKs6m/tBl6d
         i/0AuF2sAEJW/bjaR4LD5+ekFjS0Nc63ClTTtW1Ht7mE52JF81GB15ayrvkGGxFsnVU6
         BdTPMkUKpSttaLEi2mSa/c0t65Qj42c0cyprU=
Received: by 10.204.152.214 with SMTP id h22mr4794058bkw.125.1266363806124;
        Tue, 16 Feb 2010 15:43:26 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 16sm3349665bwz.7.2010.02.16.15.43.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 15:43:25 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140175>

The following function is duplicated:

  encode_header

Move this function to sha1_file.c and rename it 'encode_in_pack_object_header',
as suggested by Junio C Hamano

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-pack-objects.c |   31 ++-----------------------------
 cache.h                |    8 ++++++++
 fast-import.c          |   29 +++--------------------------
 sha1_file.c            |   20 ++++++++++++++++++++
 4 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e1d3adf..6b2f65c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -155,33 +155,6 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 }
 
 /*
- * The per-object header is a pretty dense thing, which is
- *  - first byte: low four bits are "size", then three bits of "type",
- *    and the high bit is "size continues".
- *  - each byte afterwards: low seven bits are size continuation,
- *    with the high bit being "size continues"
- */
-static int encode_header(enum object_type type, unsigned long size, unsigned char *hdr)
-{
-	int n = 1;
-	unsigned char c;
-
-	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
-		die("bad type %d", type);
-
-	c = (type << 4) | (size & 15);
-	size >>= 4;
-	while (size) {
-		*hdr++ = c | 0x80;
-		c = size & 0x7f;
-		size >>= 7;
-		n++;
-	}
-	*hdr = c;
-	return n;
-}
-
-/*
  * we are going to reuse the existing object data as is.  make
  * sure it is not corrupt.
  */
@@ -321,7 +294,7 @@ static unsigned long write_object(struct sha1file *f,
 		 * The object header is a byte of 'type' followed by zero or
 		 * more bytes of length.
 		 */
-		hdrlen = encode_header(type, size, header);
+		hdrlen = encode_in_pack_object_header(type, size, header);
 
 		if (type == OBJ_OFS_DELTA) {
 			/*
@@ -372,7 +345,7 @@ static unsigned long write_object(struct sha1file *f,
 		if (entry->delta)
 			type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
-		hdrlen = encode_header(type, entry->size, header);
+		hdrlen = encode_in_pack_object_header(type, entry->size, header);
 
 		offset = entry->in_pack_offset;
 		revidx = find_pack_revindex(p, offset);
diff --git a/cache.h b/cache.h
index d478eff..2654b60 100644
--- a/cache.h
+++ b/cache.h
@@ -911,6 +911,14 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+/*
+ * The per-object header is a pretty dense thing, which is
+ *  - first byte: low four bits are "size", then three bits of "type",
+ *    and the high bit is "size continues".
+ *  - each byte afterwards: low seven bits are size continuation,
+ *    with the high bit being "size continues"
+ */
+int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned char *hdr);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/fast-import.c b/fast-import.c
index b477dc6..776782a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1013,29 +1013,6 @@ static void cycle_packfile(void)
 	start_packfile();
 }
 
-static size_t encode_header(
-	enum object_type type,
-	uintmax_t size,
-	unsigned char *hdr)
-{
-	int n = 1;
-	unsigned char c;
-
-	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
-		die("bad type %d", type);
-
-	c = (type << 4) | (size & 15);
-	size >>= 4;
-	while (size) {
-		*hdr++ = c | 0x80;
-		c = size & 0x7f;
-		size >>= 7;
-		n++;
-	}
-	*hdr = c;
-	return n;
-}
-
 static int store_object(
 	enum object_type type,
 	struct strbuf *dat,
@@ -1138,7 +1115,7 @@ static int store_object(
 		delta_count_by_type[type]++;
 		e->depth = last->depth + 1;
 
-		hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
+		hdrlen = encode_in_pack_object_header(OBJ_OFS_DELTA, deltalen, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
 		pack_size += hdrlen;
 
@@ -1149,7 +1126,7 @@ static int store_object(
 		pack_size += sizeof(hdr) - pos;
 	} else {
 		e->depth = 0;
-		hdrlen = encode_header(type, dat->len, hdr);
+		hdrlen = encode_in_pack_object_header(type, dat->len, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
 		pack_size += hdrlen;
 	}
@@ -1209,7 +1186,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	memset(&s, 0, sizeof(s));
 	deflateInit(&s, pack_compression_level);
 
-	hdrlen = encode_header(OBJ_BLOB, len, out_buf);
+	hdrlen = encode_in_pack_object_header(OBJ_BLOB, len, out_buf);
 	if (out_sz <= hdrlen)
 		die("impossibly large object header");
 
diff --git a/sha1_file.c b/sha1_file.c
index 657825e..f3c9823 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1475,6 +1475,26 @@ const char *packed_object_info_detail(struct packed_git *p,
 	}
 }
 
+int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned char *hdr)
+{
+	int n = 1;
+	unsigned char c;
+
+	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
+		die("bad type %d", type);
+
+	c = (type << 4) | (size & 15);
+	size >>= 4;
+	while (size) {
+		*hdr++ = c | 0x80;
+		c = size & 0x7f;
+		size >>= 7;
+		n++;
+	}
+	*hdr = c;
+	return n;
+}
+
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
 			      unsigned long *sizep)
 {
-- 
1.7.0.1571.g856c2

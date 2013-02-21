From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Another slash at index size
Date: Thu, 21 Feb 2013 16:45:21 +0700
Message-ID: <1361439921-13270-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 10:46:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Sji-0003q1-8H
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 10:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab3BUJqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 04:46:15 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36777 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab3BUJqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 04:46:11 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so3429296pbc.8
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=s3HsHgWzUWTgRZjeDJz+pR070uBaJas5/OYhVxfv3A4=;
        b=A9R4MXcO+Mz/eMbX1eFKeuqswNBBZ/KPKcmAuP3lgw2Ni+N9oWXOjYE9s9alOyo/1n
         93C1weewV1BcYDlAs8kYnJ77SBDBoWoMpb25ItHU0OUxM3XabYebtSBLyiLKyM97x9Rg
         LZlcsjvbJyAo6oswaUJDntgYP+h+pNXhTIMFfSEWxvILQz+Y9hjmY/agdaBEImdYaAHs
         0olFv/TXOTE83q89VhmEnvTkPH12ouK4LrhDsRmOUau7p7aedNH/ugwjNeCzcUstAoAj
         59u+Ve30b68HptrDFxwlsLuwklaBkHTVThRjMzJp19lihYmgzbJUqukZKdtLzACiuulB
         u5Yg==
X-Received: by 10.66.175.143 with SMTP id ca15mr7333059pac.155.1361439970978;
        Thu, 21 Feb 2013 01:46:10 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ax3sm24811651pbd.42.2013.02.21.01.46.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Feb 2013 01:46:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 21 Feb 2013 16:45:28 +0700
X-Mailer: git-send-email 1.8.1.2.495.g3fdf5d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216761>

I noticed that even with v4, we still duplicate a lot of info in the
remaining fields. ce_uid and ce_guid for instance are unlikely to
change ever between entries. So I attempt to store offsets between the
previous entry instead. The result looks good. This is webkit index:

 25M index-v2
 14M index-v4
7.7M index-v5
4.5M index-v5.gz

gzip beats me naturally, we still have a lot of spare bits and we
don't use dictionaries. But the code is simpler and should run faster
than gzip.

Performance is improved too:

$ time GIT_INDEX_FILE=index-v2 ./git ls-files |head -n1 >/dev/null

real    0m0.437s
user    0m0.385s
sys     0m0.048s
$ time GIT_INDEX_FILE=index-v4 ./git ls-files |head -n1 >/dev/null

real    0m0.319s
user    0m0.277s
sys     0m0.040s
$ time GIT_INDEX_FILE=index-v5 ./git ls-files |head -n1 >/dev/null

real    0m0.250s
user    0m0.213s
sys     0m0.036s

Some details on the new format:

 - in general varint is used to store numbers, unless we know the
   numbers are really big.
 - flags is the first field on disk, it has extra bits to let git know
   what to do with the rest of the fields
 - Many fields like ctime, mtime, uid, gid, dev, ino are stored as
   offsets
 - ce_mode's special values 100644 and 100755 are stored in flags. So
   unless you use gitlinks or something else, ce_mode will not be
   stored.
 - ce_namelen is no longer stored on disk
 - pathname is compressed just like in v4

---
 cache.h      |   2 +-
 read-cache.c | 273 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 269 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index e493563..6ab53e7 100644
--- a/cache.h
+++ b/cache.h
@@ -106,7 +106,7 @@ struct cache_header {
 };
 
 #define INDEX_FORMAT_LB 2
-#define INDEX_FORMAT_UB 4
+#define INDEX_FORMAT_UB 5
 
 /*
  * The "cache_time" is just the low 32 bits of the
diff --git a/read-cache.c b/read-cache.c
index 827ae55..147ace1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1260,7 +1260,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version = ntohl(hdr->hdr_version);
-	if (hdr_version < 2 || 4 < hdr_version)
+	if (hdr_version < 2 || 5 < hdr_version)
 		return error("bad index version %d", hdr_version);
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
@@ -1407,6 +1407,137 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+/*
+ * Often used flags come first to keep flags in common case small so
+ * that encode_varint() produces fewer bytes
+ */
+#define CE5_OFS_MTIME		(1 << 0)
+#define CE5_MODEMASK		(3 << 1)
+#define CE5_MODE_644		 0
+#define CE5_MODE_755		(1 << 1)
+#define CE5_MODE_FULL		(2 << 1)
+#define CE5_FULL_INO		(1 << 3)
+#define CE5_STAGESHIFT		 4
+#define CE5_STAGEMASK		(3 << CE5_STAGESHIFT)
+#define CE5_ITA			(1 << 6)
+#define CE5_VALID		(1 << 7)
+#define CE5_SWT			(1 << 8)
+#define CE5_FULL_UID		(1 << 9)
+#define CE5_FULL_GID		(1 << 10)
+#define CE5_FULL_TIME		(1 << 11)
+#define CE5_FULL_DEV		(1 << 12)
+
+static uintmax_t decode_offset(const unsigned char **bufp, uintmax_t base)
+{
+	uintmax_t offset = decode_varint(bufp);
+	if (offset & 1)	/* negative */
+		return base - (offset >> 1);
+	else
+		return base + (offset >> 1);
+
+}
+
+static struct cache_entry *create_from_disk_v5(const unsigned char *data,
+					       unsigned long *consumed,
+					       struct strbuf *previous_name,
+					       const struct cache_entry *previous_ce)
+{
+	const unsigned char *orig = data;
+	struct cache_entry ce_tmp;
+	struct cache_entry *ce;
+	unsigned int flags;
+
+	flags = decode_varint(&data);
+	ce_tmp.ce_flags = ((flags & CE5_STAGEMASK) >> CE5_STAGESHIFT) << CE_STAGESHIFT;
+	if (flags & CE5_ITA)
+		ce_tmp.ce_flags |= CE_INTENT_TO_ADD;
+	if (flags & CE5_VALID)
+		ce_tmp.ce_flags |= CE_VALID;
+	if (flags & CE5_SWT)
+		ce_tmp.ce_flags |= CE_SKIP_WORKTREE;
+
+	if (flags & CE5_FULL_TIME) { /* full format, 16 bytes */
+		ce_tmp.ce_ctime.sec = ntoh_l(*(uint32_t*)data);
+		data += sizeof(uint32_t);
+		ce_tmp.ce_ctime.nsec = ntoh_l(*(uint32_t*)data);
+		data += sizeof(uint32_t);
+
+		ce_tmp.ce_mtime.sec = ntoh_l(*(uint32_t*)data);
+		data += sizeof(uint32_t);
+		ce_tmp.ce_mtime.nsec = ntoh_l(*(uint32_t*)data);
+		data += sizeof(uint32_t);
+	} else {
+		/* offset from previous ce */
+		ce_tmp.ce_ctime.sec = decode_offset(&data, previous_ce->ce_ctime.sec);
+		ce_tmp.ce_ctime.nsec = decode_offset(&data, previous_ce->ce_ctime.nsec);
+
+		if (flags & CE5_OFS_MTIME) {
+			/* offset from previous ce */
+			ce_tmp.ce_mtime.sec = decode_offset(&data, previous_ce->ce_mtime.sec);
+			ce_tmp.ce_mtime.nsec = decode_offset(&data, previous_ce->ce_mtime.nsec);
+		} else
+			ce_tmp.ce_mtime = ce_tmp.ce_ctime;
+	}
+
+
+	if (flags & CE5_FULL_DEV)
+		ce_tmp.ce_dev = decode_varint(&data);
+	else
+		ce_tmp.ce_dev = previous_ce->ce_dev;
+	if (flags & CE5_FULL_INO) {
+		ce_tmp.ce_ino = ntoh_l(*(uint32_t*)data);
+		data += sizeof(uint32_t);
+	} else {
+		uintmax_t offset = decode_varint(&data);
+		if (offset & 1)	/* negative */
+			ce_tmp.ce_ino = previous_ce->ce_ino - (offset >> 1);
+		else
+			ce_tmp.ce_ino = previous_ce->ce_ino + (offset >> 1);
+	}
+	switch (flags & CE5_MODEMASK) {
+	case CE5_MODE_644:
+		ce_tmp.ce_mode = 0100644;
+		break;
+	case CE5_MODE_755:
+		ce_tmp.ce_mode = 0100755;
+		break;
+	case CE5_MODE_FULL:
+		ce_tmp.ce_mode = decode_varint(&data);
+		break;
+	default:
+		die("Huh?");
+	}
+	if (flags & CE5_FULL_UID)
+		ce_tmp.ce_uid = decode_varint(&data);
+	else
+		ce_tmp.ce_uid = previous_ce->ce_uid;
+	if (flags & CE5_FULL_GID)
+		ce_tmp.ce_gid = decode_varint(&data);
+	else
+		ce_tmp.ce_gid = previous_ce->ce_gid;
+	ce_tmp.ce_size = decode_varint(&data);
+	hashcpy(ce_tmp.sha1, data);
+	data += 20;
+
+	*consumed = data - orig;
+	*consumed += expand_name_field(previous_name, (const char *)data);
+
+	ce = xmalloc(cache_entry_size(previous_name->len));
+	ce->ce_ctime = ce_tmp.ce_ctime;
+	ce->ce_mtime = ce_tmp.ce_mtime;
+	ce->ce_dev   = ce_tmp.ce_dev;
+	ce->ce_ino   = ce_tmp.ce_ino;
+	ce->ce_mode  = ce_tmp.ce_mode;
+	ce->ce_uid   = ce_tmp.ce_uid;
+	ce->ce_gid   = ce_tmp.ce_gid;
+	ce->ce_size  = ce_tmp.ce_size;
+	ce->ce_flags = ce_tmp.ce_flags;
+	ce->ce_namelen = previous_name->len;
+	hashcpy(ce->sha1, ce_tmp.sha1);
+	memcpy(ce->name, previous_name->buf, previous_name->len + 1);
+	return ce;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1452,7 +1583,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
 	istate->initialized = 1;
 
-	if (istate->version == 4)
+	if (istate->version >= 4)
 		previous_name = &previous_name_buf;
 	else
 		previous_name = NULL;
@@ -1464,7 +1595,13 @@ int read_index_from(struct index_state *istate, const char *path)
 		unsigned long consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(disk_ce, &consumed, previous_name);
+		if (istate->version == 5)
+			ce = create_from_disk_v5((const unsigned char*)disk_ce,
+						 &consumed,
+						 previous_name,
+						 i > 0 ? istate->cache[i - 1] : NULL);
+		else
+			ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
@@ -1652,6 +1789,125 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	}
 }
 
+static void strbuf_encode_varint(struct strbuf *sb, uintmax_t value)
+{
+	static unsigned char varint[16];
+	int varint_len = encode_varint(value, varint);
+	strbuf_add(sb, varint, varint_len);
+}
+
+static void strbuf_encode_offset(struct strbuf *sb, unsigned int v1, unsigned int v2)
+{
+	if (v1 < v2)
+		strbuf_encode_varint(sb, (v2 - v1) << 1);
+	else
+		strbuf_encode_varint(sb, 1 | ((v1 - v2) << 1));
+}
+
+static int ce_write_entry_v5(git_SHA_CTX *c, int fd,
+			     struct cache_entry *ce,
+			     struct strbuf *previous_name,
+			     struct cache_entry *previous_ce)
+{
+	uint32_t data[4];
+	unsigned int flags = 0;
+	struct strbuf sb = STRBUF_INIT;
+	int result;
+
+	if (ce->ce_flags & CE_INTENT_TO_ADD)
+		flags |= CE5_ITA;
+	if (ce->ce_flags & CE_VALID)
+		flags |= CE5_VALID;
+	if (ce->ce_flags & CE_SKIP_WORKTREE)
+		flags |= CE5_SWT;
+	flags |= ce_stage(ce) << CE5_STAGESHIFT;
+
+	if (previous_ce) {
+		if (ce->ce_ctime.sec != ce->ce_mtime.sec ||
+		    ce->ce_ctime.nsec != ce->ce_mtime.nsec)
+			flags |= CE5_OFS_MTIME;
+		if (ce->ce_uid != previous_ce->ce_uid)
+			flags |= CE5_FULL_UID;
+		if (ce->ce_gid != previous_ce->ce_gid)
+			flags |= CE5_FULL_GID;
+		if (ce->ce_dev != previous_ce->ce_dev)
+			flags |= CE5_FULL_DEV;
+	} else
+		flags |= CE5_FULL_TIME | CE5_FULL_UID | CE5_FULL_GID | CE5_FULL_DEV;
+	if (ce->ce_mode == 0100644)
+		flags |= CE5_MODE_644; /* no bit sets actually */
+	else if (ce->ce_mode == 0100755)
+		flags |= CE5_MODE_755;
+	else
+		flags |= CE5_MODE_FULL;
+	if (previous_ce &&
+	    (ce->ce_ino - previous_ce->ce_ino < 16000 ||
+	     previous_ce->ce_ino - ce->ce_ino < 16000))
+		;		/* inode offset */
+	else
+		flags |= CE5_FULL_INO;
+
+	strbuf_encode_varint(&sb, flags);
+
+	if (flags & CE5_FULL_TIME) { /* full format, 16 bytes */
+		data[0] = htonl(ce->ce_ctime.sec);
+		data[1] = htonl(ce->ce_ctime.nsec);
+		data[2] = htonl(ce->ce_mtime.sec);
+		data[3] = htonl(ce->ce_mtime.nsec);
+		strbuf_add(&sb, data, sizeof(data));
+	} else {
+		/* offset from previous ce */
+		strbuf_encode_offset(&sb, previous_ce->ce_ctime.sec, ce->ce_ctime.sec);
+		strbuf_encode_offset(&sb, previous_ce->ce_ctime.nsec, ce->ce_ctime.nsec);
+
+		if (flags & CE5_OFS_MTIME) {
+			/* offset from previous ce */
+			strbuf_encode_offset(&sb, previous_ce->ce_mtime.sec, ce->ce_mtime.sec);
+			strbuf_encode_offset(&sb, previous_ce->ce_mtime.nsec, ce->ce_mtime.nsec);
+		}
+	}
+
+	if (flags & CE5_FULL_DEV)
+		strbuf_encode_varint(&sb, ce->ce_dev);
+	if (flags & CE5_FULL_INO) {
+		data[0] =  htonl(ce->ce_ino);
+		strbuf_add(&sb, data, sizeof(*data));
+	} else
+		strbuf_encode_offset(&sb, previous_ce->ce_ino, ce->ce_ino);
+	if (flags & CE5_MODE_FULL)
+		strbuf_encode_varint(&sb, ce->ce_mode);
+	if (flags & CE5_FULL_UID)
+		strbuf_encode_varint(&sb, ce->ce_uid);
+	if (flags & CE5_FULL_GID)
+		strbuf_encode_varint(&sb, ce->ce_gid);
+	strbuf_encode_varint(&sb, ce->ce_size);
+	strbuf_add(&sb, ce->sha1, 20);
+
+	if (previous_name) {
+		int common, to_remove, prefix_size;
+		unsigned char to_remove_vi[16];
+		for (common = 0;
+		     (ce->name[common] &&
+		      common < previous_name->len &&
+		      ce->name[common] == previous_name->buf[common]);
+		     common++)
+			; /* still matching */
+		to_remove = previous_name->len - common;
+		prefix_size = encode_varint(to_remove, to_remove_vi);
+
+		strbuf_add(&sb, to_remove_vi, prefix_size);
+		strbuf_add(&sb, ce->name + common, ce_namelen(ce) - common);
+
+		strbuf_splice(previous_name, common, to_remove,
+			      ce->name + common, ce_namelen(ce) - common);
+	} else
+		strbuf_add(&sb, ce->name, ce_namelen(ce));
+
+	result = ce_write(c, fd, sb.buf, sb.len + 1);
+	strbuf_release(&sb);
+	return result;
+}
+
 /* Copy miscellaneous fields but not the name */
 static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 				       struct cache_entry *ce)
@@ -1793,16 +2049,23 @@ int write_index(struct index_state *istate, int newfd)
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
+	previous_name = (hdr_version >= 4) ? &previous_name_buf : NULL;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
+		int ret;
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
 		if (is_null_sha1(ce->sha1))
 			return error("cache entry has null sha1: %s", ce->name);
-		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
+		if (hdr_version == 5)
+			ret = ce_write_entry_v5(&c, newfd, ce,
+						previous_name,
+						i > 0 ? cache[i-1] : NULL);
+		else
+			ret = ce_write_entry(&c, newfd, ce, previous_name);
+		if (ret < 0)
 			return -1;
 	}
 	strbuf_release(&previous_name_buf);
-- 
1.8.1.2.495.g3fdf5d5.dirty

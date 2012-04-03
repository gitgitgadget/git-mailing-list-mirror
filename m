From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] read-cache.c: read prefix-compressed names in index
 on-disk version v4
Date: Tue,  3 Apr 2012 15:53:15 -0700
Message-ID: <1333493596-14202-9-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbj-0006ve-11
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab2DCWxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab2DCWxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A8AC7F8C
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GFtT
	9ozKYUcB2ZjwWknGIGLDOOM=; b=ndwMVQstP0YOTKrwgSMxD2Dz7Gaf1JVVxZ+J
	Kc7+riNrv5OLo6KqjQ1UcMnV7KbCNMmlgfFGJ8ssi41n6HyjPUjcGadhwxuX9Ynf
	By5uhQKh63W2CJ0anNZK9MtoLpyznzGFk5Y/Di5jjAa3Oko/rnbKnYL011Wru5kV
	1CAYlnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TiE1we
	F4ROMUbN3ocBtq0uqICpOH+Zl08IJ+GM4TrnrZOWYx+Azpt7i08z92iShecWT6/o
	ls7mthUf9KDdWaheWTfPQX5RuchUvx8Nis/Yk7uca8oFj45AMMLwdTjAsSVnsiZz
	mqhL2bjnIM/VgmoLfPaJe/nz1dGALuhUqGD8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F414E7F8B
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B9017F8A for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D63B0256-7DDF-11E1-A2D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194669>

Because the entries are sorted by path, adjacent entries in the index tend
to share the leading components of them, and it makes sense to only store
the differences in later entries.  In the v4 on-disk format of the index,
each on-disk cache entry stores the number of bytes to be stripped from
the end of the previous name, and the bytes to append to the result, to
come up with its name.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c159351..1c173f7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -12,6 +12,8 @@
 #include "commit.h"
 #include "blob.h"
 #include "resolve-undo.h"
+#include "strbuf.h"
+#include "varint.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 
@@ -1236,6 +1238,7 @@ struct ondisk_cache_entry_extended {
 	char name[FLEX_ARRAY]; /* more */
 };
 
+/* These are only used for v3 or lower */
 #define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
 #define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
 #define ondisk_cache_entry_extended_size(len) align_flex_name(ondisk_cache_entry_extended,len)
@@ -1252,7 +1255,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version = ntohl(hdr->hdr_version);
-	if (hdr_version < 2 || 3 < hdr_version)
+	if (hdr_version < 2 || 4 < hdr_version)
 		return error("bad index version %d", hdr_version);
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
@@ -1331,8 +1334,30 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	return ce;
 }
 
+/*
+ * Adjacent cache entries tend to share the leading paths, so it makes
+ * sense to only store the differences in later entries.  In the v4
+ * on-disk format of the index, each on-disk cache entry stores the
+ * number of bytes to be stripped from the end of the previous name,
+ * and the bytes to append to the result, to come up with its name.
+ */
+static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
+{
+	const unsigned char *ep, *cp = (const unsigned char *)cp_;
+	size_t len = decode_varint(&cp);
+
+	if (name->len < len)
+		die("malformed name field in the index");
+	strbuf_remove(name, name->len - len, len);
+	for (ep = cp; *ep; ep++)
+		; /* find the end */
+	strbuf_add(name, cp, ep - cp);
+	return (const char *)ep + 1 - cp_;
+}
+
 static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
-					    unsigned long *ent_size)
+					    unsigned long *ent_size,
+					    struct strbuf *previous_name)
 {
 	struct cache_entry *ce;
 	size_t len;
@@ -1357,10 +1382,22 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	else
 		name = ondisk->name;
 
-	if (len == CE_NAMEMASK)
-		len = strlen(name);
-	ce = cache_entry_from_ondisk(ondisk, flags, name, len);
-	*ent_size = ondisk_ce_size(ce);
+	if (!previous_name) {
+		/* v3 and earlier */
+		if (len == CE_NAMEMASK)
+			len = strlen(name);
+		ce = cache_entry_from_ondisk(ondisk, flags, name, len);
+
+		*ent_size = ondisk_ce_size(ce);
+	} else {
+		unsigned long consumed;
+		consumed = expand_name_field(previous_name, name);
+		ce = cache_entry_from_ondisk(ondisk, flags,
+					     previous_name->buf,
+					     previous_name->len);
+
+		*ent_size = (name - ((char *)ondisk)) + consumed;
+	}
 	return ce;
 }
 
@@ -1373,6 +1410,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
 	errno = EBUSY;
 	if (istate->initialized)
@@ -1410,6 +1448,11 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
 	istate->initialized = 1;
 
+	if (hdr->hdr_version == htonl(4))
+		previous_name = &previous_name_buf;
+	else
+		previous_name = NULL;
+
 	src_offset = sizeof(*hdr);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
@@ -1417,11 +1460,12 @@ int read_index_from(struct index_state *istate, const char *path)
 		unsigned long consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(disk_ce, &consumed);
+		ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
 	}
+	strbuf_release(&previous_name_buf);
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
-- 
1.7.10.rc4.54.g1d5dd3

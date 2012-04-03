From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] cache.h: hide on-disk index details
Date: Tue,  3 Apr 2012 15:53:09 -0700
Message-ID: <1333493596-14202-3-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbT-0006o1-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073Ab2DCWxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab2DCWxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2032E7F67
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+oIM
	m3d+QunDLSH7ULnuVVJ0wt4=; b=v3At6E2IAdJG95CF9JjHpxkshmbzUlst6EaV
	cMM2ZWt2WA60tr4EMN8hkE97mdhY2I4w8F81HfR6TRS63/rJ62F4Gabt/NUHGrgE
	8zuEO21NwtG8ojtaWxGDM9L+3iLanObP0ixBttvdRbcKtvoRwDrJL7QBCKTADm7I
	dmUWkMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KKCZV7
	MxayrjgV/71SeMC4X9tQ0U/fUW4EbljC2cj3zTgWUbdYHLjh0EhAvvDQOCDCqR5u
	vpLbTcESJIE6Qg2tcrttLN86NTTlz2uYtsHCVWtaEFYt21hYezJz+xN73pzNam5J
	xZvItp1XVwpE5p90BfCsPAWETC1Ri4gIPFTIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DAA07F65
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42DBD7F64 for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CFA6F3FA-7DDF-11E1-BFF4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194663>

The on-disk format of the index file is a detail whose implementation is
neatly encapsulated in read-cache.c; there is no need to expose it to the
general public that include the cache.h header file.

Also add a prominent mark to read-cache.c to delineate the parts that deal
with the index file I/O routines from the remainder of the file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      |   48 ------------------------------------------------
 read-cache.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/cache.h b/cache.h
index e5e1aa4..65a7aba 100644
--- a/cache.h
+++ b/cache.h
@@ -115,48 +115,6 @@ struct cache_time {
 	unsigned int nsec;
 };
 
-/*
- * dev/ino/uid/gid/size are also just tracked to the low 32 bits
- * Again - this is just a (very strong in practice) heuristic that
- * the inode hasn't changed.
- *
- * We save the fields in big-endian order to allow using the
- * index file over NFS transparently.
- */
-struct ondisk_cache_entry {
-	struct cache_time ctime;
-	struct cache_time mtime;
-	unsigned int dev;
-	unsigned int ino;
-	unsigned int mode;
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int size;
-	unsigned char sha1[20];
-	unsigned short flags;
-	char name[FLEX_ARRAY]; /* more */
-};
-
-/*
- * This struct is used when CE_EXTENDED bit is 1
- * The struct must match ondisk_cache_entry exactly from
- * ctime till flags
- */
-struct ondisk_cache_entry_extended {
-	struct cache_time ctime;
-	struct cache_time mtime;
-	unsigned int dev;
-	unsigned int ino;
-	unsigned int mode;
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int size;
-	unsigned char sha1[20];
-	unsigned short flags;
-	unsigned short flags2;
-	char name[FLEX_ARRAY]; /* more */
-};
-
 struct cache_entry {
 	struct cache_time ce_ctime;
 	struct cache_time ce_mtime;
@@ -253,9 +211,6 @@ static inline size_t ce_namelen(const struct cache_entry *ce)
 }
 
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
-#define ondisk_ce_size(ce) (((ce)->ce_flags & CE_EXTENDED) ? \
-			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
-			    ondisk_cache_entry_size(ce_namelen(ce)))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
@@ -306,10 +261,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 	return S_IFGITLINK;
 }
 
-#define flexible_size(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
-#define ondisk_cache_entry_size(len) flexible_size(ondisk_cache_entry,len)
-#define ondisk_cache_entry_extended_size(len) flexible_size(ondisk_cache_entry_extended,len)
 
 struct index_state {
 	struct cache_entry **cache;
diff --git a/read-cache.c b/read-cache.c
index 274e54b..fa8aa73 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1189,6 +1189,60 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
 }
 
+
+/*****************************************************************
+ * Index File I/O
+ *****************************************************************/
+
+/*
+ * dev/ino/uid/gid/size are also just tracked to the low 32 bits
+ * Again - this is just a (very strong in practice) heuristic that
+ * the inode hasn't changed.
+ *
+ * We save the fields in big-endian order to allow using the
+ * index file over NFS transparently.
+ */
+struct ondisk_cache_entry {
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
+	char name[FLEX_ARRAY]; /* more */
+};
+
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
+#define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
+#define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
+#define ondisk_cache_entry_extended_size(len) align_flex_name(ondisk_cache_entry_extended,len)
+#define ondisk_ce_size(ce) (((ce)->ce_flags & CE_EXTENDED) ? \
+			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
+			    ondisk_cache_entry_size(ce_namelen(ce)))
+
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
-- 
1.7.10.rc4.54.g1d5dd3

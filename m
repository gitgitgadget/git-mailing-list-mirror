Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0A41F462
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfBSAGU (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34840 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732294AbfBSAGR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:17 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E48AF60997;
        Tue, 19 Feb 2019 00:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534776;
        bh=hXdBQmxKcdp38XPH0Yx4qOCZOiLkrEgT+oxVjBoJJH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uPnSBjufhXfMZfKhWfhkjV2DTNDcJ9T0r31o8Yw1rLPJcIkAvI7VGCBpjTVODa8NR
         eSC0Sd9pawY/tqq5eEq1DrTn7q41Mcb9EEHWbvJq+eYf76PwtkKNdEG83JeoGrImSj
         cOmXgElMNSgQJFrNh3gZMjdt3tQawYEkYmCkOOIVMuhy2wC4Q5K/Wv8Jow2ndARUAb
         UG5BYyBlOuinD3C9VWq3zfdRLnpi1vLMgx+vTt52FlvC6+LGGff/BXw2HFyQ4BDr/+
         oUKpive7hOCdKL4SFWgG9HqMNe2eI9suasNwfHGFzMOC490q+4y7HAS5Jw2+vRgkDd
         R1ckkOxahx9ph4bpFzmm2lsoG6FnLpp9nGfZOTmdFDEMvc3KpHt17K83tHwZIS6per
         fc7tX9OoWsbfVIDsgIxflbV4PezuzH+hxS28RgTgsYrfYMHY0Eco1Qb3MmHCE4eXYw
         7DCZ1kXogzHUjGGfEhD9/GWl6tpgI/E3UDk1uf8S03D+Dout1fd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 33/35] read-cache: read data in a hash-independent way
Date:   Tue, 19 Feb 2019 00:05:24 +0000
Message-Id: <20190219000526.476553-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Index entries are structured with a variety of fields up front, followed
by a hash and one or two flags fields.  Because the hash field is stored
in the middle of the structure, it's difficult to use one fixed-size
structure that easily allows access to the hash and flags fields.
Adjust the structure to hold the maximum amount of data that may be
needed using a member called "data" and read and write this field
independently in the various places that need to read and write the
structure.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 read-cache.c | 74 ++++++++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0e0c93edc9..d9f12c568f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1634,39 +1634,24 @@ struct ondisk_cache_entry {
 	uint32_t uid;
 	uint32_t gid;
 	uint32_t size;
-	unsigned char sha1[20];
-	uint16_t flags;
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
-	uint32_t dev;
-	uint32_t ino;
-	uint32_t mode;
-	uint32_t uid;
-	uint32_t gid;
-	uint32_t size;
-	unsigned char sha1[20];
-	uint16_t flags;
-	uint16_t flags2;
-	char name[FLEX_ARRAY]; /* more */
+	/*
+	 * unsigned char hash[hashsz];
+	 * uint16_t flags;
+	 * if (flags & CE_EXTENDED)
+	 *	uint16_t flags2;
+	 */
+	unsigned char data[GIT_MAX_RAWSZ + 2 * sizeof(uint16_t)];
+	char name[FLEX_ARRAY];
 };
 
 /* These are only used for v3 or lower */
 #define align_padding_size(size, len) ((size + (len) + 8) & ~7) - (size + len)
-#define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
+#define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,data) + (len) + 8) & ~7)
 #define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
-#define ondisk_cache_entry_extended_size(len) align_flex_name(ondisk_cache_entry_extended,len)
-#define ondisk_ce_size(ce) (((ce)->ce_flags & CE_EXTENDED) ? \
-			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
-			    ondisk_cache_entry_size(ce_namelen(ce)))
+#define ondisk_data_size(flags, len) (the_hash_algo->rawsz + \
+				     ((flags & CE_EXTENDED) ? 2 : 1) * sizeof(uint16_t) + len)
+#define ondisk_data_size_max(len) (ondisk_data_size(CE_EXTENDED, len))
+#define ondisk_ce_size(ce) (ondisk_cache_entry_size(ondisk_data_size((ce)->ce_flags, ce_namelen(ce))))
 
 /* Allow fsck to force verification of the index checksum. */
 int verify_index_checksum;
@@ -1740,6 +1725,8 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	struct cache_entry *ce;
 	size_t len;
 	const char *name;
+	const unsigned hashsz = the_hash_algo->rawsz;
+	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
 	unsigned int flags;
 	size_t copy_len = 0;
 	/*
@@ -1752,22 +1739,20 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	int expand_name_field = version == 4;
 
 	/* On-disk flags are just 16 bits */
-	flags = get_be16(&ondisk->flags);
+	flags = get_be16(flagsp);
 	len = flags & CE_NAMEMASK;
 
 	if (flags & CE_EXTENDED) {
-		struct ondisk_cache_entry_extended *ondisk2;
 		int extended_flags;
-		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		extended_flags = get_be16(&ondisk2->flags2) << 16;
+		extended_flags = get_be16(flagsp + 1) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
 			die(_("unknown index entry format 0x%08x"), extended_flags);
 		flags |= extended_flags;
-		name = ondisk2->name;
+		name = (const char *)(flagsp + 2);
 	}
 	else
-		name = ondisk->name;
+		name = (const char *)(flagsp + 1);
 
 	if (expand_name_field) {
 		const unsigned char *cp = (const unsigned char *)name;
@@ -1806,7 +1791,9 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	ce->index = 0;
-	hashcpy(ce->oid.hash, ondisk->sha1);
+	hashcpy(ce->oid.hash, ondisk->data);
+	memcpy(ce->name, name, len);
+	ce->name[len] = '\0';
 
 	if (expand_name_field) {
 		if (copy_len)
@@ -2528,6 +2515,8 @@ static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 				       struct cache_entry *ce)
 {
 	short flags;
+	const unsigned hashsz = the_hash_algo->rawsz;
+	uint16_t *flagsp = (uint16_t *)(ondisk->data + hashsz);
 
 	ondisk->ctime.sec = htonl(ce->ce_stat_data.sd_ctime.sec);
 	ondisk->mtime.sec = htonl(ce->ce_stat_data.sd_mtime.sec);
@@ -2539,15 +2528,13 @@ static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	ondisk->uid  = htonl(ce->ce_stat_data.sd_uid);
 	ondisk->gid  = htonl(ce->ce_stat_data.sd_gid);
 	ondisk->size = htonl(ce->ce_stat_data.sd_size);
-	hashcpy(ondisk->sha1, ce->oid.hash);
+	hashcpy(ondisk->data, ce->oid.hash);
 
 	flags = ce->ce_flags & ~CE_NAMEMASK;
 	flags |= (ce_namelen(ce) >= CE_NAMEMASK ? CE_NAMEMASK : ce_namelen(ce));
-	ondisk->flags = htons(flags);
+	flagsp[0] = htons(flags);
 	if (ce->ce_flags & CE_EXTENDED) {
-		struct ondisk_cache_entry_extended *ondisk2;
-		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		ondisk2->flags2 = htons((ce->ce_flags & CE_EXTENDED_FLAGS) >> 16);
+		flagsp[1] = htons((ce->ce_flags & CE_EXTENDED_FLAGS) >> 16);
 	}
 }
 
@@ -2566,10 +2553,7 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 		stripped_name = 1;
 	}
 
-	if (ce->ce_flags & CE_EXTENDED)
-		size = offsetof(struct ondisk_cache_entry_extended, name);
-	else
-		size = offsetof(struct ondisk_cache_entry, name);
+	size = offsetof(struct ondisk_cache_entry,data) + ondisk_data_size(ce->ce_flags, 0);
 
 	if (!previous_name) {
 		int len = ce_namelen(ce);
@@ -2727,7 +2711,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
-	struct ondisk_cache_entry_extended ondisk;
+	struct ondisk_cache_entry ondisk;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;

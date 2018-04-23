Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294C21F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbeDWXk2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932717AbeDWXkY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1276360B1A;
        Mon, 23 Apr 2018 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526822;
        bh=s+bwdwzeXMw8BXsTiS9RM7j1ru0+Hhx3NYtMNT4NpG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SP5yp0E+3r0SuYg7aMmQrm05Izb/PodtlgrZ6YnF9SZSUB6ZOKfePY/nFAYArNPXJ
         J+J6bMa/+MOb0SG2RTlUbMrgQ7C4m0hIy/vDf8+RlG/HQj3Ov/u8DJyBPrZJyxbRlm
         r8yRCjhBqHbroIo1cL1ePHVmTeYbAU8QDV430IbZ505zU/1BB0SRUTR+t88X3mzy1o
         V/ZE6kK/PBdUKzEWjf1KrQgChlsrCOKnIuEU6Pszj6JMqJYxYULCpbPPIfi4ebVTXg
         0+PTbwOHdMEq8vruz/C+n8erv264KcvAl6K8pwJr/NaA+/SFPEpDYvkJP5uo8RRSS/
         iu3BbfKFU081ptoWpGM/fucLaopFe4H2bieYjacj0RIARf7gTmUVjJOyrEdSYatcA+
         AP86fPdBQDwWpeiHg77oZ5rSWZ4dfr0eYnUwGn6aADeC8fjcPsheI8wqvXUY7uuTXc
         mJ48f6/RevgviboEjeAyVQIYqueNZVGzdfBs+wTdhzV+UN+zdzC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 16/41] Update struct index_state to use struct object_id
Date:   Mon, 23 Apr 2018 23:39:26 +0000
Message-Id: <20180423233951.276447-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust struct index_state to use struct object_id instead of unsigned
char [20].

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h                          |  2 +-
 read-cache.c                     | 16 ++++++++--------
 t/helper/test-dump-split-index.c |  2 +-
 unpack-trees.c                   |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index e03a0d4d23..9ad1dd2ddc 100644
--- a/cache.h
+++ b/cache.h
@@ -324,7 +324,7 @@ struct index_state {
 		 drop_cache_tree : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct untracked_cache *untracked;
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
diff --git a/read-cache.c b/read-cache.c
index f47666b975..9dbaeeec43 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1806,7 +1806,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
-	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - the_hash_algo->rawsz);
+	hashcpy(istate->oid.hash, (const unsigned char *)hdr + mmap_size - the_hash_algo->rawsz);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
@@ -1902,10 +1902,10 @@ int read_index_from(struct index_state *istate, const char *path,
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
-	if (hashcmp(split_index->base_oid.hash, split_index->base->sha1))
+	if (oidcmp(&split_index->base_oid, &split_index->base->oid))
 		die("broken index, expect %s in %s, got %s",
 		    base_oid_hex, base_path,
-		    sha1_to_hex(split_index->base->sha1));
+		    oid_to_hex(&split_index->base->oid));
 
 	freshen_shared_index(base_path, 0);
 	merge_base_index(istate);
@@ -2194,7 +2194,7 @@ static int verify_index_from(const struct index_state *istate, const char *path)
 	if (n != the_hash_algo->rawsz)
 		goto out;
 
-	if (hashcmp(istate->sha1, hash))
+	if (hashcmp(istate->oid.hash, hash))
 		goto out;
 
 	close(fd);
@@ -2373,7 +2373,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	if (ce_flush(&c, newfd, istate->sha1))
+	if (ce_flush(&c, newfd, istate->oid.hash))
 		return -1;
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), tempfile->filename.buf);
@@ -2497,10 +2497,10 @@ static int write_shared_index(struct index_state *istate,
 		return ret;
 	}
 	ret = rename_tempfile(temp,
-			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
+			      git_path("sharedindex.%s", oid_to_hex(&si->base->oid)));
 	if (!ret) {
-		hashcpy(si->base_oid.hash, si->base->sha1);
-		clean_shared_index_files(sha1_to_hex(si->base->sha1));
+		oidcpy(&si->base_oid, &si->base->oid);
+		clean_shared_index_files(oid_to_hex(&si->base->oid));
 	}
 
 	return ret;
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 754e9bb624..63c689d6ee 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -14,7 +14,7 @@ int cmd__dump_split_index(int ac, const char **av)
 	int i;
 
 	do_read_index(&the_index, av[1], 1);
-	printf("own %s\n", sha1_to_hex(the_index.sha1));
+	printf("own %s\n", oid_to_hex(&the_index.oid));
 	si = the_index.split_index;
 	if (!si) {
 		printf("not a split index\n");
diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051e..038ef7b926 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1287,7 +1287,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.split_index = o->src_index->split_index;
 	if (o->result.split_index)
 		o->result.split_index->refcount++;
-	hashcpy(o->result.sha1, o->src_index->sha1);
+	oidcpy(&o->result.oid, &o->src_index->oid);
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 

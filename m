Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE081F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfHRUFv (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58022 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbfHRUFt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA62F6075F;
        Sun, 18 Aug 2019 20:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158748;
        bh=W8Uto2ygpHuu0OXbhG8L/QQCmGsZz63EWPkH0b5f+og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IbV/Kdhqb80yl5Uz2Q18xjSromm8JWL2KNoNroDcKjtD0NioHBFeGKDxAwcZS7SIj
         dTraDCRUpZXGnR/+CW8YKWOqRw7Dt8Sr/2kb/sjW/whM87O0C0MAm53/3qvC2nSKky
         NJ3xNlXCisI48HJfUcXf3PrMVtJhca64eKPLS9IcBR06Ec0wpQKp6WjDD7LOh89AxP
         2fA6fmLaN44IUiEM9UPL2J03sT4ScmrHLhamJ/TqkSdi6GQqUjgIMxl3R3ohh03Ds6
         Ze5Mw+tNJfoB1IMfxxbr9BzbeE35k/YHrxxLooofPEYs7OKr3L3slKmjrSr2nvpdEN
         5eZ6dAGGuH9cCoEEIJBzjpiurPhFbDzvcCoI4zDFkpG7E4yW6ngY6lWo8ekwZwpRQ3
         sQfCeGSU5fLFc4RBE1/AC3bO8iYhRHkJpa/OlPMBdMpocd7HSNghI/QOjHBxb6d3gh
         JNralCS4nrzrnbUQIJ2VgcQcWeDwUs0POz9QkByRNd/SWN4Gx2m
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 19/26] cache: remove null_sha1
Date:   Sun, 18 Aug 2019 20:04:20 +0000
Message-Id: <20190818200427.870753-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the existing uses of null_sha1 can be converted into uses of
null_oid, so do so.  Remove null_sha1 and is_null_sha1, and define
is_null_oid in terms of null_oid.  This also has the additional benefit
of removing several uses of sha1_to_hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/clone.c             | 2 +-
 builtin/submodule--helper.c | 2 +-
 cache.h                     | 8 +-------
 sha1-file.c                 | 1 -
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f665b28ccc..eabd02846a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -785,7 +785,7 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
+	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 909e77e802..8a6f2abce4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -424,7 +424,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 		const struct cache_entry *ce = list.entries[i];
 
 		if (ce_stage(ce))
-			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
+			printf("%06o %s U\t", ce->ce_mode, oid_to_hex(&null_oid));
 		else
 			printf("%06o %s %d\t", ce->ce_mode,
 			       oid_to_hex(&ce->oid), ce_stage(ce));
diff --git a/cache.h b/cache.h
index b1da1ab08f..79efd2168f 100644
--- a/cache.h
+++ b/cache.h
@@ -1029,7 +1029,6 @@ const char *repo_find_unique_abbrev(struct repository *r, const struct object_id
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
 #define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
-extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
@@ -1064,14 +1063,9 @@ static inline int oideq(const struct object_id *oid1, const struct object_id *oi
 	return hasheq(oid1->hash, oid2->hash);
 }
 
-static inline int is_null_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, null_sha1);
-}
-
 static inline int is_null_oid(const struct object_id *oid)
 {
-	return hasheq(oid->hash, null_sha1);
+	return oideq(oid, &null_oid);
 }
 
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
diff --git a/sha1-file.c b/sha1-file.c
index 487ea35d2d..0ea28f7da3 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -55,7 +55,6 @@
 	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
 	"\x18\x13"
 
-const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
 static const struct object_id empty_tree_oid = {
 	EMPTY_TREE_SHA1_BIN_LITERAL

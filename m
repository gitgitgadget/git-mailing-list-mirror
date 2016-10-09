Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC6C20986
	for <e@80x24.org>; Sun,  9 Oct 2016 09:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbcJIJ5k (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 05:57:40 -0400
Received: from mout.web.de ([212.227.15.14]:52956 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbcJIJ5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 05:57:38 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MNg5K-1bm1BU11TO-007GCw; Sun, 09 Oct 2016 11:56:54
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/2] read-cache: factor out get_sha1_from_index() helper
Date:   Sun,  9 Oct 2016 11:56:52 +0200
Message-Id: <20161009095652.1925-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7WCeUl5Gdb+S10dVBH9nGORsBYQuf+rKgrOnkn6OdAi0EIjdGvP
 BI2f61vmhpC4QHeFfz8KnO5RZsJH5LX1d4ArVLoYTrCo58cZnk6WBUwTde0Oky5rgwwk+Is
 GmWJro8CpvtE20Alp4EqS5M+nmVgJ4qDXeGQ/U++j8u7HuY/tJGak1pTmEudnOGiPyUppjU
 j4Wg98fl1b0+bfbx8h5mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fOeRF6FZHnY=:fSARKW6WMZvPbnFEtM5+Zs
 zNUnIrmllqUCnOpBTP7UYos5lG8hfDQYGYshV1xDjunYGHwY1x/uW0LjH178dNi8k6iZCqFQN
 NQWthpJqUr1CYEeQUgDhMTOcRmtQbpQirCAFwOhbDmTFPHl7evBdaof/V+5ArCAOlK0DQEgzs
 9Ki1n+7vtTe3qSw18NJDgEofd5UijtPkkpeMcVNu5qzbS8jNHPjf3JzdBiajV8kMs28t0QImp
 dj8qpnRg/yUMoKJNBMLwE46K+6X85oSjWz6VMTBn6QMRRp2cFPz5vxu6D9ERrCzyq6otc9AD6
 AdBCnE8C7+J6SNslBNiHh91JLJysSfQURVPafqRHSkPLcWI8IKgArj//5Ij0gcfy2x3fIay8+
 CGulblfqS3t3pRE+K5paM+aUQxCvNXvxXr0QQGiabAZf2au3h2nRHPp1TsC6Qf8+CkPgIgMCU
 yQ52WXTuHjSMwK35b5HX47ibCP9HX2SgGQOjOoHWEtCE5HlY+VyfvtMPHorNNZ3QG35BQczz3
 TktxS8XDTIH9Nph3BvjaROzzZWfySvvQ2WBEDK91o+QGdHQNNz+MfxVBoKulcVEdJJyinNCgF
 v8R2FRfPG8EjjVpA0jYjtufnh5Rji4jPPhohUWM9t2qEe9qmCaWepyY+5H8qhZ1ps8TGOeF+Q
 9FF+8P/6m2zI6X/9OANqPOpR1VqG1eBOlfdmm6ZzrHFHOh66KCCUW7grWbAO68pD/ZjWo8/Kx
 KW1isSju/XbNIv7tV/PbHK02zLe3L1ImRg3grnOg0y3KaCIryIIXKc5iXjm7G3fcZLc4LXNLG
 7UQUdD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Factor out the retrieval of the sha1 for a given path in
read_blob_data_from_index() into the function get_sha1_from_index().

This will be used in the next commit, when convert.c can do the
analyze for "text=auto" without slurping the whole blob into memory
at once.

Add a wrapper definition get_sha1_from_cache().
---
 cache.h      |  3 +++
 read-cache.c | 29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 1604e29..04de209 100644
--- a/cache.h
+++ b/cache.h
@@ -380,6 +380,7 @@ extern void free_name_hash(struct index_state *istate);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
+#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, (path))
 #endif
 
 enum object_type {
@@ -1089,6 +1090,8 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
 }
 
+const unsigned char *get_sha1_from_index(struct index_state *istate, const char *path);
+
 /*
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
diff --git a/read-cache.c b/read-cache.c
index 38d67fa..5a1df14 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2290,13 +2290,27 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 
 void *read_blob_data_from_index(struct index_state *istate, const char *path, unsigned long *size)
 {
-	int pos, len;
+	const unsigned char *sha1;
 	unsigned long sz;
 	enum object_type type;
 	void *data;
 
-	len = strlen(path);
-	pos = index_name_pos(istate, path, len);
+	sha1 = get_sha1_from_index(istate, path);
+	if (!sha1)
+		return NULL;
+	data = read_sha1_file(sha1, &type, &sz);
+	if (!data || type != OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	if (size)
+		*size = sz;
+	return data;
+}
+
+const unsigned char *get_sha1_from_index(struct index_state *istate, const char *path)
+{
+	int pos = index_name_pos(istate, path, strlen(path));
 	if (pos < 0) {
 		/*
 		 * We might be in the middle of a merge, in which
@@ -2312,14 +2326,7 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
 	}
 	if (pos < 0)
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->oid.hash, &type, &sz);
-	if (!data || type != OBJ_BLOB) {
-		free(data);
-		return NULL;
-	}
-	if (size)
-		*size = sz;
-	return data;
+	return istate->cache[pos]->oid.hash;
 }
 
 void stat_validity_clear(struct stat_validity *sv)
-- 
2.10.0


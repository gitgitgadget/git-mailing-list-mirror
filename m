Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C52207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755101AbcJLNsh (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:48:37 -0400
Received: from mout.web.de ([217.72.192.78]:61403 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754954AbcJLNsP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:15 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M5wrF-1axNZO0ziz-00xpfo; Wed, 12 Oct 2016 15:47:27
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/2] read-cache: factor out get_sha1_from_index() helper
Date:   Wed, 12 Oct 2016 15:47:26 +0200
Message-Id: <20161012134726.28326-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161009095649.1886-1-tboegi@web.de>
References: <20161009095649.1886-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WUf1AVjX7N87ecUZ5icmIjOg+R63WVUWGuMFBmlP09Zxv1roU+2
 R2q46Ixh2Dwz4F/tpEqpPY3maKWvd/2BsshKBZhmQfNmEs76mSpBNR98HZ7q/Rhjce1FhQz
 Fdh+0zlKHl1KcZhR40iAnqXt87oAEqTdMZHoc7vguxvCstUI9SN5fv58Et/I5B461okuFQg
 GVVkZt3zcF9AC8ODbIB2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eEmq8nEdnuo=:oXGXCzR2QYCBvbpnO7IZj0
 lMLACYXaN1oj9kqIsIYgbBms0kwWWuXzZmepB2Rw93iE1n3Kfd520zgJOrrp2daY1LaAWSsSz
 nm+5CoefF6ts3ZEDRG4ZIcJsRUS+t/OzCLbUnk6TWdbOWb5Hj2GOF7vMftLBoHddPVAyooRuh
 i6rP3gGbJVJdg1ytHtxYROQvxUiM6QBkL0J39fbOZmYyy02HjBNMUWFeKsl90Lj0vizIa0Bfz
 4C7o3thArQxXx7iOjVDQFoX5ERvoo+odxxP7VTJ7wgKkm+d4Dmcgm7+AOvV0zhLwgb9Y0Wdbp
 6rCA5wmLtDaYNnWTeZfjddNt5HASAyoPP4e0ekVwsG9Ogz7yn8c0yXpInVBPNYQDX4KgP06+e
 dzDBqa46FXdohAwY+ijlmd4r5V4hSR0y3XhqReomGqN8TiVOlMbsE6tfl+2hgc+UvfsJMsv9Y
 VM/MtbODfG3+3wziBIeRPNkfwQxegUEtL8uuJc7s/u3jJLgBCuTW3o8TCXH/hJHySdSKY/OBL
 akA8DjUxD/BWDZw+k0ihHZ6yYprb+fT0rX6Ci1oymX9NXEpmr8fBbVdko7vnU8jjC6lzgE0O4
 XXtGhqZx9OQuLnx6/7YmFe8TWPzS8spCGjEf/jjEmPis/e41LGHZExx/hFTGR58p5f9CubfsT
 WBQRHfQmuZmA00mKELiq41WRHfPKPUWZcvrLootVXlZHL6v55SziryC06r4GTE35h6BIBgIN7
 cgmL0pd9uQ9R8ZmSerqnr4yPKtAI8PGFq+Cy2eIldcghGcQCMtZASAwznDdurY/m9AKAmEYsw
 bfAoNiW
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

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
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


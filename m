Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF19F1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfHMMp6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:45:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728425AbfHMMp5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Aug 2019 08:45:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CB28F6081D;
        Tue, 13 Aug 2019 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565700356;
        bh=jrWBhDkJ1D78B//37wU5SAN2JFspob4KOc83NhDNEb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=haq+08CUn/GbIEMr4OSc+eUGmILL84CGY6qqHjycFg5iuwDB8ZiCiHckz/l3ycrih
         LJixCDKdWoUCJF5LltF39wASZ1vBg1gdS8IQznJOs8Ks/rYt3qfrWXlRqGdEBRavmf
         7BvnQ83TEIuadcjXTJZ1yuQ8dhok9shwaDe4nlYMYaWAFHMvKB3VvkGsBkiVRbGGVt
         D2t1xeWQ76da5r5k/Svuh/j4MkRm+W8g/OkHBZ4KbKS6QWkGI7bDGlmFuEQsVpY8dp
         x90/02nnAdquA00Cw3cVq/5MV+FD22vhbvLdA6lBzACRE1Pg42UhmyvllyOm/CfizV
         vkFAW8UHWuBKDLP5CkRXDRZzbw7cHo05yKTEmBGka6QuIySYfzTN7V1Efr6eqUIg1D
         2gLy5xhK+dRf6n+FNrwnHbqUVxoq9u+0ffjQp9B5i6JXOExZshiGSUcaNInYPWgd81
         6sHGM3QII94BZiYSzqiNAA3Zjtj4i4PxnnFdCbK+Q7QBjcptvWy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] path: add a function to check for path suffix
Date:   Tue, 13 Aug 2019 02:43:06 +0000
Message-Id: <20190813024307.705016-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190813024307.705016-1-sandals@crustytoothpaste.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190813024307.705016-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a function to strip the path suffix from a commit, but we don't
have one to check for a path suffix. For a plain filename, we can use
basename, but that requires an allocation, since POSIX allows it to
modify its argument. Refactor strip_path_suffix into a helper function
and a new function, ends_with_path_components, to meet this need.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 path.c | 39 ++++++++++++++++++++++++++++++---------
 path.h |  3 +++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index 25e97b8c3f..e3da1f3c4e 100644
--- a/path.c
+++ b/path.c
@@ -1221,31 +1221,52 @@ static inline int chomp_trailing_dir_sep(const char *path, int len)
 }
 
 /*
- * If path ends with suffix (complete path components), returns the
- * part before suffix (sans trailing directory separators).
- * Otherwise returns NULL.
+ * If path ends with suffix (complete path components), returns the offset of
+ * the last character in the path before the suffix (sans trailing directory
+ * separators), and -1 otherwise.
  */
-char *strip_path_suffix(const char *path, const char *suffix)
+static ssize_t stripped_path_suffix_offset(const char *path, const char *suffix)
 {
 	int path_len = strlen(path), suffix_len = strlen(suffix);
 
 	while (suffix_len) {
 		if (!path_len)
-			return NULL;
+			return -1;
 
 		if (is_dir_sep(path[path_len - 1])) {
 			if (!is_dir_sep(suffix[suffix_len - 1]))
-				return NULL;
+				return -1;
 			path_len = chomp_trailing_dir_sep(path, path_len);
 			suffix_len = chomp_trailing_dir_sep(suffix, suffix_len);
 		}
 		else if (path[--path_len] != suffix[--suffix_len])
-			return NULL;
+			return -1;
 	}
 
 	if (path_len && !is_dir_sep(path[path_len - 1]))
-		return NULL;
-	return xstrndup(path, chomp_trailing_dir_sep(path, path_len));
+		return -1;
+	return chomp_trailing_dir_sep(path, path_len);
+}
+
+/*
+ * Returns true if the path ends with components, considering only complete path
+ * components, and false otherwise.
+ */
+int ends_with_path_components(const char *path, const char *components)
+{
+	return stripped_path_suffix_offset(path, components) != -1;
+}
+
+/*
+ * If path ends with suffix (complete path components), returns the
+ * part before suffix (sans trailing directory separators).
+ * Otherwise returns NULL.
+ */
+char *strip_path_suffix(const char *path, const char *suffix)
+{
+	ssize_t offset = stripped_path_suffix_offset(path, suffix);
+
+	return offset == -1 ? NULL : xstrndup(path, offset);
 }
 
 int daemon_avoid_alias(const char *p)
diff --git a/path.h b/path.h
index 2ba6ca58c8..14d6dcad16 100644
--- a/path.h
+++ b/path.h
@@ -193,4 +193,7 @@ const char *git_path_merge_head(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
 
+
+int ends_with_path_components(const char *path, const char *components);
+
 #endif /* PATH_H */

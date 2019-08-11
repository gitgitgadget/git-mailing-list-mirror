Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC201F45A
	for <e@80x24.org>; Sun, 11 Aug 2019 17:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfHKRsM (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 13:48:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfHKRsM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Aug 2019 13:48:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e9dc:6bd6:18c8:c98f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4FBC56081D;
        Sun, 11 Aug 2019 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565545690;
        bh=oibvStL69glxrTBI/bxKYvOvqb8EvAzdOfdAryJAa4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ziq1inq8dctGMIQqKB4CM/qKDMWPJUKajUBGnX20zwTLfhuZSc4cLKl9ZoTtHx/rr
         eeJ3mU1BbmDtkpNkaN8rPfyDDRhX7XEHsZH79F2oCRnp5WO0BeVR52F3MMiTkeN63Z
         Ia+U/7oAcmRrJfID2zk5F7of/o91i8nn6nSZCKiWpOkcvzmVmrtHr9Q7/aDmuO09O2
         sGfA0z9xZ9Sg4X73DwzbKm5f1NSL8rwe7ZeLzwra8eFCyqDFblGS4hgKsrubeS3MtC
         xFaMaUWkoIXpNnvnCx+mhpUb4B1ypSg6YGNI5V+ddB8NmRCos3luQa833XzFc9OGRk
         S4lfUZThqooW2H0fG+EP2y9oU1nFfwUmsVXigocWz3e7dmff20Mlmzd+w6Y8gCtyEK
         p5+cVuYFZxS/iTm4sFTIeyKX7NtSruV+F9gxlWZjfs7jJuJ5pyA5TNSLdXlkhq+s67
         qs8ixtWJWfmoA3m4KcoILKcPwCAO8sNrL/JwHEGqfrqcYJXgaVF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] path: add a function to check for path suffix
Date:   Sun, 11 Aug 2019 17:47:47 +0000
Message-Id: <20190811174748.33552-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190811174748.33552-1-sandals@crustytoothpaste.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-1-sandals@crustytoothpaste.net>
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
and a new function, has_path_suffix to meet this need.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 path.c | 39 ++++++++++++++++++++++++++++++---------
 path.h |  3 +++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index 25e97b8c3f..e193c62b7d 100644
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
+ * Returns true if the path ends with suffix, considering only complete path
+ * components and false otherwise.
+ */
+int has_path_suffix(const char *path, const char *suffix)
+{
+	return stripped_path_suffix_offset(path, suffix) != -1;
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
index 2ba6ca58c8..c01d045786 100644
--- a/path.h
+++ b/path.h
@@ -193,4 +193,7 @@ const char *git_path_merge_head(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
 
+
+int has_path_suffix(const char *path, const char *suffix);
+
 #endif /* PATH_H */

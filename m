Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82D11F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfHRSoT (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:44:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57714 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfHRSoT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 14:44:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DBEE460736;
        Sun, 18 Aug 2019 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566153857;
        bh=jrWBhDkJ1D78B//37wU5SAN2JFspob4KOc83NhDNEb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ivGW9hIFHDcDkLcpcfKN7MesfLm/qrDF2P4S6oLDRgELCwRzF8sujggugp8b9+dzU
         EBpnheBdxWOwgQ7y8yYOGrW4axbBWxbCRrBs9nFuoNAG8NDAQTdBfgWYBD0T6AM0jD
         gqvZzGuDaTY6HrZ8a0R3wzR5dlXWhOHaEZ7Z/9Tpo/djs+CAW/AjX+AE540yUTwscX
         3gFpDuxT+TLtBeKlBRBMocbT3JOPAs26UTvDGIxGSbWwhERDJtli7kRAVTw/4hpNYa
         zPmD/Ml/lviHG8kAiL494de0Yry07CIVNVsbkXar3Yn8XpGoU/S5hBkDCVXr232IvY
         6Jdsnyu+v9aaQRpaNKLUlbloeWr1Yt38BGaz70vsVU9sZANJgD0ieUSInXsmzfIJ8i
         aOkNf67nJCmD4hepzkSPmjqy0Jp4EWWXBlNELU/jCZY4WwVYL6avyMXXef8/uQYIsh
         IHIrggiZLP7vvskIjsBPuNBxQW/28rFBIqdlf72S51n6grKJ4Oz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/2] path: add a function to check for path suffix
Date:   Sun, 18 Aug 2019 18:44:02 +0000
Message-Id: <20190818184403.861907-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818184403.861907-1-sandals@crustytoothpaste.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
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

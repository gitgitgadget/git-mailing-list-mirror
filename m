Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7911F461
	for <e@80x24.org>; Sun, 25 Aug 2019 23:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfHYXeC (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 19:34:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58234 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728730AbfHYXeC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 19:34:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C081F60736;
        Sun, 25 Aug 2019 23:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566776039;
        bh=jrWBhDkJ1D78B//37wU5SAN2JFspob4KOc83NhDNEb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NBhTxT5hvg4M5IaFJdQTbztV936Vu5Pmx3PloW9mo+v2rFTNp3fb04ZQ9RXX0t8ze
         tNx7InMfPApJWM7m5wb3+z2g1imgm/jg6CQt6GSwtitH/7BeqkQA7hcUYs/u4za1sk
         rhTgQUsDhBUrtOCSqtJrR9/oOFirbEFzCZ0hR53cDWcbyt+YhHLD+fOKlWSyqj8rUu
         ECLKxin+NtFNUc/3TgSXyMd0QpIi+j8yBK30pQAVaYkvNKwXmQR4BemkZMjnj1r1Pv
         TSDprltORo0rKJJOEfjy+34KHxeBzVk35Fcy03uyMv1jhrD2Hkk9hfsNn9c0odw/ak
         nwNCNHGqLLkLw9In070q6wR4/ZyWdQedBR2hU8HJAxNm8ZpKn1xc8HOsBYzYEwZTnU
         s1gNgkI/E89sT1CBxL5AVcx6QtxtpzhC2Vg0BXmrco+3mLRsXKA5PiXHfRdoY/S2Ar
         GTUNF28Fmv4Y5D2Dar8rJrIcu5KiytbSorCCTJhh6lia16HE8fD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 1/2] path: add a function to check for path suffix
Date:   Sun, 25 Aug 2019 23:33:39 +0000
Message-Id: <20190825233340.10894-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190825233340.10894-1-sandals@crustytoothpaste.net>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net>
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

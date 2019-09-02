Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E081F461
	for <e@80x24.org>; Mon,  2 Sep 2019 22:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfIBWj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 18:39:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727635AbfIBWjy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Sep 2019 18:39:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 89DE660FBE;
        Mon,  2 Sep 2019 22:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567463992;
        bh=jrWBhDkJ1D78B//37wU5SAN2JFspob4KOc83NhDNEb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=k/MIDeiy1Qrpvw7P/EwVPj4aNu9UuwaKNSc8VF5P1U21G4MqzodnWgs9uZf+oLfQ/
         maSRXEL5ltMdpXxOcGvvN6q+K1ryfV87nH1RjWFqSM+ArfY+Ut23Iiy3KaTV8crnIa
         /AsFmzA15Xjw+azR3M3NF2P9OvPnnGpOwE+YPbr8m85czFGcEgpMX+CYLq3nLNCp00
         qlfo05Wmj6GfRCMnB0bZxZpgjPvETGR/f1jE+zO3qj359fbf7ksS0j5vZpe+BxyOFk
         IUCveXH/12ij0srVziHsUOvkboSe0qLnvglKWHTAcOJbFOC6pgkvJG6Z3KpKsTZb1L
         7J2KQMXdh+RaqfDH+qB23TS5JydboANHuHfe8OBATX1GNChDoJpTA/XFoOoiaANX3X
         Pr9CAu6NEO/3puf/p+k1uJVsyK0h0Mm4zWv+mtI6WfF9YOs2IYdnqpeYKKi07VCCmC
         tfSmoxb0pp2wl76ZP7aS7XpXQo3biSfMBKZlIXUGR8MiPLBs+DK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 1/2] path: add a function to check for path suffix
Date:   Mon,  2 Sep 2019 22:39:43 +0000
Message-Id: <20190902223944.897504-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734
In-Reply-To: <20190902223944.897504-1-sandals@crustytoothpaste.net>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net>
 <20190902223944.897504-1-sandals@crustytoothpaste.net>
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

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F37BC3E8C5
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 23:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5294A2223D
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 23:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgK0X0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 18:26:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49196 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730999AbgK0XTw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Nov 2020 18:19:52 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 157AD60756;
        Fri, 27 Nov 2020 23:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606519167;
        bh=Gd8TiTo5T6Lj9SIfkf3k4chafBgwjmYyfkQnyGoGTnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Qsdl3hfo5/jm5kHzMlFYa/hkx7MDF7rDhIw2JNp0AAO6HkqIcEn5T0oO3qRo6ba+N
         Pue2kV2nKFqtKIerdY6WSN0zmrwZbYdiA6lcNEj4OEMUXLpr+rj1qisGJHyL2XyA8u
         i/bDgvydCjq2Tl9cg4cEmpEVVMO1YpakKL56nfRd+4z0X5NXAz2vGP8IwXMnKdZxY1
         LQwGBldeXZXaSyoNONk5RL/ykiZDiFd23gGwoVpa7/obBOaV8dVkG5Rr26EOeGACSh
         FZIrpqBLqDMukwdhdq1DrW8pMXb0TRscSznTsKEskWNvCm6S2/UUKZm0ixhNc+Zyu6
         6Hs33ivB2DIN3foVUrtREZ91pD6wHVDHxWw/GT4K8PhXqQR2UvRWqOnTuNlB2rH1ma
         MCy0xj5SLd4XShrlOhSa+4aF4gszBfD2F0EZjyD5WwLyPeXY42Wd/BEruT1bD2/DE0
         j9VlH45CFWMFEmj4AejtB/6MGVPwYyNuV2tz534ho2LFGFgF9Nu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v3 1/2] abspath: add a function to resolve paths with missing components
Date:   Fri, 27 Nov 2020 23:19:15 +0000
Message-Id: <20201127231916.609852-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201127231916.609852-1-sandals@crustytoothpaste.net>
References: <20201127231916.609852-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd like to canonicalize paths such that we can preserve any number of
trailing components that may be missing.  Let's add a function to do
that, taking the number of components to canonicalize, and make
strbuf_realpath a wrapper around it that allows just one component.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 abspath.c | 33 ++++++++++++++++++++++++++++++++-
 cache.h   |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 6f15a418bb..1d8f3d007c 100644
--- a/abspath.c
+++ b/abspath.c
@@ -20,6 +20,7 @@ static void strip_last_component(struct strbuf *path)
 	/* Find start of the last component */
 	while (offset < len && !is_dir_sep(path->buf[len - 1]))
 		len--;
+
 	/* Skip sequences of multiple path-separators */
 	while (offset < len && is_dir_sep(path->buf[len - 1]))
 		len--;
@@ -66,6 +67,22 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 #define MAXSYMLINKS 32
 #endif
 
+/* Count non-contiguous directory separators, not including a trailing one. */
+static int count_dir_separators(const char *s)
+{
+	int count = 0;
+	int last_sep = 0;
+	const char *p = s;
+	while (*p) {
+		int is_sep = is_dir_sep(*p++);
+		if (is_sep && !last_sep)
+			count++;
+		last_sep = is_sep;
+	}
+	return count;
+}
+
+
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
  * and extra slashes removed) equivalent to the specified path.  (If
@@ -80,6 +97,16 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
  */
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error)
+{
+	return strbuf_realpath_missing(resolved, path, 1, die_on_error);
+}
+
+/*
+ * Just like strbuf_realpath, but allows specifying how many missing components
+ * are permitted.  -1 may be specified to allow an unlimited number.
+ */
+char *strbuf_realpath_missing(struct strbuf *resolved, const char *path,
+			      int missing_components, int die_on_error)
 {
 	struct strbuf remaining = STRBUF_INIT;
 	struct strbuf next = STRBUF_INIT;
@@ -128,8 +155,12 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		strbuf_addbuf(resolved, &next);
 
 		if (lstat(resolved->buf, &st)) {
+			int trailing_components = count_dir_separators(remaining.buf) +
+						  (remaining.len != 0);
 			/* error out unless this was the last component */
-			if (errno != ENOENT || remaining.len) {
+			if (errno != ENOENT ||
+			    !(missing_components == -1 ||
+			      trailing_components < missing_components)) {
 				if (die_on_error)
 					die_errno("Invalid path '%s'",
 						  resolved->buf);
diff --git a/cache.h b/cache.h
index c0072d43b1..ee4bc5ec04 100644
--- a/cache.h
+++ b/cache.h
@@ -1320,6 +1320,8 @@ static inline int is_absolute_path(const char *path)
 int is_directory(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
+char *strbuf_realpath_missing(struct strbuf *resolved, const char *path,
+			      int missing_components, int die_on_error);
 char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);

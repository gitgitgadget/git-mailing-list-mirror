Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43D6C1B0D8
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 22:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCA623107
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 22:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgLFWz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 17:55:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgLFWz7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Dec 2020 17:55:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4EC1D60752;
        Sun,  6 Dec 2020 22:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607295317;
        bh=ApAJmS2Xgc2qQDU751ZIc42FSKT70vD0MCZMfSwgD1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=t8fA7D9fE+rAAanOC8/JXxTQbhgRt6uy6JOIt7mz7MorrPONboJ1sae/BXYd6LGmb
         ODeZPRim5fZKrGX+M40w59p8kB1sNRzfdEHwcLSW6VaNUrWlI+CWxj+fB3+nOjZ+qR
         5Ek1Vah8cH86zy3hMRtoR0J2Zz5ub60bN3Y0/IupWYT+kUw3YnGS+GuHx4Em9ZpOlj
         qIi8+6ba/oM0xLuTxO/k/HVJUpGh7byi14uFQ8Wkow0owj0jzYAq11URLWGtCRnMqU
         3fYZFXnYKFV20gYZ+SHqHFvDzV0bz4AnCHKl//AW3gLd9jhWm2A1vbl0wM1eYo+W59
         gamKdYiNqOUI53B2cy2AV8oPwpi1Qf0amN4ailZvv/jAMI2biulPBMA30d2Ey3UzVx
         ZQheJEL15O0jaok9qTDIeJ/ykG4opxtsuJ72V6q+qJ7hWBJ84qPBaIYi5khcJUV7OI
         n6iY8I+t6ryYemGiOUKCsabWMOpatQcX75jlGlDL30N1/1Al9/3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 1/2] abspath: add a function to resolve paths with missing components
Date:   Sun,  6 Dec 2020 22:53:48 +0000
Message-Id: <20201206225349.3392790-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201206225349.3392790-1-sandals@crustytoothpaste.net>
References: <20201206225349.3392790-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd like to canonicalize paths such that we can preserve any number of
trailing components that may be missing.  Let's add a function to do
that, allowing either one or an unlimited number of components to
canonicalize, and make strbuf_realpath a wrapper around it that allows
just one component.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 abspath.c | 13 ++++++++++++-
 cache.h   |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 6f15a418bb..e6630b3618 100644
--- a/abspath.c
+++ b/abspath.c
@@ -80,6 +80,17 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
  */
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error)
+{
+	return strbuf_realpath_missing(resolved, path, 0, die_on_error);
+}
+
+/*
+ * Just like strbuf_realpath, but allows specifying how many missing components
+ * are permitted.  If many_missing is true, an arbitrary number of path
+ * components may be missing; otherwise, only the last component may be missing.
+ */
+char *strbuf_realpath_missing(struct strbuf *resolved, const char *path,
+			      int many_missing, int die_on_error)
 {
 	struct strbuf remaining = STRBUF_INIT;
 	struct strbuf next = STRBUF_INIT;
@@ -129,7 +140,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
 		if (lstat(resolved->buf, &st)) {
 			/* error out unless this was the last component */
-			if (errno != ENOENT || remaining.len) {
+			if (errno != ENOENT || (!many_missing && remaining.len)) {
 				if (die_on_error)
 					die_errno("Invalid path '%s'",
 						  resolved->buf);
diff --git a/cache.h b/cache.h
index e986cf4ea9..a1386235fc 100644
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

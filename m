Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927FDC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FE922282
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbgJITP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:15:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46868 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgJITP6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Oct 2020 15:15:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0FCC06046C;
        Fri,  9 Oct 2020 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602270927;
        bh=HQnS2/swOqT23YL4XyQ14rVMVpigpOhFCnDkeSDgiOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Q/oh94o5QwAdFaxQMEyGbe1SzMmHAEenn1xrdE5ub3fsSBFjYOwBZGHtFrGr6KWk+
         Hlfs22nrR73QuYIeougmdYR4oV6naD4ebRaJNIp/kDD8rETsVxJnGGcQL+L6+//6It
         4LmzwbqEIJeW0avZOCmCBa3gdxaAVVLVhdpAZjEBYuZv8Zci1N30YbgKYNXOPyBCu+
         WAMHnp8PH477Lg2mK/Zu3lgUZ1IbrZqYL0C8F00KICib9bk9J+oIW0iqu8YeZFk2P1
         O8qgHTlQIBGZLe0SubMkXRFo+q8KCKe+kOKdWe7X3yiQuGealJrZPvJwxIVfH/3eAU
         nXUybWMiNT42NXjLROydg3DSyh91umbrF3tMDgXeC285iOEKo2dWsPFEOhpCWsMvAX
         MAOYtTDZRG4i5O4uszeOzJi1oEiRKvdzaGXHD+zZukjM6hQ8xjF+MAJ39817VQDvYH
         qR75Y2ndQCb42NMD8r/folL4lDPTaf50L7RFDbDd8Mh16/tI/bF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/2] abspath: add a function to resolve paths with missing components
Date:   Fri,  9 Oct 2020 19:15:10 +0000
Message-Id: <20201009191511.267461-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20201009191511.267461-1-sandals@crustytoothpaste.net>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd like to canonicalize paths such that we can preserve any number of
trailing components that may be missing.  Let's add a function to do
that that calls strbuf_realpath to find the canonical path for the
portion we do have and then append the missing part.  We adjust
strip_last_component to return us the component it has stripped and use
that to help us accumulate the missing part.

Note that it is intentional that we invoke strbuf_realpath here,
repeatedly if necessary, because on Windows that function is replaced
with a version that uses the proper system semantics for
canonicalization.  Trying to adjust strbuf_realpath to perform this kind
of canonicalization with an additional option would fail to work
properly on Windows.  The present approach is equivalent to
strbuf_realpath for cases where the path exists, and the only other
cases where we will use this function the additional overhead of
multiple invocations is not significant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 abspath.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 cache.h   |  1 +
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/abspath.c b/abspath.c
index 6f15a418bb..092bb33b64 100644
--- a/abspath.c
+++ b/abspath.c
@@ -11,8 +11,12 @@ int is_directory(const char *path)
 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
 }
 
-/* removes the last path component from 'path' except if 'path' is root */
-static void strip_last_component(struct strbuf *path)
+/*
+ * Removes the last path component from 'path' except if 'path' is root.
+ *
+ * If last is not NULL, the last path component is copied to last.
+ */
+static void strip_last_component(struct strbuf *path, struct strbuf *last)
 {
 	size_t offset = offset_1st_component(path->buf);
 	size_t len = path->len;
@@ -20,6 +24,10 @@ static void strip_last_component(struct strbuf *path)
 	/* Find start of the last component */
 	while (offset < len && !is_dir_sep(path->buf[len - 1]))
 		len--;
+
+	if (last)
+		strbuf_addstr(last, path->buf + len);
+
 	/* Skip sequences of multiple path-separators */
 	while (offset < len && is_dir_sep(path->buf[len - 1]))
 		len--;
@@ -118,7 +126,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			continue; /* '.' component */
 		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
 			/* '..' component; strip the last path component */
-			strip_last_component(resolved);
+			strip_last_component(resolved, NULL);
 			continue;
 		}
 
@@ -169,7 +177,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 				 * strip off the last component since it will
 				 * be replaced with the contents of the symlink
 				 */
-				strip_last_component(resolved);
+				strip_last_component(resolved, NULL);
 			}
 
 			/*
@@ -202,6 +210,40 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	return retval;
 }
 
+/*
+ * Like strbuf_realpath, but trailing components which do not exist are copied
+ * through.
+ */
+char *strbuf_realpath_missing(struct strbuf *resolved, const char *path)
+{
+	struct strbuf remaining = STRBUF_INIT;
+	struct strbuf trailing = STRBUF_INIT;
+	struct strbuf component = STRBUF_INIT;
+
+	strbuf_addstr(&remaining, path);
+
+	while (remaining.len) {
+		if (strbuf_realpath(resolved, remaining.buf, 0)) {
+			strbuf_addbuf(resolved, &trailing);
+
+			strbuf_release(&component);
+			strbuf_release(&remaining);
+			strbuf_release(&trailing);
+
+			return resolved->buf;
+		}
+		strip_last_component(&remaining, &component);
+		strbuf_insertstr(&trailing, 0, "/");
+		strbuf_insertstr(&trailing, 1, component.buf);
+		strbuf_reset(&component);
+	}
+
+	strbuf_release(&component);
+	strbuf_release(&remaining);
+	strbuf_release(&trailing);
+	return NULL;
+}
+
 char *real_pathdup(const char *path, int die_on_error)
 {
 	struct strbuf realpath = STRBUF_INIT;
diff --git a/cache.h b/cache.h
index c0072d43b1..e1e17e108e 100644
--- a/cache.h
+++ b/cache.h
@@ -1320,6 +1320,7 @@ static inline int is_absolute_path(const char *path)
 int is_directory(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
+char *strbuf_realpath_missing(struct strbuf *resolved, const char *path);
 char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);

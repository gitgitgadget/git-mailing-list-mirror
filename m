Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116A7C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE44964E00
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBPOpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:45:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:34178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhBPOpE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:45:04 -0500
Received: (qmail 13379 invoked by uid 109); 16 Feb 2021 14:44:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:44:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24723 invoked by uid 111); 16 Feb 2021 14:44:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:44:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:44:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 1/6] add open_nofollow() helper
Message-ID: <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some callers of open() would like to use O_NOFOLLOW, but it is not
available on all platforms. Let's abstract this into a helper function
so we can provide system-specific implementations.

Some light web-searching reveals that we might be able to get something
similar on Windows using FILE_FLAG_OPEN_REPARSE_POINT. I didn't dig into
this further.

For other systems without O_NOFOLLOW or any equivalent, we have two
options for fallback:

  - we can just open anyway, following symlinks; this may have security
    implications (e.g., following untrusted in-tree symlinks)

  - we can determine whether the path is a symlink with lstat().

    This is slower (two syscalls instead of one), but that may be
    acceptable for infrequent uses like looking up .gitattributes files
    (especially because we can get away with a single syscall for the
    common case of ENOENT).

    It's also racy, but should be sufficient for our needs (we are
    worried about in-tree symlinks that we ourselves would have
    previously created). We could make it non-racy at the cost of making
    it even slower, by doing an fstat() on the opened descriptor and
    comparing the dev/ino fields to the original lstat().

This patch implements the lstat() option in its slightly-faster racy
form.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h |  7 +++++++
 wrapper.c         | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 838246289c..fd99eaeb6d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1231,6 +1231,13 @@ int access_or_die(const char *path, int mode, unsigned flag);
 /* Warn on an inaccessible file if errno indicates this is an error */
 int warn_on_fopen_errors(const char *path);
 
+/*
+ * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
+ * may be racy. Do not use this as protection against an attacker who can
+ * simultaneously create paths.
+ */
+int open_nofollow(const char *path, int flags);
+
 #if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
 #define USE_PARENS_AROUND_GETTEXT_N 1
 #endif
diff --git a/wrapper.c b/wrapper.c
index bcda41e374..563ad590df 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -678,3 +678,19 @@ int is_empty_or_missing_file(const char *filename)
 
 	return !st.st_size;
 }
+
+int open_nofollow(const char *path, int flags)
+{
+#ifdef O_NOFOLLOW
+	return open(path, flags | O_NOFOLLOW);
+#else
+	struct stat st;
+	if (lstat(path, &st) < 0)
+		return -1;
+	if (S_ISLNK(st.st_mode)) {
+		errno = ELOOP;
+		return -1;
+	}
+	return open(path, flags);
+#endif
+}
-- 
2.30.1.986.gd86016a168


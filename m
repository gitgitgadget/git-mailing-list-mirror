Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A3BC5518A
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955C5214AF
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wBA1Px1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDVTvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:51:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37576 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbgDVTvX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 15:51:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E3D96052F;
        Wed, 22 Apr 2020 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587585082;
        bh=Jjm2JhTN3d08WSCutP92yMXzBn+qtQq/XOpP7ETjqsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wBA1Px1tVxAPXcT/gdAxk3KMm8TqcjGbrBpM6GoKltnAtY2q9LzBqgrzZGrrG8pYt
         mDfJETx1hpXeprnJYelMzI0zgbnf0LvyU3PTsvRA2mMC6v8VmAtO9CkSrk/2CsnWhd
         Vte8zhLhkpf97qMfqwwz6au38Lw3TY1iChCSn3CuDhVKoQOvS+WIZCwe7Jl+fUJna4
         aJeD5fHFP4fUZQh4j3xhnjAWud7rhi/3JsTU0n/b4dD1OqUwHqGX9eH178sPd0xiBb
         M4oSqa7mdM3lDl+i4TZdtso/WWA5nn/o5xJPvbpNQCqSw4NNx8vAJJaU4Q98euYdxe
         a5akRX1RqMZfn/3hQxt0ouvcMT2oO9bI/gkXAJ8itUqqUyBIFNpEBXL2TnadvM5qm0
         ApdMlVNzJpc294wr6ue799keIk9CMI1+uFcCGYIdrI6ai2Nh/npEw3nPlF4L4pGDwd
         YraUFekIsdQ9kP3GA8d0qlOtydpu8Jp1fEUB/bvArbo4DE/s/i7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Ilya Tretyakov <it@it3xl.ru>
Subject: [PATCH v2] credential: fix matching URLs with multiple levels in path
Date:   Wed, 22 Apr 2020 19:51:09 +0000
Message-Id: <20200422195109.2224035-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9
In-Reply-To: <20200421225837.GB3515235@coredump.intra.peff.net>
References: <20200421225837.GB3515235@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

46fd7b3900 ("credential: allow wildcard patterns when matching config",
2020-02-20) introduced support for matching credential helpers using
urlmatch.  In doing so, it introduced code to percent-encode the paths
we get from the credential helper so that they could be effectively
matched by the urlmatch code.

Unfortunately, that code had a bug: it percent-encoded the slashes in
the path, resulting in any URL path that contained multiple levels
(i.e., a directory component) not matching.

We are currently the only caller of the percent-encoding code and could
simply change it not to encode slashes.  However, we still want to
encode slashes in the username component, so we need to have both
behaviors available.

So instead, let's add a flag to skip encoding slashes, which is the
behavior we want here, and use it when calling the code in this case.
Add a test for credential helper URLs using multiple slashes in the
path, which our test suite previously lacked, as well as one ensuring
that we handle usernames with slashes gracefully.

Reported-by: Ilya Tretyakov <it@it3xl.ru>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v1:
* Continue to encode slashes in usernames.
* Add a test for encoding slashes in usernames.
* Hoist existing tests near the other percent-encoding tests.
* Update commit message.
* Remove debugging information.

 credential.c           |  4 ++--
 strbuf.c               |  8 +++++---
 strbuf.h               |  6 +++++-
 t/t0300-credentials.sh | 30 ++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/credential.c b/credential.c
index 108d9e183a..6658cd0860 100644
--- a/credential.c
+++ b/credential.c
@@ -136,14 +136,14 @@ static void credential_format(struct credential *c, struct strbuf *out)
 		return;
 	strbuf_addf(out, "%s://", c->protocol);
 	if (c->username && *c->username) {
-		strbuf_add_percentencode(out, c->username);
+		strbuf_add_percentencode(out, c->username, 0);
 		strbuf_addch(out, '@');
 	}
 	if (c->host)
 		strbuf_addstr(out, c->host);
 	if (c->path) {
 		strbuf_addch(out, '/');
-		strbuf_add_percentencode(out, c->path);
+		strbuf_add_percentencode(out, c->path, STRBUF_PERCENTENCODE_PATH);
 	}
 }
 
diff --git a/strbuf.c b/strbuf.c
index bb0065ccaf..da5a1c9ca4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -479,15 +479,17 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src)
 	}
 }
 
-#define URL_UNSAFE_CHARS " <>\"%{}|\\^`:/?#[]@!$&'()*+,;="
+#define URL_UNSAFE_CHARS " <>\"%{}|\\^`:?#[]@!$&'()*+,;="
 
-void strbuf_add_percentencode(struct strbuf *dst, const char *src)
+void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags)
 {
 	size_t i, len = strlen(src);
 
 	for (i = 0; i < len; i++) {
 		unsigned char ch = src[i];
-		if (ch <= 0x1F || ch >= 0x7F || strchr(URL_UNSAFE_CHARS, ch))
+		if (ch <= 0x1F || ch >= 0x7F ||
+		    (ch == '/' && !(flags & STRBUF_PERCENTENCODE_PATH)) ||
+		    strchr(URL_UNSAFE_CHARS, ch))
 			strbuf_addf(dst, "%%%02X", (unsigned char)ch);
 		else
 			strbuf_addch(dst, ch);
diff --git a/strbuf.h b/strbuf.h
index ce8e49c0b2..651aedff57 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -378,11 +378,15 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb,
  */
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
 
+#define STRBUF_PERCENTENCODE_PATH 1
+
 /**
  * Append the contents of a string to a strbuf, percent-encoding any characters
  * that are needed to be encoded for a URL.
+ *
+ * If STRBUF_PERCENTENCODE_PATH is set in flags, don't percent-encode slashes.
  */
-void strbuf_add_percentencode(struct strbuf *dst, const char *src);
+void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
 
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 5555a1524f..87267a7aac 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -366,6 +366,36 @@ test_expect_success 'match percent-encoded values' '
 	EOF
 '
 
+test_expect_success 'match percent-encoded values in username' '
+	test_config credential.https://user%2fname@example.com/foo/bar.git.helper "$HELPER" &&
+	check fill <<-\EOF
+	url=https://user%2fname@example.com/foo/bar.git
+	--
+	protocol=https
+	host=example.com
+	username=foo
+	password=bar
+	--
+	EOF
+'
+
+test_expect_success 'fetch with multiple path components' '
+	test_unconfig credential.helper &&
+	test_config credential.https://example.com/foo/repo.git.helper "verbatim foo bar" &&
+	check fill <<-\EOF
+	url=https://example.com/foo/repo.git
+	--
+	protocol=https
+	host=example.com
+	username=foo
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	EOF
+'
+
 test_expect_success 'pull username from config' '
 	test_config credential.https://example.com.username foo &&
 	check fill <<-\EOF

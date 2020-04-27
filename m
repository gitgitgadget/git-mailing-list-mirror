Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E5CC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 01:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB040206A5
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 01:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dC7BYvFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgD0BST (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 21:18:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgD0BSS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 21:18:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B41BE6052F;
        Mon, 27 Apr 2020 01:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587950297;
        bh=rSwDqAkqoFuOeLryxCug437ujTUtpSKvGpXQQBjKxUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=dC7BYvFCXRBAkr4RyVfreuMs14olQNcy6+nn5ntpMTJ/YeBVV9et0rhtuUVGsW+o+
         boz1uW5V/FnXroXVk4AxirYUov/nNLNHnyVdYkzy/Nov1aCJy+RaYu9Lc2NaYYU2Yg
         cpboNGOFEZBgkI4riYnB+VreUgruwMGltihmXsg7s0/dy86q7w/fLgQFPA1pkRIFTZ
         6CMdiBqFg3belAmDacNCy50YUyuE+b5OBYlXESiDYR4cOxif2lSJwfROMhWmVxi1bu
         M11cGy0pnr+62BSA6RKM+am5fza4OyYa730ZfB/O2yRUHCNMOTODbP3gpzuMo0PNr5
         ce7ySO0HvXI4Aohlm/PQ10NECO/X/2/OKH1ANYoBvmtgjF9cG6HLDIuRRhXDtLAXIQ
         3FMBI5qpvc1oYcXOionZ0WT+rEyg4vnoQ+oSsyltTt/TEHq3aGamW8ftMIdFmecsdA
         gyAIww7GHiJiPRcqLdYD2sqaS7WsZOkfTVTOU0g3tbcMxXP3FUB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Ilya Tretyakov <it@it3xl.ru>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5] credential: fix matching URLs with multiple levels in path
Date:   Mon, 27 Apr 2020 01:18:08 +0000
Message-Id: <20200427011809.2494377-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9
In-Reply-To: <20200421225837.GB3515235@coredump.intra.peff.net>
References: <20200421225837.GB3515235@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

So instead, let's add a flag to control encoding slashes, which is the
behavior we want here, and use it when calling the code in this case.

Add a test for credential helper URLs using multiple slashes in the
path, which our test suite previously lacked, as well as one ensuring
that we handle usernames with slashes gracefully.  Since we're testing
other percent-encoding handling, let's add one for non-ASCII UTF-8
characters as well.

Reported-by: Ilya Tretyakov <it@it3xl.ru>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I talked to Carlo off-list because he was concerned about the potential
security implications of the patch, and as part of that discussion he
suggested an additional test for our UTF-8 handling.  Since adding some
additional tests for that case seemed like a good idea, I squashed in a
patch of his to handle that case.

That's the only change between v4 and v5.

 credential.c           |  4 ++--
 strbuf.c               |  8 +++++---
 strbuf.h               |  7 ++++++-
 t/t0300-credentials.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/credential.c b/credential.c
index 064e25e5d5..d72e2ed0d8 100644
--- a/credential.c
+++ b/credential.c
@@ -136,14 +136,14 @@ static void credential_format(struct credential *c, struct strbuf *out)
 		return;
 	strbuf_addf(out, "%s://", c->protocol);
 	if (c->username && *c->username) {
-		strbuf_add_percentencode(out, c->username);
+		strbuf_add_percentencode(out, c->username, STRBUF_ENCODE_SLASH);
 		strbuf_addch(out, '@');
 	}
 	if (c->host)
 		strbuf_addstr(out, c->host);
 	if (c->path) {
 		strbuf_addch(out, '/');
-		strbuf_add_percentencode(out, c->path);
+		strbuf_add_percentencode(out, c->path, 0);
 	}
 }
 
diff --git a/strbuf.c b/strbuf.c
index bb0065ccaf..51c83aae2d 100644
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
+		    (ch == '/' && (flags & STRBUF_ENCODE_SLASH)) ||
+		    strchr(URL_UNSAFE_CHARS, ch))
 			strbuf_addf(dst, "%%%02X", (unsigned char)ch);
 		else
 			strbuf_addch(dst, ch);
diff --git a/strbuf.h b/strbuf.h
index ce8e49c0b2..e524c52e01 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -378,11 +378,16 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb,
  */
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
 
+#define STRBUF_ENCODE_SLASH 1
+
 /**
  * Append the contents of a string to a strbuf, percent-encoding any characters
  * that are needed to be encoded for a URL.
+ *
+ * If STRBUF_ENCODE_SLASH is set in flags, percent-encode slashes.  Otherwise,
+ * slashes are not percent-encoded.
  */
-void strbuf_add_percentencode(struct strbuf *dst, const char *src);
+void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
 
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 48484cbcf6..91a007fbfa 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -366,6 +366,51 @@ test_expect_success 'match percent-encoded values' '
 	EOF
 '
 
+test_expect_success 'match percent-encoded UTF-8 values in path' '
+	test_config credential.https://example.com.useHttpPath true &&
+	test_config credential.https://example.com/perú.git.helper "$HELPER" &&
+	check fill <<-\EOF
+	url=https://example.com/per%C3%BA.git
+	--
+	protocol=https
+	host=example.com
+	path=perú.git
+	username=foo
+	password=bar
+	--
+	EOF
+'
+
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

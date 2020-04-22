Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD15C2BA19
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364AF206D5
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xTLxu8s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDVBY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:24:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37504 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbgDVBY0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 21:24:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C288A6088E;
        Wed, 22 Apr 2020 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587518635;
        bh=JOujugVVhL9Vclmu0lbjLRQ7zgAvMfnMgqO4cGYe8LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xTLxu8s8j9dh72xtxvNitFp4426b6fNmN7LpAoihAxfyLi40p6nw2gztHC2x551Qv
         109CQL9OvM3zcm4C27mZJsDMh3p08yaDgv/2bmW66nVX0kNpuLOatT222NkRdCgSo0
         TpBAs8i6LxKHMGUdifqjat1RsMJsBUhQyc/m6ij4HKI0mgZHNab6Ns/2UBZ6GN5ZVR
         NfGSmiO+fg90k9AQXUoczDQd7pDbGoNnlYNvU50B/Yw6OTKN4sqnC++Oj2KhZbTkYu
         ungflRcw+sK1cYuaIpy2KrlJN6mHBGCgv4bUMn0aclQR2qlsFBmvsaqTi/fHTz/WkL
         gZpIkjmCQhuXxSBLD9/DPMjWZpNaLCKh9/CJycQ6bZwL+fCn2FQviyfKbDpUy9h26D
         OkWzM6gZnFZC6em4Hy28P5qd+oja+2UDTtEVzcMK1eIedDkcbCerE6Mt5Vx2g8YQyd
         yOYQh9yikPbWmY0udQ/XJT6J4tlnnsneeRguN7EH3A8O1sKqB65
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Ilya Tretyakov <it@it3xl.ru>
Subject: [PATCH] credential: fix matching URLs with multiple levels in path
Date:   Wed, 22 Apr 2020 01:23:44 +0000
Message-Id: <20200422012344.2051103-1-sandals@crustytoothpaste.net>
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
simply change it not to encode slashes.  However, this would be
surprising to other potential users who might want to use it and might
result in unwanted slashes appearing in the encoded value.

So instead, let's add a flag to skip encoding slashes, which is the
behavior we want here, and use it when calling the code in this case.
Add a test for credential helper URLs using multiple slashes in the
path, which our test suite previously lacked.

Reported-by: Ilya Tretyakov <it@it3xl.ru>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 credential.c           |  4 ++--
 strbuf.c               |  8 +++++---
 strbuf.h               |  6 +++++-
 t/t0300-credentials.sh | 18 ++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/credential.c b/credential.c
index 108d9e183a..f0e55a27ac 100644
--- a/credential.c
+++ b/credential.c
@@ -136,14 +136,14 @@ static void credential_format(struct credential *c, struct strbuf *out)
 		return;
 	strbuf_addf(out, "%s://", c->protocol);
 	if (c->username && *c->username) {
-		strbuf_add_percentencode(out, c->username);
+		strbuf_add_percentencode(out, c->username, STRBUF_PERCENTENCODE_PATH);
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
index 5555a1524f..15eeef1dfd 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -510,6 +510,24 @@ test_expect_success 'helpers can abort the process' '
 	test_i18ncmp expect stderr
 '
 
+test_expect_success 'helpers can fetch with multiple path components' '
+	test_unconfig credential.helper &&
+	test_config credential.https://example.com/foo/repo.git.helper "verbatim foo bar" &&
+	echo url=https://example.com/foo/repo.git | git credential fill &&
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
 test_expect_success 'empty helper spec resets helper list' '
 	test_config credential.helper "verbatim file file" &&
 	check fill "" "verbatim cmdline cmdline" <<-\EOF

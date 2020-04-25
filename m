Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB22C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 21:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F03B2071C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 21:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yx/1kaf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgDYVd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 17:33:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37664 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbgDYVd5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 17:33:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4954D6042C;
        Sat, 25 Apr 2020 21:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587850405;
        bh=OvRHiekQCgClpPDhrM1I9/p9qi/au9e2h4YF6NSrvEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yx/1kaf8zuYGZefljVSWGpKlRHm0rtICAwv515jmNAB1Ea0uObIAL75rpXMoXg28+
         2l6ayhzcNLuIZK7I3GWQLxmyIeCXaoAoz+Rph/u0I6DOAuvn7HV1Hk/jX7why0RNWL
         ovOqDoFzYlbXk7mw9DZkQcDXF3qPbN5wcbWaUMQO8gunM1JMm1EckkmrlU5dUveR8L
         RSn52jeO7RKtyyRXwG9hA1F5/UrNkXIR4eV8m+sEXAtKUfQFjV59R97tlw0kpRuhRM
         ocG87SuVhTcPn3PWJ1UgTX+S/yzlRUqcmg5X8GyRiBg8MoPIugPxX/hEHrdQV3UI2F
         Ex0DjKdhK8D16Qed73QRf/MEmhCdZyRyGkSk8BU7sv13IJK1l6qN431W60ssmTLszE
         qAqjHT2kYKmiWBnouMg0qYiXRAVJO5CB1/jpk/4wPwuLg5wx1fHPNlyCC8oovSCuer
         LBronDXHQKi4LuZ0j/XOT1XjWZtmR3UrgHeHCZMIQ0zqq3k1Ry/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Ilya Tretyakov <it@it3xl.ru>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] redential: fix matching URLs with multiple levels in path
Date:   Sat, 25 Apr 2020 21:32:15 +0000
Message-Id: <20200425213215.71674-1-sandals@crustytoothpaste.net>
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

So instead, let's add a flag to control encoding slashes, which is the
behavior we want here, and use it when calling the code in this case.
Add a test for credential helper URLs using multiple slashes in the
path, which our test suite previously lacked, as well as one ensuring
that we handle usernames with slashes gracefully.

Reported-by: Ilya Tretyakov <it@it3xl.ru>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v2:
* Invert the sense of the flag.
* Shorten the flag name.

Changes from v1:
* Continue to encode slashes in usernames.
* Add a test for encoding slashes in usernames.
* Hoist existing tests near the other percent-encoding tests.
* Update commit message.
* Remove debugging information.

 credential.c           |  4 ++--
 strbuf.c               |  8 +++++---
 strbuf.h               |  7 ++++++-
 t/t0300-credentials.sh | 30 ++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/credential.c b/credential.c
index 108d9e183a..f5327d3d9e 100644
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

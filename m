Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F6C3F68F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6292086A
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qphdRVTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBNXIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:08:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32958 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgBNXIJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 18:08:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BFD406079B;
        Fri, 14 Feb 2020 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581721688;
        bh=GnKK0RrNPB+/OrNKc7VMf69RhrAzVHTMICW5+YimF2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qphdRVTYWAFY1zm/iGH/ODrExiR418YJL3faorj898Ua96EBsFZno4f6q8jHYZ6uu
         tZdzAGBzbdYmJmaWvqHnQDNATpkl8H76LfMPnZvcxepuXMqZpNpf8M6TxiyCFBteIW
         SV3XdtXQHzEs98xdAv5h7nvIQ0VmtR1DOvm9r35zHmNE0tmLWAFzjSHt8d1dKcqRh+
         4EI+iU8esplNJFkwJhIFJBfBtHlBu8Wi1SCxyCITnWonIy3i0kkyJ0mc3ngTTandCA
         xU4dElxBdLc3/hAlTL4cP35JikZ8RRLmNDEKxEwmUzoU4hyNxxuze21CGG1H9L6ng7
         ygnRPWVyI56ZUHKxiSKCR3c7npwTQT09c7rAXYz8rNC+S643/VTUCB1FePkeSYQ9Bo
         I0qw616zoc7YoVZGHb7wQoNjgNrGbETE4LaLP4rxzo5cabFUOxKOmJi+eCdCIQzevJ
         n6Di+91uSelnQSPY0PVdYp7rfjuT31E+SIX8ChHu652yCpA9MAy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 3/3] credential: allow wildcard patterns when matching config
Date:   Fri, 14 Feb 2020 22:59:29 +0000
Message-Id: <20200214225929.541306-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0
In-Reply-To: <20200214225929.541306-1-sandals@crustytoothpaste.net>
References: <20200214225929.541306-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: brian m. carlson <bk2204@github.com>

In some cases, a user will want to use a specific credential helper for
a wildcard pattern, such as https://*.corp.example.com. Use the urlmatch
code to match a pattern for a URL to allow this behavior.

Since we are handling URLs using urlmatch, remove the custom code to
match URLs, since it is no longer needed.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/gitcredentials.txt |  4 +++-
 credential.c                     | 41 +++++++++++++++++---------------
 t/t0300-credentials.sh           | 20 ++++++++++++++++
 3 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index ea759fdee5..12cb032352 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -131,7 +131,9 @@ context would not match:
 because the hostnames differ. Nor would it match `foo.example.com`; Git
 compares hostnames exactly, without considering whether two hosts are part of
 the same domain. Likewise, a config entry for `http://example.com` would not
-match: Git compares the protocols exactly.
+match: Git compares the protocols exactly.  However, you may use wildcards in
+the domain name and other pattern matching techniques as with the `http.<url>.*`
+options.
 
 If the "pattern" URL does include a path component, then this too must match
 exactly: the context `https://example.com/bar/baz.git` will match a config
diff --git a/credential.c b/credential.c
index 62be651b03..08904e247f 100644
--- a/credential.c
+++ b/credential.c
@@ -6,6 +6,7 @@
 #include "url.h"
 #include "prompt.h"
 #include "sigchain.h"
+#include "urlmatch.h"
 
 void credential_init(struct credential *c)
 {
@@ -40,7 +41,7 @@ static int credential_config_callback(const char *var, const char *value,
 				      void *data)
 {
 	struct credential *c = data;
-	const char *key, *dot;
+	const char *key;
 
 	if (!skip_prefix(var, "credential.", &key))
 		return 0;
@@ -48,23 +49,6 @@ static int credential_config_callback(const char *var, const char *value,
 	if (!value)
 		return config_error_nonbool(var);
 
-	dot = strrchr(key, '.');
-	if (dot) {
-		struct credential want = CREDENTIAL_INIT;
-		char *url = xmemdupz(key, dot - key);
-		int matched;
-
-		credential_from_url(&want, url);
-		matched = credential_match(&want, c);
-
-		credential_clear(&want);
-		free(url);
-
-		if (!matched)
-			return 0;
-		key = dot + 1;
-	}
-
 	if (!strcmp(key, "helper")) {
 		if (*value)
 			string_list_append(&c->helpers, value);
@@ -87,11 +71,30 @@ static int proto_is_http(const char *s)
 	return !strcmp(s, "https") || !strcmp(s, "http");
 }
 
+static void credential_describe(struct credential *c, struct strbuf *out);
+
 static void credential_apply_config(struct credential *c)
 {
+	char *normalized_url;
+	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct strbuf url = STRBUF_INIT;
+
 	if (c->configured)
 		return;
-	git_config(credential_config_callback, c);
+
+	config.section = "credential";
+	config.key = NULL;
+	config.collect_fn = credential_config_callback;
+	config.cascade_fn = git_default_config;
+	config.cb = c;
+
+	credential_describe(c, &url);
+	normalized_url = url_normalize(url.buf, &config.url);
+
+	git_config(urlmatch_config_entry, &config);
+	free(normalized_url);
+	strbuf_release(&url);
+
 	c->configured = 1;
 
 	if (!c->use_http_path && proto_is_http(c->protocol)) {
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 82eaaea0f4..516b3268f9 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -289,6 +289,26 @@ test_expect_success 'http paths can be part of context' '
 	EOF
 '
 
+test_expect_success 'context uses urlmatch' '
+	test_config "credential.https://*.org.useHttpPath" true &&
+	check fill "verbatim foo bar" <<-\EOF
+	protocol=https
+	host=example.org
+	path=foo.git
+	--
+	protocol=https
+	host=example.org
+	path=foo.git
+	username=foo
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.org
+	verbatim: path=foo.git
+	EOF
+'
+
 test_expect_success 'helpers can abort the process' '
 	test_must_fail git \
 		-c credential.helper="!f() { echo quit=1; }; f" \

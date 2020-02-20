Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3EEC11D41
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3BA24671
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h4YgD2FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBTCYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:24:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36878 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727691AbgBTCYj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Feb 2020 21:24:39 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C6D0760CF2;
        Thu, 20 Feb 2020 02:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582165478;
        bh=29Py2g5Hh7ZkCVn7lQaxX3CTed5DJDABtVkK4NzfDK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=h4YgD2FH6BE72chV1LzjRexkkMLRRxt4E3mSzK7UX7POf1d9rDO15ECfbbWdksXS2
         alg6730+k3jc69FhaOZe/tqFTv1j8pbZ3doehPe+Px/c9BTdolTJiTQYKIVvS6NkNw
         g5gE3qlNlKiM5WHlpmAhFCu4OgrHWRQvwgejGqcOuFCP1xmhHTDK5C4fHbS4HGgbL8
         JZg8T9rTU2seRG+lr7YuW/vHF8l8jSeazQYdWXMmzGS21q0vKq8rLPkOU8aZ3uko1r
         KcqbCggiOcWi/BWzB4tpf1Pww/zfFXVc8vTbi+6DR3AD3SxMG6zT+BwK03G/5d89AZ
         10/MovYbGYUfb+040gxUjAkCKMvN4Th+nIf/s9s1JkT+5GiTCor2H11ubq/Il5xrnc
         ig3Lf9A33HMGrx/yFonfkV5VJcLj3QulZCzJDp0mZ2RcTRjI2ljj2JpbvkfngC9w1Q
         BpaJxkzOqxQf9LPDRs7PgjTse3gNT9MfiTz3QZhuJooQlaKjBVu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 5/5] credential: allow wildcard patterns when matching config
Date:   Thu, 20 Feb 2020 02:24:13 +0000
Message-Id: <20200220022413.258026-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200220022413.258026-1-sandals@crustytoothpaste.net>
References: <20200220022413.258026-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: brian m. carlson <bk2204@github.com>

In some cases, a user will want to use a specific credential helper for
a wildcard pattern, such as https://*.corp.example.com.  We have code
that handles this already with the urlmatch code, so let's use that
instead of our custom code.

Since the urlmatch code is a superset of our current matching in terms
of capabilities, there shouldn't be any cases of things that matched
previously that don't match now.  However, in addition to wildcard
matching, we now use partial path matching, which can cause slightly
different behavior in the case that a helper applies to the prefix
(considering path components) of the remote URL.  While different, this
is probably the behavior people were wanting anyway.

Since we're using the urlmatch code, we need to encode the components
we've gotten into a URL to match, so add a function to percent-encode
data and format the URL with it.  We now also no longer need to the
custom code to match URLs, so let's remove it.

Additionally, the urlmatch code always looks for the best match, whereas
we want all matches for credential helpers to preserve existing
behavior.  Let's add an optional field, select_fn, that lets us control
which items we want (in this case, all of them) and default it to the
best-match code that already exists for other users.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/gitcredentials.txt |  4 +-
 credential.c                     | 66 +++++++++++++++++++++++---------
 strbuf.c                         | 15 ++++++++
 strbuf.h                         |  6 +++
 t/t0300-credentials.sh           | 20 ++++++++++
 urlmatch.c                       |  4 +-
 urlmatch.h                       |  9 +++++
 7 files changed, 103 insertions(+), 21 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 5b9d14fb1f..1814d2d23c 100644
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
index 5701e32792..77dfde44e3 100644
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
@@ -89,11 +73,38 @@ static int proto_is_http(const char *s)
 	return !strcmp(s, "https") || !strcmp(s, "http");
 }
 
+static void credential_describe(struct credential *c, struct strbuf *out);
+static void credential_format(struct credential *c, struct strbuf *out);
+
+static int select_all(const struct urlmatch_item *a,
+		      const struct urlmatch_item *b)
+{
+	return 0;
+}
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
+	config.cascade_fn = NULL;
+	config.select_fn = select_all;
+	config.cb = c;
+
+	credential_format(c, &url);
+	normalized_url = url_normalize(url.buf, &config.url);
+
+	git_config(urlmatch_config_entry, &config);
+	free(normalized_url);
+	strbuf_release(&url);
+
 	c->configured = 1;
 
 	if (!c->use_http_path && proto_is_http(c->protocol)) {
@@ -114,6 +125,23 @@ static void credential_describe(struct credential *c, struct strbuf *out)
 		strbuf_addf(out, "/%s", c->path);
 }
 
+static void credential_format(struct credential *c, struct strbuf *out)
+{
+	if (!c->protocol)
+		return;
+	strbuf_addf(out, "%s://", c->protocol);
+	if (c->username && *c->username) {
+		strbuf_add_percentencode(out, c->username);
+		strbuf_addch(out, '@');
+	}
+	if (c->host)
+		strbuf_addstr(out, c->host);
+	if (c->path) {
+		strbuf_addch(out, '/');
+		strbuf_add_percentencode(out, c->path);
+	}
+}
+
 static char *credential_ask_one(const char *what, struct credential *c,
 				int flags)
 {
diff --git a/strbuf.c b/strbuf.c
index f19da55b07..bb0065ccaf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -479,6 +479,21 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src)
 	}
 }
 
+#define URL_UNSAFE_CHARS " <>\"%{}|\\^`:/?#[]@!$&'()*+,;="
+
+void strbuf_add_percentencode(struct strbuf *dst, const char *src)
+{
+	size_t i, len = strlen(src);
+
+	for (i = 0; i < len; i++) {
+		unsigned char ch = src[i];
+		if (ch <= 0x1F || ch >= 0x7F || strchr(URL_UNSAFE_CHARS, ch))
+			strbuf_addf(dst, "%%%02X", (unsigned char)ch);
+		else
+			strbuf_addch(dst, ch);
+	}
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index aae7ac3a82..ce8e49c0b2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -378,6 +378,12 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb,
  */
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
 
+/**
+ * Append the contents of a string to a strbuf, percent-encoding any characters
+ * that are needed to be encoded for a URL.
+ */
+void strbuf_add_percentencode(struct strbuf *dst, const char *src);
+
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 8f87599056..39f097ea9e 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -397,6 +397,26 @@ test_expect_success 'http paths can be part of context' '
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
diff --git a/urlmatch.c b/urlmatch.c
index 3e42bd7504..29272a5c4f 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -557,6 +557,8 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	const char *key, *dot;
 	struct strbuf synthkey = STRBUF_INIT;
 	int retval;
+	int (*select_fn)(const struct urlmatch_item *a, const struct urlmatch_item *b) =
+		collect->select_fn ? collect->select_fn : cmp_matches;
 
 	if (!skip_prefix(var, collect->section, &key) || *(key++) != '.') {
 		if (collect->cascade_fn)
@@ -587,7 +589,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	if (!item->util) {
 		item->util = xcalloc(1, sizeof(matched));
 	} else {
-		if (cmp_matches(&matched, item->util) < 0)
+		if (select_fn(&matched, item->util) < 0)
 			 /*
 			  * Our match is worse than the old one,
 			  * we cannot use it.
diff --git a/urlmatch.h b/urlmatch.h
index eed5f29235..2407520731 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -50,6 +50,15 @@ struct urlmatch_config {
 	void *cb;
 	int (*collect_fn)(const char *var, const char *value, void *cb);
 	int (*cascade_fn)(const char *var, const char *value, void *cb);
+	/*
+	 * Compare the two matches, the one just discovered and the existing
+	 * best match and return a negative value if the found item is to be
+	 * rejected or a non-negative value if it is to be accepted.  If this
+	 * field is set to NULL, use the default comparison technique, which
+	 * checks to ses if found is better (according to the urlmatch
+	 * specificity rules) than existing.
+	 */
+	int (*select_fn)(const struct urlmatch_item *found, const struct urlmatch_item *existing);
 };
 
 int urlmatch_config_entry(const char *var, const char *value, void *cb);

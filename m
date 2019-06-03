Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66281F462
	for <e@80x24.org>; Mon,  3 Jun 2019 22:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFCWWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 18:22:51 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:35478 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfFCWWu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jun 2019 18:22:50 -0400
Received: from resomta-po-07v.sys.comcast.net ([96.114.154.231])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id XpxLhvVb1F9fpXvLthGTfO; Mon, 03 Jun 2019 22:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559600569;
        bh=HrZJjYgplm0OTmz6QHKmFCZXFI+lYA0DxJPMTwPqgpk=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=UzKzSodMjwmPfUV/ivsPVnpgksYxA4HotNYIdv6hOH/FRyTsi1FyIsGlz2A/oOmmh
         QKuXGb4Q9gpu21UAOMMaLe0dPqwqliVn2amYwBAqCPDMsFqAl0LswJ13Qn1rMwn4C1
         gX0Rioh9PNWeFWOXWKDN/UsTsXJYvA8YU6f6110Uz+5VxUtyAoGdONvwOxNwUUii4U
         kZCaBzmeXVZfP10uCMqFyTHEJfwkp4VBCe5Z8jlw08ndPMQYIIDqR/oMT957rBvPJw
         KOisXj7Ox2ZU/OQMznupSPVN1W72iamT7XYMRTd0sj5SfqP7PoLxo2a8qiKM2ykPeG
         WYEk0dbzrQirQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a5aa:2f0c:f3a4:606c])
        by resomta-po-07v.sys.comcast.net with ESMTPSA
        id XvLrhbalDqH0NXvLshvYtQ; Mon, 03 Jun 2019 22:22:49 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Mon, 3 Jun 2019 15:22:47 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190603222247.GG4641@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603123435.GA18953@sigill.intra.peff.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 08:34:35AM -0400, Jeff King wrote:
> Great. We might want to stop there, but it's possible could reuse even
> more code. I didn't look closely before, but it seems this code is
> decoding a URL. We already have a url_decode() routine in url.c. Could
> it be reused?

Very nice. Here is an interdiff and the changes will be included in v3 of my
patchset:

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ed02c88eb6..0f135602a7 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,19 +1,20 @@
 #include "cache.h"
 #include "commit.h"
 #include "config.h"
 #include "revision.h"
 #include "argv-array.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "trace.h"
+#include "url.h"
 
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf);
 
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
  *       --filter=<arg>
@@ -84,54 +85,20 @@ static int gently_parse_list_objects_filter(
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
 	strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
-static int url_decode(struct strbuf *s, struct strbuf *errbuf)
-{
-	char *dest = s->buf;
-	char *src = s->buf;
-	size_t new_len;
-
-	while (*src) {
-		if (src[0] != '%') {
-			*dest++ = *src++;
-			continue;
-		}
-
-		if (hex_to_bytes((unsigned char *)dest, src + 1, 1)) {
-			strbuf_addstr(errbuf,
-				      "error in filter-spec - "
-				      "invalid hex sequence after %");
-			return 1;
-		}
-
-		if (!*dest) {
-			strbuf_addstr(errbuf,
-				      "error in filter-spec - unexpected %00");
-			return 1;
-		}
-
-		src += 3;
-		dest++;
-	}
-	new_len = dest - s->buf;
-	strbuf_remove(s, new_len, s->len - new_len);
-
-	return 0;
-}
-
 static const char *RESERVED_NON_WS = "~`!@#$^&*()[]{}\\;'\",<>?";
 
 static int has_reserved_character(
 	struct strbuf *sub_spec, struct strbuf *errbuf)
 {
 	const char *c = sub_spec->buf;
 	while (*c) {
 		if (*c <= ' ' || strchr(RESERVED_NON_WS, *c)) {
 			strbuf_addf(errbuf,
 				    "must escape char in sub-filter-spec: '%c'",
@@ -147,56 +114,57 @@ static int has_reserved_character(
 static int parse_combine_subfilter(
 	struct list_objects_filter_options *filter_options,
 	struct strbuf *subspec,
 	struct strbuf *errbuf)
 {
 	size_t new_index = filter_options->sub_nr;
 
 	ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 		      filter_options->sub_alloc);
 
-	return has_reserved_character(subspec, errbuf) ||
-		url_decode(subspec, errbuf) ||
-		gently_parse_list_objects_filter(
-			&filter_options->sub[new_index], subspec->buf, errbuf);
+	decoded = url_percent_decode(subspec->buf);
+
+	result = gently_parse_list_objects_filter(
+		&filter_options->sub[new_index], decoded, errbuf);
+
+	free(decoded);
+	return result;
 }
 
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
 	size_t sub;
-	int result;
+	int result = 0;
 
 	if (!subspecs[0]) {
 		strbuf_addf(errbuf,
 			    _("expected something after combine:"));
 		result = 1;
 		goto cleanup;
 	}
 
-	for (sub = 0; subspecs[sub]; sub++) {
+	for (sub = 0; subspecs[sub] && !result; sub++) {
 		if (subspecs[sub + 1]) {
 			/*
 			 * This is not the last subspec. Remove trailing "+" so
 			 * we can parse it.
 			 */
 			size_t last = subspecs[sub]->len - 1;
 			assert(subspecs[sub]->buf[last] == '+');
 			strbuf_remove(subspecs[sub], last, 1);
 		}
 		result = parse_combine_subfilter(
 			filter_options, subspecs[sub], errbuf);
-		if (result)
-			goto cleanup;
 	}
 
 	filter_options->choice = LOFC_COMBINE;
 
 cleanup:
 	strbuf_list_free(subspecs);
 	if (result) {
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 7fb5e50cde..e1bf3ed038 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -405,32 +405,20 @@ test_expect_success 'combine:... while URL-encoding things that should not be' '
 
 test_expect_success 'combine: with nothing after the :' '
 	expect_invalid_filter_spec combine: "expected something after combine:"
 '
 
 test_expect_success 'parse error in first sub-filter in combine:' '
 	expect_invalid_filter_spec combine:tree:asdf+blob:none \
 		"expected .tree:<depth>."
 '
 
-test_expect_success 'combine:... with invalid URL-encoded sequences' '
-	# Not enough hex chars
-	expect_invalid_filter_spec combine:tree:2+blob:non%a \
-		"error in filter-spec - invalid hex sequence after %" &&
-	# Non-hex digit after %
-	expect_invalid_filter_spec combine:tree:2+blob%G5none \
-		"error in filter-spec - invalid hex sequence after %" &&
-	# Null byte encoded by %
-	expect_invalid_filter_spec combine:tree:2+blob%00none \
-		"error in filter-spec - unexpected %00"
-'
-
 test_expect_success 'combine:... with non-encoded reserved chars' '
 	expect_invalid_filter_spec combine:tree:2+sparse:@xyz \
 		"must escape char in sub-filter-spec: .@." &&
 	expect_invalid_filter_spec combine:tree:2+sparse:\` \
 		"must escape char in sub-filter-spec: .\`." &&
 	expect_invalid_filter_spec combine:tree:2+sparse:~abc \
 		"must escape char in sub-filter-spec: .\~."
 '
 
 test_expect_success 'validate err msg for "combine:<valid-filter>+"' '
diff --git a/url.c b/url.c
index 25576c390b..bdede647bc 100644
--- a/url.c
+++ b/url.c
@@ -79,20 +79,26 @@ char *url_decode_mem(const char *url, int len)
 
 	/* Skip protocol part if present */
 	if (colon && url < colon) {
 		strbuf_add(&out, url, colon - url);
 		len -= colon - url;
 		url = colon;
 	}
 	return url_decode_internal(&url, len, NULL, &out, 0);
 }
 
+char *url_percent_decode(const char *encoded)
+{
+	struct strbuf out = STRBUF_INIT;
+	return url_decode_internal(&encoded, strlen(encoded), NULL, &out, 0);
+}
+
 char *url_decode_parameter_name(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
 	return url_decode_internal(query, -1, "&=", &out, 1);
 }
 
 char *url_decode_parameter_value(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
 	return url_decode_internal(query, -1, "&", &out, 1);
diff --git a/url.h b/url.h
index 00b7d58c33..2a27c34277 100644
--- a/url.h
+++ b/url.h
@@ -1,16 +1,24 @@
 #ifndef URL_H
 #define URL_H
 
 struct strbuf;
 
 int is_url(const char *url);
 int is_urlschemechar(int first_flag, int ch);
 char *url_decode(const char *url);
 char *url_decode_mem(const char *url, int len);
+
+/*
+ * Similar to the url_decode_{,mem} methods above, but doesn't assume there
+ * is a scheme followed by a : at the start of the string. Instead, %-sequences
+ * before any : are also parsed.
+ */
+char *url_percent_decode(const char *encoded);
+
 char *url_decode_parameter_name(const char **query);
 char *url_decode_parameter_value(const char **query);
 
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
 #endif /* URL_H */

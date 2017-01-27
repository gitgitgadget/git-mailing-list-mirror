Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767DD1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbdA0Kdw (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:33:52 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58190 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932566AbdA0Kci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:32:38 -0500
Received: from localhost (x55b3aa69.dyn.telefonica.de [85.179.170.105])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 4241D16C790;
        Fri, 27 Jan 2017 11:32:35 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v4 0/5] urlmatch: allow wildcard-based matches
Date:   Fri, 27 Jan 2017 11:32:13 +0100
Message-Id: <cover.1485512626.git.patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

so this is part four of my patch series. The previous version can
be found at [1]. The use case is to be able to configure an HTTP
proxy for all subdomains of a domain where there are hundreds of
subdomains.

Changes to the previous version:

 - applied Junio's proposed patch to replace `strtok_r` with a
   `memchr`-based loop
 - applied Junio's proposed rewrite of the commit message of
   patch 5
 - I realized that with my patches, "ranking" of URLs was broken.
   Previously, we've always taken the longest matching URL. As
   previously, only the user and path could actually differ, only
   these two components were used for the comparison. I've
   changed this now to also include the host part so that URLs
   with a longer host will take precedence. This resulted in a
   the patch 4.
 - New tests are included which examine if the precedence-rules
   are actually honored correctly. The tests are part of patches
   4 and 5.

You can find the interdiff below.

Regards
Patrick

[1]: http://public-inbox.org/git/20170125095648.4116-1-patrick.steinhardt@elego.de/T/#t

Patrick Steinhardt (5):
  mailmap: add Patrick Steinhardt's work address
  urlmatch: enable normalization of URLs with globs
  urlmatch: split host and port fields in `struct url_info`
  urlmatch: include host and port in urlmatch length
  urlmatch: allow globbing for the URL host part

 .mailmap                 |   1 +
 Documentation/config.txt |   5 +-
 t/t1300-repo-config.sh   | 105 ++++++++++++++++++++++++++++++++++++
 urlmatch.c               | 138 +++++++++++++++++++++++++++++++++++------------
 urlmatch.h               |  12 +++--
 5 files changed, 220 insertions(+), 41 deletions(-)

-- 
2.11.0

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index ec545e092..052f12021 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1177,7 +1177,72 @@ test_expect_success 'urlmatch' '
 	test_cmp expect actual
 '
 
-test_expect_success 'glob-based urlmatch' '
+test_expect_success 'urlmatch favors more specific URLs' '
+	cat >.git/config <<-\EOF &&
+	[http "https://example.com/"]
+		cookieFile = /tmp/root.txt
+	[http "https://example.com/subdirectory"]
+		cookieFile = /tmp/subdirectory.txt
+	[http "https://user@example.com/"]
+		cookieFile = /tmp/user.txt
+	[http "https://averylonguser@example.com/"]
+		cookieFile = /tmp/averylonguser.txt
+	[http "https://preceding.example.com"]
+		cookieFile = /tmp/preceding.txt
+	[http "https://*.example.com"]
+		cookieFile = /tmp/wildcard.txt
+	[http "https://*.example.com/wildcardwithsubdomain"]
+		cookieFile = /tmp/wildcardwithsubdomain.txt
+	[http "https://trailing.example.com"]
+		cookieFile = /tmp/trailing.txt
+	[http "https://user@*.example.com/"]
+		cookieFile = /tmp/wildcardwithuser.txt
+	[http "https://sub.example.com/"]
+		cookieFile = /tmp/sub.txt
+	EOF
+
+	echo http.cookiefile /tmp/root.txt >expect &&
+	git config --get-urlmatch HTTP https://example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/subdirectory.txt >expect &&
+	git config --get-urlmatch HTTP https://example.com/subdirectory >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/subdirectory.txt >expect &&
+	git config --get-urlmatch HTTP https://example.com/subdirectory/nested >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/user.txt >expect &&
+	git config --get-urlmatch HTTP https://user@example.com/ >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/subdirectory.txt >expect &&
+	git config --get-urlmatch HTTP https://averylonguser@example.com/subdirectory >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/preceding.txt >expect &&
+	git config --get-urlmatch HTTP https://preceding.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/wildcard.txt >expect &&
+	git config --get-urlmatch HTTP https://wildcard.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/sub.txt >expect &&
+	git config --get-urlmatch HTTP https://sub.example.com/wildcardwithsubdomain >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/trailing.txt >expect &&
+	git config --get-urlmatch HTTP https://trailing.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/sub.txt >expect &&
+	git config --get-urlmatch HTTP https://user@sub.example.com >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'urlmatch with wildcard' '
 	cat >.git/config <<-\EOF &&
 	[http]
 		sslVerify
@@ -1210,6 +1275,10 @@ test_expect_success 'glob-based urlmatch' '
 		echo http.sslverify false
 	} >expect &&
 	git config --get-urlmatch HTTP https://good.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.sslverify >expect &&
+	git config --get-urlmatch HTTP https://more.example.com.au >actual &&
 	test_cmp expect actual
 '
 
diff --git a/urlmatch.c b/urlmatch.c
index 53ff972a6..bb5267732 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -63,36 +63,47 @@ static int append_normalized_escapes(struct strbuf *buf,
 	return 1;
 }
 
+static const char *end_of_token(const char *s, int c, size_t n)
+{
+	const char *next = memchr(s, c, n);
+	if (!next)
+		next = s + n;
+	return next;
+}
+
 static int match_host(const struct url_info *url_info,
 		      const struct url_info *pattern_info)
 {
-	char *url = xmemdupz(url_info->url + url_info->host_off, url_info->host_len);
-	char *pat = xmemdupz(pattern_info->url + pattern_info->host_off, pattern_info->host_len);
-	char *url_tok, *pat_tok, *url_save, *pat_save;
-	int matching;
+	const char *url = url_info->url + url_info->host_off;
+	const char *pat = pattern_info->url + pattern_info->host_off;
+	int url_len = url_info->host_len;
+	int pat_len = pattern_info->host_len;
 
-	url_tok = strtok_r(url, ".", &url_save);
-	pat_tok = strtok_r(pat, ".", &pat_save);
+	while (url_len && pat_len) {
+		const char *url_next = end_of_token(url, '.', url_len);
+		const char *pat_next = end_of_token(pat, '.', pat_len);
 
-	for (; url_tok && pat_tok; url_tok = strtok_r(NULL, ".", &url_save),
-				   pat_tok = strtok_r(NULL, ".", &pat_save)) {
-		if (!strcmp(pat_tok, "*"))
-			continue; /* a simple glob matches everything */
+		if (pat_next == pat + 1 && pat[0] == '*')
+			/* wildcard matches anything */
+			;
+		else if ((pat_next - pat) == (url_next - url) &&
+			 !memcmp(url, pat, url_next - url))
+			/* the components are the same */
+			;
+		else
+			return 0; /* found an unmatch */
 
-		if (strcmp(url_tok, pat_tok)) {
-			/* subdomains do not match */
-			matching = 0;
-			break;
-		}
+		if (url_next < url + url_len)
+			url_next++;
+		url_len -= url_next - url;
+		url = url_next;
+		if (pat_next < pat + pat_len)
+			pat_next++;
+		pat_len -= pat_next - pat;
+		pat = pat_next;
 	}
 
-	/* matching if both URL and pattern are at their ends */
-	matching = (url_tok == NULL && pat_tok == NULL);
-
-	free(url);
-	free(pat);
-
-	return matching;
+	return (!url_len && !pat_len);
 }
 
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
@@ -458,7 +469,7 @@ static size_t url_match_prefix(const char *url,
 
 static int match_urls(const struct url_info *url,
 		      const struct url_info *url_prefix,
-		      int *exactusermatch)
+		      struct urlmatch_item *match)
 {
 	/*
 	 * url_prefix matches url if the scheme, host and port of url_prefix
@@ -477,8 +488,8 @@ static int match_urls(const struct url_info *url,
 	 * contained a user name or false if url_prefix did not have a
 	 * user name.  If there is no match *exactusermatch is left untouched.
 	 */
-	int usermatched = 0;
-	int pathmatchlen;
+	char usermatched = 0;
+	size_t pathmatchlen;
 
 	if (!url || !url_prefix || !url->url || !url_prefix->url)
 		return 0;
@@ -513,22 +524,38 @@ static int match_urls(const struct url_info *url,
 		url->url + url->path_off,
 		url_prefix->url + url_prefix->path_off,
 		url_prefix->url_len - url_prefix->path_off);
+	if (!pathmatchlen)
+		return 0; /* paths do not match */
 
-	if (pathmatchlen && exactusermatch)
-		*exactusermatch = usermatched;
-	return pathmatchlen;
+	if (match) {
+		match->hostmatch_len = url_prefix->host_len;
+		match->pathmatch_len = pathmatchlen;
+		match->user_matched = usermatched;
+	}
+
+	return 1;
+}
+
+static int cmp_matches(const struct urlmatch_item *a,
+		       const struct urlmatch_item *b)
+{
+	if (a->hostmatch_len != b->hostmatch_len)
+		return a->hostmatch_len < b->hostmatch_len ? -1 : 1;
+	if (a->pathmatch_len != b->pathmatch_len)
+		return a->pathmatch_len < b->pathmatch_len ? -1 : 1;
+	if (a->user_matched != b->user_matched)
+		return b->user_matched ? -1 : 1;
+	return 0;
 }
 
 int urlmatch_config_entry(const char *var, const char *value, void *cb)
 {
 	struct string_list_item *item;
 	struct urlmatch_config *collect = cb;
-	struct urlmatch_item *matched;
+	struct urlmatch_item matched;
 	struct url_info *url = &collect->url;
 	const char *key, *dot;
 	struct strbuf synthkey = STRBUF_INIT;
-	size_t matched_len = 0;
-	int user_matched = 0;
 	int retval;
 
 	if (!skip_prefix(var, collect->section, &key) || *(key++) != '.') {
@@ -546,9 +573,9 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 		free(config_url);
 		if (!norm_url)
 			return 0;
-		matched_len = match_urls(url, &norm_info, &user_matched);
+		retval = match_urls(url, &norm_info, &matched);
 		free(norm_url);
-		if (!matched_len)
+		if (!retval)
 			return 0;
 		key = dot + 1;
 	}
@@ -558,24 +585,17 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 
 	item = string_list_insert(&collect->vars, key);
 	if (!item->util) {
-		matched = xcalloc(1, sizeof(*matched));
-		item->util = matched;
+		item->util = xcalloc(1, sizeof(matched));
 	} else {
-		matched = item->util;
-		/*
-		 * Is our match shorter?  Is our match the same
-		 * length, and without user while the current
-		 * candidate is with user?  Then we cannot use it.
-		 */
-		if (matched_len < matched->matched_len ||
-		    ((matched_len == matched->matched_len) &&
-		     (!user_matched && matched->user_matched)))
+		if (cmp_matches(&matched, item->util) <= 0)
+			 /*
+			  * Our match is worse than the old one,
+			  * we cannot use it.
+			  */
 			return 0;
-		/* Otherwise, replace it with this one. */
 	}
 
-	matched->matched_len = matched_len;
-	matched->user_matched = user_matched;
+	memcpy(item->util, &matched, sizeof(matched));
 	strbuf_addstr(&synthkey, collect->section);
 	strbuf_addch(&synthkey, '.');
 	strbuf_addstr(&synthkey, key);
diff --git a/urlmatch.h b/urlmatch.h
index 0ea812b03..37ee5da85 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -34,7 +34,8 @@ struct url_info {
 extern char *url_normalize(const char *, struct url_info *);
 
 struct urlmatch_item {
-	size_t matched_len;
+	size_t hostmatch_len;
+	size_t pathmatch_len;
 	char user_matched;
 };
 

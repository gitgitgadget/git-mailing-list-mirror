Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3CA21F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbdA0Kdw (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:33:52 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58206 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932573AbdA0Kcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:32:39 -0500
Received: from localhost (x55b3aa69.dyn.telefonica.de [85.179.170.105])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 63B3B16C881;
        Fri, 27 Jan 2017 11:32:37 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v4 4/5] urlmatch: include host and port in urlmatch length
Date:   Fri, 27 Jan 2017 11:32:17 +0100
Message-Id: <27c4d2844114c6bc8dc3b02d1a426411b7ab1d56.1485512626.git.patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1485512626.git.patrick.steinhardt@elego.de>
References: <cover.1485512626.git.patrick.steinhardt@elego.de>
In-Reply-To: <cover.1485512626.git.patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de> <cover.1485512626.git.patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be able to rank positive matches by `urlmatch`, we inspect
the path length and user part to decide whether a match is better than
another match. As all other parts are matched exactly between both URLs,
this is the right thing to do right now.

In the future, though, we want to introduce wild cards for the domain
part. When doing this, though, it does not make sense anymore to only
compare the path lengths. Instead, we also want to compare the domain
lengths to determine which of both URLs matches the host part more
closely.

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
---
 t/t1300-repo-config.sh | 33 ++++++++++++++++++++++++++++
 urlmatch.c             | 59 +++++++++++++++++++++++++++++---------------------
 urlmatch.h             |  3 ++-
 3 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 923bfc5a2..6c844d519 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1177,6 +1177,39 @@ test_expect_success 'urlmatch' '
 	test_cmp expect actual
 '
 
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
+	test_cmp expect actual
+'
+
 # good section hygiene
 test_expect_failure 'unsetting the last key in a section removes header' '
 	cat >.git/config <<-\EOF &&
diff --git a/urlmatch.c b/urlmatch.c
index e328905eb..f35d00a6e 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -426,7 +426,7 @@ static size_t url_match_prefix(const char *url,
 
 static int match_urls(const struct url_info *url,
 		      const struct url_info *url_prefix,
-		      int *exactusermatch)
+		      struct urlmatch_item *match)
 {
 	/*
 	 * url_prefix matches url if the scheme, host and port of url_prefix
@@ -445,8 +445,8 @@ static int match_urls(const struct url_info *url,
 	 * contained a user name or false if url_prefix did not have a
 	 * user name.  If there is no match *exactusermatch is left untouched.
 	 */
-	int usermatched = 0;
-	int pathmatchlen;
+	char usermatched = 0;
+	size_t pathmatchlen;
 
 	if (!url || !url_prefix || !url->url || !url_prefix->url)
 		return 0;
@@ -483,22 +483,38 @@ static int match_urls(const struct url_info *url,
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
@@ -516,9 +532,9 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
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
@@ -528,24 +544,17 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 
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
 
-- 
2.11.0


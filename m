Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7440C1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbdA0Kdv (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:33:51 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58211 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932579AbdA0Kck (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:32:40 -0500
Received: from localhost (x55b3aa69.dyn.telefonica.de [85.179.170.105])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id E885616C882;
        Fri, 27 Jan 2017 11:32:37 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v4 5/5] urlmatch: allow globbing for the URL host part
Date:   Fri, 27 Jan 2017 11:32:18 +0100
Message-Id: <ac84183cc77f4d91e580ceb47c0c8bda5d6c3531.1485512626.git.patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1485512626.git.patrick.steinhardt@elego.de>
References: <cover.1485512626.git.patrick.steinhardt@elego.de>
In-Reply-To: <cover.1485512626.git.patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de> <cover.1485512626.git.patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The URL matching function computes for two URLs whether they match not.
The match is performed by splitting up the URL into different parts and
then doing an exact comparison with the to-be-matched URL.

The main user of `urlmatch` is the configuration subsystem. It allows to
set certain configurations based on the URL which is being connected to
via keys like `http.<url>.*`. A common use case for this is to set
proxies for only some remotes which match the given URL. Unfortunately,
having exact matches for all parts of the URL can become quite tedious
in some setups. Imagine for example a corporate network where there are
dozens or even hundreds of subdomains, which would have to be configured
individually.

Allow users to write an asterisk '*' in place of any 'host' or
'subdomain' label as part of the host name.  For example,
"http.https://*.example.com.proxy" sets "http.proxy" for all direct
subdomains of "https://example.com", e.g. "https://foo.example.com", but
not "https://foo.bar.example.com".

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  5 +++-
 t/t1300-repo-config.sh   | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 urlmatch.c               | 49 +++++++++++++++++++++++++++++---
 3 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 506431267..078e9b490 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1914,7 +1914,10 @@ http.<url>.*::
   must match exactly between the config key and the URL.
 
 . Host/domain name (e.g., `example.com` in `https://example.com/`).
-  This field must match exactly between the config key and the URL.
+  This field must match between the config key and the URL. It is
+  possible to specify a `*` as part of the host name to match all subdomains
+  at this level. `https://*.example.com/` for example would match
+  `https://foo.example.com/`, but not `https://foo.bar.example.com/`.
 
 . Port number (e.g., `8080` in `http://example.com:8080/`).
   This field must match exactly between the config key and the URL.
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 6c844d519..052f12021 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1187,6 +1187,18 @@ test_expect_success 'urlmatch favors more specific URLs' '
 		cookieFile = /tmp/user.txt
 	[http "https://averylonguser@example.com/"]
 		cookieFile = /tmp/averylonguser.txt
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
 	EOF
 
 	echo http.cookiefile /tmp/root.txt >expect &&
@@ -1207,6 +1219,66 @@ test_expect_success 'urlmatch favors more specific URLs' '
 
 	echo http.cookiefile /tmp/subdirectory.txt >expect &&
 	git config --get-urlmatch HTTP https://averylonguser@example.com/subdirectory >actual &&
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
+	cat >.git/config <<-\EOF &&
+	[http]
+		sslVerify
+	[http "https://*.example.com"]
+		sslVerify = false
+		cookieFile = /tmp/cookie.txt
+	EOF
+
+	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://good.example.com >actual &&
+	test_must_be_empty actual &&
+
+	echo true >expect &&
+	git config --bool --get-urlmatch http.SSLverify https://example.com >actual &&
+	test_cmp expect actual &&
+
+	echo true >expect &&
+	git config --bool --get-urlmatch http.SSLverify https://good-example.com >actual &&
+	test_cmp expect actual &&
+
+	echo true >expect &&
+	git config --bool --get-urlmatch http.sslverify https://deep.nested.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo false >expect &&
+	git config --bool --get-urlmatch http.sslverify https://good.example.com >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo http.cookiefile /tmp/cookie.txt &&
+		echo http.sslverify false
+	} >expect &&
+	git config --get-urlmatch HTTP https://good.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.sslverify >expect &&
+	git config --get-urlmatch HTTP https://more.example.com.au >actual &&
 	test_cmp expect actual
 '
 
diff --git a/urlmatch.c b/urlmatch.c
index f35d00a6e..bb5267732 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -63,6 +63,49 @@ static int append_normalized_escapes(struct strbuf *buf,
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
+static int match_host(const struct url_info *url_info,
+		      const struct url_info *pattern_info)
+{
+	const char *url = url_info->url + url_info->host_off;
+	const char *pat = pattern_info->url + pattern_info->host_off;
+	int url_len = url_info->host_len;
+	int pat_len = pattern_info->host_len;
+
+	while (url_len && pat_len) {
+		const char *url_next = end_of_token(url, '.', url_len);
+		const char *pat_next = end_of_token(pat, '.', pat_len);
+
+		if (pat_next == pat + 1 && pat[0] == '*')
+			/* wildcard matches anything */
+			;
+		else if ((pat_next - pat) == (url_next - url) &&
+			 !memcmp(url, pat, url_next - url))
+			/* the components are the same */
+			;
+		else
+			return 0; /* found an unmatch */
+
+		if (url_next < url + url_len)
+			url_next++;
+		url_len -= url_next - url;
+		url = url_next;
+		if (pat_next < pat + pat_len)
+			pat_next++;
+		pat_len -= pat_next - pat;
+		pat = pat_next;
+	}
+
+	return (!url_len && !pat_len);
+}
+
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
 {
 	/*
@@ -467,9 +510,7 @@ static int match_urls(const struct url_info *url,
 	}
 
 	/* check the host */
-	if (url_prefix->host_len != url->host_len ||
-	    strncmp(url->url + url->host_off,
-		    url_prefix->url + url_prefix->host_off, url->host_len))
+	if (!match_host(url, url_prefix))
 		return 0; /* host names do not match */
 
 	/* check the port */
@@ -528,7 +569,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 		struct url_info norm_info;
 
 		config_url = xmemdupz(key, dot - key);
-		norm_url = url_normalize(config_url, &norm_info);
+		norm_url = url_normalize_1(config_url, &norm_info, 1);
 		free(config_url);
 		if (!norm_url)
 			return 0;
-- 
2.11.0


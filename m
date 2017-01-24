Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F5020AC5
	for <e@80x24.org>; Tue, 24 Jan 2017 17:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbdAXRBC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 12:01:02 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:45521 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbdAXRBA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 12:01:00 -0500
Received: from localhost (x4e340422.dyn.telefonica.de [78.52.4.34])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 4752716C78E;
        Tue, 24 Jan 2017 18:00:58 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <patrick.steinhardt@elego.de>
Subject: [PATCH v2 4/4] urlmatch: allow globbing for the URL host part
Date:   Tue, 24 Jan 2017 18:00:31 +0100
Message-Id: <20170124170031.18069-5-patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170124170031.18069-1-patrick.steinhardt@elego.de>
References: <20170124170031.18069-1-patrick.steinhardt@elego.de>
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
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

This commit introduces the ability to use globbing in the host-part of
the URLs. A user can simply specify a `*` as part of the host name to
match all subdomains at this level. For example adding a configuration
key `http.https://*.example.com.proxy` will match all subdomains of
`https://example.com`.

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
---
 Documentation/config.txt |  5 ++++-
 t/t1300-repo-config.sh   | 36 ++++++++++++++++++++++++++++++++++++
 urlmatch.c               | 38 ++++++++++++++++++++++++++++++++++----
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 506431267..a78921c2b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1914,7 +1914,10 @@ http.<url>.*::
   must match exactly between the config key and the URL.
 
 . Host/domain name (e.g., `example.com` in `https://example.com/`).
-  This field must match exactly between the config key and the URL.
+  This field must match between the config key and the URL. It is
+  possible to use globs in the config key to match all subdomains, e.g.
+  `https://*.example.com/` to match all subdomains of `example.com`. Note
+  that a glob only every matches a single part of the hostname.
 
 . Port number (e.g., `8080` in `http://example.com:8080/`).
   This field must match exactly between the config key and the URL.
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 923bfc5a2..ec545e092 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1177,6 +1177,42 @@ test_expect_success 'urlmatch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'glob-based urlmatch' '
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
+	test_cmp expect actual
+'
+
 # good section hygiene
 test_expect_failure 'unsetting the last key in a section removes header' '
 	cat >.git/config <<-\EOF &&
diff --git a/urlmatch.c b/urlmatch.c
index e328905eb..53ff972a6 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -63,6 +63,38 @@ static int append_normalized_escapes(struct strbuf *buf,
 	return 1;
 }
 
+static int match_host(const struct url_info *url_info,
+		      const struct url_info *pattern_info)
+{
+	char *url = xmemdupz(url_info->url + url_info->host_off, url_info->host_len);
+	char *pat = xmemdupz(pattern_info->url + pattern_info->host_off, pattern_info->host_len);
+	char *url_tok, *pat_tok, *url_save, *pat_save;
+	int matching;
+
+	url_tok = strtok_r(url, ".", &url_save);
+	pat_tok = strtok_r(pat, ".", &pat_save);
+
+	for (; url_tok && pat_tok; url_tok = strtok_r(NULL, ".", &url_save),
+				   pat_tok = strtok_r(NULL, ".", &pat_save)) {
+		if (!strcmp(pat_tok, "*"))
+			continue; /* a simple glob matches everything */
+
+		if (strcmp(url_tok, pat_tok)) {
+			/* subdomains do not match */
+			matching = 0;
+			break;
+		}
+	}
+
+	/* matching if both URL and pattern are at their ends */
+	matching = (url_tok == NULL && pat_tok == NULL);
+
+	free(url);
+	free(pat);
+
+	return matching;
+}
+
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
 {
 	/*
@@ -467,9 +499,7 @@ static int match_urls(const struct url_info *url,
 	}
 
 	/* check the host */
-	if (url_prefix->host_len != url->host_len ||
-	    strncmp(url->url + url->host_off,
-		    url_prefix->url + url_prefix->host_off, url->host_len))
+	if (!match_host(url, url_prefix))
 		return 0; /* host names do not match */
 
 	/* check the port */
@@ -512,7 +542,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 		struct url_info norm_info;
 
 		config_url = xmemdupz(key, dot - key);
-		norm_url = url_normalize(config_url, &norm_info);
+		norm_url = url_normalize_1(config_url, &norm_info, 1);
 		free(config_url);
 		if (!norm_url)
 			return 0;
-- 
2.11.0


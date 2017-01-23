Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA30320A17
	for <e@80x24.org>; Mon, 23 Jan 2017 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdAWNM7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 08:12:59 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:40563 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbdAWNM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 08:12:57 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jan 2017 08:12:57 EST
Received: from localhost (x4e3406a1.dyn.telefonica.de [78.52.6.161])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 09D5016C880;
        Mon, 23 Jan 2017 14:06:54 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        Patrick Steinhardt <patrick.steinhardt@elego.de>
Subject: [PATCH v1 2/2] urlmatch: allow regex-based URL matching
Date:   Mon, 23 Jan 2017 14:06:35 +0100
Message-Id: <20170123130635.29577-3-patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
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

This commit introduces the ability to have regex-based URL matches. A
user can prefix a configuration key's URL with a question mark ('?') to
use regular expressions instead of exact matches in order to find all
matching URLs. A user can now simply add a key
`http.?http://.*\\.example\\.com.proxy` to set a proxy for all
subdomains of `example.com`. When no question mark is given as a prefix,
then the configuration subsystem will use the old algorithm based on
exact matches.

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
---
 Documentation/config.txt |  6 ++++-
 t/t1300-repo-config.sh   | 31 ++++++++++++++++++++++++++
 urlmatch.c               | 57 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 506431267..23651b19e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1906,7 +1906,11 @@ http.followRedirects::
 
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some URLs.
-	For a config key to match a URL, each element of the config key is
+	There are two different modes to match URLs: if the config key's URL is
+	prefixed with a `?`, it allows to make use of regular expressions. An
+	example for this is `http.?http://.*\\.example\\.com.*` to match all
+	subdomains of `example.com`.
+	If the key is not prefixed with a `?`, each element of the config key is
 	compared to that of the URL, in the following order:
 +
 --
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 923bfc5a2..fbbc58304 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1177,6 +1177,37 @@ test_expect_success 'urlmatch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'regex-based urlmatch' '
+	cat >.git/config <<-\EOF &&
+	[http]
+		sslVerify
+	[http "?https://.*\\.example\\.com"]
+		sslVerify = false
+		cookieFile = /tmp/cookie.txt
+	EOF
+
+	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://good.example.com >actual &&
+	test_must_be_empty actual &&
+
+	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://good-example.com >actual &&
+	test_must_be_empty actual &&
+
+	echo true >expect &&
+	git config --bool --get-urlmatch http.SSLverify https://example.com >actual &&
+	test_cmp expect actual &&
+
+	echo false >expect &&
+	git config --bool --get-urlmatch http.sslverify https://subdomain.example.com >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo http.cookiefile /tmp/cookie.txt &&
+		echo http.sslverify false
+	} >expect &&
+	git config --get-urlmatch HTTP https://subdomain.example.com >actual &&
+	test_cmp expect actual
+'
+
 # good section hygiene
 test_expect_failure 'unsetting the last key in a section removes header' '
 	cat >.git/config <<-\EOF &&
diff --git a/urlmatch.c b/urlmatch.c
index 132d342bc..8ed5047e3 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -490,18 +490,51 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	}
 	dot = strrchr(key, '.');
 	if (dot) {
-		char *config_url, *norm_url;
-		struct url_info norm_info;
-
-		config_url = xmemdupz(key, dot - key);
-		norm_url = url_normalize(config_url, &norm_info);
-		free(config_url);
-		if (!norm_url)
-			return 0;
-		matched_len = match_urls(url, &norm_info, &user_matched);
-		free(norm_url);
-		if (!matched_len)
-			return 0;
+		/*
+		 * When the configuration key's URL is prefixed
+		 * with a '?', regular expressions are enabled to
+		 * match the URL instead of the exact-match
+		 * algorithm.
+		 */
+		if (starts_with(key, "?")) {
+			char *config_url;
+			regex_t reg;
+			int status;
+
+			config_url = xmemdupz(key + 1, dot - key - 1);
+			if (regcomp(&reg, config_url, REG_EXTENDED)) {
+				warning(_("Cannot prepare URL regexp %s"),
+					config_url);
+				free(config_url);
+				return 0;
+			}
+
+			status = regexec(&reg, url->url, 0, NULL, 0);
+			free(config_url);
+			regfree(&reg);
+
+			if (status) {
+				 if (status != REG_NOMATCH)
+					warning(_("regexec returned %d for input '%s'"),
+						status, url->url);
+
+				return 0;
+			}
+		} else {
+			char *config_url, *norm_url;
+			struct url_info norm_info;
+
+			config_url = xmemdupz(key, dot - key);
+			norm_url = url_normalize(config_url, &norm_info);
+			free(config_url);
+			if (!norm_url)
+				return 0;
+			matched_len = match_urls(url, &norm_info, &user_matched);
+			free(norm_url);
+			if (!matched_len)
+				return 0;
+		}
+
 		key = dot + 1;
 	}
 
-- 
2.11.0


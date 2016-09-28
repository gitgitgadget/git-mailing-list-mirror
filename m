Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D3E1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 18:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbcI1SBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 14:01:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbcI1SBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 14:01:47 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3E96C0921A5
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 18:01:46 +0000 (UTC)
Received: from pirat-work.brq.redhat.com (unused-4-182.brq.redhat.com [10.34.4.182])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8SI1j2v028741;
        Wed, 28 Sep 2016 14:01:45 -0400
From:   Petr Stodulka <pstodulk@redhat.com>
To:     git@vger.kernel.org
Cc:     pstodulk@redhat.com
Subject: [PATCH v2] http: Control GSSAPI credential delegation.
Date:   Wed, 28 Sep 2016 20:01:34 +0200
Message-Id: <1475085694-10056-1-git-send-email-pstodulk@redhat.com>
In-Reply-To: <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
References: <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 28 Sep 2016 18:01:46 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Delegation of credentials is disabled by default in libcurl since
version 7.21.7 due to security vulnerability CVE-2011-2192. Which
makes troubles with GSS/kerberos authentication when delegation
of credentials is required. This can be changed with option
CURLOPT_GSSAPI_DELEGATION in libcurl with set expected parameter
since libcurl version 7.22.0.

This patch provides new configuration variable http.delegation
which corresponds to curl parameter "--delegation" (see man 1 curl).

The following values are supported:

* none (default).
* policy
* always

Signed-off-by: Petr Stodulka <pstodulk@redhat.com>
---
 Documentation/config.txt | 14 ++++++++++++++
 http.c                   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e78293b..a179474 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1736,6 +1736,20 @@ http.emptyAuth::
 	a username in the URL, as libcurl normally requires a username for
 	authentication.
 
+http.delegation::
+	Control GSSAPI credential delegation. The delegation is disabled
+	by default in libcurl since version 7.21.7. Set parameter to tell
+	the server what it is allowed to delegate when it comes to user
+	credentials. Used with GSS/kerberos. Possible values are:
++
+--
+* `none` - Don't allow any delegation.
+* `policy` - Delegates if and only if the OK-AS-DELEGATE flag is set in the
+  Kerberos service ticket, which is a matter of realm policy.
+* `always` - Unconditionally allow the server to delegate.
+--
+
+
 http.extraHeader::
 	Pass an additional HTTP header when communicating with a server.  If
 	more than one such entry exists, all of them are added as extra
diff --git a/http.c b/http.c
index 82ed542..0c65639 100644
--- a/http.c
+++ b/http.c
@@ -90,6 +90,18 @@ static struct {
 	 * here, too
 	 */
 };
+#if LIBCURL_VERSION_NUM >= 0x071600
+static const char *curl_deleg;
+static struct {
+	const char *name;
+	long curl_deleg_param;
+} curl_deleg_levels[] = {
+	{ "none", CURLGSSAPI_DELEGATION_NONE },
+	{ "policy", CURLGSSAPI_DELEGATION_POLICY_FLAG },
+	{ "always", CURLGSSAPI_DELEGATION_FLAG },
+};
+#endif
+
 static struct credential proxy_auth = CREDENTIAL_INIT;
 static const char *curl_proxyuserpwd;
 static const char *curl_cookie_file;
@@ -323,6 +335,15 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.delegation", var)) {
+#if LIBCURL_VERSION_NUM >= 0x071600
+		return git_config_string(&curl_deleg, var, value);
+#else
+		warning(_("Delegation control is not supported with cURL < 7.22.0"));
+		return 0;
+#endif
+	}
+
 	if (!strcmp("http.pinnedpubkey", var)) {
 #if LIBCURL_VERSION_NUM >= 0x072c00
 		return git_config_pathname(&ssl_pinnedkey, var, value);
@@ -629,6 +650,22 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
+#if LIBCURL_VERSION_NUM >= 0x071600
+	if (curl_deleg) {
+		int i;
+		for (i = 0; i < ARRAY_SIZE(curl_deleg_levels); i++) {
+			if (!strcmp(curl_deleg, curl_deleg_levels[i].name)) {
+				curl_easy_setopt(result, CURLOPT_GSSAPI_DELEGATION,
+						curl_deleg_levels[i].curl_deleg_param);
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(curl_deleg_levels))
+			warning("Unknown delegation method '%s': using default",
+				curl_deleg);
+	}
+#endif
+
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
-- 
2.5.5


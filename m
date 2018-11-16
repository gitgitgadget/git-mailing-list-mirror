Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B0E1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbeKPTBP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 14:01:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727567AbeKPTBO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 14:01:14 -0500
Received: (qmail 29248 invoked by uid 109); 16 Nov 2018 08:49:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Nov 2018 08:49:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25222 invoked by uid 111); 16 Nov 2018 08:49:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Nov 2018 03:49:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2018 03:49:51 -0500
Date:   Fri, 16 Nov 2018 03:49:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] remote-curl: die on server-side errors
Message-ID: <20181116084951.GC31603@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116084427.GA31493@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

When a smart HTTP server sends an error message via pkt-line,
remote-curl will fail to detect the error (which usually results in
incorrectly falling back to dumb-HTTP mode).

This patch adds a check in check_smart_http() for server-side error
messages, as well as a test case for this issue.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c                   | 3 +++
 t/lib-httpd.sh                  | 1 +
 t/lib-httpd/apache.conf         | 4 ++++
 t/lib-httpd/error-smart-http.sh | 3 +++
 t/t5551-http-fetch-smart.sh     | 5 +++++
 5 files changed, 16 insertions(+)
 create mode 100644 t/lib-httpd/error-smart-http.sh

diff --git a/remote-curl.c b/remote-curl.c
index 3c9c4a07c3..b1309f2bdc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -382,6 +382,9 @@ static void check_smart_http(struct discovery *d, const char *service,
 		 */
 		d->proto_git = 1;
 
+	} else if (skip_prefix(line, "ERR ", &p)) {
+		die(_("remote error: %s"), p);
+
 	} else {
 		die("invalid server response; got '%s'", line);
 	}
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a8729f8232..4e946623bb 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -131,6 +131,7 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
+	install_script error-smart-http.sh
 	install_script error.sh
 	install_script apply-one-time-sed.sh
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 581c010d8f..6de2bc775c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -117,6 +117,7 @@ Alias /auth/dumb/ www/auth/dumb/
 </LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
+ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
 ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
 <Directory ${GIT_EXEC_PATH}>
@@ -125,6 +126,9 @@ ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
 <Files broken-smart-http.sh>
 	Options ExecCGI
 </Files>
+<Files error-smart-http.sh>
+	Options ExecCGI
+</Files>
 <Files error.sh>
   Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/error-smart-http.sh b/t/lib-httpd/error-smart-http.sh
new file mode 100644
index 0000000000..e65d447fc4
--- /dev/null
+++ b/t/lib-httpd/error-smart-http.sh
@@ -0,0 +1,3 @@
+echo "Content-Type: application/x-git-upload-pack-advertisement"
+echo
+printf "%s" "0019ERR server-side error"
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 8630b0cc39..ba83e567e5 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -429,5 +429,10 @@ test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
 	! grep "=> Send data" err
 '
 
+test_expect_success 'server-side error detected' '
+	test_must_fail git clone $HTTPD_URL/error_smart/repo.git 2>actual &&
+	grep "server-side error" actual
+'
+
 stop_httpd
 test_done
-- 
2.19.1.1636.gc7a073d580

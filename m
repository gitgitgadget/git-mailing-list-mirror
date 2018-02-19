Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CA71F404
	for <e@80x24.org>; Mon, 19 Feb 2018 19:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeBSTuR (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 14:50:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:57168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753574AbeBSTuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 14:50:16 -0500
Received: (qmail 32703 invoked by uid 109); 19 Feb 2018 19:50:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Feb 2018 19:50:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6467 invoked by uid 111); 19 Feb 2018 19:51:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Feb 2018 14:51:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Feb 2018 14:50:14 -0500
Date:   Mon, 19 Feb 2018 14:50:14 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jon Simons <jon@jonsimons.org>
Subject: [PATCH 2/2] remote-curl: unquote incoming push-options
Message-ID: <20180219195014.GB988@sigill.intra.peff.net>
References: <20180219194709.GA837@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180219194709.GA837@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transport-helper protocol c-style quotes the value of
any options passed to the helper via the "option <key> <value>"
directive. However, remote-curl doesn't actually unquote the
push-option values, meaning that we will send the quoted
version to the other side (whereas git-over-ssh would send
the raw value).

The pack-protocol.txt documentation defines the push-options
as a series of VCHARs, which excludes most characters that
would need quoting. But:

  1. You can still see the bug with a valid push-option that
     starts with a double-quote (since that triggers
     quoting).

  2. We do currently handle any non-NUL characters correctly
     in git-over-ssh. So even though the spec does not say
     that we need to handle most quoted characters, it's
     nice if our behavior is consistent between protocols.

There are two new tests: the "direct" one shows that this
already works in the non-http case, and the http one covers
this bugfix.

Reported-by: Jon Simons <jon@jonsimons.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c           | 11 ++++++++++-
 t/t5545-push-options.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6ec5352435..f5b3d22e26 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -13,6 +13,7 @@
 #include "credential.h"
 #include "sha1-array.h"
 #include "send-pack.h"
+#include "quote.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -145,7 +146,15 @@ static int set_option(const char *name, const char *value)
 			return -1;
 		return 0;
 	} else if (!strcmp(name, "push-option")) {
-		string_list_append(&options.push_options, value);
+		if (*value != '"')
+			string_list_append(&options.push_options, value);
+		else {
+			struct strbuf unquoted = STRBUF_INIT;
+			if (unquote_c_style(&unquoted, value, NULL) < 0)
+				die("invalid quoting in push-option value");
+			string_list_append_nodup(&options.push_options,
+						 strbuf_detach(&unquoted, NULL));
+		}
 		return 0;
 
 #if LIBCURL_VERSION_NUM >= 0x070a08
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index c64dee2127..b47a95871c 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -217,6 +217,15 @@ test_expect_success 'invalid push option in config' '
 	test_refs master HEAD@{1}
 '
 
+test_expect_success 'push options keep quoted characters intact (direct)' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	test_commit -C workbench one &&
+	git -C workbench push --push-option="\"embedded quotes\"" up master &&
+	echo "\"embedded quotes\"" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
@@ -260,6 +269,15 @@ test_expect_success 'push options work properly across http' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push options keep quoted characters intact (http)' '
+	mk_http_pair true &&
+
+	test_commit -C test_http_clone one &&
+	git -C test_http_clone push --push-option="\"embedded quotes\"" origin master &&
+	echo "\"embedded quotes\"" >expect &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options
+'
+
 stop_httpd
 
 test_done
-- 
2.16.2.552.gea2a3cf654

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9360F1F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 03:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdB1DZY (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 22:25:24 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33064 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdB1DZW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 22:25:22 -0500
Received: by mail-pf0-f170.google.com with SMTP id o64so22964pfb.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 19:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tSyU0w/lA6wAZxEY/D7hHPFWg9/DDgnnVRMKgyFSjb8=;
        b=ZLwYrKUqqc+5OKW48X8GAgiiUtm5M9+NUFc5JQxsPBucw9jsHCUv0/CBWXaG+AsAIh
         wck/PwXteebFDATKh1wg9gJSc2/oHttSpD44g5jcTUsQiJxXZbCtB3/HbqsM0jCn+sG6
         qnaeD2t+7wcjERtumq1k11y9BdTYIceeTR9Aa+itK/EwvJZFCsK4Sg3msdf6qin5F8LZ
         k+Huq2FAb0FMIIrMbsNHJmIN+UQaRY7/68bGrV0WaNxUQIf38r1gCne4MhVetxEcSGSM
         3HIb1GAMGEJfZa+/TQ//YgwVCjtpFcGeK9AhRBZ1KvKW7wuZVBDkWSAbPHc8VGpCKhSD
         Vu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tSyU0w/lA6wAZxEY/D7hHPFWg9/DDgnnVRMKgyFSjb8=;
        b=HuzEGx2+dNZPmOfNNzHeo/SataKhk9bm7xf8XNlU/U6MWGmLGJFtnCQFDaGTdzl9q5
         uIJrogCArsa2Faramwiu4bUVnxjgFzVwZ4VdcPZj8nW7SypCz9kaQLE87UC0pQzYGe0e
         nDFufvAFO2DT72DU2hYjaYDwGFeyuB4fy9QAjQDnJHC1atIhfgmDOg1/FYEawbbkY7aY
         HRGKnvIR8eJx7tSD6ENcRz5DrD5S8GqUu42l71XSr4rOPQWMdFy8hyIFTWz7ZTi9JMJm
         ZH57e5zzNIwb/7ik6YVsKA5WAINz4xU49xoOW8vrzvYHm9TfLLk6r5uQKUJtV/HI++BO
         vPsg==
X-Gm-Message-State: AMke39mDzmyJOVE5LsQkVWMWxIfTxI1vs7e4r8Q4+0wN+FnfLqbYp9uBJrtmuq3sXH6Sw99b
X-Received: by 10.84.205.70 with SMTP id o6mr5526plh.176.1488250394712;
        Mon, 27 Feb 2017 18:53:14 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id m21sm363862pgh.4.2017.02.27.18.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 18:53:13 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Subject: [PATCH] http: attempt updating base URL only if no error
Date:   Mon, 27 Feb 2017 18:53:11 -0800
Message-Id: <20170228025311.6347-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

http.c supports HTTP redirects of the form

  http://foo/info/refs?service=git-upload-pack
  -> http://anything
  -> http://bar/info/refs?service=git-upload-pack

(that is to say, as long as the Git part of the path and the query
string is preserved in the final redirect destination, the intermediate
steps can have any URL). However, if one of the intermediate steps
results in an HTTP exception, a confusing "unable to update url base
from redirection" message is printed instead of a Curl error message
with the HTTP exception code.

This was introduced by 2 commits. Commit c93c92f ("http: update base
URLs when we see redirects", 2013-09-28) introduced a best-effort
optimization that required checking if only the "base" part of the URL
differed between the initial request and the final redirect destination,
but it performed the check before any HTTP status checking was done. If
something went wrong, the normal code path was still followed, so this
did not cause any confusing error messages until commit 6628eb4 ("http:
always update the base URL for redirects", 2016-12-06), which taught
http to die if the non-"base" part of the URL differed.

Therefore, teach http to check the HTTP status before attempting to
check if only the "base" part of the URL differed. This commit teaches
http_request_reauth to return early without updating options->base_url
upon an error; the only invoker of this function that passes a non-NULL
"options" is remote-curl.c (through "http_get_strbuf"), which only uses
options->base_url for an informational message in the situations that
this commit cares about (that is, when the return value is not HTTP_OK).

The included test checks that the redirect scheme at the beginning of
this commit message works, and that returning a 502 in the middle of the
redirect scheme produces the correct result. Note that this is different
from the test in commit 6628eb4 ("http: always update the base URL for
redirects", 2016-12-06) in that this commit tests that a Git-shaped URL
(http://.../info/refs?service=git-upload-pack) works, whereas commit
6628eb4 tests that a non-Git-shaped URL
(http://.../info/refs/foo?service=git-upload-pack) does not work (even
though Git is processing that URL) and is an error that is fatal, not
silently swallowed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http.c                     | 3 +++
 t/lib-httpd/apache.conf    | 9 +++++++++
 t/t5550-http-fetch-dumb.sh | 9 +++++++++
 3 files changed, 21 insertions(+)

diff --git a/http.c b/http.c
index 90a1c0f11..1df186894 100644
--- a/http.c
+++ b/http.c
@@ -1727,6 +1727,9 @@ static int http_request_reauth(const char *url,
 {
 	int ret = http_request(url, result, target, options);
 
+	if (ret != HTTP_OK && ret != HTTP_REAUTH)
+		return ret;
+
 	if (options && options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 69174c6e3..0642ae7e6 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -133,6 +133,15 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
 RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
 RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
 
+# redir-to/502/x?y -> really-redir-to?path=502/x&qs=y which returns 502
+# redir-to/x?y -> really-redir-to?path=x&qs=y -> x?y
+RewriteCond %{QUERY_STRING} ^(.*)$
+RewriteRule ^/redir-to/(.*)$ /really-redir-to?path=$1&qs=%1 [R=302]
+RewriteCond %{QUERY_STRING} ^path=502/(.*)&qs=(.*)$
+RewriteRule ^/really-redir-to$ - [R=502,L]
+RewriteCond %{QUERY_STRING} ^path=(.*)&qs=(.*)$
+RewriteRule ^/really-redir-to$ /%1?%2 [R=302]
+
 # The first rule issues a client-side redirect to something
 # that _doesn't_ look like a git repo. The second rule is a
 # server-side rewrite, so that it turns out the odd-looking
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index aeb3a63f7..2d3b1e9f9 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -378,5 +378,14 @@ test_expect_success 'http-alternates triggers not-from-user protocol check' '
 		clone $HTTPD_URL/dumb/evil.git evil-user
 '
 
+test_expect_success 'can redirect through non-"info/refs?service=git-upload-pack" URL' '
+	git clone "$HTTPD_URL/redir-to/dumb/repo.git"
+'
+
+test_expect_success 'print HTTP error when any intermediate redirect throws error' '
+	test_must_fail git clone "$HTTPD_URL/redir-to/502" 2> stderr &&
+	test_i18ngrep "unable to access.*/redir-to/502" stderr
+'
+
 stop_httpd
 test_done
-- 
2.11.0.483.g087da7b7c-goog


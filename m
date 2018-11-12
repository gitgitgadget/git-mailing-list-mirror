Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925681F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeKMIkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:40:13 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47502 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeKMIkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:40:12 -0500
Received: by mail-qk1-f202.google.com with SMTP id z68so2482629qkb.14
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=tPfqhBsUdELVXlNSVoOUsVz8+/7VSl8yDeBguBBWP3A=;
        b=djFFwA3MgNuqf653Tsc+6o2yv0gwep3O2+ukiTq3YzsvMFI+D4/j5zHlNjkaDloUKB
         cnBYjRdBXmgYdJRvaByisvat35tRcLY/iXKgH8kAuia+jahCUTfy6O59HMsjGwl67i/J
         GatBPeUlBKudX6wvBkho/INLKcEkVhg83RZZvbEiMS7BaZRC4yNA7rnunoR5gpnmlo/H
         Ktvd8AVW7TiLyXROJbe4sLLfb5IurdNcF9S9sxwuIzSuAq8RSSP1N/B9XvZa7nMy7RHW
         2G5/QnD19qfPy/xIaUp1ph+Jg6+eK/+2cF58HH8Bky6e49B/15P8QkigL7dp0lf6kZ4m
         AJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=tPfqhBsUdELVXlNSVoOUsVz8+/7VSl8yDeBguBBWP3A=;
        b=CHjWhcmZStNNaP8D9lq6dzNZm/qowyD1toxcaV4FdfPkY/CouwIdFE1IV0HWjWH7p6
         KNHAqZqTcpD64YNXUCVp1NAlcc6/D23KtBCr5P64ePj5Sw/7qEz4GCuLHGiWZCfKXyoc
         PbrMPRsZtGIaTM6Xnl0G2UjmKw5gflM0FGKVoEWIiykLwnqeCSWtEIDcuYCwyA5Z4T2E
         BxKh98YB97DZnESFeTKUpl4QZMG2fr3B4Lt5fW6oA5VWh3JncDK30o+yBg0/EEUleLPZ
         29L+O2hgLwFs5as7xAlwfU7Q3gM7Cwam40kUCvlZfc9npRof3htzitTLfJKNlBC8ZfcR
         ajuQ==
X-Gm-Message-State: AGRZ1gL2kXoxyCR/KBgM7npPZOp9r08HmBlp/kraa3aJF4wrVebK8wdy
        087xBqbNrk+XIOz054lCcBXhk5DibBMNjhaAYwm4Jsy7ol2NJrHtFYhocIu3MFGBF3A0oykWRy8
        7erNB3IqGzVnHCTdrgjx6+YmnTSsMuVfGnf33++zKIAyD1VeYVLEC4uuuORI1amE=
X-Google-Smtp-Source: AJdET5fziDBjyOVa7dRVQRKwpTGzb3ftWjSOAWOrG32HHSrY42GyMzJtmAnyTbuKvJvjpmuoZ/EBrBTVVODp8A==
X-Received: by 2002:ac8:2a78:: with SMTP id l53mr1871859qtl.44.1542062699337;
 Mon, 12 Nov 2018 14:44:59 -0800 (PST)
Date:   Mon, 12 Nov 2018 14:44:56 -0800
Message-Id: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH] remote-curl: die on server-side errors
From:   steadmon@google.com
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a smart HTTP server sends an error message via pkt-line,
remote-curl will fail to detect the error (which usually results in
incorrectly falling back to dumb-HTTP mode).

This patch adds a check in discover_refs() for server-side error
messages, as well as a test case for this issue.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 remote-curl.c                   | 4 +++-
 t/lib-httpd.sh                  | 1 +
 t/lib-httpd/apache.conf         | 4 ++++
 t/lib-httpd/error-smart-http.sh | 3 +++
 t/t5551-http-fetch-smart.sh     | 5 +++++
 5 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-httpd/error-smart-http.sh

diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..bb3a86505e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -436,7 +436,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	} else if (maybe_smart &&
 		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
 		last->proto_git = 1;
-	}
+	} else if (maybe_smart && last->len > 5 &&
+		   starts_with(last->buf + 4, "ERR "))
+		die(_("remote error: %s"), last->buf + 8);
 
 	if (last->proto_git)
 		last->refs = parse_git_refs(last, for_push);
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
index 0000000000..0a1af318f7
--- /dev/null
+++ b/t/lib-httpd/error-smart-http.sh
@@ -0,0 +1,3 @@
+printf "Content-Type: text/%s\n" "html"
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
2.19.1.930.g4563a0d9d0-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F3F20970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdDKRSF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:18:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33098 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbdDKRSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:18:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id r36so395339lfi.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLb89yFiFnHX7zuxX1/KOdUikBfBvPxrseZ9Nu7GSDA=;
        b=Cy3+MpvLnTJtzungJ0zGDtCgaHmcUfZ4yk4Sh5n+z5c1fUBs2OCHmGIfisAQCXKx9e
         RDfZJIe4e6hfTAQhH9wyVjtfW91TZNUGFjv3tjtSq6MDjdcF1ZAbukkkpouIYwWeTBCR
         zFUhXcjbbSBSiV1tuY7zYIs5z2X1IR5wjsujt0Rbi9MLHQ3DdVJVx/rttRyOctOtOt9q
         XTXhoCGnrZTsbKCPqzxLdFLZMYUtKY7yqtcxNjzxgXm1a1udTlciCcNN8LVogueYBukW
         Y2B7mPvm4YV+F7B8nvoWhyeowyaPL+iY3UCAc5SgQRaARYBLYep8+fxKkCIk0xHF2MX6
         wxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLb89yFiFnHX7zuxX1/KOdUikBfBvPxrseZ9Nu7GSDA=;
        b=BciybIgJodoA1GdWDk9LxQYd71+MtEVT1h4wYwUSzsH0K9NfQR9V5GG1NdXaWuaFBn
         +Ht0yLR1Hjhw91gQ86jWjTiomvbtB8u7mpPOsm5yrhfW1Epw8mikQQM9a+ck96bQ/Ar4
         7+Ymj53Z46Xaqusd10yihlq4NjnQfzqfUfrQS9vy/VSJ9BR33x+FLNJgoiR0BbAZWBqw
         EVE2sJ3GrgBoczm/qW/KlMLjJwjs/fdPNi0DHZpsvv9RpRg+G6Bkx7ZHfuDucDwz1oSm
         vWCIqFGLYVcN0ijmP1xYtlaLXNd0C+oTlMlKOekF8J7qZvYXBTDeyhulX3LGJR9/c4l9
         ajjA==
X-Gm-Message-State: AN3rC/4KIiIQUQLhWn12IBDKaNkUDL1Uej/Dbga1UtbF29f1jg0r7+1OZpyQkPHVm0i/+w==
X-Received: by 10.25.141.134 with SMTP id p128mr4159394lfd.60.1491931079923;
        Tue, 11 Apr 2017 10:17:59 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id l70sm1009083lfl.69.2017.04.11.10.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:17:59 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>
Subject: [PATCH v3 2/2] http: fix the silent ignoring of proxy misconfiguraion
Date:   Tue, 11 Apr 2017 20:17:50 +0300
Message-Id: <20170411171750.18624-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170411171750.18624-1-ryazanov.s.a@gmail.com>
References: <20170411171750.18624-1-ryazanov.s.a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, the whole http.proxy option string was passed to curl without
any preprocessing so curl could complain about the invalid proxy
configuration.

After the commit 372370f167 ("http: use credential API to handle proxy
authentication", 2016-01-26), if the user specified an invalid HTTP
proxy option in the configuration, then the option parsing is silently
fails and NULL will be passed to curl as a proxy. This forces curl to
fall back to detecting the proxy configuration from the environment,
causing the http.proxy option ignoring.

Fix this issue by checking the proxy option parsing result. If parsing
failed then print error message and die. Such behaviour allows user to
quickly figure the proxy misconfiguration and correct it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v2:
  - new patch

 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http.c b/http.c
index 8be75b2..82664dd 100644
--- a/http.c
+++ b/http.c
@@ -867,6 +867,9 @@ static CURL *get_curl_handle(void)
 			strbuf_release(&url);
 		}
 
+		if (!proxy_auth.host)
+			die("Invalid proxy URL '%s'", curl_http_proxy);
+
 		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
 #if LIBCURL_VERSION_NUM >= 0x071304
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
-- 
2.10.2


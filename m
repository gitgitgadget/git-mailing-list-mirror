Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8C71FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935041AbcLNWkT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:40:19 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36063 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbcLNWkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:40:17 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so5463617pfz.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nGlBAShV91lmPQAFzoz8YcPqcdSsEj8Z/0zjMEAm54I=;
        b=EbO9Sifa9QRknVCPOQo5BJnezJCF5hMcfAxMM1/fnyLDlG/XQ0nGGVgqMVFVT4UUgm
         5cNsLHOceoTlwLcI1cToD3s786YnKtgWFwoxmI/68b5LguWx//1Q5ItIqS0T/3wOmiLJ
         JTvZwQ85FPU+8CHRJaLHAWiTz/HvAVzQdwWang4O/zWsnrtvmtW5rwQhfE7Bv1qVwysS
         bavzN7Ze383AEp/sZLnmbANsuua+Z6PZYoRNw37/hWmvL3RineH4IIAgO0axsty5yVS7
         lsNW5AnnpFU385ymAtw/k5M8/yPf3m3zrEVUt6OIsMZEqBGontwg/NRlr+YEBKIXE9t1
         wJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nGlBAShV91lmPQAFzoz8YcPqcdSsEj8Z/0zjMEAm54I=;
        b=aWWu+uCaZubSy1sNR7F4ZoxUavExccdlQGFmxzcqscTfYSjGTlcl388rWtjnGwXF3D
         1FHGUEQHKkU0TsobZYQy+Iyqz+GoiCahOCMZ1RMIRVHN8/CzAfbgCbbCE8iM1bxhZCQW
         9sJhDLp/3aWHoiKKwF1wp7hAfvWzMQynmfNtiAj1YvugiN981VONXMcopqRGozh9DMVw
         wE36sYIR1fGEIN5f0Ibepq50H5LmvgfBZAhqcY7VpF92nI82EnQEOlOJ7lK38g1mraeX
         W9orXlZwrHRsa1tPQfar6lCq/AIJcZFkrqcp0cuVzuSJZqFviGhFPPUjkf3aX7dB/xxA
         l1Kg==
X-Gm-Message-State: AKaTC01IWn3pzhe+cnxUlDJ4bkg0dxMkogcxySKhNf7Gh59x1uPAJds77lIObSD/fWBLnZA7
X-Received: by 10.99.116.25 with SMTP id p25mr189547610pgc.161.1481755216867;
        Wed, 14 Dec 2016 14:40:16 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 72sm89600973pfw.37.2016.12.14.14.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:40:15 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: [PATCH v10 2/6] http: always warn if libcurl version is too old
Date:   Wed, 14 Dec 2016 14:39:51 -0800
Message-Id: <1481755195-174539-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481755195-174539-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Always warn if libcurl version is too old because:

1. Even without a protocol whitelist, newer versions of curl have all
   non-http protocols disabled by default.
2. A future patch will introduce default "known-good" and "known-bad"
   protocols which are allowed/disallowed by 'is_transport_allowed'
   which older version of libcurl can't respect.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c      | 5 ++---
 transport.c | 5 -----
 transport.h | 6 ------
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/http.c b/http.c
index 5cd3ffd..034426e 100644
--- a/http.c
+++ b/http.c
@@ -583,9 +583,8 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS, allowed_protocols);
 #else
-	if (transport_restrict_protocols())
-		warning("protocol restrictions not applied to curl redirects because\n"
-			"your curl version is too old (>= 7.19.4)");
+	warning("protocol restrictions not applied to curl redirects because\n"
+		"your curl version is too old (>= 7.19.4)");
 #endif
 
 	if (getenv("GIT_CURL_VERBOSE"))
diff --git a/transport.c b/transport.c
index 41eb82c..dff929e 100644
--- a/transport.c
+++ b/transport.c
@@ -629,11 +629,6 @@ void transport_check_allowed(const char *type)
 		die("transport '%s' not allowed", type);
 }
 
-int transport_restrict_protocols(void)
-{
-	return !!protocol_whitelist();
-}
-
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	const char *helper;
diff --git a/transport.h b/transport.h
index c681408..3396e1d 100644
--- a/transport.h
+++ b/transport.h
@@ -153,12 +153,6 @@ int is_transport_allowed(const char *type);
  */
 void transport_check_allowed(const char *type);
 
-/*
- * Returns true if the user has attempted to turn on protocol
- * restrictions at all.
- */
-int transport_restrict_protocols(void);
-
 /* Transport options which apply to git:// and scp-style URLs */
 
 /* The program to use on the remote side to send a pack */
-- 
2.8.0.rc3.226.g39d4020


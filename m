Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4D920451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754669AbcLNBuf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:50:35 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36737 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754628AbcLNBuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:50:32 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so2053094pgc.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 17:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dKv+LQVgZnofa5RbqfeoCBNMEMbc6VYW2CiWoG+yDw=;
        b=TBocPAdLYZMERY+1QzbiJRWPkLdjPu5MizH4BKIM7VFHwmtWUipIZVGuas3U1V0P4Z
         +YakspGqyvUxe2MksSpNHWerNOtvxom1ExumFPnjwb0wfaWhGoCAYL4egC2982RTavbh
         2I15f9HpbcwDGr3sK3mw3qozH2XxrDenjJ3R8OF1KMw4i/USml2HFK3HrZGM638/HD50
         CG7+zfI1op204g9hOrNsGwm7iIENQ5Z7gQ8IfIVRPrfIVWebZyZtz1GnHLyZNlskbJAO
         dbdMPv1taZdQbAkRAU9+ASaRiReZ9jgEyXWX+BNOgnh2J4Ga4TSW/iKdI9rEQrwHERtn
         XgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dKv+LQVgZnofa5RbqfeoCBNMEMbc6VYW2CiWoG+yDw=;
        b=RgoT2sLuSpcb5PqceKF6pYZkT0Km5YcFcPekqY8uH8awgBA6/n3OC8Jh5KL9j0XFZQ
         jeFYopASs0e2nTyRVopR2OEhtKFoJSZMAjRJne0z4THLQLJl5owmQar345dtNj0EY32M
         LjI5qnc0puInaVRV1nyQy6je+CD2iVHuTFoa7H/4TY7qc7aQjaV+4bpB2E+GXMl858A3
         iM1rEQ8WlQnMvBWYvj+4m3RbdTFcWRqFolUw+5wdvr1O7bLeYGWIjfbEqZh99a20gdDu
         +655rmvyGW7lKt+JKWCj490RlKkrEBromU6fjC1PpvNfwQ93X2EqRMWqzBw8uA9MsH6c
         KeDg==
X-Gm-Message-State: AKaTC03DOJQWI7d70anU7nNbDhLts/EvPSVNCnw7/f/REy7RNem4BjYgKxbjGmHydSUUFDQX
X-Received: by 10.98.166.136 with SMTP id r8mr105142482pfl.113.1481679703801;
        Tue, 13 Dec 2016 17:41:43 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id b12sm82462599pfb.78.2016.12.13.17.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 17:41:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCH v9 3/5] http: always warn if libcurl version is too old
Date:   Tue, 13 Dec 2016 17:40:35 -0800
Message-Id: <1481679637-133137-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481679637-133137-1-git-send-email-bmwill@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that there are default "known-good" and "known-bad" protocols which
are allowed/disallowed by 'is_transport_allowed' we should always warn
the user that older versions of libcurl can't respect the allowed
protocols for redirects.

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
index e1ba78b..fbd799d 100644
--- a/transport.c
+++ b/transport.c
@@ -700,11 +700,6 @@ void transport_check_allowed(const char *type)
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


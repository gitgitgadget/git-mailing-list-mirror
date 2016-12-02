Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017961FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbcLBABX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:01:23 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33904 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753026AbcLBABU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:01:20 -0500
Received: by mail-pf0-f176.google.com with SMTP id c4so48758756pfb.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZbyDA7bAxdhh7h2FYpg0CW89ZilRxG0LnNJPk1YcYXs=;
        b=gtgcEqaftzsuVvhfqRWTxh8xGFNp7gywuHdObLTMTyxDvqrqeONondLkHAlqWVXDQn
         4eLfaca+Wm9kDUwfW1jOaAE9aaYwfl0ON8txzmgh4a+coiOQAIDTca5sQYYxWxKtBFXR
         wJNIScuXGnjHQOvL2ptQt2T80Ike6Rr2LVEJ5wBv4Ll+YVClGnDrWmKLLgbavE/gXRyM
         neXI+XROcOmSw/IeQh1869AdtMBrO+/NB5W3mQ1wgi2gX2IdEd1cRt41RzwOA4kaz7h8
         bzOVi/QJVxXxBOzw0bcPij0n8WWFUg6yxA/T3ivS77nRUZJWMgKr2CeAX4scry6SFqTd
         iSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZbyDA7bAxdhh7h2FYpg0CW89ZilRxG0LnNJPk1YcYXs=;
        b=hktWdHJZwkpHybTa5QMxs4aH0XvkwlLH+JUeC8gk942TJDVff2QGuyx9fsRKEnZWVh
         5205Tf0UxivFu9IrycDDfph60a53XrhZLgewMC1gxBJLRxQfWU62UB93cCssFtQ81o5W
         d2kcThQ0Br6dz4Uw4tEip1n77MNeXXfvrqge/4NKEwVA4U1ImNgNfgQznVj8JlGjZyJT
         1c5g577505Cm5HhsNJDr1qGdXsOQO7zarOo+gIZABZENMqS8Q0O9/gf5+dtE+OkpTQCp
         flScWZL5LX0W8pxg91FpgVvF1gPX/ih/KP1IKc4bPzzj26mxZPiv8J+dxAdNX7PGKxMi
         QoBw==
X-Gm-Message-State: AKaTC02D7h5NqF8olbRHt23ErCiPbn4KmZhSwNpPgmh8DOFUtg7gXZJR+lPzKeJj0QxXFoQ8
X-Received: by 10.98.62.73 with SMTP id l70mr41189711pfa.92.1480636879819;
        Thu, 01 Dec 2016 16:01:19 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r124sm2692687pgr.6.2016.12.01.16.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 16:01:19 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v8 3/5] http: always warn if libcurl version is too old
Date:   Thu,  1 Dec 2016 16:01:00 -0800
Message-Id: <1480636862-40489-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480636862-40489-1-git-send-email-bmwill@google.com>
References: <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480636862-40489-1-git-send-email-bmwill@google.com>
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
index 4c4a812..fee128b 100644
--- a/http.c
+++ b/http.c
@@ -735,9 +735,8 @@ static CURL *get_curl_handle(void)
 		allowed_protocols |= CURLPROTO_FTPS;
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
 #else
-	if (transport_restrict_protocols())
-		warning("protocol restrictions not applied to curl redirects because\n"
-			"your curl version is too old (>= 7.19.4)");
+	warning("protocol restrictions not applied to curl redirects because\n"
+		"your curl version is too old (>= 7.19.4)");
 #endif
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
diff --git a/transport.c b/transport.c
index 2c0ec76..186de9a 100644
--- a/transport.c
+++ b/transport.c
@@ -747,11 +747,6 @@ void transport_check_allowed(const char *type)
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
index b8e4ee8..f4998bc 100644
--- a/transport.h
+++ b/transport.h
@@ -164,12 +164,6 @@ int is_transport_allowed(const char *type);
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


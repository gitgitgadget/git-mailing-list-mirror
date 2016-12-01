Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6061FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755093AbcLAU0e (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:34 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34291 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934001AbcLAU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:31 -0500
Received: by mail-pg0-f43.google.com with SMTP id x23so98607497pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZbyDA7bAxdhh7h2FYpg0CW89ZilRxG0LnNJPk1YcYXs=;
        b=JnKVWQZxrzGBNR3DaIxkvVC2UHRpCFgMl43BcQDxgfVUSvbam/h5AGV9/V8WSuU3cE
         xlqqMNMLSdlOH44KmaxxmW5te7PPO1IkmZzztVRpMAFtUzgkth8IUA+VILoweZgK2zIh
         HVD6s0ddO6yofajsw3rLly9wKeRML0y044RaOx6rxV5HcUkKpyqKqwq7HblhhA5x4XYs
         IJXcfxnnczkFIvVNWQb7i0Su3MUe9/Gr/LGyC0m889SZIXs8RhrIsFq2L7WFF5R25GtX
         9P227pm1Lip5Ymspb/9/er+ipFwzDjiBszzJvbk5QaNh8czAh2QE4shE7tPlGAd/G6kq
         zIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZbyDA7bAxdhh7h2FYpg0CW89ZilRxG0LnNJPk1YcYXs=;
        b=D+ge2orXmYa/1Kps9U98gQaJdqxIHc0S9CQ9LdYdiANDnuGj/px2n/vHU2mOTAXan/
         6KbJA7HIrPZYvzxNGSDwxVjx/02VLFrDYe3HMXQTiSycvFfcOL93VT/ou3rvFoW0G3d6
         BkHr8FnEuf8COdE9sZoYVb5KzarAY9AjnGjRDRXqFy/tpdyRJYb9gpzN6rYrH3pCwSXL
         71nOqKuEQTD1gAa7SR5LetzhqtPlChnj5XRPs2i/FDMt0fYCdzo6H90nwNnzvfG0JVP0
         4jPeeniKUzvZg3O/XuiTNBb5VLnQMHrZJTt1QIMuqfK47r/ClC/+ZrkuVJ8ih1bwdoJ3
         RTKQ==
X-Gm-Message-State: AKaTC03uVL3VL+WzfY4mk/Q5nbBaUdS5NCCpp/oS8eaeB5XHqp117AIKgEyvmyxIXWE0GayX
X-Received: by 10.99.120.13 with SMTP id t13mr70431178pgc.17.1480623990291;
        Thu, 01 Dec 2016 12:26:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 16sm2230074pfy.4.2016.12.01.12.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v7 3/4] http: always warn if libcurl version is too old
Date:   Thu,  1 Dec 2016 12:25:58 -0800
Message-Id: <1480623959-126129-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480623959-126129-1-git-send-email-bmwill@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
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


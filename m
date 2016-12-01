Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF6120754
	for <e@80x24.org>; Thu,  1 Dec 2016 19:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760095AbcLATpq (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:45:46 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33228 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760036AbcLATpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:45:34 -0500
Received: by mail-pg0-f54.google.com with SMTP id 3so98259112pgd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZbyDA7bAxdhh7h2FYpg0CW89ZilRxG0LnNJPk1YcYXs=;
        b=D7zZkwxbP+lOsR9FagNNW4+eN+FXWOssLmLya/gDoqiABThbnKk0WeiRy5kGnItX0l
         7x3ApzZFmH4EhgR/JrSN6HkVwkhIrCOZF8KEwb68m55kQ56SKrYhqd7/eyAFSRpShkQw
         qz2tv+/qZAfcm1vQAmUooZw18nBIf2iqXWUDz010pjNeUGUichhZ1rxMQ1kxHDTRe5Lo
         PhiX8KXtF8jv0Q+F9qmkFSOR1WSlxZsu4zXuS+H+PhJryHK2Or0ZCw0Es66NaonX80p6
         hxa9qu+xtzdqiug0BSnA52gtyKTq6lHx/CqmD6CxwRE+X9vtJwcRhlm2BBWxT6a+67Kt
         2H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZbyDA7bAxdhh7h2FYpg0CW89ZilRxG0LnNJPk1YcYXs=;
        b=eBEqziLUwjcVjBH7nQJkqqZk/rSjw0CAFVb5uSu9RjJX/QPgNaJJpL2/WhWdunOgDr
         ZAxClo7jur9TdzcqB/EHakxJzqB9oERAXZKSQSHk5dayHdXOhe1TuhqZ8Gh1ZwSqb9Kw
         IGKP4Oa1FnB6gYF5MUX64e7B6qv1Bwlm03e46V/hgdOvX8H8DX8unU49ASNw8hT8ihzN
         7iAQ/8bQRLMGuv7Nybc4hmCEnJx1U1irNYhBvUBLdJGiZ5X5rZ0OKVwt1z82FP+v7ESq
         UQACWzdJgD0hlbQmTJDxHksvAyvoNtJ0448AwXUkn75I4U/+MgWeJKDL5HR0tiX1Ehnx
         6sLQ==
X-Gm-Message-State: AKaTC018Jy8lbz9UJ35GdxQY/beOXoVyagryHpOmE1OXwjYCbvICbki7LIX9cKdbrd+VR5o1
X-Received: by 10.84.216.26 with SMTP id m26mr88395573pli.22.1480621493508;
        Thu, 01 Dec 2016 11:44:53 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q145sm2090998pfq.22.2016.12.01.11.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:44:52 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v6 3/4] http: always warn if libcurl version is too old
Date:   Thu,  1 Dec 2016 11:44:06 -0800
Message-Id: <1480621447-52399-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480621447-52399-1-git-send-email-bmwill@google.com>
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1480621447-52399-1-git-send-email-bmwill@google.com>
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229E620899
	for <e@80x24.org>; Fri, 11 Aug 2017 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbdHKQht (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 12:37:49 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:49918 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753307AbdHKQhs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Aug 2017 12:37:48 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 923D03C000744;
        Fri, 11 Aug 2017 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:in-reply-to
        :references; s=jupiterrise.com; bh=5r1r9U4o/3OAzVAWd+LP+SZ2jPY=; b=
        GszXqMm4Jx9kweJhMVZBdya7/MHx48BgAe9XfruJAG9DdTjB1f/1gLcuVoXFCeeh
        VpRphFXRgEE0Avpz86+8QjiSsJ8hmlUsx38nF8UOG0ZnOmPaggAUVZirigyOyxqT
        tqJT76bUxgr83ymfe5AW3Q3Xuvl3EZoGDsXlME+uReY=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 5CB853C001C17;
        Fri, 11 Aug 2017 09:37:47 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet.jupiterrise.com [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id E5B8160617;
        Fri, 11 Aug 2017 18:37:44 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id CC3056006D; Fri, 11 Aug 2017 18:37:44 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: [PATCH 1/2] http: Fix handling of missing CURLPROTO_*
Date:   Fri, 11 Aug 2017 18:37:33 +0200
Message-Id: <4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1502462884.git.tgc@jupiterrise.com>
References: <cover.1502462884.git.tgc@jupiterrise.com>
In-Reply-To: <cover.1502462884.git.tgc@jupiterrise.com>
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com> <cover.1502462884.git.tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit aeae4db1 refactored the handling of the curl protocol restriction
support into a function but failed to add a version check for older
versions of curl that lack CURLPROTO_* support.
This adds the missing check and at the same time converts it to a feature
check instead of a version based check.
This is done to ensure that vendor supported curl versions that have had
CURLPROTO_* support backported are handled correctly.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 http.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index e00264cff..569909e8a 100644
--- a/http.c
+++ b/http.c
@@ -685,6 +685,7 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
 
+#ifdef CURLPROTO_HTTP
 static long get_curl_allowed_protocols(int from_user)
 {
 	long allowed_protocols = 0;
@@ -700,6 +701,7 @@ static long get_curl_allowed_protocols(int from_user)
 
 	return allowed_protocols;
 }
+#endif
 
 static CURL *get_curl_handle(void)
 {
@@ -798,7 +800,7 @@ static CURL *get_curl_handle(void)
 #elif LIBCURL_VERSION_NUM >= 0x071101
 	curl_easy_setopt(result, CURLOPT_POST301, 1);
 #endif
-#if LIBCURL_VERSION_NUM >= 0x071304
+#ifdef CURLPROTO_HTTP
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
 			 get_curl_allowed_protocols(0));
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
-- 
2.14.1


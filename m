Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2617D20966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbdDENFj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:39 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41194 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933049AbdDENEa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:30 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id 85252600050C
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=TYnwCtujjcB6MNs9gz4sJcZnpmA=; b=kyI8wzQkJ24c
        mnvZrasoxKCB3wrURLFyNVCueXQOooWnnjQSC2cZ6kruuPu2fo3mfy7PfgVeHM2a
        b0xnunwQ+gYTC+Xllt3OO/ltiD+nH1zyyvTGQeO9xneCOgH9O4gQrd4EJAnQhI6a
        oRPJ6SADNly3rNO3I9Ibn8VTRe5M2UU=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 3D2DE600050D
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:29 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 26393612EA
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 2326576C7A; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0
Date:   Wed,  5 Apr 2017 15:04:24 +0200
Message-Id: <20170405130424.13803-8-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170405130424.13803-1-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 17966c0a added an unguarded use of curl_easy_strerror.
This adds a guard so it is not used with curl < 7.12.0.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 http.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http.c b/http.c
index a46ab23af..104caaa75 100644
--- a/http.c
+++ b/http.c
@@ -2116,8 +2116,12 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		CURLcode c = curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE,
 						&slot->http_code);
 		if (c != CURLE_OK)
+#if LIBCURL_VERSION_NUM >= 0x070c00
 			die("BUG: curl_easy_getinfo for HTTP code failed: %s",
 				curl_easy_strerror(c));
+#else
+			die("BUG: curl_easy_getinfo for HTTP code failed");
+#endif
 		if (slot->http_code >= 300)
 			return size;
 	}
-- 
2.12.2


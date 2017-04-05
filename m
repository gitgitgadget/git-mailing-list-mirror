Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD92E20966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbdDENFk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:40 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41177 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932920AbdDENE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:28 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id A7EF6600051A
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=8fIs/M5z+h75WhkkFn0+QaytEL4=; b=cRiMcVZFIhLV
        aMZyW0lUj9z2gK8UEUdFPp7NdRXuY5yl4G5nLDOqlyFiOfeGmqw0JA+YaQpkwPy/
        ckJHT5exllB2JuZp5drOqzcki6FqFe4bh21kK5GflXFtfFZKQku8k684dRO/IrX6
        O2FZJ4cqZ3IaPjTYikB2UUvMHj0ZrSY=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 751C96000509
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 1A485612E2
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 1692176C93; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7
Date:   Wed,  5 Apr 2017 15:04:21 +0200
Message-Id: <20170405130424.13803-5-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170405130424.13803-1-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With curl < 7.10.7 we cannot get the proxy CONNECT response code.
As a workaround set it to zero which means no response code available.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 http.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http.c b/http.c
index 96d84bbed..ce618bdca 100644
--- a/http.c
+++ b/http.c
@@ -214,8 +214,12 @@ static void finish_active_slot(struct active_request_slot *slot)
 		slot->results->auth_avail = 0;
 #endif
 
+#if LIBCURL_VERSION_NUM >= 0x070a07
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
 			&slot->results->http_connectcode);
+#else
+		slot->results->http_connectcode = 0;
+#endif
 	}
 
 	/* Run callback if appropriate */
-- 
2.12.2


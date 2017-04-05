Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D040020999
	for <e@80x24.org>; Wed,  5 Apr 2017 13:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933254AbdDENFj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:39 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41193 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933029AbdDENE3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:29 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id 757636000519
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=UMHGl1gjZVMcuax+rdKtYo/9I2g=; b=G7h90jAdVHi3
        epfYQs8hfmud4hklD+liu1mV1xPvms+nLJCYiMwIamCSHlDSk/JwEayVSMb58Hdi
        EOCOc7TMc+L1wAw+AJHOibWvhQV+u+aikOuEW+zlp7DOB86NvvMjeuv6720llCAS
        3s7Q+Ovk/HCVAwjR0QSu+i7qJXAaByA=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 3B2926000504
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:29 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 24B50612E3
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 1ECE776C82; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] Handle missing CURLINFO_SSL_DATA_{IN,OUT}
Date:   Wed,  5 Apr 2017 15:04:23 +0200
Message-Id: <20170405130424.13803-7-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170405130424.13803-1-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not try and use CURLINFO_SSL_DATA_{IN,OUT} for curl < 7.12.1.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 http.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http.c b/http.c
index ce618bdca..a46ab23af 100644
--- a/http.c
+++ b/http.c
@@ -649,10 +649,12 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 		text = "=> Send data";
 		curl_dump_data(text, (unsigned char *)data, size);
 		break;
+#if LIBCURL_VERSION_NUM >= 0x070c01
 	case CURLINFO_SSL_DATA_OUT:
 		text = "=> Send SSL data";
 		curl_dump_data(text, (unsigned char *)data, size);
 		break;
+#endif
 	case CURLINFO_HEADER_IN:
 		text = "<= Recv header";
 		curl_dump_header(text, (unsigned char *)data, size, NO_FILTER);
@@ -661,10 +663,12 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 		text = "<= Recv data";
 		curl_dump_data(text, (unsigned char *)data, size);
 		break;
+#if LIBCURL_VERSION_NUM >= 0x070c01
 	case CURLINFO_SSL_DATA_IN:
 		text = "<= Recv SSL data";
 		curl_dump_data(text, (unsigned char *)data, size);
 		break;
+#endif
 	}
 	return 0;
 }
-- 
2.12.2


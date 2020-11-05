Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443DC4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606CC20724
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Fha4rnEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgKEVKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:10:54 -0500
Received: from avasout03.plus.net ([84.93.230.244]:34338 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEVKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:10:53 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amWxkLtVD99nqamWykhVlp; Thu, 05 Nov 2020 21:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610652; bh=Z7LKfJ7KQswo/vkM/0V0ZpAtVcTp579Ej3IP6KbpB8M=;
        h=To:Cc:From:Subject:Date;
        b=Fha4rnEUP1CgCZLT/507FbYBtt115V9drN0JMmbmTw7HYOlenNXyWlItHWhhyZ4yn
         rQJIsgvwlDMxd2SR+aCKFvTibP2BsFdCFTHH9/Cot8Y4eJpj92xaiTIaOz+584aUlt
         GGwA1/ac8qZ6Yn0UFsnTQcuthlXdMMRtp3Q01/9HMqxngoIFHwHCeWb9wlUaEAJ/pq
         yP650HVN2qsTLePcBi5TWx7CGgLZDRhetAWI5fbm0X6UdaOYp9mai6jlSuIGZlmKao
         fJTu8SJZMD1qzCwfDuZZSdabJ6HREO32/IaYoM6H02WZ8jbE8VXUCrRvUCGiMUVy5k
         WgpVv+cskcIpQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=GBawf_CGCaMNpgGozlEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 8/8] Makefile: conditionally include GIT-VERSION-FILE
Message-ID: <75576fd6-29d7-9700-22a0-bcb30b6ba6bb@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:10:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBmjmEC5qjKLEfaqqNGnmRdZ2gfkgQKrykgzMIbp3SLedPUJJ3PEqqd34EzZYszE5iRV/EppTt01qnBgduH3TDwsbjqDenAU0E8OPEk8C/Qe8YrtJfaD
 ReerLTfG1E9oSTcdCF2zA0kuMd5JYu9XWrwIxjzpOC9jjlDNDaKGXi8BWlsfTTwj2M8/kKYDUtF2bw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is still noticeably slow on cygwin, despite the
improvements made by previous patches. For example, the second
invocation of 'make clean' below:

  $ make clean >/dev/null 2>&1
  $ make clean
  GIT_VERSION = 2.29.0.7.g273f7f9394
  ...
  $

has been timed at 6.430s on my laptop (on old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the 'clean' target is still causing the $(GIT_VERSION) make
variable to be set (executing the GIT-VERSION-GEN script in the
process). However, the last few commits have removed all dependency on
the $(GIT_VERSION) variable from the 'clean' target. The calculation of
the git version, in order to set this variable, is thus wasted effort.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include GIT-VERSION-FILE' when the
target is not 'clean'. (This drops the time down to 4.064s, on my laptop,
giving an improvement of 36.80%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index bc9ce28bc3..ca65259e10 100644
--- a/Makefile
+++ b/Makefile
@@ -502,7 +502,9 @@ all::
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
+ifneq ($(MAKECMDGOALS),clean)
 -include GIT-VERSION-FILE
+endif
 
 # Set our default configuration.
 #
-- 
2.29.0

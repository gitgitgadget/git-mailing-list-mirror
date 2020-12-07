Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCC1C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2222122509
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgLGAdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:33:16 -0500
Received: from avasout01.plus.net ([84.93.230.227]:33380 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgLGAdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:33:16 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id m4SUkwQYIn8O7m4SVkbbQM; Mon, 07 Dec 2020 00:32:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607301175; bh=Af22eD85dsghLR2PX3f0Ji2nUV9RZXl+pRkRnEP/kYM=;
        h=To:Cc:From:Subject:Date;
        b=hqf/etOth6MEn+68Gdr3UKUSJPNAzipvDtMveFQHFkvchyhxikQnub1HY+PLTB5oP
         doRzoFXpc1eXDECLMNllb93ycyQDxC0EQe8ai3JolC5jPXiqC6aBe8P3BT1zjfFDo1
         IacOTLaYJlYs/Qw6aBxyiZy1vqnpu+M5RPP+97pFfP36RTJdWMDQs7clJCwOmABabX
         VMtIHdaSgWUS/brUNX02XrycsiFzqiv5c+WFQJ1Yrk+Ub/g4GIuR972qCngn/LKcuy
         4oR8UqqG1E9kB5eyqXL+VyF3ad+Fqwdqc92ly75AlOw2CKR1S9Fv+s6qZ6hQ1tiHAw
         5i3aLSHee4RQA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=lLT4iZDIu0lhsO9_-yEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 2/5] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <3e085045-99d5-29ee-ed3f-076b1b8bb6b6@ramsayjones.plus.com>
Date:   Mon, 7 Dec 2020 00:32:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKZmuwTrKRjRbvspwwpBIE1YnNiB7W0V9t0O4gzQrkqSrewHT+4IHEvoiTN4hwIAL/9okQRUN+yvyuL6eqMhtoMZNWZYzyEGWr0jaYsorznSoDkJprcR
 ePn6860Rw4AXpvgwQc7MqHQNBGaQdx6+svzbD0UG4vpWTLxKGNi2Pv3Oh7sHv7i8/O/RdIYajbGfLQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is still noticeably slow on cygwin, despite the
substantial improvement made by the previous patch. For example, the
second invocation of 'make clean' below:

  $ make clean >/dev/null 2>&1
  $ make clean
  ...
  make[1]: Entering directory '/home/ramsay/git/Documentation'
  make[2]: Entering directory '/home/ramsay/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/ramsay/git'
  ...
  $

has been timed at 12.364s on my laptop (on old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the 'clean' target is making a nested call to the parent
Makefile to ensure that the GIT-VERSION-FILE is up-to-date (prior to
the previous patch, there would have been _two_ such invocations).
This is to ensure that the $(GIT_VERSION) make variable is set, once
that file had been included.  However, the 'clean' target does not use
the $(GIT_VERSION) variable, so this is wasted effort.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
target is not 'clean'. (This drops the time down to 10.361s, on my laptop,
giving an improvement of 16.20%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 652d57a1b6..5c680024eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -272,7 +272,9 @@ install-html: html
 ../GIT-VERSION-FILE: FORCE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
+ifneq ($(MAKECMDGOALS),clean)
 -include ../GIT-VERSION-FILE
+endif
 
 #
 # Determine "include::" file references in asciidoc files.
-- 
2.29.0

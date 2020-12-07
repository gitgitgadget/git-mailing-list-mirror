Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF08C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E44122E03
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgLGAkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:40:20 -0500
Received: from avasout01.plus.net ([84.93.230.227]:33782 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLGAkU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:40:20 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id m4YskwQy5n8O7m4YtkbbTe; Mon, 07 Dec 2020 00:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607301573; bh=gFXeId6R+1zh1wtvuOyg+5SuIAqWXQKRV5Q18Y6QsA4=;
        h=To:Cc:From:Subject:Date;
        b=M5OXUiG/d2Pg6GRm5cJ/ij9dpR78+zO/bHLtYFx9sqAtPg08XBP6MntJux56UzcfJ
         vYa41IIUOm6wzFT5lZa4KBVBS+N61aWpU0nRxUK+nVpGyih0DrRSl+Ymj7SJ2dE6XC
         KLubvD/CNsi0VoCRkNgtdk+BVE9t9le/Gv+E78tvesPuh0EvmTugkrk4FxiNJuJbce
         thta1pOy9FgQ9RlcqIhsKGM4JEfNhJzKDxFTWHOaC7XFILB7Nse4Jqat69boQ8wV9E
         GIG2kC6k1z8m+rJQ0bMbeBGFv2kgQsUg4bJsqmdBYyU35UhI/WW76RrGOsN41mYE0H
         1UAZRQNhKQ8Rg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=LmtbTrIp9brtLQbQUBgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: conditionally include GIT-VERSION-FILE
Message-ID: <ceacd2f6-c9c7-ef93-8bc2-0749770a260f@ramsayjones.plus.com>
Date:   Mon, 7 Dec 2020 00:39:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHfjoyN/eyw8yHz1/pS2O9yCpz9MEVh+cvQ+82YL5XrrjJLsJhQ7LERqF+oXnbIQLTDcMSLbCxOtVRtl85pWuUYqVOFATOKY8XfIvi5LPC8im4xYNdos
 SYpVqg6OpMsJDZR3hp2tTG8SQA92IvpROvO7AEDf4sDkE+QJpSf3wI0LiISxxV+Mh7q6KWHiamRoRg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is noticeably slow on cygwin, even for a 'do-nothing'
invocation of 'make clean'. For example, the second 'make clean' given
below:

  $ make clean >/dev/null 2>&1
  $ make clean
  GITGUI_VERSION = 0.21.0.85.g3e5c
  rm -rf git-gui lib/tclIndex po/*.msg
  rm -rf GIT-VERSION-FILE GIT-GUI-VARS
  $

has been timed at 1.934s on my laptop (an old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the Makefile, as part of processing the 'clean' target, is
updating the 'GIT-VERSION-FILE' file.  This is to ensure that the
$(GITGUI_VERSION) make variable is set, once that file had been included.
However, the 'clean' target does not use the $(GITGUI_VERSION) variable,
so this is wasted effort.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include GIT-VERSION-FILE' when the
target is not 'clean'. (This drops the time down to 0.676s, on my laptop,
giving an improvement of 65.05%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Pratyush,

This is the promised 'separated out' patch to git-gui from the "speed up
'make clean'" series. Note that the speed improvement doesn't appear to
be as good 'stand-alone'; it seems to be about 1.3s rather than 1.976s
when called as part of the git Makefile. (Also, on Linux, the numbers
are 0.091s ->  0.020s for an 78% improvement).

This patch was build on git-gui 'master' branch (@3e5c911) tonight.

Thanks!

ATB,
Ramsay Jones

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index f10caed..56c85a8 100644
--- a/Makefile
+++ b/Makefile
@@ -9,7 +9,9 @@ all::
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
+ifneq ($(MAKECMDGOALS),clean)
 -include GIT-VERSION-FILE
+endif
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
-- 
2.29.0

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7917AC433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412D4238EE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgLHWfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:35:16 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60896 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgLHWfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:35:16 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlYykHHw90K1OmlYzkvn9v; Tue, 08 Dec 2020 22:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607466870; bh=Kzue2oX0uswM9t+FcFGJSGcX8S+TQ2Nl/Mf6uWXPrmw=;
        h=To:Cc:From:Subject:Date;
        b=phQvJhU6E5Bm739X/c23ixXOykFLgTFbgVlSszVVUALD6zbH7ACtbXMxdv6JrOgQc
         C2NAAufkiHh4jYGP8I4dESpQUfGtPE10bQ4mWKD69Dtad++LNEz6V393zSTV+jamtc
         PFgIey6feNguQeIxn1bnT2Y+/wYsXt1/xoYTPqYXfplcv+PNfAt9OiFK4Ct7iiqHVW
         gIjXgEtJATez04pqUIt3QrBhTsSDTkIOym39Bc0LRggoQKn5xIeTl3b9x6JM2QJoWt
         XcJ5wyzeW6B1KgN8erzjmTAABRwKpposeL8s2/5QSGAEy4IMyiqAp39X0e3LN2vONZ
         g3WWM3Vkcfbhw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=awHaz76ZRxkwiDev0AUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 3/5] gitweb/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <8aa9a686-94f1-e29c-6581-2d8d53bd55e0@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:34:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBuORL4R0kuaMopT4x7QgX/79FWuvP6Sv9PkVpfoTtR3VZtCtpSxt/mXge+E1m2dF9sa8zrezW5gYlrSeoYW5AfYZBy9K6h4CAW7WJeMRY1YaxnR038P
 sP21SeiTM7yPf6VfmFGJ1WaqW9jrEX6w+buulbiK8qRNj+Ly2pVxa0w7B1Qtjl6Go72JqaoR6mhNWA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is still noticeably slow on cygwin, despite the
improvements made by previous patches. For example, the second
invocation of 'make clean' below:

  $ make clean >/dev/null 2>&1
  $ make clean
  ...
  make[1]: Entering directory '/home/ramsay/git/gitweb'
  make[2]: Entering directory '/home/ramsay/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/ramsay/git'
  ...
  $

has been timed at 10.361s on my laptop (an old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the 'clean' target is making a nested call to the parent
Makefile to ensure that the GIT-VERSION-FILE is up-to-date. This is to
ensure that the $(GIT_VERSION) make variable is set, once that file had
been included. However, the 'clean' target does not use the $(GIT_VERSION)
variable, directly or indirectly, so it does not have any affect on what
the target removes. Therefore, the time spent on ensuring an up to date
GIT-VERSION-FILE is wasted effort.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
target is not 'clean'. (This drops the time down to 8.430s, on my laptop,
giving an improvement of 18.64%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 gitweb/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd194d057f..f13e23c4de 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -48,7 +48,9 @@ HIGHLIGHT_BIN = highlight
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
+ifneq ($(MAKECMDGOALS),clean)
 -include ../GIT-VERSION-FILE
+endif
 
 ### Build rules
 
-- 
2.29.0

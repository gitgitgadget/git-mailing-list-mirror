Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E58C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1879B22ADF
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgLGAfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:35:17 -0500
Received: from avasout01.plus.net ([84.93.230.227]:33556 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLGAfR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:35:17 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id m4U1kwQeIn8O7m4U2kbbR1; Mon, 07 Dec 2020 00:34:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607301271; bh=ZspPBG9L2bMOreAQiDuu4CEWxyFOfFvQ+r3+w37A2ws=;
        h=To:Cc:From:Subject:Date;
        b=gbiVIdw7U0ItNT0V6y76RQFGPVJPjofrmFjEgro6pXz7RUjjcacWeCebnevuMezjG
         QB5WkctZB5MTiFjsEwOuKPEagWTxZvsuq0vvi0DV1Y8rHReixQficY7WqPOS85GzPp
         txpB2diGSEvjlg4ferOYTlQOJ/tWRye1YwA/DzZpfz2lsdqw2RwIUHVRYV5DE1COq1
         NMtg7aKVaBDqsmf6I1cmZ3VeEb6XIm//RkhQHCHegBeiycoa5O6XZ4MgSenwgqGwFL
         WSa+v59uhJHb8vZ2GFAVS5PfnqCyRGvQPF3HUTSsy2iqPMCPw1D3EAnqByk0a+1WRi
         X1g52Tt8fs+nQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=awHaz76ZRxkwiDev0AUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 3/5] gitweb/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <f96f5cf3-713f-5c89-d486-e1a3f1c97b07@ramsayjones.plus.com>
Date:   Mon, 7 Dec 2020 00:34:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKVwjiv/iF/hedXQkfUyW9KDkoR6jcfeGH2fPvJdayZRJjhPgzNFVgv6WSL+/2xUUsGhGE039FX+KEX4+psFL4/hc6PHBaC9q3WpnW6C1VbhcKjPS2gH
 zIN0aBHp4LGj1EXeTyx6fzrVS9qV16Fpieb8ooTIRm7hgb7RBN0zFV9NjN/KFSUOMtHMG7kQGzxoTQ==
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

has been timed at 10.361s on my laptop (on old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the 'clean' target is making a nested call to the parent
Makefile to ensure that the GIT-VERSION-FILE is up-to-date. This is to
ensure that the $(GIT_VERSION) make variable is set, once that file had
been included. However, the 'clean' target does not use the $(GIT_VERSION)
variable, so this is wasted effort.

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

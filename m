Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FFC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D759224DF
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgLGAcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:32:05 -0500
Received: from avasout01.plus.net ([84.93.230.227]:33380 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLGAcF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:32:05 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id m4RLkwQUCn8O7m4RMkbbPq; Mon, 07 Dec 2020 00:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607301104; bh=DHHibXVpUqxpYo8MGGEPk7zn1EDWqEDrbF+ceWCWQ3k=;
        h=To:Cc:From:Subject:Date;
        b=pz5X28l+ku0Qa/dLo48g4Mbjj63cDc+8RDW96MU8yFI/Wq12gsHBOt3LJUnqeCmxT
         MnMujDCIMiC7f4UeT1PACEAMQXDdvZ5dFhBXLomUGSZSBW3abtql1/wQfqs0Ej8Qi3
         e5LXVBbYKo/b360sk+QlJoEdhZgQd2NnIfVSctMTbDhMuFj9XY5SGfN9k2rkQpXDFL
         5jyH10bqse8S+yMib443EyVOax3tcP2H55aWYmdjQ20pQCQ6f/fp/binZRo6apCc3w
         Brbi5AUKCqNNLJkDfoU9BcvVLEgNBWOtfea+hsAsXsHbmFU/CUFHssWT265cJrT8Tg
         1rpSJNDsPFsdQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=WGfck5Sx_jJAHGwoxU0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 1/5] Documentation/Makefile: conditionally include doc.dep
Message-ID: <a8e1bc9d-ce6c-d065-5a20-fee15967364d@ramsayjones.plus.com>
Date:   Mon, 7 Dec 2020 00:31:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEcUaZwEGrstbDWSNrHucy5Q88pGkQj7ACTtyWCJ8m9HZhCQxGQZ9XKZCZn6gHCzN0C1W8/OKcmNIeAhNH6OF/Dw5NTRkBfGz+i9m/MM6gkaOWQAEtk/
 QdHu915tMKGFbU1sbmQ+71AFGWPdHvd7ZECTuljdtJeKQ0uNXUxKM1KPMLlW8+BvqMYijlPEheabng==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is noticeably slow on cygwin, even for a 'do-nothing'
invocation of 'make clean'. For example, the second 'make clean' below:

  $ make clean >/dev/null 2>&1
  $ make clean
  GIT_VERSION = 2.29.0
  ...
  make[1]: Entering directory '/home/ramsay/git/Documentation'
      GEN mergetools-list.made
      GEN cmd-list.made
      GEN doc.dep
  ...
  $

has been timed at 23.339s, using git v2.29.0, on my laptop (on old core
i5-4200M @ 2.50GHz, 8GB RAM, 1TB HDD).

Notice that, since the 'doc.dep' file does not exist, make takes the
time (about 8s) to generate several files in order to create the doc.dep
include file. (If an 'include' file is missing, but a target for the
said file is present in the Makefile, make will execute that target
and, if that file now exists, throw away all its internal data and
re-read and re-parse the Makefile). Having spent the time to include
the 'doc.dep' file, the 'clean' target immediately deletes those files.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include doc.dep' when the target is
not 'clean'. (This drops the time down to 12.364s, on my laptop, giving
an improvement of 47.02%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 80d1908a44..652d57a1b6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -286,7 +286,9 @@ doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt) build-doc
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
+ifneq ($(MAKECMDGOALS),clean)
 -include doc.dep
+endif
 
 cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
-- 
2.29.0

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1078C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD06F238EE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgLHWcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:32:07 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60696 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgLHWcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:32:06 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlWKkHHho0K1OmlWLkvn8I; Tue, 08 Dec 2020 22:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607466706; bh=81uG1+QL4F6D2XE44Iznxiyqq5afFo+9zKZE92WNH/A=;
        h=To:Cc:From:Subject:Date;
        b=AiG8MebgoDgYW9uQhv/d2GNB37AgyKoaGYOuvEsII2/B90qDa7147VIJobTjyLUzD
         ljbnaicXpWnjmotLF+NGuT8lJKjsUxdoUQBpGkx/y9JTFGSQmFuE3wMZKwO5rQRtU9
         pxp72U0rj3pm/w8RXQGlrhk3p4F629TF3efhGRjousK61K5KrS913fjS8AmDnqCtSO
         aEwaG3c2g8m/0dGZsV0DlNbgDqWvnosQyGDQxYTFReewSi8YSpHd9KaEati3V9zCUp
         6z5i84bIIGvtLf08qFoTsUTfMuC4V4XTRS16SheIrzWLMchBBPxLorX1g+sd6ZW1l/
         Hz1hlBLyM2P/Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fGLe8T8LZrKVVAFXI-8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 1/5] Documentation/Makefile: conditionally include doc.dep
Message-ID: <88d87207-0668-2119-e63a-49384897c789@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:31:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNRjIO31MUc7hcQf23qYqBQ6GMT0Uls+h9EdZmSRl0AGt4v/jyo84Ar+vyNUvaOCgpcGEhzgalG1wsYlfpyh5vN6Icu2CaVy+R6FYJu+Ena74tMefM5h
 lLURNbY50Ms0FyTZFMBghs+Fr39o7N2sp9JDdcD7DF1uAkGjPlO2CNQeYiJWJvldgnPqkSN1LyQUUg==
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

has been timed at 23.339s, using git v2.29.0, on my laptop (an old core
i5-4200M @ 2.50GHz, 8GB RAM, 1TB HDD).

Notice that, since the 'doc.dep' file does not exist, make takes the
time (about 8s) to generate several files in order to create the doc.dep
include file. (If an 'include' file is missing, but a target for the
said file is present in the Makefile, make will execute that target
and, if that file now exists, throw away all its internal data and
re-read and re-parse the Makefile). Having spent the time to include
the 'doc.dep' file, the 'clean' target immediately deletes those files.
The document dependencies specified in the 'doc.dep' include file,
expressed as make targets and prerequisites, do not affect what the
'clean' target removes. Therefore, the time spent in generating the
dependencies is completely wasted effort.

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

Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA88C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A5220719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="TBraVFMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgKEVC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:02:29 -0500
Received: from avasout03.plus.net ([84.93.230.244]:33869 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:02:29 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amOokLswE99nqamOpkhVe8; Thu, 05 Nov 2020 21:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610147; bh=DHHibXVpUqxpYo8MGGEPk7zn1EDWqEDrbF+ceWCWQ3k=;
        h=To:Cc:From:Subject:Date;
        b=TBraVFMqJJ5SUZLYHkt4FIDAFs7YKE1oC4J4o/45vkn7oMFDGyBvd6s0gkE9lOdUH
         kIFlb4qcIAd3DoejJMtIB6tUt18I4y2lczV+YVMWL2KT565eXM3LvaNDC2gxFdv9f5
         POHKkFBGDZsis6nMc6Dx0J1CU6egU0SEI6xnG2lCZySvVtuUzXjzGGWfX9J/mNU0+d
         EOxF2x85e7mmbMp++um3LR4mZA4/REVuu2S126FH+lq6LqrMXTgIfpTA9wcdNGW0ci
         wVrBFJtQrwTHdjK7JsPQbSJSjjeawD5HK29AT7xNNd+oTyVI+nbMcb46S/dVYcYn7Z
         2cNyUOh+VgqYQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=WGfck5Sx_jJAHGwoxU0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/8] Documentation/Makefile: conditionally include doc.dep
Message-ID: <7810d64d-c6d0-8a1a-b5b1-d29df70cb589@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:02:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPsGy4dW3SmPE8OSMwubCAlKDF1auEhjIok25r9HVgZmXJRAnkKBQK8dCgUPFyNclC6BxhIYvuxwBV35QaEsUxKxL/9IEycVJyFQoxi1LEG2bkQvKQ2O
 5F71NhDBQ8zXe8m2d493gg4f9a0rxGaPXJb/Se+Of25zVbU9lReTvPimfZk+lrggfiXQGQ2aA/5+qA==
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

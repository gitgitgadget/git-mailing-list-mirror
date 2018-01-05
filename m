Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945151F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeAEUbD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:31:03 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60608 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbeAEUbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:31:02 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id XYdnepfYXUnu3XYdpe1YUl; Fri, 05 Jan 2018 20:31:01 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=DY5nkrlW c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=kUvnWPqztj1zlzCV5YoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] upload-pack: fix some sparse warnings
Message-ID: <720013d4-a493-e0b6-7a38-9ebbbaa198ce@ramsayjones.plus.com>
Date:   Fri, 5 Jan 2018 20:30:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI06dok4kdHU8kPUX9NV211++2G9p1T57+pN2GKcfGLHpTd0uMS558M/0KMig00E7BChAzh04/BaDCBf6zNFxqyw5Bhn2N/x4aEHlNrIZ84z2gD0EHUq
 eA10nCCVTKCiwDtGYtAVKVrCyEzH95TRJOrb7j8RKd3KFXfyNXoXM+cVNdLBmIxVo3MCzI2y2gm5PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Brandon,

If you need to re-roll your 'bw/protocol-v2' branch, could you please
squash this (or something like it) into the relevant patches. The first
hunk would go in commit 6ec1105192, "upload-pack: convert to a builtin",
2018-01-02), whereas the second hunk would go to commit b3f3749a24,
"upload-pack: factor out processing lines", 2018-01-02).

The sparse warnings were:

       SP upload-pack.c
   upload-pack.c:783:43: error: incompatible types for operation (<=)
   upload-pack.c:783:43:    left side has type int *depth
   upload-pack.c:783:43:    right side has type int
   upload-pack.c:783:43: error: incorrect type in conditional
   upload-pack.c:783:43:    got bad type
   upload-pack.c:1389:5: warning: symbol 'cmd_upload_pack' was not declared. Should it be static?

[Note that the line numbers are off-by-one.]

I note, in passing, that strtol() returns a 'long int' but *depth is
an 'int' (yes, the original code was like that too ;-) ).

Should cmd_upload_pack(), along with the #include "builtin.h", be moved
to builtin/upload-pack.c?

Also, I note that packet_read_with_status(), introduced in commit 4570421c3,
is not called outside of pkt-line.c; does this symbol need to be extern?

Thanks!

ATB,
Ramsay Jones


 upload-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 8002f1f20..6271245e2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "refs.h"
 #include "pkt-line.h"
@@ -780,7 +781,7 @@ static int process_deepen(const char *line, int *depth)
 	if (skip_prefix(line, "deepen ", &arg)) {
 		char *end = NULL;
 		*depth = strtol(arg, &end, 0);
-		if (!end || *end || depth <= 0)
+		if (!end || *end || *depth <= 0)
 			die("Invalid deepen: %s", line);
 		return 1;
 	}
-- 
2.15.0

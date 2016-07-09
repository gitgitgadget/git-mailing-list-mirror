Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4700E20705
	for <e@80x24.org>; Sat,  9 Jul 2016 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbcGIHYN (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 03:24:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:51912 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbcGIHYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 03:24:05 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LoVja-1atcXM0PoQ-00gWvd; Sat, 09 Jul 2016 09:23:58
 +0200
Date:	Sat, 9 Jul 2016 09:23:55 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Naja Melan <najamelan@autistici.org>
Subject: [PATCH 2/2] diff: fix a double off-by-one with
 --ignore-space-at-eol
In-Reply-To: <cover.1468048754.git.johannes.schindelin@gmx.de>
Message-ID: <daf43539479acdebe1c5799c38f3be75c2399feb.1468048754.git.johannes.schindelin@gmx.de>
References: <cover.1468048754.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GPDo+VipHl+oP5Vud1ltCGkxKg4EfD3Fh73EeXjuQ1yOusWQlcw
 CAzBc0AWALwB9n7L+XnNFePqnnjB8XSZ/a9UG8jwq/D/cXWzijJSraamcn1hwApPVNX94LT
 MndDmEnPvCgmA9q5aTI6RkkW+vaeRpk3qMYeet8XNC9TUYOy0Wk/CfOkyhZqENnkeTGyuK7
 huWstTpFOkRkekYxXkAAg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:4opKrl2ETGo=:dlMa3USjQpY2ts17qs07/i
 dfEhbQJ67MsKjrdfeD3rKJ3kp/ya2Bwd7V44GkZnPRRxXlh3t1i+Taw/hXljcwWhtcUVMINg0
 rcop6i8UHI7otnwiypqxgtAHSRhvPD5ENU/oHaX97w4f3+BsKTreLmi4nxvMzin7NkFaDRTYw
 ltCUidHHHVCYbFEKuOKT7EDjxaU9reBzGX56XLgVZKxR0T24IZN5t0Y3xPPp+B6Pk7UUmlQFA
 LQV24NRQCLFF1sp8gYYDX8iDJ5sx5HWltLAVEh3/Zm70oAR0CSLKg4SZGwkryGIXQCh6eZDQv
 S61cWBfEHsdpMv3DdbESVykoHdCXmYgs1fG2MPfqKTP5PuIfswuRQskMd18Ibpe+Z4Ykbal9e
 h7NhoCRUD5fcGsVe681xMqjjuo/Bvz6nmP//fm3fVD2A+dSf5Itqg2RJz6X4F996N8lcjBCdN
 Z7TH3+1F32shYN8H+Cm7Jypw1gqVQKd570XlLew3RkRFux7Q1RYDmxqig8aAhKEVd8RfWBDHE
 BRuOnLZtIyc9Bo9vwsG9DQtcMPFyGL4mP3LHR5kMc3DTMBsNnXT5HNljJMj3HkXgYkMq0UrGR
 Z6jo/rj1Ncp5zDwpbpNs8OSW/0oeYO8rYuyBBBmb4C4jqL83YcauE5U80be8JP8EJS4/oHUxI
 buxlB5GjBgfEjRL8B4oQL8dEdIMsa4fELrkiJfFu0wbJT7AZqDkyBENvT+1FTYXX0ak4z8Qwy
 hUs3E1WlFsJ1xEv7P5pMVkNauFQgUkk80N6DbxD85crfCRF5RJvHbHu6hTFwqxwZ2ZyH5kgVU
 BwmHWla
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When comparing two lines, ignoring any whitespace at the end, we first
try to match as many bytes as possible and break out of the loop only
upon mismatch, to let the remainder be handled by the code shared with
the other whitespace-ignoring code paths.

When comparing the bytes, however, we incremented the counters always,
even if the bytes did not match. And because we fall through to  the
space-at-eol handling at that point, it is as if that mismatch never
happened.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4033-diff-patience.sh | 2 +-
 xdiff/xpatience.c        | 2 +-
 xdiff/xutils.c           | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 5f0d0b1..113304d 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -5,7 +5,7 @@ test_description='patience diff algorithm'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
-test_expect_failure '--ignore-space-at-eol with a single appended character' '
+test_expect_success '--ignore-space-at-eol with a single appended character' '
 	printf "a\nb\nc\n" >pre &&
 	printf "a\nbX\nc\n" >post &&
 	test_must_fail git diff --no-index \
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 04e1a1a..a613efc 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -1,6 +1,6 @@
 /*
  *  LibXDiff by Davide Libenzi ( File Differential Library )
- *  Copyright (C) 2003-2009 Davide Libenzi, Johannes E. Schindelin
+ *  Copyright (C) 2003-2016 Davide Libenzi, Johannes E. Schindelin
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 62cb23d..027192a 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -200,8 +200,10 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 				return 0;
 		}
 	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
-		while (i1 < s1 && i2 < s2 && l1[i1++] == l2[i2++])
-			; /* keep going */
+		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
+			i1++;
+			i2++;
+		}
 	}
 
 	/*
-- 
2.9.0.278.g1caae67

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310852082F
	for <e@80x24.org>; Sat, 15 Jul 2017 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdGOTLb (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 15:11:31 -0400
Received: from mout.web.de ([212.227.17.12]:61739 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdGOTLa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 15:11:30 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJl1M-1dXYvo47Ge-0017jy; Sat, 15
 Jul 2017 21:11:17 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] bswap: convert to unsigned before shifting in get_be32
Message-ID: <56f1263c-a0b4-260b-7e23-881e21119041@web.de>
Date:   Sat, 15 Jul 2017 21:11:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:sQW7EdTP59CaR+ulPLlH4vHHND4PeOdWZrWxmUg4m/iynVJvaDM
 nn6EJU6BgZROVQ3INMBp3MOueFCOXDIDyPRTkn+/bipCyk4sfp6zyedDnclfUV7M2z60ow6
 6viG3CJjXrrOwWBJN6bHSUdiAJlXmwP313FXPNXi0DZ5sjiGAw4TU2syBR2vh6OTPEXMrmt
 i8/QFB1+zVL1RKJVBD7+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o4RQhBBdyYo=:hmo6up7QSOGh1irY5VUsZV
 Cv8J/pjdLwyd5ClwHANSLman8Lj8SgR+gvsouG5H8uZal60kNgvfulGdZrX9xPOsF2yKlqXxA
 /CqXg1M099nDXdPLi1PxSvv7ljnVy7gcAFbPkf2luZ6yixOv6IrorvVO0cVWqIObNF/kPdu8Y
 w/hH1Tq0qwLVid1qoJ8MActCfKMJtsMuLKdDmqUG2TS+UK9Uc2LXddGyxf1H4LK5i5WUlhnuc
 3OQtl2AD3bf++EuXTRougYCzKSsJ2Knfrl4x83XQFfoIKuNrnhAI84GQ7ru4atET+SxpnrIsw
 6PWxULWessCl0vzwU/N/a28jiEdsfFAQTUSTksOjrEKwPhwvWOu8Xocvw0oFRkicmxsgutnhq
 W4Jz5fdzJt1KsDM5KB8Og59XzlKBQ5BmKyySnWU6JGQMNNiWlhnIUMa+gyK1iuxVrSBD4PpVP
 v2YzeiKQCWYtjLNFFW2ZKTHUP67zag7FCNQsCaSMoUoTwrhMFN77jspmHUMhIpuvPcS2/WQji
 xg6PuRMO9Ob5gIhgvKhLiuimiujbh7sdnDHTbG9wpXHMtNznLswYR7pSCJqfloR6i8jrE9ChY
 yGBqUdEKITh5WPoOD4G08jGy/6s53prFUZDrug0AjWEBfDFuYzZgINnqoFgNcSXGVn8fWozvJ
 qkiehdvdz/mlyJvxikfLw4gaZ2Gnye0V8WwmZe5YEy1DiLiC4wDpWRA4wh/oTIHDDPrnd/+p9
 T6t/9fRHxDaAfCgDW0aMES4zABymx2G0m+GmE0C+gZLo5e1lsWSblXDYWXZLv69rfh6prKWgM
 9WfUBI21ZR1b0xuQiZ6H7kXXuSwHEnNxANApC9ZmgXG7VFHi4s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pointer p is dereferenced and we get an unsigned char.  Before
shifting it's automatically promoted to int.  Left-shifting a signed
32-bit value bigger than 127 by 24 places is undefined.  Explicitly
convert to a 32-bit unsigned type to avoid undefined behaviour if
the highest bit is set.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 compat/bswap.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index d47c003544..4582c1107a 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -166,10 +166,10 @@ static inline uint64_t git_bswap64(uint64_t x)
 	(*((unsigned char *)(p) + 0) << 8) | \
 	(*((unsigned char *)(p) + 1) << 0) )
 #define get_be32(p)	( \
-	(*((unsigned char *)(p) + 0) << 24) | \
-	(*((unsigned char *)(p) + 1) << 16) | \
-	(*((unsigned char *)(p) + 2) <<  8) | \
-	(*((unsigned char *)(p) + 3) <<  0) )
+	((uint32_t)*((unsigned char *)(p) + 0) << 24) | \
+	((uint32_t)*((unsigned char *)(p) + 1) << 16) | \
+	((uint32_t)*((unsigned char *)(p) + 2) <<  8) | \
+	((uint32_t)*((unsigned char *)(p) + 3) <<  0) )
 #define put_be32(p, v)	do { \
 	unsigned int __v = (v); \
 	*((unsigned char *)(p) + 0) = __v >> 24; \
-- 
2.13.3

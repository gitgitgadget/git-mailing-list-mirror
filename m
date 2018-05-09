Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEADE1F424
	for <e@80x24.org>; Wed,  9 May 2018 21:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965245AbeEIVGw (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 17:06:52 -0400
Received: from mout.web.de ([217.72.192.78]:36727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935200AbeEIVGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 17:06:51 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUBA-1esE6o3tAu-00SfTC; Wed, 09
 May 2018 23:06:46 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fast-export: avoid NULL pointer arithmetic
Message-ID: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
Date:   Wed, 9 May 2018 23:06:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GH6/BuH+lXrhsMcqSoisVJ37g/7U7vi3kXjEaYeGbhYf+qf+EwT
 8/WzsrKdepaeZsfZNYKFyel8JmyV/kjR3A7yYKI/Z8RUlvRpRV2i3CrcL/tQpJYdvB0ZxwZ
 A3iARhc4UbacFGyUtp64MgemVjkvo0IkWLSTlxlYyMPmOpBDqoAOmZxY1kEZFUsrbKV6IIl
 7Z00T7XX8dl5plY63mqhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w4oA55xQPMs=:kpP0hiLcdUgwi39X8j0/SQ
 fhFx20Dyjp/eZZagDCBSXfE8fqjbufFbFZXVFyXuOFt8rqvV34llhnIZJ6wUHVTEeqGHdjzG4
 tnKiTUKr9vTN10SYBEl0/tyKgXCkZMiM9weORhcbvm5/+sbsc97nwOVG+K/lkOsQ4TOUmXEbG
 TkWga7mEAe3x8Imm2HDdeWnOJbuB3U3C4KoeqtzO0wmn7gVU3WxhDbd4FA5x+TZIqNLwNotji
 TtgZ0CbBr//eG+xyq/ysJ2J9+LcuFYa8Zk0JQuD977fGr9ZiZPFVMtgr7OUH8Bla7br65VyUn
 KmyIqh90xxAse+Uy/qP7GtnDq2lwWCfG50RWnokMF7jHP3aUP5Hy5GPvOYC/p6zDnk/BbTz0i
 ZB0ah/0aYNF9dyrF8ZOAZq/WmQPMva7xe5OXHQaTOC+WUzdccVVGbZ3QOV3oPDV/jYryVU+WD
 LNdIFvhezqdeaLPoCBB0aE/pHXXGXIwudOdjAOEIeNzw4TOMjU8eCl9x096oc3VPpf3v4KfLI
 AdFa/3qAfsxab9MAoYEbmP2mnuloG9idCzUwH4xbWY/25bEdn2koOjoPA247sdog3DmzOTx9q
 LDzpsnKEOiPO+YwmwRZ8I/0W1Is/DpPUIy5Rz1XKRPl+4x8G8Rh8xy1nOLZkV8ZcWRfD5xM3A
 B4uYN8Od+x+arXRT7E0rzs5L7EGo4mqagsWR3O4+KXs7eaPe+aphSPizkNUUz0lqaI4XVTJM1
 bFfwiefbsFdcZNr2t4NBONDtBzYutJzGRszDiOYB9eW3qN7Gw+36y413SRAcWIdKFfkMqXQpR
 F90uA3d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clang 6 reports the following warning, which is turned into an error in a
DEVELOPER build:

	builtin/fast-export.c:162:28: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
		return ((uint32_t *)NULL) + mark;
		       ~~~~~~~~~~~~~~~~~~ ^
	1 error generated.

The compiler is correct, and the error message speaks for itself.  There
is no need for any undefined operation -- just cast mark to void * or
uint32_t after an intermediate cast to uintptr_t.  That encodes the
integer value into a pointer and later decodes it as intended.

While at it remove an outdated comment -- intptr_t has been used since
ffe659f94d (parse-options: make some arguments optional, add callbacks),
committed in October 2007.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fast-export.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 530df12f05..fa556a3c93 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -156,15 +156,14 @@ static void anonymize_path(struct strbuf *out, const char *path,
 	}
 }
 
-/* Since intptr_t is C99, we do not use it here */
-static inline uint32_t *mark_to_ptr(uint32_t mark)
+static inline void *mark_to_ptr(uint32_t mark)
 {
-	return ((uint32_t *)NULL) + mark;
+	return (void *)(uintptr_t)mark;
 }
 
 static inline uint32_t ptr_to_mark(void * mark)
 {
-	return (uint32_t *)mark - (uint32_t *)NULL;
+	return (uint32_t)(uintptr_t)mark;
 }
 
 static inline void mark_object(struct object *object, uint32_t mark)
-- 
2.17.0

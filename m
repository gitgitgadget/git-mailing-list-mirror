Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB4C20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbdJAOpR (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:45:17 -0400
Received: from mout.web.de ([212.227.15.14]:56188 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdJAOpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:45:16 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgOQQ-1deE7r1zpG-00NkQc; Sun, 01
 Oct 2017 16:45:13 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] tag: avoid NULL pointer arithmetic
Message-ID: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de>
Date:   Sun, 1 Oct 2017 16:45:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PxXw5pKm+8jgj+desqX7tsDVBgTrtSC+dP8/W/eRiiL+8lzJg5A
 r6lkm3pw9Dl0Pv4cJxYXtrhrgBK6gg6xc/6bxW7cnMnIIeM/gl1N3roz5ZXDCsiYOdUlEmj
 2av0LXdFM0W17AKRl7vdyMHGotp/g+JzIMOMYAW/OLZcRWUR6EtFCBdyzKETUo0hQqZ4SkN
 3k8tU3t+b0uiRzLxAAi1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YtuvqtyA7SY=:nAr+9ahHHjIn2RTpWv4TxR
 Nc4Trw3/cI3oZlL6xkPvfYalwZYCRJ/WLyJ/aJKmOJO+Qmvwb4HSFwbDdiexit30a8JtwzBz+
 QNnYm8yGyhArwqDNBwwE/YtHwpWddEBu43CNwUKdA4c3Xk2M2wFdRtXeu+05NwPLuAtXcFTdN
 Vd/eGS0azbSfYDBt/CAFfwAiKtkolNp2IrIw3ctzmv0nj0RLXnCRaJwQBjTvvhWvz2bdo7ouD
 RHs4VKWdgEAnsDXe0HABY0ETGa1SHL24UmO79OfvOxDAdchHjkkMnTd8LsJ77GZW8464RqsNZ
 /T7wsWeJje3BMrvF91+2ICg8M3hJYyQDLj9UkcJkj7AWPgBnhAvW6+YTqgm2iAQb/d7gFQeGK
 BAG2q5UCC8bDaRqIkp9Hmd/bFlz/vyp2rX3wJPY1IIY+cCdgrpwCiDjZw/trlvQMH0nf5vp1Q
 wxzDKeVuUZkLBKU78nhat0PAvEssfWrqSiV54j0xC6lm65W/tf+qIFGkaxb52bLL4rnCMtxFO
 Tu5M3XRpQqy+FS90TfIZ3Fdfawz2pPYzViwxQn+2Uyr8jm4cVTY6bIzj8UcsS9H4XPsCVR8BB
 9ahA2XY85+3aZz1hSLpm6dkOR/eS6LJdbXoBliTovXt0dvsvdNz7rvy7lC+NAjzNxXGLkiayk
 uwofV8iCOpJ6NavieahB7EShU7TtBby46oSUh9Yy00858nK1pxf0rvN1uhBw0D3bAsu5IxJhM
 N35YU7onzQ4rP7dh46ozokWhA7D9i39k0Ag492hyG91I3J/ueo86hm8t8TZprWYnY3bLgM7dU
 lvdaQv3SEzKvGenD3iHQb/XhUO7tUOazM41Q5fRr2YXo/L4wns=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lookup_blob() etc. can return NULL if the referenced object isn't of the
expected type.  In theory it's wrong to reference the object member in
that case.  In practice it's OK because it's located at offset 0 for all
types, so the pointer arithmetic (NULL + 0) is optimized out by the
compiler.  The issue is reported by Clang's AddressSanitizer, though.

Avoid the ASan error by casting the results of the lookup functions to
struct object pointers.  That works fine with NULL pointers as well.  We
already rely on the object member being first in all object types in
other places in the code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tag.c b/tag.c
index 7e10acfb6e..fcbe012f7a 100644
--- a/tag.c
+++ b/tag.c
@@ -142,13 +142,13 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = &lookup_blob(&oid)->object;
+		item->tagged = (struct object *)lookup_blob(&oid);
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = &lookup_tree(&oid)->object;
+		item->tagged = (struct object *)lookup_tree(&oid);
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = &lookup_commit(&oid)->object;
+		item->tagged = (struct object *)lookup_commit(&oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = &lookup_tag(&oid)->object;
+		item->tagged = (struct object *)lookup_tag(&oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
-- 
2.14.2

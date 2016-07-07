Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE12C2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcGGOgD (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:58782 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbcGGOf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:59 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MdXSC-1avoQi0Wmy-00PNYC; Thu, 07 Jul 2016 16:35:48
 +0200
Date:	Thu, 7 Jul 2016 16:35:47 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 08/16] merge-recursive: allow write_tree_from_memory() to
 error out
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <fc331704b5d9fdf58bded97eaf4ac866998180d8.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zsyUFIlWzP31OAbzPx2dCK5TPHC7c4cjCCTcrQ2HTkKYDmmlLXi
 EfIIlzGrmPoDvyvO67e9K572uIKTPkpVkQKt4uWq+2GyxPRTJsiKmVpI2ye4dWEL5n9q23B
 I+t4AlNrYEprK+ljvrr+gEVo9Y8hlnAU7irS4hlmV/SFCtSl1sLxp6j25OPSMvv5IW6NaDv
 1yMEwIaHDvKclllrDVYSQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:X3Nli9siGq8=:JdsL6n95qpJg4Y4GUkU7xz
 ryP9JtWf8pfpLuvkn7WtZwEObWNo+JrDMwlJM3s8UHL/fvm2nNT821gcW+Ozwbcil3W0w8JlK
 Tu3IKIqOQqM00bfaP8lem70vAYCeyJp+3coN5/ChhOYa2Grt2G2hOmC1lqynNXhHk9O0KIGSP
 seFJ97kC3BSaK5CW2F7JJUU/qSxf1LeBLiEWuTFit2OWQmazuf71eUg4pMGrCa4LkySv9UyRX
 znyBG+P5Bzus7pRJRaUMwK4zzNjnvslZPWosE1fQw4pc6kMEXgDZNyxDhrpGvOXGvrEh/Gdqn
 YUJzHzxlWlAs6tMbneayAoPXUDg/lyEN20mV3n1Fbr+k5Xm8cbp/P0H8RuqVdiX9ojBeQABeA
 +xcK97w4qyvXXTy5QBTsmBe1gY5AHmv6TJTQBroU4awEbZYaQck5CuXipreA8SSaEdfS9zgqH
 iRg4cX3dcJsvquUWFt7X0nbtFkjaJu0uM1qD/B2k22idawc1a64tlHr2sMU8n9knRcmhZn+IW
 gMz44dnMlDygBWWc+UPMzSmrE7Au31s4gk+WcW3z+N/ZB3tySTKhF/80izt8Oif7Te7tlrKLt
 QtqrOd+PSBhjYWJiCQDfASD+uWsagvpF1OCks08HmihxEe8aV7IanZpCB8qFW5wg81HMKaL6A
 xq7kYTrRIcg7Y687PT9pJcfWKMjOKzjTgoYl8c0Vge82q0vooR5TJV5oCLg+svONhto2vrtL4
 K2Zh0BAaILi+YEWkY+4LlL0aCuQQbqK8kCo62bSpAR42zRjS9YlpK20SDtUqmBOXd91DZTBiq
 4/HEjfX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is possible that a tree cannot be written (think: disk full). We
will want to give the caller a chance to clean up instead of letting
the program die() in such a case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d9221ce..09f4e27 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1903,8 +1903,8 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	if (o->call_depth)
-		*result = write_tree_from_memory(o);
+	if (o->call_depth && !(*result = write_tree_from_memory(o)))
+		return -1;
 
 	return clean;
 }
-- 
2.9.0.278.g1caae67



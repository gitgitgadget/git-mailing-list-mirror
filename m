Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B5A207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbdEDN7k (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:59:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:58150 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755518AbdEDN7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:59:30 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjeWC-1ddQAv2bGa-00bYAk; Thu, 04
 May 2017 15:59:09 +0200
Date:   Thu, 4 May 2017 15:59:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 23/25] name-rev: avoid leaking memory in the `deref`
 case
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <c34be4cbfa4f25bade20f3d6b2ae07d1c847f630.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gb7Rul614Ni638dk77Lwu3X8XfeA1kXFmR5qobauOR8Ucx61Lco
 O+/qLemOjqO4obXK2UpiJfmtt874w3OTKoUH6j4CIOPBKatCjm1UJ7+GPT7JMhnMA5pmtjR
 bvgOe0jbPNdGQOleeYIrjylW5OqIuXq3kJWKUwL34mJNxBXAqVFOKU4sbmUJsolpg50dM7d
 SmAJ3AKPoNbbbwloXLKeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ck2iA0QAGyw=:fFKYSuPmXDO1umDniTWbRZ
 4U3fKrjVZvTuo6iDur0MxmQPG54rtz0PaNSikabRDzM/5C3UCsAQ/dm2gd7LBlSelWD6GVyKX
 tnD+Y3f3UvuYVmlyriG7DXG22c8l3gKgRdqY39ICWjRvA6bEPbQYAJwUURF3TrpxfMceo8rxs
 E9B1yJPMs7ZTlmbvVNYwJfQNWvClWTqxAMD1Zjq2ob5S7HkVFvG5gm1Z0rcZnxoztHdXEymEf
 A8SnnJvuAI+fmcWZM2jWsJpUXFR1qkMqOGpxCgbssQ2t2d6wnxEfmomana+h07BpoqTv8SVNz
 AkOFgN/XqkucH34zLX5NSDql6zE+jEcPXEZQijoZrvScv9BIYGFkmrh1zsgAt4/BP36XIVP/y
 d3KqntINODwOX0V4l6elkA9owPJfCDPrz/7suitogUY6i3Lyj6EFPa/mKVOOjKnXKAbuYDY+H
 Dlk8acP9vThnmw+Xmndh8bKYuZxW6gSXZDBNLOlrPnAMriM+CoIvmiLW8/zBHesPLOY1b2Ht7
 rcdzN9CXGpUfu4z1P7+NyApV8XqqtFpofKgD/+3lS/iAXVb1lWUDo9CaZWqULuOd6PdT6WpKU
 XIWCiSZjlHU3cveJiXxgR5nnUZlP4poa14bd1hLu+cxEPyaD9WmB7JrN99mPDpeJfFT8gGNVu
 g5av9i38ikRBmDWvkfEK4lj6RGx5fWelH472fQHIZt5v8Ug/s6d0UwmIQ0JsvM0q4FWhgAEIP
 +FDMerJsOy+2QSAiouMEcPLOmYTvdAc54+Uldwcm8iuQzN9KJJx1azEAy0PCJgbOMeJ3XuMhV
 i8NLqpN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the `name_rev()` function is asked to dereference the tip name, it
allocates memory. But when it turns out that another tip already
described the commit better than the current one, we forgot to release
the memory.

Pointed out by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/name-rev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 92a5d8a5d26..e7a3fe7ee70 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -28,6 +28,7 @@ static void name_rev(struct commit *commit,
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
 	int parent_number = 1;
+	char *to_free = NULL;
 
 	parse_commit(commit);
 
@@ -35,7 +36,7 @@ static void name_rev(struct commit *commit,
 		return;
 
 	if (deref) {
-		tip_name = xstrfmt("%s^0", tip_name);
+		tip_name = to_free = xstrfmt("%s^0", tip_name);
 
 		if (generation)
 			die("generation: %d, but deref?", generation);
@@ -53,8 +54,10 @@ static void name_rev(struct commit *commit,
 		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
-	} else
+	} else {
+		free(to_free);
 		return;
+	}
 
 	for (parents = commit->parents;
 			parents;
-- 
2.12.2.windows.2.800.gede8f145e06



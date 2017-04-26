Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BEE3207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936473AbdDZUWQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:22:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:54573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967224AbdDZUWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:22:09 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw1vh-1eAlS53ZV7-017mq4; Wed, 26
 Apr 2017 22:21:56 +0200
Date:   Wed, 26 Apr 2017 22:21:54 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 24/26] name-rev: avoid leaking memory in the `deref` case
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <a0c807b75ea55cf944554f4c2cd4dd4126572277.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wWUX9MlZE2tKlA4d8ZnWvBvNmdo8YbtU4RQ+tN4Yx4+3FJWChj2
 jxN3g5o6bcn/ymlfL7IT3pYCHxJXqdYmfzQlAvopsMCxfTZ/apwef4asknOYzP2QKcH+7ft
 ghhh14iD2Z4BI4ClcXF4Gn02UdCPxCYSXFVJjTEQqoxOv6ITJF4yrUS0Rk4uuRosuNAymA0
 a/o3NKHauGs3kFVYf98Gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ys6XMMczGtc=:QLR7ET/e1IEAX+rrTtoxtR
 rsesqJdTXx6VrMYXk2yFEthKkx1oUx5gtwQ7uBerqCdsvgvLrbdiuW2MfoIXzXLN1axJZiT91
 cLFGimVLvPqC41QqWOi0vwelOsmGz4+Y1y+bTN/1Ovc/CHkj1cm1eyOagLt32HHgNDFs0/whi
 MyAWgMnllVOT/K5/Aw6gUNnn3ztZqXJ4HEThtF/N74XICg+52tvbIQx5IlOD64mpucx2S63j6
 Qajh/XpN+o0zPrcIxaN+GnKD1l2iLt6RY0BuWlcp/dGYU1ChzPs4fvS87ybtQjoahwsnTHxiq
 +Z3o1KeGrKpCw4lSlUeI3T6DoX+2pmMDte3M611bxWIfxkdcLWT/BXyTjLxOJ/onxU5b57zm2
 g6vIZdnLww48CCW9/4qf330p85kwXElPZCLqkhArFz6fXDpOrB+P5QKxvScS6Rb9EtL0OpxZ8
 PQxxvv+i7OB4BiuCJXmu5OAPZ3n/PWUnLe1RS6ALkN7nDuH0Jitrhd/enKyk7Bj8dY09NSRpv
 /63Cvv4Y3kN/GqzBlo3Fs3VihSjQyqJ8KPOT8PBuE+p49FejaccGvwirkAmsjyUXO8c9rsbx/
 Liy/2IK3WQqFE7i4JqczPqetU8Lw2jRUmLjfhe6DKL4RCG4VA27nR2FQWaIspzvu8ISI7y3tA
 feg2HzdW8tHJvuAEYnDN58U54IdZIFxqYGFOX17X43mpww3gRZiFvOvMkMD+HlSVchXPe1xbE
 kahe9IKsNJpveTG76eDdXHkl3fQM/7BA0BbkZmNRFYX+1kOa62cavNQiXp1OT9M+WAcfjtZVW
 BlCPNK5
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
index 92a5d8a5d26..a4ce73fb1e9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -28,6 +28,7 @@ static void name_rev(struct commit *commit,
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
 	int parent_number = 1;
+	char *p = NULL;
 
 	parse_commit(commit);
 
@@ -35,7 +36,7 @@ static void name_rev(struct commit *commit,
 		return;
 
 	if (deref) {
-		tip_name = xstrfmt("%s^0", tip_name);
+		tip_name = p = xstrfmt("%s^0", tip_name);
 
 		if (generation)
 			die("generation: %d, but deref?", generation);
@@ -53,8 +54,10 @@ static void name_rev(struct commit *commit,
 		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
-	} else
+	} else {
+		free(p);
 		return;
+	}
 
 	for (parents = commit->parents;
 			parents;
-- 
2.12.2.windows.2.800.gede8f145e06



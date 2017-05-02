Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D133D1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdEBQDe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:03:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:51755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdEBQDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:03:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MH0SI-1dJJlU2z1G-00DnRy; Tue, 02
 May 2017 18:03:02 +0200
Date:   Tue, 2 May 2017 18:02:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 23/25] name-rev: avoid leaking memory in the `deref`
 case
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <c3f8b61f789912213444364043bdef20cff970e1.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Fe7reeiP4S5KCgAJfRVUMI7YIKecTMtZiXyFRe0bMI3yiv/1RZh
 QC9MHakfvpEtV9/9rYXxKaflOzohUyoVw3QlVkAvYiYi/M/pDhj8NMpRZJotx4lFx8Pn7UJ
 SnWJNf+eF5c1AAynfXKmD1THd+V/Fer6cbWnvZT+huzD+R0U/wtXr+uiy+GxSrrIFxSeQ2C
 ElCfH/ktv5AvpEBX5T89w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pan3RVYxkBA=:gflt1G0fSHNvKPHbkw5YgF
 QVBOsgCcAxsndGqiDG1A/wsnMb2Q6gNErAD9Lt7uvnh18PmJtMCiSUCEzrbPpAVw3/BkoZKFU
 a4AwUQdZtM6hOw4yhqOld7+Y81nscR+H0uAOmHFbLCLfp5ulk8KdSLrdC50DC4IkQfrHvkWpM
 YcSs7P0OfmeYcJVFFKz154myS6R37Ok1Xqd5RzhaMj69TTS7m7s6bA+qQ9k40DXEDA+L/ucg6
 M7Pusdmpjbhf7sTmk6SKd4A3KcRMaYGeWXW4DZb8+nTisrTw2kuNB16BG5S8mFEnrM58IsCDe
 iwJvgXUcr/xaX3XeCuLipiIUhnC0Ji3WTRmKuVTF0TrMw9SbLlLWKdyJhwSMREP+Ywiqcz4L/
 o+zKeOKC+ADhPIdv86VtjTIfG6ZHHpsGg6UNwcCMueHolvpVzNYLDuWl2N7jldAs7BmcjbTXL
 CIos+GIxEDRxndMWfjvdV+iWX5MLTdSxakmjJcZyZsqIShmCag12teUtfAJ7mjRVqcJquTBSp
 VIMA8l1ayNEiqpV9H2AeejUOv7JXCbe1ugL01vwCUHJwcJ8tMs4eEAKHXil/VsEweqHJ++Qnm
 pzL8HF/ij9XGExPVNsKKsv8K2wA8fyJgSZ5KMSwJY+xS1KlWSPTbRGY7gX7HIr0nK734v7XBy
 GiKTmcSe3ZFqS0Dx1YVJ+GQFN5yHg0M7ZbtWV6D9unHh+iQRkVDK5wij2LBQLaP61bIEByOLl
 VljRKg/I9nUmoblewFaZUqAIPZewYTJgjqiknhXAvykcV5mX0+G920pAqUUOiLA4av5I+uu6R
 8UzHJTG
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



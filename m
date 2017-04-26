Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9561207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936471AbdDZUWL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:22:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:63002 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933310AbdDZUWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:22:08 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1dmkPs0sz6-00jGpc; Wed, 26
 Apr 2017 22:22:00 +0200
Date:   Wed, 26 Apr 2017 22:21:59 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 25/26] show_worktree(): plug memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <51890c396683ddc9485a44d50b8ccaf04e06a3e2.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9l9YEWoss1VwMajdG8xDAHI0VBpFt/yIXDGSAychM06ybuwrMzy
 5uTkkovVRacruUCL/obmaHryyttgAO3j9/BKvhNCuQVXt7A6Y38ZmqK6rzQmfxUJzIkJtyE
 BNeICO1pWej5VkwMlD6HycbuIjY7kL3Ppqx+NDS55Pw9bvB3dc57B1BrFdHzbR8Ikm3fk77
 5Hs83UZWlD7BTCkInj5Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y60HYEAylg4=:ReTGrIHp9YpzvqmzniAr06
 jZa7PB1O49MSITgSDuufcOaSSb9fr+5gqJYJvF+pTGA/lKTLAUr+4Fn4xnjOzhRLjP9CDoZMb
 iXMBbzLmHoGDQAWrMhfBSjpM5b/sPPJviJBrfTQ6fhwEoUyLNa9WV+SKqidDZ8X+iCnc07PJC
 RNSGUaDK3G05MmGZKuOA2hHjbqihZlueZ0LKBk+e03TJkFbuV9Jwc28rh5yQhiKXzUu4QWtvy
 Ap94geArNPvmeFI8JpeZ0JIcL/eFWwVOcgIHd4Aihv3oDoIApkszYFrVGAlIueNF2rz9bDcha
 fsLiaNS8u6rKslJgNSmFC0762PkEka/g0g/PI+R+Gm8tfeSOb1INfkJVnvYrv0oIwPkRjvnxs
 qHK6MHKdhKDeSU5JgwDEE9n6Mvrh8U1To0ZxxwtZ23qUYlSarjUyMrMtpzJ3G7k7hFaybbynb
 3ukKuPfKVEyyHQIRXd0Afz5HKWy029Z6qN+FqXHsbHUvl6j5z7lxmIts8R9n9ha7ph4mRzUyb
 eFyXH/DcjlSzEgHl4HoyNsV9qNmziyqSkJzabOws5dFjaHI5a04zdkh0+o5P0Mr/+yZybXcUw
 MOsF5SY40Au/u71Ix5UhWuHiAx4O6VHzPFGZOT3pePP0GVazDltDBF+0kdekRqLICK+P9NkUR
 uo5uZ+PC+nW5w8l2aINa1UJ7yxqopZQf+HsNL2Zet+qOiXaOhfj9aJVDYLfiBzJXdeoKyiW/5
 r+hXDWGoWDL2dji/F8SyFzlB1kR3GRSF1wlKTX99Mwsaz05jMNTLmCqQ3pNi9n8L+548q5vAO
 LIZyC/3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer allocated by shorten_unambiguous_ref() needs to be released.

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/worktree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9993ded41aa..6bfd7ad5323 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -409,9 +409,11 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
-		else if (wt->head_ref)
-			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
-		else
+		else if (wt->head_ref) {
+			char *ref = shorten_unambiguous_ref(wt->head_ref, 0);
+			strbuf_addf(&sb, "[%s]", ref);
+			free(ref);
+		} else
 			strbuf_addstr(&sb, "(error)");
 	}
 	printf("%s\n", sb.buf);
-- 
2.12.2.windows.2.800.gede8f145e06



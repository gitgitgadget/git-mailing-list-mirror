Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D1A207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755521AbdEDN7e (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:59:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:64704 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755484AbdEDN7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:59:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRWzQ-1dUWGR0Bse-00SfvF; Thu, 04
 May 2017 15:59:15 +0200
Date:   Thu, 4 May 2017 15:59:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 24/25] show_worktree(): plug memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <8059540948d52fb613cee1023813f9d48dbe8e32.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:httqpoi2MO7rGoFtoEejlW0sBoceLTXeGJ0Cl99g59FzPH3obIO
 YAZIM9dTloqKQpq+CoGexEEU7opUzOiAZ8t5sP7fBxBpIi8NuB6LbdAj1YnURjFkkFVh544
 EPcaDtSQbQYd1zMd5RZna6oqIWCjLYpC51wn0TTazwoqL77ouiMM58YOdySCYKeV74TB2e6
 Q0gzo8oagTtbY/fw6t0gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pZNmnUgn2ww=:BoEdz5YlQhuZzO8pi/YKZZ
 sy+2lCNm6xC1sOZUAEz4bp7IsTIOZbLHXMyVFgll/nkaXGcTUyKFHyYE+vGvrWS3zj14wE0Lf
 akpybFZSXqqkILQx+ElUUpPS3ufdNUElEaE7WU2qj3LEJaorq5HRF3P5myLeS/Jn+x2APrBIN
 sqWPdP1RDJ8w4mEWHyUUKAYPhjfOq34IXzwsiWYRcLbtJyWoCbtONZFpwgBlvTKGADDvP/1pM
 9+sbhSNSdL9mkYb9L6A1ujGuLdA0kwpuH+Y/OvMc4IAR5BtJ8MIp48PCrROkAuYLBc3C1w4MH
 nB401f00cMwc0X7dwp0E99sfgv7i9Z1Z80IKcfqY+egjvSxxFviqbDz3opUP3biiKNE/lBpHH
 eXXLgFe60HUzRUbMckeCQyVeIfiSTQld8jFDmczMPDHYhIt6Ua8T+5eSBkOGsfGqLWZUhmzx6
 7H7V0s8yRxwK7SGU+zTN9jiCib2LMg9OCgvoL/i29ozCEz158g0Ym3y+MJUUoM8tN2E3up6Bz
 +qGHPySC0zbKyVlRFddwoGi2ApVUuNCf+mL6/4arzOnd8gOU89VZ1/6aOM/zh7Z7ZXLIdkOXS
 IOxojj4dbOHYI0XxH9cc+zUXcNHikq9+8FKmIKb2fCWD+YLUMbieK7Lu6XRlVkWqdjjmXqf0P
 NYMTgjcl4iXfpqgsJ0lRmHBOxNmtvPoO54EvoOppjDiaYNDtKnT8+pk7Eos9+hW3I/Q6kCt4T
 80/fEPJZkmD+eXebCHd0vzgjQEsdL2RPD10GPYqnXw51Qz4A0KFZEVe+TcWOn2gXe112MHjCc
 ri/07n/
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
index 1722a9bdc2a..ff5dfd2b102 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -414,9 +414,11 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
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



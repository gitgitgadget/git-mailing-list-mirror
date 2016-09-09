Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0990B20705
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbcIIOh6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:54879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbcIIOhu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LvlWS-1az75x1nPo-017UPx; Fri, 09 Sep 2016 16:37:45
 +0200
Date:   Fri, 9 Sep 2016 16:37:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 11/17] sequencer: lib'ify create_seq_dir()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <7a6dc6abaf9ef3ea204b63c542b3f5f89d292b91.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x4F1WVb/9cfEzJRl3tdTUGsaE+OZh13MEtiOhYV/rprOoY0wEwp
 V0qe7YogZTyrCGtyaTG2ad1EydUl2A0qGeRiBoVZ2RXMCzc+s+d3WfCNxfyiyd5EsBypekf
 qQ9u+Eip/acrysfxjJEuK30BTy+Py1wqG4Jy9CjEkLizwMzKrSOMaWnOUDqbcPtNdlZiBY9
 +HvyJxWaGAetPlrd/q0uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jWWY4pjZnkg=:H1SXcrKUWEFJs2pFQhUPwI
 ufdwWHGV5NC2X1taBKU108jno1MuDwYdLqjHvz1qc5MBktaswM3TO5dJ5f7cYxywVIVBaZqBe
 1j3vuRiIFPBa21iK2bpdzuC7VSgyyof72Gccuwn9CPRrwLSM7cBZNPSdvMyrzSfzmN97azKXn
 5jgr1qza2L5VZZWLI/ABq7LWcywm9yDdexUU0chyLx+Xwj+Tr3/TKMqXieLQTcvdMGc7vXxt+
 wZIRe7S7OKAkGS2FO4vXGO5OHirSt4O3NSL5znXZ12YR+6+1brRxedNwZG/MHpbjF+j2OVWhG
 bYn7z3zCUuCSKkaSyd88A7s694XYli9LbBP+uZuFyG0EzeKr6oMsalE9Q7Bd9x6ClmLn1LUls
 B0U56UlOHgrdUbsPviEz3PeteMTQs88Wq5XyQ7CscximyVKe6ecFr3nP0NIWG/SSGwGBMLuMR
 6pUZA8NgyTEGW5qB7Voi1nXjiDCOIfHBbHFtc9qrfbRbIrhQaqSJy4w6oDJeBLeq/V7HwrYMp
 50om7M0cHNYck29l6qiNm18e/4kdqmdvptMNJz4qunj9H0ur6dhu79Y9SzLekuhfJx40PEYLH
 UU+ha0ZPqPU+prmXVWXKcu/x8pIYnDNQc9w2wxaIPoxJ0YjQKqQf6ijM6dyKb/8XMrGTkATW7
 NcOA+UEX397nTU7YAnzwtJZFfyMgRCs+96gVGxBw0/nhLaDSytGx9y8A/oOSKvU5lxwJgy9Xs
 1B1GLsCiTYOoAEwPY+64Vvr+cJ3/0PlRWXNRugi7U7Igl6UHGzwChzLZA04kQB6kJRdUJfkUl
 k7WAWfG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of create_seq_dir(), sequencer_pick_revisions() can
already return errors, so its caller must be already prepared to
handle error returns, and with this step, we make it notice an error
return from this function.

So this is a safe conversion to make create_seq_dir() callable from
new callers that want it not to die, without changing the external
behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1614efb..eb9c473 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -847,8 +847,8 @@ static int create_seq_dir(void)
 		return -1;
 	}
 	else if (mkdir(git_path_seq_dir(), 0777) < 0)
-		die_errno(_("Could not create sequencer directory %s"),
-			  git_path_seq_dir());
+		return error_errno(_("Could not create sequencer directory %s"),
+				   git_path_seq_dir());
 	return 0;
 }
 
-- 
2.10.0.windows.1.10.g803177d



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD411207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997426AbdD1OEp (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:04:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:51605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2997363AbdD1OEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:04:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgGDK-1dQbR5131K-00NjnO; Fri, 28
 Apr 2017 16:04:37 +0200
Date:   Fri, 28 Apr 2017 16:04:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 22/25] remote: plug memory leak in match_explicit()
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <235cd51a6a89141ab245ac8ee04d2c90ddfc9984.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6y1j2s2TAI178eB0nbdsjMtpP3pXcp0Dgc7fajd+JLEJ+gihdre
 6qzn29WR7D2xgdPXHeEX3TjhnR0Z5d55CPJgFZRSrFh4/xISqUcjgxZTxyo7Y3E+MAPbF+j
 rgGYU1cHE+EmstF3wPCMp3EdECrQS/miyiDiVIspN9fwN3hdSukrZWVXcX6NgOS9/Xihl8N
 hKoe0o7WUFM+TU/D27JyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DREKNi2XV/o=:vkZ3sS/8+KRRuvurH3wpUd
 bP1jsq2aRhbUMcUcudocoLMqEdEvAJyK+oQQUCKOg7PkkGnTO3r7kPVryfHoBvwkTUjEp5tj/
 OKS71A0Lzw5odjFbrLpmGTwPcR//19D2CMDQ4IJRKuEbFvEB9ON00Ky0BBRbubK6BQWFTim68
 G6X9lq9mqnt1ly7eBc7YWPdBCGcU7T5vm6+DfBtfyaL12bewe46s21KVitdrtKX3h6wrFB7JY
 6Q5a7ysgEl3Ze8XV3WrB6UmfXduU1qeo5EF5LKpoF/DPWJii7/GTSKPmAqJJlu4UXnZEuyLVv
 r2rlulDzfOu3pAmAJ4Ckke3A5i6bhEXjio3538Z7qHcXaS28/v6U622EatsbFFFQaROPxD6xN
 ST2BVTXJjznjxOuZGYPJ3VfnxRkvF/LVT3CthSxVaZb4n6QPbAam3uo/KI7Yu5b6Rf81nW4Or
 KJ3EJR8T1ibb1gyyiFCmBc0cm6wE+s1Gxrzm/Vc7GBTqUur5QVZKuVB96McADDUmou7aqKIEL
 K1nS2x8NHrMPQQzX1N6TVx3zpX0cBy4IC0+uEjiK+s6Y48iZO/C4LV7EGslsjD+wV7ezdlNyt
 S+8wdtLi0G+7FPc9sbOG4ZiYOtbObEnvbT+0xHhzB+0xASokAJEaSEi+fEt+ZJtFX2yCgSSO6
 5kL11aW41FHXTHxq5U4//dkWPMFllCbBDJGI+PNJL3B47gRxjUch8DATvMWBmU+gy8eMb10i6
 yGl+BzbydnDh50wxU1OPE17virtFgPFEf0jdDxZQc6KcEl15fvF4or+dAhKbfdkt4zuuncq5k
 Fdw9Ipr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `guess_ref()` returns an allocated buffer of which `make_linked_ref()`
does not take custody (`alloc_ref()` makes a copy), therefore we need to
release the buffer afterwards.

Noticed via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 801137c72eb..72b4591b983 100644
--- a/remote.c
+++ b/remote.c
@@ -1191,9 +1191,10 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		else if (is_null_oid(&matched_src->new_oid))
 			error("unable to delete '%s': remote ref does not exist",
 			      dst_value);
-		else if ((dst_guess = guess_ref(dst_value, matched_src)))
+		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
-		else
+			free(dst_guess);
+		} else
 			error("unable to push to unqualified destination: %s\n"
 			      "The destination refspec neither matches an "
 			      "existing ref on the remote nor\n"
-- 
2.12.2.windows.2.800.gede8f145e06



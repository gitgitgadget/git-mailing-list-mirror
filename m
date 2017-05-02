Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6DB1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdEBQDD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:03:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:53310 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751271AbdEBQDA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:03:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSuMn-1dXO0Z2iBR-00Rs2M; Tue, 02
 May 2017 18:02:54 +0200
Date:   Tue, 2 May 2017 18:02:54 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 22/25] remote: plug memory leak in match_explicit()
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <359c39c36a234c318b46ff934baa3757fdfc361d.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tfJdM7SRXk1Xu3Q941+14X6zOQFqAN9A+X8vfrPWaoG/Zt2RpZU
 M8GGjCDsznxQbQV4fDMOiVhk9h4NP/23jSUG2RF5eIZDzOT8L1x7gFszSfkbq9vSWMcfTI4
 Gvr+XKoVTba6x7tg64n8urCQ09iS5rABThZmIauIM6lEoKH1m4hjfSm84+5TEwAW9BPFvdD
 LM0ZKmHc3nMILkzPkd4nA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ehBAlvsh1vg=:akErjqT9cYaYyCIQx6nzdW
 cHSD+0oc7T88cxEEkqoIykzefjIXbnoJ4jRNInPHPJN/gV2i0uZb+UHpaq9IwpHGr+GZYvCe0
 RlijZKybHeRqspSZjQO2taYN2HRRulH+z3VyyqqAJt7k0Ktt1ZvsLMMv6iOcPV0yYRXbqkGlF
 XmvEdR7/Lu8DCwBVTKwe2csBk/6ukQJHsWj6WvM1lHt25OcnPIGXVnZ4b5qIkWvLqMQoqpiXZ
 SqVGGz5dhdUQK+WMqrHLBDFhQrBvLKpY6/MwCDAzI9conrELcB3VgXTzzNX+HOD2luhlBHxIa
 1vuEqOy/JkDgUAU0xQ2Dp62e7z+mK8vB+Djx9AVdDQxeSg9OlnkCjTM36+M9uX+RFaIm3d85L
 c3s1o8EO9Qow+yggGASr1eZGWMEdl5SCCt7sKBlvnj5FSQlEIMXOr5NC2yL8wdUcd8PktZ2ak
 P4r9UXgeyKq2mAhz0NZoqjXxy7n3KocW0A6Wp+bSR6iOZeLn6STDS1u47iCMMOcFIxZYoewUE
 qhdhmO1T7Os3tG8Tqr0YXEZCHH3nUlG8Xw8VvDGKPSmveWXoR6+vpBSQmE/cFh5iQmYYwTEAm
 SFKi6GC1SwhC6iFglmSM7Z4DD5G2xfK7jGI2h06+buUQQPEnTqevjut0qYNaAWcIleye4oyfY
 QJvTATb6ODcEfZnpbwDi0zcJfAkdQzM0InAL+SWCjZamUSJHMOY/nrNNcLutalHJ1dyMzbR+y
 VJAp85TRQUg4Qv82rGdfskh3MGCdv7sCnbVQcjS+51jehc8gRv640gYEwnGpvma/7abGhFdiP
 bP1RRFa
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



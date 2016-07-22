Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE3920195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbcGVM01 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:26:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:56462 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbcGVM0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:26:24 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MKIEQ-1bR81u0lss-001irH; Fri, 22 Jul 2016 14:26:16
 +0200
Date:	Fri, 22 Jul 2016 14:26:00 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 16/16] merge-recursive: flush output buffer even when
 erroring out
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <3559f07feb75bcfbdab50c756207eaa44df5f4ad.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0aQnhx2lP7qFI1/XLuNguoTket6O+tBjmh0qFvB3ydYsmt5dTUD
 gtma3MMz49Dz1VZwrsdF60c2XlmvvOqVM0BtA2XBGjsL/ne4GsNUc66ji6wOdBYsXGWf9j0
 gjPkQt1xlPAe4cOxstzdzAf9J5c4vUEHXg3d737Q0xzFZ1J/tmxPxKatFLpg2p4hNB1Np1W
 DSSHx4uIPWBbDnvNTwo+g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:zrXerTiA25E=:yiYqi+6wm2aTniXli1tyMB
 BxmZpOpWDBTVABnyItgEyMi5bPcjkeVhI4xJYmHntVI6wAuLEBGwho68mBoixc14DY1ULI0vu
 rFbHlf/khftrOP5LfTUzKzWwyJND6xbL13CLnyzVrUjrjo9kbeW2O/OVb1Hct48LXOt/zPS0b
 7cWofsHpxQYMNTUUabXB0Y+Hzr77U0cVaks4JWBqqlojTMp3JI2/hVWTSq9LgCEmB2qtIlHSE
 r9T4YXCzLjg6ykR3+9kxYxTwzJ7x/QEJXd+ALUJ5gQ8vT63vtUD6cwAzXGLgnnVEFZTx5wppd
 HOjUthBGQo0S8qdOngwnbSYsoy7+m1ie074Qo8PenRoaqzYvjGj1h7Yec6sFLYgGgkilojk37
 U1EwT5RdfbstPGz2jKMlpBPana7y6Fwh6EjG6eNVRw4m+0KMTTGcNoKfyIhNR1zeN7KDB8U+B
 1up/Fiz5yfz18b0USP8UGUgo5/SMEFTCRiFdHebemmevompjWk/2MoR25FL2zv4X6cLon2wgJ
 UoVDze5wPfg8kZZVgd4lYHQ6Y8dsmHZ0wA/PfdfO5JojXWBkYmssc7MupDlx2Ib5c6J53dm8z
 ncN7qqHyOgCOkjhei03I4td2gUrxmQFiR2vOz+TE157yaGtKZDNye+D8hUM+dNYcbsLTn3lHZ
 lKaRBubyVf/XUk/K3HWE6P1znP59WB50OfXmBkyyiRS/fJj8KQDP0kjfLRTmqSzitVxGOvP28
 SHdhfUR+EjG8LGmVe5V9HalS7bLTw88YzdG3JEsYE/7/L9ipqnMDbio0tyqr5IEw7sStyuqvO
 YDRfr2p
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ever since 66a155b (Enable output buffering in merge-recursive.,
2007-01-14), we had a problem: When the merge failed in a fatal way, all
regular output was swallowed because we called die() and did not get a
chance to drain the output buffers.

To fix this, several modifications were necessary:

- we needed to stop die()ing, to give callers a chance to do something
  when an error occurred (in this case, flush the output buffers),

- we needed to delay printing the error message so that the caller can
  print the buffered output before that, and

- we needed to make sure that the output buffers are flushed even when
  the return value indicates an error.

The first two changes were introduced through earlier commits in this
patch series, and this commit addresses the third one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index dcf1535..501cfb5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2059,6 +2059,7 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	flush_output(o);
 	if (clean < 0)
 		return clean;
 
@@ -2067,7 +2068,6 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(o);
 	if (o->buffer_output < 2)
 		strbuf_release(&o->obuf);
 	if (show(o, 2))
-- 
2.9.0.281.g286a8d9

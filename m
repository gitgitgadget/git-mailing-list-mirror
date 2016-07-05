Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BABC2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbcGELYh (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:51503 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932926AbcGELYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:34 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MRocn-1arcEF0fiT-00Swpi; Tue, 05 Jul 2016 13:24:26
 +0200
Date:	Tue, 5 Jul 2016 13:24:25 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 17/17] merge-recursive: flush output buffer even when
 erroring out
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <aa1ceae751000820b6f2f577646bb3db9f165bb0.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MJW0ivxG95jceJ/DAWT78aPICRVp5wdwXO9DsV66v25voE0y7lR
 5aC6oGg4oDjaX0IP/OHcjENRPKDaCT9NbbboFF6HErTISetihABoymdK4DHC3yKOVqBVoKh
 mBwRTpjYOfmi2GRn/xwaNHBdjZG8Zs92MnKQP3mNtVfqgqvwD0L0G3WpS+ZYoyWbBDaRSy/
 FMGlIboL6IUrE64OGHzAg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:p6fXF8pUsDA=:7Cpe9eqMUkPEEnpY0dflrT
 2BX+2TOzPAh1zdfHhHETA+dwodNN+bfv6k2/BRYo1I0bw4CzW9f815TZeEo4Zkb7U/90fEdQW
 WdOO92ZanUpVUghvAEs+tJWhObrA0xfjkQadg9uKFQwwGimE/ckM2bQQF8f1AoTIFr5gktmDv
 ifet60Kyc/sS9wSttvFis128l2p/DKBoMFNQgNl86U2Pj/yCS9rdMgMAcKsgOMwR5w0I8P4Iz
 DTPMgCZ4vtxBDlQx13XHRPDswBVGe/O2FixAh+QM7PQzC4+ZmKOobshLD8Vlw3fHeub7gOGuQ
 Pa6mFag6m0x9HdQjrRGsXPvSgZCrgeQY0Dw+OCvDCAlWP02NZKntqsz5Pyze8LF7WRHMAwIBt
 vGT540R8NWopZfhaupdZ1Uw/X/R7UFLQ0Et03vxaKcQtSv12LfB0i+VR3zsTpVmkBsallkYXc
 liHz5jRmgWJZtZwn655bJBTD7PgLvl2gQ6Icxfi99n96CxhBxTxLmjCyLaphlqcv1JFm9T+JE
 thZihomD2KG2OUqlc1rJuJtQuj5q/dh4g8Dho2Ejc6rLNSLrfqcsKOJeDhfEiY5F89rNF/bDS
 LcnZ6yxwYXun+6D45jf9jpY0Ag28yrGoTD4ht84WrFXboXqtKj5okAok+174CUVhZsw5nwsSG
 3M/bDW2y+Bd5/D8+w2qfJMJlgVqDfUzyV2uVhgcgJ0K54u1N4eh4/dtwkiM+W4zczwn7Cua/u
 h81D85WGnCYXXwf8hIwMACf5IUni/EY2jrvsfAkjjHKWxhGOs0DWpi1CJEY0VAzFBWPcQyrFk
 VIjW3tg
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
index fdc624a..d94f853 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2050,6 +2050,7 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	flush_output(o);
 	if (clean < 0)
 		return clean;
 
@@ -2058,7 +2059,6 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(o);
 	if (o->buffer_output < 2)
 		strbuf_release(&o->obuf);
 	if (show(o, 2))
-- 
2.9.0.280.g32e2a70

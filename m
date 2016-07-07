Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE9E2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbcGGOgf (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:55309 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbcGGOgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:36:33 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LrNE4-1bQhCR0eom-013AaD; Thu, 07 Jul 2016 16:36:19
 +0200
Date:	Thu, 7 Jul 2016 16:36:18 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 16/16] merge-recursive: flush output buffer even when
 erroring out
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <bdf1cccf96cd3b9908cf170d6b71f10411ab65bb.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V2h6tpPQmYdj862VRCuDkC5ZLnzvuQNE63Fs9Ma/sp6tswThXIu
 V3uNp26R2XCeIZXgUssfHP4itfSyCxQsJka5+E8ElaCJzc5yKZ7Ht0ocwmH+0MeJCxsV/iD
 9xhIIf88OkNyyuurbBLZtW/xvszBPlPYwMPTCG9S0Exxj08U0QotBITG8ZwXg40pF/sezaS
 VnRj5YD65ORFLacn1EQIQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HbnIWLaWA1Y=:JlpdR80XIhbKyIiBxdurDe
 6GstmdKlZZyz6rKh3Nc8HpyRkxxo8zjkudXngv5qISVAREaYgyGbGX2B+8xRTnPfLlr5J4qRS
 i+fZM4q88IRGZZWUWAy/b6LNCg20nlOuCooQkIla4vrl3rh8zuW2rzmytxZ1sx30Nw7JuoO6U
 7lQAJobvqltQr5o8tuo9qHJ5K5myxC5/cFbPvf5etuNs53hn3CBqI4Y5QTLOHbHN3otavFJE1
 sVRDSZJan7tjjI47R00rU5zW6kS9zIJ42qY9DLsRflzmy8lIbe5EmwldMuB8kDFUlSA0Dd79W
 u50xNJOBEl/dsZvCGHMrDzYsFjWP1iEDe9FD3E6OdmgMKK9QFCVGCktVsSTu7hNN6IF/ey2cw
 68y+nYqKvLHotkP5s0PAFWvB+PONlZZz3N70guaechwUAaFvNK777HgqDyj7ml+LYbVVP9SZO
 uUQB8tpvy2zh9jfGgal1tcHquCl2hhUB7+0atZvzzcbQIau6RCtZBfNH6ImirqY5hDcMtt+2A
 fHEGBV0G0TfnJENi89yPoHXnfqvPUhsTBvfWHNzq79wk5Pxj6zd0ra0r1u854kBowfkU8vixl
 6fjod/0JRx5GfOWsr7BAocu3rQG1f4vj8qPzPM/DnTTkvtORq1ZtEBdoFf7tSUXjTCt+z5JaG
 WmMJpzpYBSdb562eifCwMzkAfwH7I15MIWUMwz2pBqbWrXtOjNPjzo295niBSORoxAtycYLiM
 6jQWdNCPXxWGjXXM91Nq1io0A7AZgCOYPQkICZFcsM6GvV5bZ08enYyuWxxC35ZYmdIqvrMf0
 KASSDVk
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
index c0be0c5..cb701ee 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2083,6 +2083,7 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	flush_output(o);
 	if (clean < 0)
 		return clean;
 
@@ -2091,7 +2092,6 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(o);
 	if (o->buffer_output < 2)
 		strbuf_release(&o->obuf);
 	if (show(o, 2))
-- 
2.9.0.278.g1caae67

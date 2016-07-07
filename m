Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6792070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbcGGOgb (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:52200 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbcGGOg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:36:29 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M2WgT-1bc0wF24qj-00sPKU; Thu, 07 Jul 2016 16:36:14
 +0200
Date:	Thu, 7 Jul 2016 16:36:13 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 15/16] Ensure that the output buffer is released after
 calling merge_trees()
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <9565962533ef1b88cfe33e9ab668ee2c5c531adb.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wy7P6TH/P7eH0/aHSTpTFamNewrO0biHvWezcVl4MW3DNOPt9qa
 BXNYuYMPexTPTSkimozoqmURoo3Li5YN2vRfKR346HLSj6Dm8XhF4CxmmYaiIZPaYmLLXKc
 fG4kPv4Jr8YaqVdHIIiXtucEpMYV2UzARcG77+eL6EiePO0rr3imMUB1iUvO0EgYQ7+NMlZ
 xsDPAZZUUZQSgnbcz7FGg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:IQJE0OPhGfQ=:/CaMbdAut3L5tLZ7D6L02R
 l67Ufkkn3M9z7ipMiD5Uq9rZqvUkdAeMjuPUORluw69ARLzzpdmRnyMf6TYzll+iexYSVUeAg
 v2tHpLa7gL0nuTSooU0hBoPjmlfwfStnL2ZNRXGIds6KlX6dXnjWZyWB3kwRF4y3vkcgGa+Fx
 g0YwgFEY+i/VOVh/b1JPVNRdvbgXxL+mJM74tdDGtMXXAPfrLPkNwkHBTBYHpPuNmKvVevgNu
 6ULHy9oQbLBHDBSFWIVhKk+c38Io8RCQKj20aeJrVLAvOps5wMFkRwT3yG87V7MKqQdvNAC7U
 FLSngnq7P/V3Y0GLY7yCBrCsURLNpXBjZHTOPomINf8yo/nHtTAxmCzW2dEeVFgKpXArpLRit
 h3MhlmwTFUKCbCF0zKa+Ks9n17AElS6fJeP3+z37JMAkDxyWEnQZB+JYWV8eiY7ofKXBm1mal
 bbvDiS6XUavLxuGxRo5tAmBixJ9M/AE0ZuGt6Df4fXYUPj5oFb8ttNkBcX0VSFI40Jfdi3w71
 zXhlvCJk6b1Gkg8H3cK8PsPmeHq26bWkHz1/gyktVGWCJwEzwEZLkaTH0dbpAE4IFCffg8+Ma
 md3WdE3vAyk/MLRG6vuxEaMhylQBF72r3zXBhnuWWNKGxJLUzHweOBRnhR8v/ZBcB/qivnAnP
 a+qfURkHcbVM6qYwIDahShTbkd6+BREYXRsooHjWmVpBzkggPJunn/ivPuGllbRzWg3gP6ZJj
 rUlmpzrBZf0XHG94mn90GsONWmio41XqO4y6Y6pF6PTDOWNcwMATnDRBzfo+ieKvUH0WRVCWj
 afa5C/J
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The recursive merge machinery accumulates its output in an output
buffer, to be flushed at the end of merge_recursive(). At this point,
we forgot to release the output buffer.

When calling merge_trees() (i.e. the non-recursive part of the recursive
merge) directly, the output buffer is never flushed because the caller
may be merge_recursive() which wants to flush the output itself.

For the same reason, merge_trees() cannot release the output buffer: it
may still be needed.

Forgetting to release the output buffer did not matter much when running
git-checkout, or git-merge-recursive, because we exited after the
operation anyway. Ever since cherry-pick learned to pick a commit range,
however, this memory leak had the potential of becoming a problem.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 1 +
 merge-recursive.c  | 2 ++
 sequencer.c        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07dea3b..8d852d4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -573,6 +573,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				exit(128);
 			ret = reset_tree(new->commit->tree, opts, 0,
 					 writeout_error);
+			strbuf_release(&o.obuf);
 			if (ret)
 				return ret;
 		}
diff --git a/merge-recursive.c b/merge-recursive.c
index 10d3355..c0be0c5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2092,6 +2092,8 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
 	flush_output(o);
+	if (o->buffer_output < 2)
+		strbuf_release(&o->obuf);
 	if (show(o, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       o->needed_rename_limit, 0);
diff --git a/sequencer.c b/sequencer.c
index 286a435..ec50519 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -293,6 +293,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
+	strbuf_release(&o.obuf);
 	if (clean < 0)
 		return clean;
 
-- 
2.9.0.278.g1caae67



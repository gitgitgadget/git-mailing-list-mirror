Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCF42023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbcGELYe (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:49700 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932694AbcGELYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:30 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M0yaB-1bZzsA0SI3-00vC8L; Tue, 05 Jul 2016 13:24:21
 +0200
Date:	Tue, 5 Jul 2016 13:24:17 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 16/17] Ensure that the output buffer is released after
 calling merge_trees()
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <d4dba1424f5c4c4c735975606d041043c1997b37.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e4NGJ9T0TonoHQ7veUAkK1iJ7ZxruXw6bNUJAUxI/iRf7jWBFg5
 tpzflsKGPrud96wa9cVEk5cuFcvR48FSe4edFsDPLj6Fzda97iY8rkUoWQ8QN8C/2V3db3w
 AB4hdCeBbhseVAei2Ss9VACO0wUvFf1WYBiAYWCmIj9DMlmVkXlocpGc8OMlyZn8LFn5pPg
 Qnk2e3X2lCdU1H5a6rklw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3FgvqyqKJzo=:/BsCtuDCH8ZTNP/OO3SWhZ
 reWJFjOc6eZp2ldxC5d/S6LjIwMA4xAVlitgqR+/+Mst8nwwe0xu5Mftuw28xihUIjarPwjmG
 eNE9OCZBF+yQ9j20MKG6FmFW54OjQBvhXeBC7nVx84wc0CH0vsfKG3gIR1IIHs9vInDxGERvQ
 n4IMCOQgCb7PNXzDRxNEo83iMyinXY/gyC+Zbu6Y0vRYhOwgWyD19Lkjd3HVA/4XBTUTFW4Ba
 PIxK7jO6qefsMll7mZHyCUAG7C4eQ16JY8LynMWRvt/aEn6+hIvlMOthgOpD0R0kppExoSTF4
 cxQg3G+Xljq0ogx/SKn3U7Fsno/A51N5iAt/5pFjj3kc97Pk6WsFBCKk8vR860Gp1vHpFy35p
 Iuh0yKLV/ccqKDgT8tQDq+Zib/DdSARUPfmAZIZdNPh6tVjqfhbrM/3pu3+w0VAkns5ZKcdVS
 cb87tKBQbgsmxmgAMgi4of1abz5sL8hPofdyA0Rfx/qgYh6+q8HqE6/XVUTRamXtGbdbyaWlh
 TY8tdVrYb7DsE/O4N/x3ysKBV2hm02/RakiOiUMNje5AOXLT0oRBbVBSSyotu1aZpZeCeINDy
 b47gwsPeUKZ6uVrC03d/DCtCAkhiigE5ub8kpbTWTZJIP8sQwjLqkVxbQk1DOnnK4IHHsO+Na
 CcEbP2Fhn0m1dTD1iqMf5cdRclrgeKtTMQeAJTh+VKgfYn2Lr8uHGLQ8LMVSnRO3DYnHHXGLz
 CSRlXuKjxIj5jsrZh1majNDroxabDsSNIaMAKjTqN0u4GZlKzfCAlCOxJY2Ja35h3TDZqv5S2
 lFpkmhZ
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
index 14312f7..ced4ac4 100644
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
index 29cbdac..fdc624a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2059,6 +2059,8 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
 	flush_output(o);
+	if (o->buffer_output < 2)
+		strbuf_release(&o->obuf);
 	if (show(o, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       o->needed_rename_limit, 0);
diff --git a/sequencer.c b/sequencer.c
index 13b794a..8ceeb1b 100644
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
2.9.0.280.g32e2a70



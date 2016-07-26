Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A088203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 16:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116AbcGZQHL (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:07:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:61290 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757093AbcGZQHG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:07:06 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MaV3V-1blfAZ0ucr-00K9yk; Tue, 26 Jul 2016 18:06:58
 +0200
Date:	Tue, 26 Jul 2016 18:06:45 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 15/16] Ensure that the output buffer is released after
 calling merge_trees()
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <a2af8827e4df9f1555821111aac92606496006be.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UFoBNwKmEKrADI8An1ni6Gy9J70JhDk9ZDCNj7yyc1EZo0NuuGF
 GQ3FehA0CVmRgwP8Z9j468PRInr9O51mZLk8OZymC/klDSfh1/rDRNPyfs8ysTNtPf97rjF
 OwavCuK9fFEIk2clkAwVYQqiV/Y3paleeVZ9WYSPNTaiLiHMUJfUbU4382KENO1JH+Nv+6g
 W5Oo5c1mDOEe4Xlcbq0pg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gv6l0Pv9jYA=:zHcIPaQbu3izL9mXA/BzOG
 FkkgbQecCIilGtL6YHko1AJfnTRYBsIFzFixfCAWxauW649tPuJg6ir9+Acu4Ys1au8QqH/LF
 cc7RWnbXfuugAfG7wObqo/1QUPIvuP8deSefMDBejCyQGKGnRYebpzvD6Vx3ZQw2O+toIimHh
 WtCvWQbxX/T7bqkykuCqf+lJ9yciJYrtjaExXEsY910K4fDsab5kOJhuHmRVzT9bYcKi4zqB2
 5KdSxSGpEKghnct6Ra3SqCKcmmblmNFIzR/gko60f8R84u602jEZj/YbYEgfGaFOijZLlO7Nj
 P7IZ9fWAit6OkVfn1jGwHUIlpqbduLRHkPrT9zihmw8QhNlTso6lArThY7mM6zPGmGs2/hBZ7
 DLWVVaeGy020EmQD/Lketd/wwt0WEkOqaQR02u4wEbRZMDeSK1zcNyIONoiUsTmiE0eFUG64J
 UtaOrLbvIAiblINtoKL9tODPfHpnmR7Mz/VHQyr/hRiB9kg9NMZ3uWNLIIjunGdxB8cIEqr7Q
 I9l0Ao1gdZ2hcvI0ReVBLUn8QdLz8tuR5fErOsDzBhKjnjMeZg3tjpExmeapN8piVL9fkxLe8
 MG9ggNFygPOzd8R5FlAeDiZUzL9nILYAsu3XO19eN9O57M7sESluv04gHfnYdHSa16hUaGF8K
 R65KrCg7lo9xNBUfcaoIzQbWqfGX37bNiVga/ZKZvLqVEnt5qaqLrFE1o5jRnQ3PnQ+UACidm
 dqGyLuUl9SGYrypB75KxPF9UV7xgNbGZXku8RUkGFNdxcINuXmqMM+ZEyuuSDM7OPzUjMMGXr
 p8IJv67
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
index 311cfa4..a16b150 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2078,6 +2078,8 @@ int merge_recursive(struct merge_options *o,
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
2.9.0.281.g286a8d9



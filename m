Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087EE20195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbcGVM0M (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:26:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:62040 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbcGVM0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:26:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ma1tv-1blHRI0DXT-00LizT; Fri, 22 Jul 2016 14:25:59
 +0200
Date:	Fri, 22 Jul 2016 14:25:57 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 15/16] Ensure that the output buffer is released after
 calling merge_trees()
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <cd008d60b4b277c42960148d359c2d1465b32734.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OtUWjhYVV8/2pp7S4pVveJpvJO8iH+5tYreqcGOsW4kzEq968WS
 DrQee42zjY6EeJ2ZO5w3/Q4EUo7HSvD/z7AhQr45m+rq09InZP5wquMu3QR3dB1AzcDEcHa
 +rFuscQp94TUFBZuRck6futk3etBa63y7XhlAr766yyHcHJStv/zd0j1iJg52YbFr8T5xIm
 nM4g8TnbaGbAnMTtrMpog==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9lNjTQrD08s=:s3zyBIrA4kscNqVEPE++c2
 RRlA8DxcAp87fEbakCEp6j5kXpZpjzc+qTlkmQ49ORX98OwGtoBGRB+wiEslLBRtQ/eZDBrI6
 SR9A5BPG+yh7VOcMQhB/QZO2fisHkIZVMe42cHioBOz/385G7XmlWDag6J+PUxBS8UAWRdH1l
 Tmvjxm3hV0Ln+PRDku9Ml+u1XrIqjD5YhDqk2MtQJ67wt/vjPNEpZ0CrLhGVsvHLGHkSPEIvJ
 rydW0R1H81FvZv5915DIqr0RmF1w04qJx976w9O+pVHhrxR1ouYTqg4RsxRPjYpXcC45a/vIk
 qFMPF+CAy5MeFdHY/KUUn1LPjc+TCfmFlyO6Ers8qwyt0ovHBzwbIyNsRmEMSX0aWvDm/q8yL
 CHWzPrJIEg8FxbDMfk30IPdzme083N/BB/CMs2i6s20M96vhh0YKd50MJEkItGVnxPANyupy7
 3cJ/jgTER5vh8v0JXOOWRDG/R0r34ljFlBEwTXTAYbk4rdFGXsLVzIZcN6+M3rCX1i0HJNUET
 xMAagEW2NjPZwYuj14Pviq42cHEVE1LTKYziFxBpWJVVtKE8yD3yevMmnYtemtrfk7dCgHQeo
 mkONxVx/y21D115C+gmUG3hOpC/f/1bRp8Uo1mFIHcGsYGEdHOdoiXo8SX/YuTyZr3YvD+hAB
 NOu29mhls3pieFJuztK8SbwDS9SXjfW1YfwIJSgGw/vnSilf+ifvEPjbhc+LS0Wtx0HROiRnp
 5WykK0T0I4JgPr0b1Pvq3xv5FpFGy8mxISeMF9Gz9ECyu+vpq1CrROQQJaCsRTBqnhlljXwOa
 dYjor3G
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
index 1746c38..dcf1535 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2068,6 +2068,8 @@ int merge_recursive(struct merge_options *o,
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



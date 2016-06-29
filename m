Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0A21FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbcF2LhE (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:37:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:53547 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbcF2Lg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:36:59 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LsCdj-1bTP6U1Qhb-013u4H; Wed, 29 Jun 2016 13:36:49
 +0200
Date:	Wed, 29 Jun 2016 13:36:48 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] Prepare the builtins for a libified merge_recursive()
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <753eabc5193c148c67e64ed5d070b6ff08f51d82.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Rzdk5Jdx+PseuOKoWclzasMMiMofkrPJui8RV+v1w45IrEo5BeR
 +VO4ilIZeSrIeR7qBq3rjUiVcWiRuGdvKDCyKfHRLcOFuBnkp7Hu1mTCiQqzfUcEUxxqtyk
 bCUzJgVOw+DjQwP97yUVckPk2sKsvyT+Vyk0Nsv46EvSuRZ/salGSXtdjo/toGgwtCAy9mx
 0woZ9uIEv2lY4IZR/EMeg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:8tL/Uj30pB4=:lFDuRPnr1/qEKMviVKLvMy
 abYoTAHIOBKVX/tYlnrkMoNlpOt+xGz0Ze2ea/skCzDRUF8uc2zn9+ZENefvVLGoNQ40/DbY6
 u0T9KKNQJ81pLETLftTsR/XxHy01U/DTzsZeyHddqIRRd9QgYh1gXcog0eJN7FaHHo+B9XM0s
 gFB0uaTUJTPS87C3KE7uOTUOT6zCJH37qdQiQ7XPPA430Ii61kjto6zAQxMiT+Tt8hP4Tgm91
 naYF0iuEME82NUmGLIw8iryBQrjkWy7UiLinfdnMwOow8ajmZEUDXffCIXiRH0N9c+X5/GVHs
 IIkUsiHLtDrAlFRAUmlEvYYDqqSt2okN2ixIFEUSflKWvXY1rpGeQtCyadTrJGhfI31IOo6/g
 QxzdUxSd0nwma7wu+Xt2XsAdwP4dzKLW41u8+b3fhTyLB4KB36ZK8CQZiwIvsTo89njMb7qB2
 nMGCy5RyDLC+1wTdy45gwD66XuIrE1DwPJbekSEZS4I25xlBx2gdzPH+z2f2G0eB3j2l04ZEF
 OX+daEamikkTjHIqm6fNUGCRr5l/kf75LX83UrtwNGYv5xIZEBIIaOAzkzJBi5dIjqsZTl06p
 56RYsm7yKqeJfUklowsm8fGwb71EaZRNckHvq+4NSOhFCubBwf7mXGQz//jeKp2DJFoyz3JqU
 0t5izMPNXfcKRTOiREMcf0t/60QjjJxFVWnKo4h2UPZ7wfzJB3GLKHs3/PMV4nIAR9vwS0zTQ
 wHqqq0uWj8PDXZ4XUKpyOet22IMovkPMtuxbzQyWr4HVKtBtXednhpMjM4GkRelWrgwWsMT/Y
 OiTjL5H
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A truly libified function does not die() just for fun. As such, the
recursive merge will convert all die() calls to return -1 instead in the
next commits, giving the caller a chance at least to print some helpful
message.

Let's prepare the builtins for this fatal error condition, even if we do
not really do more than imitating the previous die()'s exit(128): this is
what callers of e.g. `git merge` have come to expect.

Note that the callers of the sequencer (revert and cherry-pick) already
fail fast even for the return value -1; The only difference is that they
now get a chance to say "<command> failed".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 4 +++-
 builtin/merge.c    | 4 ++++
 sequencer.c        | 4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c3486bd..14312f7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -567,8 +567,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.ancestor = old->name;
 			o.branch1 = new->name;
 			o.branch2 = "local";
-			merge_trees(&o, new->commit->tree, work,
+			ret = merge_trees(&o, new->commit->tree, work,
 				old->commit->tree, &result);
+			if (ret < 0)
+				exit(128);
 			ret = reset_tree(new->commit->tree, opts, 0,
 					 writeout_error);
 			if (ret)
diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1b..133b853 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -682,6 +682,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		hold_locked_index(&lock, 1);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
+		if (clean < 0)
+			exit(128);
 		if (active_cache_changed &&
 		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
@@ -1550,6 +1552,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		ret = try_merge_strategy(use_strategies[i]->name,
 					 common, remoteheads,
 					 head_commit, head_arg);
+		if (ret < 0)
+			exit(128);
 		if (!option_commit && !ret) {
 			merge_was_ok = 1;
 			/*
diff --git a/sequencer.c b/sequencer.c
index c6362d6..13b794a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -293,6 +293,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
+	if (clean < 0)
+		return clean;
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
@@ -561,6 +563,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
+		if (res < 0)
+			return res;
 		write_message(&msgbuf, git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
-- 
2.9.0.268.gcabc8b0



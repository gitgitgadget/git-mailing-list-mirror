Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A51E20288
	for <e@80x24.org>; Wed, 19 Jul 2017 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbdGSO42 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 10:56:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:57102 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdGSO41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 10:56:27 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHH3P-1dSZ4o1q9z-00E4h4; Wed, 19
 Jul 2017 16:56:21 +0200
Date:   Wed, 19 Jul 2017 16:56:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] run_processes_parallel: change confusing task_cb
 convention
Message-ID: <7151686aba3c5254bfff35bfd7cdd1d48992e99a.1500476164.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/PHEj8k1OD9uFX3Ni8teV4+P/AvbBgwmBHB/0Ud6VzGp8uE3Ulq
 X+NJoBANxIJ3MMQCr8VmDe2FpDouP8bIInKXFrkpXZGtrGLhPyjCCKXOfYN4wb0+/91y2Ff
 LI+CE5n0hcmQA9c0iOnWx10Lvn3F9gcQI7X8E4MrENaSkANsCzJGLAbLWZYY9J6NCkBFLTx
 /71inh5LKHjDj9w6Yxs+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lUGfSZeLz9w=:vhENuulhldMIjECBrA2fKk
 KypNE4lvv4XcRyctWjSXa1CrtT6qqAZs0EEpxUt6tgDJROUWynNotmCG89X8tiL+vZpsNv54i
 JcvqnEIyd+qCVAHkk2PbXQNfAvlws8pHi8maSNtVjsrZErh76FxIRYwHN3bp9Lmn41mtzXx/e
 woohT9+9uJbTypMol7JYmnoja7DTTxZjQ91YuKV2LX5mhlKJ2CKF4B+TylY5ft4EYkrHLMnf0
 AHBZh8HTQXrYuLMrcHPMUAHjyMnPvLbtKC5j8jSSoUfxYPXlOLsj54ghh7JgjTdC5C6yQgfAR
 b/RmXQMWiOjobGNLo8K1XdGhiYLej+zaOJQesxO8X5K35P9wDIfe0ub+lcAR5pAcWB2J+Ipq1
 9mV24KEW3/VUXWTILYmAeBF5xH+YbfUDAI4gZSFRS6jedtf4dRGK9RAyeQFKj86Mi9eJ9iqpr
 ye9AjoXCidpg3MYkpLH67e9ZBteKKVtKJJeqiekUW5GEC+/KEfREIr9wTCDi72BNHvsD4186K
 IKv+M192ScpQ1TXSP9SyAelh2y0ZzLLJDDfDcqYfdGYxpog2lTGkNcyb3Wc2odb4Hv3fts+hj
 +2kizjpblFWFnEWZkj7h5SZimmSNdA1gNX7Nz3hoeFwW54igrGHj9hoPf/pn6Am4hNOf+8ikq
 0O2upXxYwto8j/p43r30JI4XPPwYKkuuPrQMRr6eRQ6mFgQUP0W5uuaqF1jJa5BItBYHriKNt
 y8pbiWZUoOkSIcRsbxtbbCriRpWoQeLBqG/H2ybfpoh7S2IgBEl7++Zb/+DAEKYEpZMWSZgMW
 tlIiv6q7DSmCWAZLchBLMe5MfJOcp8H6geJOOsupfbGteAW0Ag=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By declaring the task_cb parameter of type `void **`, the signature of
the get_next_task method suggests that the "task-specific cookie" can be
defined in that method, and the signatures of the start_failure and of
the task_finished methods declare that parameter of type `void *`,
suggesting that those methods are mere users of said cookie.

That convention makes a total lot of sense, because the tasks are pretty
much dead when one of the latter two methods is called: there would be
little use to reset that cookie at that point because nobody would be
able to see the change afterwards.

However, this is not what the code actually does. For all three methods,
it passes the *address* of pp->children[i].data.

As reasoned above, this behavior makes no sense. So let's change the
implementation to adhere to the convention suggested by the signatures.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/submodule--helper.c | 2 +-
 run-command.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6abdad3294c..3a3c9ca72b6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -930,7 +930,7 @@ static int update_clone_task_finished(int result,
 	const struct cache_entry *ce;
 	struct submodule_update_clone *suc = suc_cb;
 
-	int *idxP = *(int**)idx_task_cb;
+	int *idxP = idx_task_cb;
 	int idx = *idxP;
 	free(idxP);
 
diff --git a/run-command.c b/run-command.c
index 9e36151bf97..b5e6eb37c0e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1533,7 +1533,7 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
 					 pp->data,
-					 &pp->children[i].data);
+					 pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 		strbuf_reset(&pp->children[i].err);
 		if (code)
@@ -1601,7 +1601,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 
 		code = pp->task_finished(code,
 					 &pp->children[i].err, pp->data,
-					 &pp->children[i].data);
+					 pp->children[i].data);
 
 		if (code)
 			result = code;

base-commit: cac25fc330fc26050dcbc92c4bfff169a4848e93
-- 
2.13.3.windows.1.13.gaf0c2223da0

Published-As: https://github.com/dscho/git/releases/tag/run-process-parallel-v1
Fetch-It-Via: git fetch https://github.com/dscho/git run-process-parallel-v1

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272E41F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933876AbcHaI4L (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:50139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758970AbcHaI4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:07 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LmrZY-1bBA8J0Zw4-00h5Ee; Wed, 31 Aug 2016 10:55:59
 +0200
Date:   Wed, 31 Aug 2016 10:55:58 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 24/34] sequencer (rebase -i): respect strategy/strategy_opts
 settings
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <4148c74b28d6e62f507a88a588ea90dc9924a672.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U/WZllDeFd/884Sq3J9nnFx2f6ZK6CVrdtT+b19+SP6qeLMxFZG
 UCastmw7kNzsRNHbRJ0jdtsuFi4NC4K3+c2rT6TDrAGAEwE52mUFEKOvN0e5PUtdN5dS0bO
 M3jq6rUkmhXQooO/UQ64NYoXeE23bud0INUcFvOlwl4DVkGQPBT2psJHWbzZuOElgSAM6Uc
 BCage8jFz9ov4IEqD9KMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mDh+0gSaF6o=:0ohm/V2ZnEgFM5OZ7Ude3F
 NuVldoaABoVIAyJG7vZBYO4QxGOpt1azRn5P+nJEXgZVCyXe3Hhv0eChQCEa1YeXF7ryIcAwS
 SXLrmRdkLJBeKeiyNuFhIbCKo/K6HHokjNZwPE4Ew9VspYVDMxqtDYTIEptgJ8Izu9XziKW5o
 ngDluHTrjbsxi60nnZULHbus8DcE9JVgCJ7ma3jfaPdlqH1qGNKnuoL9IRy5aUO3G/si+GXfS
 +WzBQTDyMec08dAFuWbjifunKsabAXlr1Ql6rfoxvJoeaw9efnWF/tlKwNhcKpbEVep+9FxG1
 vPdMwzt3D2EbS7hBXQQ+wj9rOIf58T8z97WNUTs7nAIf+N3/wjNVWcpyF9udR4tnUrvfiQ4pE
 kCXCMMxG8K/f0bFG8kSJ4L/p4R/if2Tws0jSGTlfQvECYjTSNrP3u93/dpW15dOh5paVG02LL
 bl63429iqbVhvphi12rgqT0WNKDnDR+1SasXbpQ74TxvSrF2luJxnbXiStXsJ86JademXQLp5
 8mSs4kgO6r1sNnM3ib8LD7uNrCg3JgdnAGc5fG1drgeT4xx8fHNFpeMX2oVKDWdjsjKnNdx+M
 qb57JZ9hXVtLUtuGgVXLQtl+m4usAsy7ljwi+4+4uQNOSkB9jCpFpEhg8IcDXhNTvdqFK2edG
 CLwWA+uW1HrGWliWd71waNOzrmq9q2syZySacLVzcMjukIgmjs3wtjVVOp25c8D4PMV/MiTWT
 +5yLo897iaZO2mgB6d42PTHxtPr40WGH6oSbBBOIyPvCizdvZdz1+56JNA2fx4q27rxIm2S7B
 h49vkte
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer already has an idea about using different merge
strategies. We just piggy-back on top of that, using rebase -i's
own settings, when running the sequencer in interactive rebase mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 2922837..5f5fb9f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -112,6 +112,8 @@ static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
+static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
+static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -1404,6 +1406,26 @@ static int read_populate_opts(struct replay_opts *opts)
 		if (file_exists(rebase_path_verbose()))
 			opts->verbose = 1;
 
+		if (read_oneliner(&buf, rebase_path_strategy(), 0)) {
+			opts->strategy =
+				sequencer_entrust(opts,
+						  strbuf_detach(&buf, NULL));
+			if (read_oneliner(&buf,
+					  rebase_path_strategy_opts(), 0)) {
+				int i;
+				opts->xopts_nr = split_cmdline(buf.buf,
+					&opts->xopts);
+				for (i = 0; i < opts->xopts_nr; i++)
+					skip_prefix(opts->xopts[i], "--",
+						    &opts->xopts[i]);
+				if (opts->xopts_nr)
+					sequencer_entrust(opts,
+						strbuf_detach(&buf, NULL));
+				else
+					strbuf_release(&buf);
+			}
+		}
+
 		return 0;
 	}
 
-- 
2.10.0.rc2.102.g5c102ec



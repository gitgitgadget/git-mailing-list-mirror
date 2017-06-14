Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3D620401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbdFNLgA (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:36:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:51165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbdFNLf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:35:59 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyEUz-1dqwiY11b3-015ZdV; Wed, 14
 Jun 2017 13:35:51 +0200
Date:   Wed, 14 Jun 2017 13:35:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 3/6] help: use early config when autocorrecting aliases
In-Reply-To: <cover.1497440104.git.johannes.schindelin@gmx.de>
Message-ID: <9ae04aedac595abdf9f24b61df983f1539761046.1497440104.git.johannes.schindelin@gmx.de>
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qHk2e+4Sk4nxf59n5+QOqGcBz/0f3lo1tvSgWWm8g1ZvTNCFiuR
 QKlWUppxaxRBUgEvIYexqt+iawJVzFZKH6acw83DTr3QMHz5uoD+19oCgeT92r9AD4aJ4bD
 a4gC7+UhibWZjyfcTDpIPNWo5i9kADiADWDcoeQ4I1KK+cqVdR/klT6+YN9e1RRmA1nwUjD
 NuW48AAlwZJLHYOhVlxZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hGhNcPFxAFM=:xecPODvkpNadh+uHIOnO+8
 4qBF7duVFeo/njP41j4BPQ1KXgmXsf0uIIA+HTj+/TCAsMz1VcxkNhM2/e2o+wcmogeiRx1GT
 T6zIxZuptj9kXpbwL7OIJbGHFwIp1svhQ7xqHUzpTWm22uwCUyA5XNI7nmzoQcOp6i7H2f+TB
 50SNlRV2UP87l7Qv1e5MPhB3M6mjZbdIeCkpJzOCNxqcAdOwBloZt3TgQG4b1b51AboCHElKi
 19xKG6tKXE1e+oXJz9mdh8GaZbYnIz6yIokok9bL+yq6N4iiGg48X7pvAujp7DJtqrpCzvQ/f
 /Nmro62zzsL8TEbeXBjg3aCeGJNDhQ2xwP7gNo4iPGVqc4L18sAxpA0zafhGHjP0eVy2rCJzA
 yqLNXOWLP51L5agSgP9UM87vCp2EQyTFtSO9iqlmOsc6t/IgGLXJkRAJc7TrANdgF2PAUSPqk
 nKnvvcoBMXeaMEUT3SZuEwI9RS5wuM1LBrr/PWfdcVIk9zrGdYYbvsARS7BU4wikuOMuylOJY
 SHN3Rkz0KbEqM5WuUZsJ9arGFl2IrumviBYt1m0iR9DjW+5JUTmoJdYX/GSWVOfCUzbrDZaxW
 vv7sXD6dcyt5Lo9OQl3NqC1hH1lcjTjpfi6K34l34Wmhi7PJupqIDnYFeY8Lumnn1VnNhU4HO
 Gj/4bDuCCjGvX8GE2dM1CU5we2GJPd6Ly3ahadjbs9Ah43lZQV2gwdnlWHB+K8RNAXNNDh3Qf
 avFwBLuQUHi/8VhyYHpj57U3chSrTOXIYcjTdhoAXoMTEuurIdc8YidN3Xrv4qpKS5+0PSj68
 WnY6re5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git has this feature which suggests similar commands (including aliases)
in case the user specified an unknown command.

This feature currently relies on a side effect of the way we expand
aliases right now: when a command is not a builtin, we use the regular
config machinery (meaning: discovering the .git/ directory and
initializing global state such as the config cache) to see whether the
command refers to an alias.

However, we will change the way aliases are expanded in the next
commits, to use the early config instead. That means that the
autocorrect feature can no longer discover the available aliases by
looking at the config cache (because it has not yet been initialized).

So let's just use the early config machinery instead.

This is slightly less performant than the previous way, as the early
config is used *twice*: once to see whether the command refers to an
alias, and then to see what aliases are most similar. However, this is
hardly a performance-critical code path, so performance is less important
here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index db7f3d79a01..b44c55ec2da 100644
--- a/help.c
+++ b/help.c
@@ -289,7 +289,7 @@ const char *help_unknown_cmd(const char *cmd)
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	memset(&aliases, 0, sizeof(aliases));
 
-	git_config(git_unknown_cmd_config, NULL);
+	read_early_config(git_unknown_cmd_config, NULL);
 
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-- 
2.13.1.windows.1.1.ga36e14b3aaa



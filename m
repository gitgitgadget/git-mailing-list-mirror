Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82131FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdFHTxv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:53:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:64356 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbdFHTxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:53:44 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNHqL-1dCBkQ3LzN-006tTo; Thu, 08
 Jun 2017 21:53:39 +0200
Date:   Thu, 8 Jun 2017 21:53:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] help: use early config when autocorrecting aliases
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
Message-ID: <2be3d75cd3341c1386f97c77cc63bec89c1f6a47.1496951503.git.johannes.schindelin@gmx.de>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NxwBMg1Hxp6usueBdcTNTTkSBFuwZzrIcPAGy9seV716tnb/RL2
 6C8MvEWD7KZ7qrQfLBe0ECrCf+IU9OHLadYke6a07RSb61imLaz5B0oGcyScOugp+T6Xb8q
 EnYJFpHfMf1jW0u+H9fBEvsHLVY8M+hBnatCwX5fdLv3PXC9zdFm8sNqTRCGBMVD2WMWqS6
 AYyO6rKDfCrJvlCzeGr1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gc6vNJ0u0/E=:SfMEpOAYxK6hBmALW0mVE/
 kBLTX+C3Jc193cylLVGxZ5co6r0od1aFGoUtAbLeGusdQ30EMT/0ZGM7mxLmwcHqK9MpmoDMn
 V8ovr8KBSUdng9SMal1YuuD5SFvvLloKT/BneWLxHbr5iEiP8qdYKTEH49GverdPqJNr+vd1A
 cPNztJLvq8TLGGWDnYF0zbg8zDk0s9PvIOiGIbBXWNYXIK5U8+BwZijPb3WRpyxmn79HG/lJ8
 LXaFukjCWOdmCGl/LfHNiuHh9ULHY8QBr+BZirL8+cqnOkZmhh2HBkhbD5K5MgAjIOmC6Nlup
 u59xgDnSL/YSW3KbeMNRUqYuRqEwADgOJ+4Dqpt+jEGFPmCgKvbA/X5V4ZRwaARcBE7Hb1D9m
 v1yxxRIIJDPHBhHap7Jgn8tm243MFEsRZKCfaIR1L8O8T2FOmQVePu9Imid7fa1wQ+lXs6Zzx
 YrMolPLVqk/WInmuTI1Qu76NN/bil4P1GyW/65bc3TQWCljs6I4Fw6CC7mmmAjWMW3NV/0ppw
 c1Sgt3UV2c7KRfSbiK9foUbHdljQhSJzEJT06rGG8eGjl23xKOSyH/Xdu1tBYXPw/B32L3V06
 N9Lqr+EvE90OZfglPFh5F+i0nb7ZkDtwQd+0NBE9JJJdvix79+dPzpUUBuBIIOkVM3I64aRcn
 IKrdzIhgp4FkVfDtebnCtnz31lCJs4DrO+7CqWBZTQKJx/k4dCXGfJbVbcKQsgIg6wd4kpXVz
 kZXrWVflIersHoFUaph+Mr6zRU0BG8MnCo1en7sFY6sauszReWmwhl1SqSG/+q3zbEbHqfxH3
 q7z5KYG
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
2.13.0.windows.1.460.g13f583bedb5



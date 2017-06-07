Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A811FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdFGQGZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:06:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:52796 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbdFGQGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:06:24 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGoU1-1d5hA43fF3-00DWeM; Wed, 07
 Jun 2017 18:06:13 +0200
Date:   Wed, 7 Jun 2017 18:06:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] help: use early config when autocorrecting aliases
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <d7b77cbd688b7536aebee49df652af594d2a1293.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sspP9Fc66xUCbxV0WEHGLvpItAHOi2Sj6nx9PWY8gwpZnTPn2GE
 EUvfLqp3X5dqjJLN+A5ntIebvb6kXO0JqwBmDJDHir6vrAv0j7qLFLeJdRMfuB8I4Vwk36L
 pKPaxEhlH1ecFn0QF0ZEymoojybsEoTvRC9tK/msvCqXZoqaZeETpO2oiEUaK+sbW8kgY6H
 T79jsij2CBKicvXP50l4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m/ntqajA53A=:cZC/Cb+7jCizCTMHjj2MQ2
 ua1pgHNBDbn+488/BSfgvzJQ8EfXcEzWiOzxDKHKKRXuM7YMKEKFPhPAcY8spbAUFM9RoDLXa
 M2s1U3SyvYx6/tsqpOArJg5bpVHMUfvFRnlr3tCiKJg8EiXW0OM5BqJ3B7pVIJONxR+BtQATd
 eBDApBAsApWVFi397hhiBkHmF+oYFWZxYj0bWmfFrgm4uRmTemaw2cAESimIefhp4Fry0LuOj
 +HxCRi4USD/maAE8z9IzfjlEys7fzsxZplvSHszHogAnfJpnPZ0h81mUrrPx1rclTRBA6vquJ
 E10cOy1/RByuRIcjMt0TCjhVcvewbd7YOVrblF+cEhZY3xbi4t+oWB5zTiQlxuafFyNQFJQfS
 rCMgAemFilfJUvFGJnwzI9O4y+klwfOMgE9/zl8gMTNoUP934dTEF4LgqT+DVMpspKY7SblYJ
 cXMQc+eaYo3fJ4wQFvZSH4gLMymgCg21+oRhlR/GY0gFrWQFrv/VRoXmYP/GMpWQV/ccmpNwL
 cyF+++/3aQU97rnwTDr0xNNEOf2XNFLo3qY0xrH2DFK7TetOHCrx1Bk9EuWz9Oy/PjYcLx39S
 uETD5tnEqEjTjtgAxyZm77AL8zV1SOvc8xC18MYCen4gPbWsPKEbyz1qHsVbtIKmaTjo8tNOd
 wpSeVE5yTPSVXrZPo+GhRlMH5mo6W8Tq3oJpX6uHdyTZlMic/9r6phJ9BnxJlpJcgR6QMH505
 UieUhzlRF0oFP/MHyZV7roCjanQyLvxc7MYEhYSUeckfrTYT4LM/4LjgciE2J5b8wo/34/VBm
 5IQQxl2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git has this feature where suggests similar commands (including aliases)
in case that the user specified an unknown command.

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



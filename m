Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682532095C
	for <e@80x24.org>; Fri, 17 Mar 2017 22:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdCQWJh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:09:37 -0400
Received: from mout.web.de ([217.72.192.78]:60598 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdCQWJg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:09:36 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlneG-1cFwBY1zhg-00ZMx7; Fri, 17
 Mar 2017 23:02:36 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] receive-pack: simplify run_update_post_hook()
Message-ID: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
Date:   Fri, 17 Mar 2017 23:02:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:d5XVuVAD/bebDRkZ5OXZmUtGNXlzx002cyxFt32BS87iTKSNPsZ
 +4M2RGGYd7BCLp4SyTIDb4jo95bbZy0cfkVYT2Ok619GzMhGOrfVVK2wnBQFDTpr4ITnMPu
 p9RFTHj8untg7NtZFKuGAnqUm4HozEz2aU8MlRPQpyeaiemLPKd3ghslyjjrCLwucl/UByh
 ojut38eZoZmO+wEU8N2UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4vRm7NMZKLI=:yK3vWTOp6LhCfof4OO20qi
 VC1HwD0dO9hBE+dlH9htYr0k6zIs+uCAyqUOUTChUxFzGeJGvjClqgwEkkOtgg0dHKtde/Ohj
 ckXm7h6MN9YRJSqFBWqK8iV/YBNUasaWaf4POp8Kwmj0xAIBn6djXh1v2R/D/p8Wy5SpEhgxl
 YPfyHC2XA5JX0Wlobv6aC+HDBbMJgc8Zh0zvSnwPRy8U4q05vmz0DL9Sr+hIn2d/26CuBMLwC
 N/vQM0qWoLtuWpst0x/W6TMM0QJjl3aG8IuhfhC5cCOG491dLgb7IRpAn1qn5tSROT6p1DPo1
 saZWnirCiU7llNWdY5Y3pb0PoFglJipS9X0Q6Y+/y1KVfkw4mcH1VI0BZ+UBPbX0SlMl/tFg/
 YVZpPw53ovD3PUQz8LP8ja0sgRuIUt5EF+BLVmdbzImqZ0MKjR8a5vEcQmDvcRgF7HMHD4oYs
 LmNt8LVtHQUrLUmIg5er4FPd7ycNxMOg6g52sDuneWLzpshr1TUraMhv/OFqyOvO14Yhivpbm
 5asDP8fpFPAcKrpYyvR+kAKReNPYmk4D/wZYMeAKSgK6grxF27dmMTPUIFuMTP7S973F86yq1
 koCcgJ4+Buhm1C7dmVgvZI8JnZgs3t7eZByl9e2loDN2B8mzq9/X7cgD16OSKMF3jSen1CQWR
 emfncnpnIbf1RBov1fUG8j/u6NkGowDJE79KAL9V9VZ54CA3HI/UfnofSm/FjQqBo1MdB1p94
 GXl6ZDzmWz6DFksyOVAtII02e48Oky6eB0fUzFs8W0j6+A7EiRceYWJR7u9lhUsAD0S7QN/DD
 hFgF9z3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of counting the arguments to see if there are any and then
building the full command use a single loop and add the hook command
just before the first argument.  This reduces duplication and overall
code size.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/receive-pack.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 83492af05f..fb2a090a0c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1128,25 +1128,22 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	int argc;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *hook;
 
 	hook = find_hook("post-update");
-	for (argc = 0, cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string || cmd->did_not_exist)
-			continue;
-		argc++;
-	}
-	if (!argc || !hook)
+	if (!hook)
 		return;
 
-	argv_array_push(&proc.args, hook);
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
+		if (!proc.args.argc)
+			argv_array_push(&proc.args, hook);
 		argv_array_push(&proc.args, cmd->ref_name);
 	}
+	if (!proc.args.argc)
+		return;
 
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
-- 
2.12.0


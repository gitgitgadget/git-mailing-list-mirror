Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7282207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbcJFQXb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:23:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:50248 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbcJFQXa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:23:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3sqdHg6kG9z5tlT;
        Thu,  6 Oct 2016 18:23:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5A3AC529C;
        Thu,  6 Oct 2016 18:23:27 +0200 (CEST)
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the script
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <cover.1473590966.git.johannes.schindelin@gmx.de>
 <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>
 <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609121019290.129229@virtualbox>
 <xmqqr38p3z1i.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610061459390.35196@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5ed8aaea-9fbe-11b0-49b7-1b42567d4918@kdbg.org>
Date:   Thu, 6 Oct 2016 18:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1610061459390.35196@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.10.2016 um 15:08 schrieb Johannes Schindelin:
> Hi Junio,
> 
> On Mon, 12 Sep 2016, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>> I do not offhand see why we want to be lenient here,
>>>> especially only to the left.
>>>
>>> Postel's Law.
>>
>> How would that compare/relate to yagni, though?
> 
> I did need it, though. Blame it on being overworked or simply tired: I
> ended up inserting a spurious space before a "fixup" command. This command
> was handled as intended by the scripted rebase -i, and with the patch in
> question the rebase--helper agreed, too.
> 
> Note: we have no problem to the right because we do handle variable-length
> whitespace between command and SHA-1, and we do not care one iota about
> the exact form of the oneline (hence right-stripping is not necessary).

The last sentence is not entirely correct. See the patch below. You
may pick up the idea in one form or another, or just queue the patch
near the end of your series.

Let me take the opportunity to say

   Thank You Very Much!

for the new implementation of rebase -i. I'm using your branch
rebase-i-extra, and it is such a pleasure to work with on Windows
compared to the old fully scripted version.

---- 8< ----
[PATCH] sequencer: strip CR from the end of exec insns

It is not unheard of that editors on Windows write CRLF even if the file
originally had only LF. This is particularly awkward for exec lines of a
rebase -i todo sheet. Take for example the insn "exec echo": The shell
script parser (either of the sequencer or of the shell that is invoked,
I do not know) splits at the LF and leaves the CR attached to "echo",
which leads to the unknown command "echo\r".

Work it around by stripping CR before the command specified with exec is
passed to the shell.

This happens to fix t9903.14 and .15 in my environment: the insn sheet
constructed here contains CRLF thanks to MSYS1's bash cleverness.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 sequencer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index daf8f13..6961820 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2005,8 +2005,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		}
 		else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
-			int saved = *end_of_arg;
+			int saved;
 
+			while (end_of_arg != item->arg && end_of_arg[-1] == '\r')
+				end_of_arg--;
+			saved = *end_of_arg;
 			*end_of_arg = '\0';
 			res = do_exec(item->arg);
 			*end_of_arg = saved;
-- 
2.10.0.343.g37bc62b


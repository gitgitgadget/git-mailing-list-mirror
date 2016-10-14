Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C411F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932764AbcJNNTy (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:51942 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755990AbcJNNT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:19:26 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MKqOW-1bv2OF348O-0007YG; Fri, 14 Oct 2016 15:19:11
 +0200
Date:   Fri, 14 Oct 2016 15:18:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 21/25] sequencer: remove overzealous assumption in rebase
 -i mode
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <618bd6854c89534381be0956fca4e2468d66c330.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rLGZShcrTreG5WYy7vWhq4UcmcYrRvo0+rfIJJDyAshORuSe9rF
 NALUG0x5X5G3RYscrbtSTRp3HDyqcSDRbrNyujfwMZLfC2i4SDcwBLni3WqOZpE6XCcJz8N
 yx+27ChkduxQ18GU8Ne4aS4Gc4QWcf9tBUFALw1fZtoyiJXsi5+eY5A31OjHJBtXUQBvnT0
 v0nGs4iESQnPmPeNsEkpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pCo3s7xCCSs=:x4jGTBYlvn+ql5IQu+B7ME
 8wMdEQsxzCWpadMn14x/C0yT3dwWwWY7mFhaEFQoUizCXXU66UghE1NlmB68Qr9Whyqiv/S4e
 jIRclb2gOYBVkI5ott41z6hq3fe4EmlB5A5F8geUs0hW/CpI+kDjtp3QHtb2JcBC86A8sIJwR
 aY4utGMImOIRJpzdqa0tCFvlSV5gfguDDvECSwV4e2kJhd4SOd9ZGvnBLGbSaigvCe3HwJvpH
 VJmWM/iRs7drWS6Aga6WgJS3+QVCjeKt3L7rhz2nXHPyX2HISQ0Tu+NasDFXu2iLeHioh+9kv
 uxiK14Xk1/B24BFdMu+qUHg0Ytb+gA4nOXo//2R3A0oNoSwco8qUoblV0YaJe2uJVoen5AGLI
 wm0jqOnSToNLDtJuadhiRPvPYIGkWKm9vjfffIm9KW/XxH+x2+kd0jGRkZ8sFL3htA33yhs1l
 JTVZSuvZ7wSpHNQvGEoovo9LEuOxCO/l6bmzlC+rE+J1msfuBKHa4BQGRSmA5L8GCdmDSqLNk
 m2nrSbXD4D0f61uaAnG1Ccd9tPGGlk07jEbCSo4JT1e77G1f1xfVnoEEJypUzhk9MDXf7PR0N
 uRUqneLL2sxOkriYnFhG+u0fnYQqBB1vdmzFL4INtP4pAPYz8G75C+UNkJffbQeGgtE+5TpxR
 WzLespJsUK2PFGRSJdbzlvBW5+uq1kfxD+UnoUAKg4jQ7YiveVZym9REq1wp8EM3UN2FGzzgK
 m3txpSmEgcw45/H2Hw1QKaJ7RCaX7QMSXYRnHEyNLPTKpCF8PGpQu9bzVYC2r+dMnOS/uQwDu
 bzmBfrG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer was introduced to make the cherry-pick and revert
functionality available as library function, with the original idea
being to extend the sequencer to also implement the rebase -i
functionality.

The test to ensure that all of the commands in the script are identical
to the overall operation does not mesh well with that.

Therefore let's disable the test in rebase -i mode.

While at it, error out early if the "instruction sheet" (i.e. the todo
script) could not be parsed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index baccee9..36c24b6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -963,7 +963,10 @@ static int read_populate_todo(struct todo_list *todo_list,
 	close(fd);
 
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
-	if (!res) {
+	if (res)
+		return error(_("Unusable instruction sheet: %s"), todo_file);
+
+	if (!is_rebase_i(opts)) {
 		enum todo_command valid =
 			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
 		int i;
@@ -977,8 +980,6 @@ static int read_populate_todo(struct todo_list *todo_list,
 				return error(_("Cannot revert during a cherry-pick."));
 	}
 
-	if (res)
-		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
 }
 
-- 
2.10.1.513.g00ef6dd



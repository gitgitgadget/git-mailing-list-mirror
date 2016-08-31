Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6FB1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbcHaIzi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:56328 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933746AbcHaIzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:35 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJWAZ-1bgvur1yo7-0033VK; Wed, 31 Aug 2016 10:55:30
 +0200
Date:   Wed, 31 Aug 2016 10:55:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/34] sequencer (rebase -i): implement the 'reword'
 command
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <76ab1103be1a3414e200cb3766a00be049bbf03f.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:k5OcAb12WQ9q0r8ZLgFWunnVMZo1FYkTh7wZHJnkLZU/5yi5Dfv
 Eg31CteQcapxXkYGpUdSNr1zeQE9XBLnO7DMaEPE0ugMzGx1Og0XpJZc1b1nDkaseGVM13G
 xCXHPShSterwLQ+JylFjlwaXwEpWMIDi7yM7mgz3u8dOsCuCm1MxvNVzm1BRdTgn1FT0syp
 aNplqM9vQZgvWj/x7B67g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HfaJ5OFLRSg=:5o6PHS+p+ewMU0ey428gQg
 ZwPzaIfObZ6nluUfKylWnCALDKvUGajuLA9dEzZS4qeDq7c5o0jYzt7ygbEM0AGyFXvrTFeMw
 umaB7dhg5JB6awnnUTVPWswjsFAnCqhB3iJqOYSMwmE8b84vw/1COg6D+CJMlK++N1BGM2Sbu
 DCi0G73cQ5/+qgz3IEa3BWDD8Q/uCIYZnMZjLhTeJFrLPyGHdManM7sie9nMyi+NR0AUIC4WE
 xHJqCwvE//L92XcJ+26I5gC6BK8+j/HpA3zWdMygsgDgXJybv4aqIaf8Kn/so2xGA/FXvY+wz
 S1POrdacqlsDs4RvdgqFgYwzta7sOM36LCwmrRKU5QT+6EQ54wrsPaa4U63qhmMDie5LRyIlq
 Jn8hWJ+63+4lWS7pZwDxNLPcYApc4GkIPUBrBaIzk2VRmng1WyUwaFVmdhLf+vlpC2Vqqrd1M
 j4okiB9X80Wn1XF/9kEw24ngae2r1ZV7KdDpVuyjMrD1QPnJu6ivQiMC9KgxrdB+p9evINxR+
 DRTN5pthPWrDf0LYH3XjUdrswmV7/+ih6qY03UvNfjK9tKBzXotNsMLlMoxSUuVuA5ZwGPmVy
 fsgXqgA+rSgX25k3nfCRqwiOgJ+j4DNVHvZXhK2rSm0zAlnt0cVGN1cblN+S4RSo2huxSoK5n
 4hhl/HzC1yqEg+ppuuwSxX/DwSKfrVR/CO9j7gzo7SZ8a1xjCkCdEEECiMbPc8/1Pd3c8N4qv
 wokhkqIqIsTW2r0RQRYE2pgur523tSRKPkXgAQ7qOKFp3oJpjsTAovPRyjKsL80w6YQ/bla5Q
 41nbwjj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is now trivial, as all the building blocks are in place: all we need
to do is to flip the "edit" switch when committing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9a06b40..64fec47 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -746,6 +746,7 @@ enum todo_command {
 	TODO_PICK,
 	TODO_REVERT,
 	TODO_EDIT,
+	TODO_REWORD,
 	TODO_FIXUP,
 	TODO_SQUASH,
 	TODO_EXEC,
@@ -759,6 +760,7 @@ static struct {
 	{ 'p', "pick" },
 	{ 0,   "revert" },
 	{ 'e', "edit" },
+	{ 'r', "reword" },
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
@@ -1004,7 +1006,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
-	if (is_fixup(command)) {
+	if (command == TODO_REWORD)
+		edit = 1;
+	else if (is_fixup(command)) {
 		if (update_squash_messages(command, commit, opts))
 			return -1;
 		amend = 1;
@@ -1755,7 +1759,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			}
 			else if (res && is_rebase_i(opts))
 				return res | error_with_patch(item->commit,
-					item->arg, item->arg_len, opts, res, 0);
+					item->arg, item->arg_len, opts, res,
+					item->command == TODO_REWORD);
 		}
 		else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
-- 
2.10.0.rc2.102.g5c102ec



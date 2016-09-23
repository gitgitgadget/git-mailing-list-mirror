Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07FD207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 17:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934340AbcIWRlm (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 13:41:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32787 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759822AbcIWRlk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 13:41:40 -0400
Received: by mail-pa0-f45.google.com with SMTP id hm5so42249801pac.0
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uDWg/e6FbAq1VHdi5eCniJBiav/Xufhga6LlB2MQyww=;
        b=B6xupMaYBDeKmDYniwGludiv3ms15GOqXN05jQ/yHZ9uuQ3pU6LZZpBzlbOPn1njpc
         tcxLNv/lI6MZUrME39AK/yBgs234SJb4xvqXJnsGcvhO1KUurzYfDZXJAoKEMMn6sRvj
         UHkOuf+YD9wgDCo/1CSn5Qq06az28Nd/l30HjNbCw4hXjB+Q237ccceSG6R35NC5pBfU
         7RsLCbiCxn18MEc2Ad2JbjDUW6CtPnySl0Jog9gFtCKmhqAArHe92/AenZFtehm2sgJt
         znHw+rF2QuArr8JiCIyRxIWuSJDoJVCSRT3TDu+I8Il/r2H4YbdPhOO7tpbykgcBzQzO
         CWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uDWg/e6FbAq1VHdi5eCniJBiav/Xufhga6LlB2MQyww=;
        b=g/GWO6oQMcov0+mne0NyfPWEZ8lf0QyPkWtYT3IhArSMfp53ycUr0VrCLYrc4mUfBy
         /2AFEmswb58HqChYk2uwOTa94fskil0hNdKdR8l/P/n7FiGm8AJ3cDDbveUmD9V93OyQ
         3II3giLiFoNpIOl/2fUZOWRgdr28jn7WJjlCkwWbGzR1gVjm0xvYrkrOb1EPfzNH7Wf5
         WVqYcn7btAr79y9PvPyX5IX8H6hfRj4kGYGLf+TBaaYgHc3PAishP5pJ45kxLSG7zN24
         2IcnwOFA0qZNq3MCgWzv2uYQn4sp0kKBN/04gbOQ/DTGLxOyKUnMZ8n9oCOMYwdNDrmb
         li0A==
X-Gm-Message-State: AE9vXwMIxnynNimri1ZoKBnTE28pfKzynq7HLZPvlGMKz/wLz1ujyxBAdgE0eYmgODWDqnGB
X-Received: by 10.66.158.233 with SMTP id wx9mr14353212pab.2.1474652499941;
        Fri, 23 Sep 2016 10:41:39 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id r77sm13015330pfg.16.2016.09.23.10.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 10:41:38 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v2] fetch-pack: do not reset in_vain on non-novel acks
Date:   Fri, 23 Sep 2016 10:41:35 -0700
Message-Id: <1474652495-26051-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <xmqqfuor4s4z.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuor4s4z.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The MAX_IN_VAIN mechanism was introduced in commit f061e5f ("fetch-pack:
give up after getting too many "ack continue"", 2006-05-24) to stop ref
negotiation if a number of consecutive "have"s have been sent with no
corresponding new acks. This is to stop the client from digging too deep
in an irrelevant side branch in vain without ever finding a common
ancestor. A use case (as described in that commit) is the scenario in
which the local repository has more roots than the remote repository.

However, during a negotiation in which stateless RPCs are used,
MAX_IN_VAIN will (almost) never trigger (in the more-roots scenario
above and others) because in each new request, the client has to inform
the server of objects it already has and knows the server has (to remind
the server of the state), which the server then acks.

Make fetch-pack only consider, as new acks for the purpose of
MAX_IN_VAIN, acks for objects for which the client has never received an
ack before in this session.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Thanks for your comments - I really appreciate them.

Update from original:
o removed redundant text from commit message and comment in patch
o mentioned stopping the client from digging too deep in the commit
  message

I tried looking at creating a helper function to reduce both the size
and the nesting level of the loop, but it seems to me that a helper
function can't be extracted so easily because the logic is quite
intertwined with the rest of the function. For example, the "if
(args->stateless_rpc..." block uses 6 variables from the outer scope:
args, ack, commit, result_sha1, req_buf, and state_len (and in_vain, but
this can be the return value of the function). Expanding it wider would
allow us to make some of those 6 local, but also introduce new ones from
the outer scope.

 fetch-pack.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 85e77af..413937e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -428,10 +428,17 @@ static int find_common(struct fetch_pack_args *args,
 						const char *hex = sha1_to_hex(result_sha1);
 						packet_buf_write(&req_buf, "have %s\n", hex);
 						state_len = req_buf.len;
-					}
+						/*
+						 * Reset in_vain because an ack
+						 * for this commit has not been
+						 * seen.
+						 */
+						in_vain = 0;
+					} else if (!args->stateless_rpc
+						   || ack != ACK_common)
+						in_vain = 0;
 					mark_common(commit, 0, 1);
 					retval = 0;
-					in_vain = 0;
 					got_continue = 1;
 					if (ack == ACK_ready) {
 						clear_prio_queue(&rev_list);
-- 
2.8.0.rc3.226.g39d4020


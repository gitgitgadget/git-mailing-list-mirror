Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E172D201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 05:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759440AbdKPFXH (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 00:23:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52470 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934048AbdKPFWb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 00:22:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 912D6B7908;
        Thu, 16 Nov 2017 00:22:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YVfEK6mJguzB5/Zj6D8CsUvx3M0=; b=bDLQJY
        iGHENWit7xfUH02wsRfoZniucM6iEPNY6zf/4BbnnJwc+wO2BGPKwfk5UnI77AC8
        t43Whd7tI0F+7Sonzl0atdh05hyEbm46OsChJNnJuGJjHJBmRpEdh1M++wweOKkx
        ZQYL73IuElj81fopJVRvNFNOMgvYzyXfLjJwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gATonxPtpYprGMoq2DVK7U7Cv/9quSJc
        tgVter/J5cZsmdvlNhS5J18JvIm4IXnSAlSlDzJ3OD3uu/CL5Kp99HzHWy9TQ7Ma
        TAXlsoUm6OZN+cNhZy6sNmK6xkV4gQKLW0S/jgpI/6ASqn15Bg6+KCl7aBaw+L+5
        YBvlZVvb2v0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 898D9B7907;
        Thu, 16 Nov 2017 00:22:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE20FB7906;
        Thu, 16 Nov 2017 00:22:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2] sequencer: reschedule pick if index can't be locked
References: <20171115104125.1686-1-phillip.wood@talktalk.net>
Date:   Thu, 16 Nov 2017 14:22:28 +0900
In-Reply-To: <20171115104125.1686-1-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Wed, 15 Nov 2017 10:41:25 +0000")
Message-ID: <xmqqshdex0ff.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24423CFC-CA8E-11E7-9354-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Wed, 15 Nov 2017 10:41:25 +0000

If the index cannot be locked in do_recursive_merge(), issue an
error message and go on to the error recovery codepath, instead of
dying.  When the commit cannot be picked, it needs to be rescheduled
when performing an interactive rebase, but just dying there won't
allow that to happen, and when the user runs 'git rebase --continue'
rather than 'git rebase --abort', the commit gets silently dropped.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

 * I've queue this, taking input from responses by Dscho and Martin.

 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 332a383b03..10924ffd49 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -438,7 +438,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	char **xopt;
 	static struct lock_file index_lock;
 
-	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
 
 	read_cache();
 
-- 
2.15.0-360-gf2497ca0e5


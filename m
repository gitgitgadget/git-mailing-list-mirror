Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EED20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 04:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdKGESU (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 23:18:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57684 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751035AbdKGEST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 23:18:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A442A78E0;
        Mon,  6 Nov 2017 23:18:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+tkPsLIYiVSCa6gqtVhdSKDkKKY=; b=g/3sJXfIDI3iM4rtJUia
        lE1CGDXpBfZzpE9IG0ODOyt4MRxxoROHu8W9rRdmLK5MHlzTa+EyZ+h1M8vo9+UP
        0NkQqst0uQd5m1a7alHwove1w4oKKWANEdQwiCysblAcKA2ac1Ue9NOGh1yjGMr8
        cNpm1njiDDht4h8pwKRT794=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ApLIbTmhwaAZYKXmTtCAamQ4KgjF/h87GTLJ61dqXH6uIf
        hvg8vQYgQInyZUy0c8JNwJnUstO9Vy4QHaiETcgX4z+QCxKl2c/hbezDEgm/AjC9
        rjxxj8xe+Ew5xCBdL3G8ukbvPgMjtts9C6OWQsGnWj8J6ZAPSypHkcKYbYHbg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92ED9A78DE;
        Mon,  6 Nov 2017 23:18:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 109A6A78DB;
        Mon,  6 Nov 2017 23:18:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 5/8] sequencer: don't die in print_commit_summary()
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-6-phillip.wood@talktalk.net>
Date:   Tue, 07 Nov 2017 13:18:16 +0900
Message-ID: <xmqq8tfig1rr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE964D08-C372-11E7-A9E5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Return an error rather than dying so that the sequencer can exit
> cleanly once it starts committing without forking 'git commit'
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>...
> @@ -948,7 +951,9 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
>  		log_tree_commit(&rev, commit);
>  	}

Is that call to log_tree_commit() a big elephant in the room?

All of the die() we see above you are making into error() are rather
unlikely conditions (e.g. you created a commit, and try to look it
up immediately after that, and you somehow fail to find it);
log_tree_commit() makes tons more object accesses, any of which
would be equally likely to fail and die.

It definitely is a good thing to eventually make a direct in-process
call into the commit machinery, and we should aim for that endgame.

And this step is going in the right direction, but I am not sure if
this made the function safe enough to be called repeatedly from the
rebase machinery and we are ready to unleash this to the end users
and tell them it is safe to use it.

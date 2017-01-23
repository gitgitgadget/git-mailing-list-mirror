Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6986920A17
	for <e@80x24.org>; Mon, 23 Jan 2017 21:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbdAWVmO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 16:42:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdAWVmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 16:42:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFC3F62895;
        Mon, 23 Jan 2017 16:42:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c1wCemAVwYr7aRSibg3yvAeaXR4=; b=j5FjGA
        ZQX2OESmaRhZ62tcyV3BnlGK+pIIhKQF9Eyk174E8w63hh5z8Q9KlnrCpkjRXvSE
        pOFVEtCA+JAGXq8evc5slnGcGMbJLbERFJELh7cwRemIMrvFFuuRH52sC2nadZ44
        Q9hu4/JO00FJn5mwQvBAv+Ap7wmW7HRi/Wzo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WNOpFL68YhmyaRw/l0dFqyWC4jB+Jk09
        ZEVCNPj2C2OFIrwCGsBFBwoefk4tpOqDUwQQ5rELwPklKdBARvmVvayIwo2dxbMl
        qU8Mo2QWjHOciZdHmXJfEc89okxHGHUvQqMCg/lLep0KFEmqfm5qPxYmXwnn9rN3
        zk5yO8dJDoE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCB5362893;
        Mon, 23 Jan 2017 16:42:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27EA662892;
        Mon, 23 Jan 2017 16:42:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check structure
References: <20170112235354.153403-1-bmwill@google.com>
        <20170123203525.185058-1-bmwill@google.com>
        <20170123203525.185058-26-bmwill@google.com>
Date:   Mon, 23 Jan 2017 13:42:09 -0800
In-Reply-To: <20170123203525.185058-26-bmwill@google.com> (Brandon Williams's
        message of "Mon, 23 Jan 2017 12:35:23 -0800")
Message-ID: <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBD9D204-E1B4-11E6-AA1F-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The last big hurdle towards a thread-safe API for the attribute system
> is the reliance on a global attribute stack that is modified during each
> call into the attribute system.

The same comment as 22/27 applies here.  

It is not an immediate problem we need to solve in the scope of this
series, in the sense that a Big Subsystem Lock for the attribute
subsystem around git_check_attr() function can make it thread-safe.

But if we want to make it truly threadable without a Big Subsystem
Lock, this and the other one would need to become per-thread at
least.  I think the check_all_attrs scoreboard, which is the topic
of 22/27, should become per git_check_attr() invocation (immediately
before making a call to collect_some_attrs(), prepare an array with
map.size elements and use that as a scoreboard, for example).  I do
not think we can be sure that the "slimmed down attr stack" 15/27
envisions would help performance without benchmarking, but if it
does, then the "attr stack that holds entries that are relevant to
the current query" would have to become per <thread, check> pair, as
two threads may be executing the same codepath looking for the same
set of attributes (i.e. sharing a single attr_check instance), but
working on two different parts of a tree structure.

> This patch removes this global stack and instead a stack is stored
> locally in each attr_check instance.  This opens up the opportunity for
> future optimizations to customize the attribute stack for the attributes
> that a particular attr_check struct is interested in.

This is still true.  But two threads hitting the same attr_check
would make the stack thrash between the paths they are working on to
hurt performance once we go multi-threaded.

Perhaps, provided if the "slimmed down attr stack" is indeed a good
idea, we should keep the global hashmap that holds everything we
read from .gitattributes tree-wide (i.e. as in your v1), _and_
introduce a mechanism to keep the slimmed down version that is
relevant to check[] for each thread somehow.

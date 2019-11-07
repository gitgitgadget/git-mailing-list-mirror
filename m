Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68DC71F454
	for <e@80x24.org>; Thu,  7 Nov 2019 03:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbfKGDhF (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 22:37:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61396 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGDhF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 22:37:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D712F36240;
        Wed,  6 Nov 2019 22:37:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9FZowf3VHgfRwA6H8IVmf0hlbEY=; b=Uc3BF0
        MIMiGQdh25plv1hPY1dLhqbAC5CvwuQQsLttvffbIKdGkrSg1wrD/P+rChgt3bI2
        IF0giZxv5m7YlezMsXOwQ4TX/N2nP80AbT/W7JyE+GRfTZv8GhPw9ycOLyzbTMtp
        ywPs45O4+HoQISf+FHvMt7rxSFWun4K2TTFo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QCMDOHBiK/ycaDWf7W3r4ys1XbrB6upf
        jWkVNyEyJEvddfSSsChnWXBM5amvZ31QbKVfCgczvrfNKMVd5eoceByy4fjUs4SP
        PA1mOhgkKwnz6lVZGj5JVz/iddvywwUxsqni5SAEcZuDPdoJ8M0CtLUTP+D6VeEu
        bTpkUEkw7Jk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC4C83623F;
        Wed,  6 Nov 2019 22:37:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19EEA3623E;
        Wed,  6 Nov 2019 22:37:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 31/32] commit-graph.c: fix code that could convert the result of an integer multiplication to a larger type
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
        <20191104095923.116086-2-gitter.spiros@gmail.com>
        <xmqq7e4dwxob.fsf@gitster-ct.c.googlers.com>
        <20191107022347.GE6351@danh.dev>
Date:   Thu, 07 Nov 2019 12:37:00 +0900
In-Reply-To: <20191107022347.GE6351@danh.dev> (Danh Doan's message of "Thu, 7
        Nov 2019 09:23:47 +0700")
Message-ID: <xmqqtv7gs6g3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC59E178-010F-11EA-935D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2019-11-06 11:23:00 +0900, Junio C Hamano wrote:
>> > @@ -1454,7 +1454,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>> >  			    num_chunks);
>> >  		ctx->progress = start_delayed_progress(
>> >  			progress_title.buf,
>> > -			num_chunks * ctx->commits.nr);
>> > +			(uint64_t)num_chunks * ctx->commits.nr);
>> 
>> Hmph, do we need this?  I understand that the second parameter to
>> the callee is u64, so the caller needs to come up with u64 without
>> overflow, but doesn't that automatically get promoted?
>
> Neither num_chunks nor ctx->commits.nr is promoted because both of
> them are int. The result of `num_chunks * ctx->commits.nr' will be int
> and will be promoted to u64 to pass to caller.

Ah, yes.  Thanks.

The commit title is about "integer multiplication", but can the same
issue arise with addition and subtraction as well, by the way?



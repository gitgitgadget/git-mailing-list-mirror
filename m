Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC5BC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3253361996
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhC3ALD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:11:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62881 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC3AKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 20:10:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE8F412687E;
        Mon, 29 Mar 2021 20:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zmBo/0zJWpgXwrSSFuf80eSabCk=; b=UDAce5
        Na5Z5GMbx0m9oUGumulW+wKYvXXI/mSkhmtdhbeZ4QlFVUR1tqgV47YFY3Tfu+AK
        Eot4ctBr4ViJcfWxuip2GSTQvtd107vXNhx9lAtVTet87N1D+8TDACO9TrMrRk9Y
        +S8RHZTLg8yNF77/ZkAhXWsh7OhzTRhTHJo3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cYE2l7bfqgTVUFK5ae7KHdwFg+ArTkgF
        QcPkVPU8qd0teLRfEnsGDutzDp/HWrJKtJHs0uZdLN2V5EJx6IIOClLAe5Nck3H3
        zH4eYeaTlzTBlDPS58Q5LgfXcaYw6y3oH2rfHsdP4v17ds9x8mUe0WOKb1Q5V95A
        UjOhLFtUR5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A75A612687D;
        Mon, 29 Mar 2021 20:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E041612687C;
        Mon, 29 Mar 2021 20:10:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 24/37] receive-pack: convert push-to-checkout hook to
 hook.h
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-25-emilyshaffer@google.com>
        <xmqqk0qc7jpy.fsf@gitster.g> <YGJp2VcFZ8nrtho8@google.com>
Date:   Mon, 29 Mar 2021 17:10:48 -0700
In-Reply-To: <YGJp2VcFZ8nrtho8@google.com> (Emily Shaffer's message of "Mon,
        29 Mar 2021 16:59:21 -0700")
Message-ID: <xmqqlfa5fqlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 623643FA-90EC-11EB-9E85-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> OK, we opt_init(), futz with opt, call run_hooks() and opt_clear()
>> regardless of the outcome from run_hooks().  Narrow-sighted me
>> wonders if it makes the use of the API easier if run_hooks() did the
>> opt_clear() before it returns, but I haven't yet seen enough use at
>> this point to judge.
>
> Hrm, is that idiomatic? I guess it would be convenient, and as long as
> it doesn't touch explicitly caller-managed context pointer it should be
> safe, but wouldn't it be surprising?

The precedent (at this point, I will not judge if it is a good
pattern to emulate or an anti-pattern to stay away from) I had in
mind was the run_command() which clears child_process structure
as the side effect of internally calling finish_command().

Leaving them separate is of course more flexible, but depending on
how small we can keep down the number of call patterns of this new
API, always having to clear after run might become an unnecessary
source of leaks.  When I gave that comment, I didn't have enough
input to decide, and now it has been so long since I gave my
reviews, I do not quite remember what my impression after reading
all the patches through was X-<.



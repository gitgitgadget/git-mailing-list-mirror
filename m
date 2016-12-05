Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5A01FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbcLEUwG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:52:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57233 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751244AbcLEUwE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:52:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBDB25561E;
        Mon,  5 Dec 2016 15:52:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cDN28ppzcGUuOZmL0V5Y3O3mWII=; b=uYPop7
        d8GIeM2m8wHUb6H/l2DowbR52+a8gpG0oZIrBqsA4aGm8/YdjxTb7ydkhOWjiqUL
        Hr44v4o4EDksrHQLglTKLOMgUJtaPt0qoz0DF0iznMPK5uLjqYOLGc6ZG2gQv+2o
        7HxCPp/pqh2qqc1HsqIVYT7vGv4YXyjUVkdH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EFbiAPdo9UUpPp9Ee4BbuUccgeUkKdio
        RJe3QxAwgt+zqvtFBoIDE3oMIsKmgrzC2rJlnkqGKUnqWrK4JDKXNsy/CglcI3VU
        GjXq1MGHoIagCZJxfG48zX9sKdRhQNkoxg829zopSed/bKtcVqTlevyHylbdQ9Up
        +u1RVdlnfQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9A535561B;
        Mon,  5 Dec 2016 15:52:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A70F55618;
        Mon,  5 Dec 2016 15:52:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH] commit: make --only --allow-empty work without paths
References: <20161202221513.GA5370@inner.h.apk.li>
        <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net>
Date:   Mon, 05 Dec 2016 12:52:00 -0800
In-Reply-To: <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 2 Dec 2016 23:32:55 -0500")
Message-ID: <xmqqd1h63xqn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC12F3AA-BB2C-11E6-9152-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Dec 02, 2016 at 11:15:13PM +0100, Andreas Krey wrote:
>
>> --only is implied when paths are present, and required
>> them unless --amend. But with --allow-empty it should
>> be allowed as well - it is the only way to create an
>> empty commit in the presence of staged changes.
>
> OK. I'm not sure why you would want to create an empty commit in such a
> case. But I do agree that this seems like a natural outcome for "--only
> --allow-empty". So whether it is particularly useful or not, it seems
> like the right thing to do. The patch itself looks good to me.

Slightly related topic.  

>> -	if (argc == 0 && (also || (only && !amend)))
>> +	if (argc == 0 && (also || (only && !amend && !allow_empty)))
>>  		die(_("No paths with --include/--only does not make sense."));
>>  	if (argc == 0 && only && amend)
>>  		only_include_assumed = _("Clever... amending the last one with dirty index.");
>

We allow "-o --amend" without no pathspec because that is how you
would reword without changing the tree object in the tip commit, and
we reward the user who figured out such an esoteric use with a
message "Clever...".  I do not think if people who say "I want to
create an empty commit but I already have added changes to the
index" deserve the same "Clever..." praise, so I will not suggest
adding another message above.

More seriously, I suspect that the message outlived its usefulness.
If we wanted to make the "use --amend -o without pathspec if you
want to reword the tip one without touching its tree" easier to
discover, the place to do so is in the documentation, not a message
that is given as a reward to those who already discovered it.

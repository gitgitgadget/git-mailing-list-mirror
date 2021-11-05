Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00001C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80EF61056
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhKESQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:16:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57771 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKESQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 14:16:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E6B51528A2;
        Fri,  5 Nov 2021 14:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HuXpV+TjupvKjPHVyVSd+35SERYvOuWVtQVfHh
        kaFt8=; b=RHVJYi6iJEmq3fH31qw2K/1wOUQOLogfECJMJjGLoerQB9t+TXFAvK
        sBOqch2W/vOhMa9CX2BJ2jgBbpWeJ5xCjFiOKA/FyCs9T1E2LvLMWVo2mPlgXBrB
        2aFRW87ABslMrQ5QrGGsa3dozaMUGd8O8weD86ejksxfCCzxol3n0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0806E1528A1;
        Fri,  5 Nov 2021 14:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99D561528A0;
        Fri,  5 Nov 2021 14:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <xmqq7ddn3dlt.fsf@gitster.g> <20211105112525.GA25887@dinwoodie.org>
Date:   Fri, 05 Nov 2021 11:14:04 -0700
In-Reply-To: <20211105112525.GA25887@dinwoodie.org> (Adam Dinwoodie's message
        of "Fri, 5 Nov 2021 11:25:25 +0000")
Message-ID: <xmqqfssaxyfn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 298E1336-3E64-11EC-8348-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> On Thursday 04 November 2021 at 12:49 pm -0700, Junio C Hamano wrote:
>> Adam Dinwoodie <adam@dinwoodie.org> writes:
>> 
>> > SSH keys are expected to be created with very restrictive permissions,
>> > and SSH commands will fail if the permissions are not appropriate.  When
>> > creating a directory for SSH keys in test scripts, attempt to clear any
>> > ACLs that might otherwise cause the private key to inherit less
>> > restrictive permissions than it requires.
>> 
>> All of the above makes sense as an explanation as to why the
>> ssh-keygen command may be unhappy with the $GNUPGHOME directory that
>> is prepared here, but ...
>> 
>> > This change is required in particular to avoid tests relating to SSH
>> > signing failing in Cygwin.
>> 
>> ... I am not quite sure how this explains "tests relating to ssh
>> signing failing on Cygwin".  After all, this piece of code is
>> lazy_prereq, which means that ssh-keygen in this block that fails
>> (due to a less restrictive permissions) would merely mean that tests
>> that are protected with GPGSSH prerequisite will be skipped without
>> causing test failures.  After all that is the whole point of
>> computing prereq on the fly.
>
> The issue is that the prerequisite check isn't _just_ checking a
> prerequisite: it's also creating an SSH key that's used without further
> modification by the tests.
>
> There are three cases to consider:
>
> - On systems where this prerequisite check fails, a key may or may not
>   be created, but the tests that rely on the key won't be run, so it
>   doesn't matter either way.
>
> - On (clearly the mainline) systems where this check passes and there
>   are no ACL problems, the key that's generated is stored with
>   sufficiently restrictive permissions that the tests that rely on the
>   key can pass.
>
> - On my system, where ACLs are a problem, the prerequisite check passes,
>   and a key is created, but it has permissions that are too permissive.
>   As a result, when a test calls OpenSSH to use that key, OpenSSH
>   refuses due to the permissions, and the test fails.

Makes sense.  If we can update the commit log message so that the
above three points are clear to readers without asking (all three
may not necessarily need to be spelled out in the bulletted list
form), that would be great.

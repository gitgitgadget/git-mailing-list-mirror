Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5563C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3D260E73
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGWQKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:10:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52663 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGWQKM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:10:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0227D139007;
        Fri, 23 Jul 2021 12:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l1QqeBxvgb1AeRV0BT6W+WvFpTFWmgd63nRGIS
        v3SUI=; b=jTAaFimsZTEpm4xssB1bljFC7h3Q0ZOLrNzeRIygq9uyJtgeUo5E0M
        VrA1kLSTm4D55OI9L0BK4KAh099H+Js5J7ZgqtAzlyiOCoYHj3dRUB7GmjRdnKA8
        hiNOC4GCN1NfhRiy+655UnK75GJ6eKsAfKikXEUb6Aacdl7P45rjg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE98F139006;
        Fri, 23 Jul 2021 12:50:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4555A139005;
        Fri, 23 Jul 2021 12:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Angelo Borsotti <angelo.borsotti@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Extracting a file
References: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
        <871r7qvhhr.fsf@evledraar.gmail.com>
        <CAB9Jk9DqCR8C9qx6-gZmpTQfBAKnEupQTb1WkJgN3YOqSO0=2A@mail.gmail.com>
        <YPppNYOO26xAq2fn@coredump.intra.peff.net>
Date:   Fri, 23 Jul 2021 09:50:41 -0700
In-Reply-To: <YPppNYOO26xAq2fn@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 23 Jul 2021 03:01:09 -0400")
Message-ID: <xmqq5yx1oty6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E8CC242-EBD6-11EB-AB6F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 22, 2021 at 11:46:01AM +0200, Angelo Borsotti wrote:
>
>> Actually, I did not want to make git behave like a read-only filesystem,
>> but only to be able to get what is stored in it using some easy to remember
>> command.
>> 
>> I guess that:
>> 
>>     git mv A B &&
>>     git checkout HEAD -- A
>> 
>> renames file A in the work, current, directory to B, and then recovers
>> A from the
>> repository. This changes the file on which I am working. After having
>> read the old
>> A, and understood what changes I make that are not correct, I should delete A,
>> and rename B back to A.
>> If something gets wrong with this, I risk to damage my original A.
>> This is why it is
>> better not to change it, and instead get a copy of the old one with
>> another name,
>> which is what
>> 
>> git show HASH:file/path/name.ext > some_new_name.ext
>
> You might also like "git checkout -p HASH -- A", which will let you pick
> individual hunks from HASH:A and apply them to your working tree.

There is

    git cat-file --textconv --filters HASH:A >my-temporary-file-to-inspect

which would not touch the index or any tracked working tree file,
other than the target of redirection.


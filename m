Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D9C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 00:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiCMAEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 19:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiCMAEr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 19:04:47 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2E939AD
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 16:03:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15D41174BF6;
        Sat, 12 Mar 2022 19:03:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cjewj0CBz4EYJi4AWPXMImEl2/9c8Z6mTCOkjY
        +cb5Q=; b=i3Db3eptYn47LQMiHENnXZ7oaCFrTwJGrzc8nrkYZLRrx559U+HJIe
        OVyyRVNRKsL8imy70eL+B61ikW/kH9wljYWLttywwybohKK8/i7Dy+hFLGljfmF6
        OJLSbtB+Xq5iiQWiB4QTRA1YP+j/GUjimvrj1hr3M0mNkkizjDK2g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E4EE174BF4;
        Sat, 12 Mar 2022 19:03:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.195.168.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B407174BF3;
        Sat, 12 Mar 2022 19:03:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
References: <878rtebxk0.fsf@gmail.com>
Date:   Sat, 12 Mar 2022 16:03:35 -0800
In-Reply-To: <878rtebxk0.fsf@gmail.com> (Sean Allred's message of "Sat, 12 Mar
        2022 16:38:56 -0600")
Message-ID: <xmqq4k42n2g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 081CA008-A261-11EC-BE16-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean Allred <allred.sean@gmail.com> writes:

> As a baseline, we know the following statements are true:
>
>   1. A person's preferred name can change at any time.
>   2. A person's preferred email can change at any time.
>   3. Neither of these pieces of information are necessarily
>      identifying in a given codebase.

Another thing we know is

    4. People know that old e-mail addresses stay in archives and
       address books of people, and find it wise to avoid reusing an
       address somebody else (especially well-known ones) has been
       using, so that they do not get e-mails from total strangers
       and having to tell them that the intended recipient does not
       read the mailbox anymore.

>   1. Do nothing.  Leave it to the developer to determine the correct
>      contact information without assistance.
>
>      This doesn't really resolve the confusion, but it is technically
>      an option.
>
>   2. Use gitmailmap(5) functionality to resolve historical emails to
>      primary emails.
>
>      Sadly this doesn't actually solve the email recycling problem.
>      Since one email could be used by multiple developers, there's no
>      way (that I can see) to use a single mailmap file to resolve one
>      of these emails to a single person.


GNU arch (tla) had an interesting idea around this area and used
combination of time and e-mail address to identify a person.
one@corp--$date referred to the person who had control of the
address on the specified date, where $date can be abbreviated to
2022 or 202201 to mean 20220101.

The mailmap allows "Name e-mail" or "e-mail" to be mapped to
canonical "Name e-mail", but we should be able to coax "valid time
range" information encoded in each entry of the .mailmap format,
i.e. "if you see 'Name e-mail' between time X and Y, map that to...".


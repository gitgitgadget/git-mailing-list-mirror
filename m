Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BCFC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C12120797
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ci6Z//zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbgJLWad (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:30:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63775 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbgJLWac (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 18:30:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7DEAF2FBB;
        Mon, 12 Oct 2020 18:30:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+MVotfI45Lg0B8NUfjHaw0meQsY=; b=ci6Z//
        zt7NhRw5jatrW/NroRIimCiaRyDm8Xe1ecFtOY+d+zJHtEXYDnIb3HugCAa8Y2cr
        yKNEYWn8WY8Eo1BQqUZNmIksj2R/MaQJ6bGX25VzWACnhX1tOaHa7k7/7Gvhaaop
        qww9Wy3VJl4rAyoGKHgvUtyEeSmI2nzM9rvzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yfBFKcx4rD5dj7ahg4qPu3yIDen5MQU6
        czJJVMgIn/6aupk6TXzpssqZay9vxSf5NBG54raxMpAsi9W6mu6Ienzjwe+rcckF
        0ig5COOeswSLUtjeMQrs2ubeuyjSdmr3Lw4ujqC2MGHlLFYqn1AJQ02ScY/mGI/h
        V+FSZ0ljgoE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0D5CF2FBA;
        Mon, 12 Oct 2020 18:30:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 03B02F2FB8;
        Mon, 12 Oct 2020 18:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, masayasuzuki@google.com
Subject: Re: [PATCH] remote-curl: add testing for intelligent retry for HTTP
References: <20201012184806.166251-1-smcallis@google.com>
        <20201012201940.229694-1-smcallis@google.com>
        <xmqqy2kbmalb.fsf@gitster.c.googlers.com>
        <CAM4o00e4wYOHkn38H8UwqboRMSzAs4QCvTN6Ef6PuUnYfwOoXg@mail.gmail.com>
Date:   Mon, 12 Oct 2020 15:30:25 -0700
In-Reply-To: <CAM4o00e4wYOHkn38H8UwqboRMSzAs4QCvTN6Ef6PuUnYfwOoXg@mail.gmail.com>
        (Sean McAllister's message of "Mon, 12 Oct 2020 16:20:49 -0600")
Message-ID: <xmqqd01nm60u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86E2151C-0CDA-11EB-9435-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean McAllister <smcallis@google.com> writes:

>> Sean McAllister <smcallis@google.com> writes:
>>
>> > +# generate a random 12 digit string
>> > +gen_nonce() {
>> > +    test_copy_bytes 12 < /dev/urandom | tr -dc A-Za-z0-9
>> > +}
>>
>> What is the randomness requirement of this application?  IOW, what
>> breaks if we just change this to "echo 0123456789ab"?
>>
>> Or "date | git hash-object --stdin" for that matter?
>>
>> We'd want to make our tests more predictiable, not less.
>
> The randomness requirement is just that I need nonces to be unique
> during a single run of the HTTP server
> as they uniquefy the files I put on disk to make the HTTP hack-ily
> stateful.  I'd be fine with your date/hash-object
> solution, but I don't know that it will help make the tests more predictable.

If so, would something like this be

    global_counter_for_nonce=0
    gen_nonce () {
	global_counter_for_nonce=$(( global_counter_for_nonce + 1 )) &&
	echo "$global_counter_for_nonce"
    }

more appropriate?  It is utterly predictable and yields the same
answer only once during a single run.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA97C1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbdAYUO7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:14:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56989 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751016AbdAYUO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:14:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 911C862356;
        Wed, 25 Jan 2017 15:14:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hEh/SY5FA5SGKP6D9bd5Va2A4Mc=; b=pLSF7W
        7smXU0fHyAzEt5H7eWlgTl/6e5uMxksqWlINv4IcE4mqzSV4yPzu6a/AEYOFrPJb
        IWcYOJ6HxiT3sJM5DDwTvKFX5+eyPrtIzYANPkfCO1ZnSpXvA566yACcazkDNrDq
        pMiHscZWxQPV9Mq0a2BAWPuZyXnH+bITU1cwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iCRAKucxuArTcsoskRfmyLRmYds+icwU
        iUnGffjTHU7XIxsNMlqWWqHEs8EG/3/yBSvwZuno15wXwnDGMUL+rA+xg54I7VPM
        rRHT6g4/IM6HJ2Buvvpo01W7D7w7V+H/OimFhkiDI+sV+1MWerJliaAk+KteZ9Kg
        VRtBFBtEp6s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86B6F62355;
        Wed, 25 Jan 2017 15:14:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5F4162353;
        Wed, 25 Jan 2017 15:14:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check structure
References: <20170112235354.153403-1-bmwill@google.com>
        <20170123203525.185058-1-bmwill@google.com>
        <20170123203525.185058-26-bmwill@google.com>
        <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
        <20170123220614.GA187696@google.com>
        <20170124011135.GB187696@google.com>
        <xmqqinp5p4x2.fsf@gitster.mtv.corp.google.com>
        <20170125195745.GA83343@google.com>
Date:   Wed, 25 Jan 2017 12:14:55 -0800
In-Reply-To: <20170125195745.GA83343@google.com> (Brandon Williams's message
        of "Wed, 25 Jan 2017 11:57:45 -0800")
Message-ID: <xmqq1svqc2ww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0CC5C26-E33A-11E6-9747-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> In my mind, the value of having a constant check_attr is primarily
>> that it gives us a stable pointer to serve as a hashmap key,
>> i.e. the identifier for each call site, in a later iteration.
>
> We didn't really discuss this notion of having the pointer be a key into
> a hashmap, what sort of information are you envisioning being stored in
> this sort of hashmap?

The "entries relevant to this attr_check() call, that is specific to
the <check_attr instance, the thread> tuple" (aka "what used to be
called the global attr_stack") we discussed would be the primary
example.  A thread is likely be looping in a caller that has many
paths inside a directory, calling a function that has a call to
attr_check() for each path.  Having something that can use to
identify the check_attr instance in a stable way, even when the
inner function is called and returns many times, would allow us to
populate the "attr stack" just once for the thread when it enters a
directory for the first time (remember, another thread may be
executing the same codepath, checking for paths in a different
directory) and keep using it.  There may be other mechanisms you can
come up with, so I wouldn't say it is the only valid way, but it is
a way.  That is why I said:

>> But all of the above comes from my intuition, and I'll very much
>> welcome to be proven wrong with an alternative design, or better
>> yet, a working code based on an alternative design ;-).

near the end of my message.

> One issue I can see with this is that the
> functions which have a static attr_check struct would still not be thread
> safe if the initialization of the structure isn't surrounded by a mutex
> itself. ie

Yes, that goes without saying.  That is why I suggested Stefan to do
not this:

> static struct attr_check *check;
>
> if (!check)
>   init(check);
>
> would need to be:
>
> lock()
> if (!check)
>   init(check);
> unlock();

but this:

	static struct attr_check *check;
	init(&check);

and hide the lock/unlock gymnastics inside the API.  I thought that
already was in what you inherited from him and started your work
on top of?


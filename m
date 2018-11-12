Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896571F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 04:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeKLN4X (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 08:56:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60110 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLN4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 08:56:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DC392E7A8;
        Sun, 11 Nov 2018 23:05:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1E50b8Bc9QGia8IJIzO3gf61M3M=; b=cC6oGs
        kdu4DD0N0cvm5r1tL/cScqdyA1yNcf7ZZjBlu4rCkpmW4UXFbU3ItcS+V8BcXj39
        A0pxgekFLXl8HmVwvyK3p/DySpqQmm7Qd2WxccVCYyWPlQoe9OzVeBNb3vH1iVz9
        rAwkJCjdAc2lxKxIbFEBu+XW/lv9/wpF0K0fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vEXELp00ex8wncf5sL99hpvIosRwcUOs
        bMLVTPrk3MfNKNd+QcPntwV92nShFbxVqXMMXr6t7Gb+mym50ZrfgEMgOhWx7CwW
        YJ8U6xAreTpIXTrbccpseJYNNbo74mlZXQvz66zdzaWvNxrxpdbaN5UTUwJLCAKQ
        H/Xqu46LyfE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 278242E7A7;
        Sun, 11 Nov 2018 23:05:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7E992E7A5;
        Sun, 11 Nov 2018 23:04:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior where appropriate
References: <pull.72.git.gitgitgadget@gmail.com>
        <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com>
        <20181109101148.GB7410@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Nov 2018 13:04:53 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 9 Nov 2018 18:21:41 +0100 (STD)")
Message-ID: <xmqq1s7r3pqy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D49D7AC-E630-11E8-896E-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >  static int reset_head(struct object_id *oid, const char *action,
>> > -		      const char *switch_to_branch, int detach_head,
>> > +		      const char *switch_to_branch,
>> > +		      int detach_head, int reset_hard,
>> 
>> It might be worth switching to a single flag variable here. It would
>> make calls like this:
>> 
>> > -	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
>> > +	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1, 0,
>> >  	    NULL, msg.buf))
>> 
>> a little more self-documenting (if a little more verbose).
>
> I thought about that, but for just two flags? Well, let me try it and see
> whether I like the result ;-)

My rule of thumb is that repeating three times is definitely when we
should consolidate separate ones into a single flag word, and twice
is a borderline.

For two-time repetition, it is often worth fixing when somebody
notices it during the review, as that is a sign that repetition,
even a minor one, disturbed a reader enough to point out.  On the
other hand, for a file-scope static that is likely to stay as a
non-API function but a local helper, it may not be worth it.

So I am OK either way, slightly in favor of fixing it while we
remember.


>> This one could actually turn into:
>> 
>>   ret = error(...);
>>   goto leave_reset_head;
>> 
>> now. We don't have to worry about an uninitialized desc.buffer anymore
>> (as I mentioned in the previous email), because "nr" would be 0.
>> 
>> It doesn't save any lines, though (but maybe having a single
>> cleanup/exit point would make things easier to read; I dunno).
>
> But you're right, of course. Consistency makes for easier-to-read code.

Yup, that does sound good.

Thanks.

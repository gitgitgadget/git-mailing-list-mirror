Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B697F205F4
	for <e@80x24.org>; Sun,  1 Jan 2017 10:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbdAAKgx (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 05:36:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60958 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752517AbdAAKgw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 05:36:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 947F756835;
        Sun,  1 Jan 2017 05:36:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uM0mWWVtGhZbVqoPXzp1o6hlfKA=; b=Y6zmtP
        d9vRtyW6U0obdlfBlkt2xq8asKq+sNSZ+AqzugACqVUmPjD60h2/Zc2eUYaRCqth
        LsQqvjWMEgFL1X1q4t4kzKezehsk9rKb3sQvRhO2tEgHFNG5iN5owrKGrTT3n50U
        4q15SAwvurXAC+kAEGkw/+mIGua7OEB8KTwiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u/9vFNWZETQQP+toIHHxg3l8Y+P11m3h
        aUv4cxrOXFGLCDfm9qqgjSOrrZ5IyoFktB0P9tuMpc7Rj35aCf8JHpLlr1ZtGKnT
        o0k4ZGzOhwcgI7x+5h4hddboDzb5rhPBn5E82UOJSattZGVOw04jwIwR++3jZgYv
        bAusCMl6VY0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8ACDF56834;
        Sun,  1 Jan 2017 05:36:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 086F856833;
        Sun,  1 Jan 2017 05:36:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 13/23] log_ref_setup(): pass the open file descriptor back to the caller
References: <cover.1483153436.git.mhagger@alum.mit.edu>
        <ef2355e9d5ccaa53928c821530bae59f2b118013.1483153436.git.mhagger@alum.mit.edu>
        <20161231063211.tqsiafg3iahcuotz@sigill.intra.peff.net>
        <f5ced16d-61dc-ba14-7f29-88f20d4a65d2@alum.mit.edu>
        <20161231175808.cvm54nmk3x7zoipo@sigill.intra.peff.net>
Date:   Sun, 01 Jan 2017 02:36:49 -0800
In-Reply-To: <20161231175808.cvm54nmk3x7zoipo@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 31 Dec 2016 12:58:08 -0500")
Message-ID: <xmqqd1g73w3i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3482F348-D00E-11E6-B87F-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Dec 31, 2016 at 08:58:43AM +0100, Michael Haggerty wrote:
>
>> > The return value is always "0" or "-1". It seems like it would be
>> > simpler to just return the descriptor instead of 0.
>> > 
>> > I guess that makes it hard to identify the case when we chose not to
>> > create a descriptor. I wonder if more "normal" semantics would be:
>> > 
>> >   1. ret >= 0: file existed or was created, and ret is the descriptor
>> > 
>> >   2. ret < 0, err is empty: we chose not to create
>> > 
>> >   3. ret < 0, err is non-empty: a real error
>> 
>> I don't like making callers read err to find out whether the call was
>> successful, and I think we've been able to avoid that pattern so far.
>
> I guess my mental model is that case 2 _is_ a failure, because we didn't
> open the reflog. It's just one that callers may want to distinguish from
> case 3, because it's probably a silent failure, not one we want to
> complain to the user about.
>
> But whether that's accurate would depend on the callers. Looking at the
> callers, I think the immediate callers would be happier with this, but
> you probably would want to end up converting case 3 back to "return 0"
> out of files_log_ref_write().
>
>> > I dunno. This may just be bikeshedding, and I can live with it either
>> > way (especially because you documented it!).
>> 
>> Let's see if anybody has a strong opinion about it; otherwise I'd rather
>> leave it as is.
>
> Sounds good.

FWIW, in my mental model, 2. is not a failure ("we returned without
creating new log because that is what was asked by the user").  A
true failure case is "we wanted to open but couldn't".

The caller needs to be able to differentiate between these two cases
because we get no usable fd out of the function in either case.

I agree that we could cram the error status and the file descriptor
into a single return value as you two discussed, but I think what
the patch chose to do is easier to use from the callers' point of
view.  The caller can switch between the codepath to give an error
message and the non-error codepath based on the return value, and in
the non-error codepath can choose what to do based on the value of
logfd.

I do not mind "all negative values mean there is no fd" plus "some
negative values are more special than others" convention, and if a
patch did that from the beginning, I certainly would not suggest to
rewrite it to use the "error status comes as a return value, file
descriptor is an out parameter" convention; i.e. I personally do not
see much difference either way, so...

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65811F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdCBTJq (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:09:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60900 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750787AbdCBTJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:09:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE087834C7;
        Thu,  2 Mar 2017 12:52:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AaXp12X4qxbf+1tLU8ws+GQqoJc=; b=CcLvhf
        +HyQh0lzZ3onVjCX11LMOSGFI0RL1R/GNy6RqHhx+CPSbNAV75vx+tdI7mSqi6Qw
        9uj9StbL+wEqIvn3zeOT5F9M+hmGWEFI6FG2Y8mkAOe2HN8AAXYSMEQ9M5pNH8dm
        kAEvT+VHYnd83a15kf4uL93qeqAsHTgUwxeSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ONOeZj90wtuvKpcyMsJhHFPeSA2XzvH3
        5Pctnus5It+ItByHVbKBOxclvcPLsi2Grz2G1wlU8vH6qzZGe3jBhgFktqTGP6fx
        A3AfQWcvkrHGzXFDYcwqu/4XGYKdlf/DII5QgrOfFGqvU8z4MsMXvqAx74yPYKQ1
        7CbQFifin+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C629A834C6;
        Thu,  2 Mar 2017 12:52:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39C9D834C5;
        Thu,  2 Mar 2017 12:52:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     tboegi@web.de, git@vger.kernel.org, mac@mcrowe.com
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
        <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
        <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
        <20170302085313.r6dox4wa2kqnp7ao@sigill.intra.peff.net>
Date:   Thu, 02 Mar 2017 09:52:21 -0800
In-Reply-To: <20170302085313.r6dox4wa2kqnp7ao@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 2 Mar 2017 03:53:13 -0500")
Message-ID: <xmqqmvd3d0ru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD4D9A58-FF70-11E6-82C9-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/diff.c b/diff.c
>> index 8c78fce49d..dc51dceb44 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2792,8 +2792,25 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>>  			s->should_free = 1;
>>  			return 0;
>>  		}
>> -		if (size_only)
>> +
>> +		/*
>> +		 * Even if the caller would be happy with getting
>> +		 * only the size, we cannot return early at this
>> +		 * point if the path requires us to run the content
>> +		 * conversion.
>> +		 */
>> +		if (!would_convert_to_git(s->path) && size_only)
>>  			return 0;
>
> The would_convert_to_git() function is a little expensive (it may have
> to do an attribute lookup). It may be worth swapping the two halves of
> the conditional here to get the short-circuit.

Yes.  I think it makes sense.

>> +
>> +		/*
>> +		 * Note: this check uses xsize_t(st.st_size) that may
>> +		 * not be the true size of the blob after it goes
>> +		 * through convert_to_git().  This may not strictly be
>> +		 * correct, but the whole point of big_file_threashold
>
> s/threashold/threshold/

Thanks.  I felt there was something wrong and looked at the line
three times but somehow failed to spot exactly what was wrong ;-)

>
>> +		 * and is_binary check being that we want to avoid
>> +		 * opening the file and inspecting the contents, this
>> +		 * is probably fine.
>> +		 */
>>  		if ((flags & CHECK_BINARY) &&
>>  		    s->size > big_file_threshold && s->is_binary == -1) {
>>  			s->is_binary = 1;
>
> I'm trying to think how this "not strictly correct" could bite us. 

Note that the comment is just documenting what I learned and thought
while working on an unrelated thing that happened to be sitting next
to it.

Nobody asks "I am OK without the contents i.e. size-only" and "Can
you see if this is binary?" at the same time (and if a caller did,
it would never have got is_binary with the original code).  s->size
is still a copy of st.size at this point of the code (we have not
actually updated it to the size of the real blob, which happens a
bit later in the flow of this codepath where we actually slurp the
thing in and run the conversion).  So with or without this patch,
there shouldn't be any change in the behaviour wrt CHECK_BINARY.

> For
> line-ending conversion, I'd say that the before/after are going to be
> approximately the same size. But what about something like LFS? If I
> have a 600MB file that convert_to_git() filters into a short LFS
> pointer, I think this changes the behavior. Before, we would diff the
> pointer file, but now we'll get "binary file changed".

To be quite honest, I do not think this code should cater to LFS or
any other conversion hack.  They all install their own diff driver
and they can tell diff_filespec_is_binary() if the thing is binary
or not without falling back to this heuristics codepath.

What is done here *is* inconsistent with what is done on the other
side of if/else, that compares big_file_threshold with in-git size,
not in-working-tree size.  That may want to be addressed, but I am
not sure if it is worth it.

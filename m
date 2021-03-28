Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E06C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B5C6197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhC1SGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 14:06:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65312 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1SGT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 14:06:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D190EBCD50;
        Sun, 28 Mar 2021 14:06:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dcjA+lHhI/DhqdzTOHDVMn714vE=; b=IQVRAw
        iKieBQIpcO73SjXyPyJSYSaMvxhlno3XsJMyGmd3LXATDqlvty8LDQl2yedfNJmf
        EVdKnOO7hf2YZG0SRbJjrulYWZi5+0Z+xHGjn23aZVUjN68V48E1BB9LDMcSE53h
        P/gAq1Z5uoIDXbksq84Ar9xcKzA7T1NWaWgdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rgMn3sgq3F7kdAo7tvwkGauVxsBElpKY
        IE9TQwFX0qgU9BiZJ4xNk7b4V9Ldwgbx5QkojPvpbb/vpa9tzYAi+A4Ml9q2vddZ
        sRGDCozGdvnE/329EehfoEy99hAUsCUtfUh3WZwhyFvMkt1zUugLYBQY17S9HE8z
        6K6qh+mUWCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8F86BCD46;
        Sun, 28 Mar 2021 14:06:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59707BCD45;
        Sun, 28 Mar 2021 14:06:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
References: <20210327173938.59391-1-raykar.ath@gmail.com>
        <xmqq5z1cqki7.fsf@gitster.g>
        <EBC020E6-BE8B-4332-8225-A988CB7CFA69@gmail.com>
Date:   Sun, 28 Mar 2021 11:06:17 -0700
In-Reply-To: <EBC020E6-BE8B-4332-8225-A988CB7CFA69@gmail.com> (Atharva
        Raykar's message of "Sun, 28 Mar 2021 17:21:16 +0530")
Message-ID: <xmqqft0fm9uu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B564466-8FF0-11EB-A995-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

>>> +         "(\\.|[^][)(\\}\\{ ])+"),
>> 
>> One or more "dot or anything other than SP or parentheses"?  But
>> a dot "." is neither a space or any {bra-ce} letter, so would the
>> above be equivalent to
>> 
>> 	"[^][()\\{\\} \t]+"
>> 
>> I wonder...
>
> A backslash is allowed in scheme identifiers, and I erroneously thought that
> the first part handles the case for identifiers such as `component\new` or 
> `\"id-with-quotes\"`. (I tested it with a regex engine that behaves differently
> than the one git is using, my bad.)

Ah, perhaps you didn't have enough backslashes.  A half of the
doubled one before the dot is eaten by the C compiler, so the regexp
engine is seeing only a single backslash before the dot, which means
"literally a single dot".  If you meant "literally a single
backslash, followed by any single char", you probably would write 4
backslashes and a dot---half of the backslashes would be eaten by
the compiler, so you'd be passing two backslashes and a dot, which
is probably what you meant.

Having said that, two further points.

 - the "anything but whitespaces and various forms of parentheses"
   set would include backslash, so 'component\new' would be taken as
   a single word with "[^][()\\{\\} \t]+", wouldn't it?

 - how common is the use of backslashes in identifiers?  I am trying
   to see if the additional complexity needed to support them is
   worth the benefit.

> But somehow, the regexp you suggested, ie:
>
> 	"[^][()\\{\\} \t]+"
>
> does not handle the case of make\foo -> make\bar (it will only diff on foo).
> I am not too sure why it treats backslashes as delimiters.

Perhaps because you have included two backslashes inside [] to say
"backslash is not a word character" in the original, and I blindly
copied that?  IOW, do you need to quote {} inside []?

> Yes, this is exactly what I was trying to express. All words should be
> delimited by either whitespace or a parenthesis, and all other special
> characters should be accepted as part of the word.

That sentence after "All words should be..." would be a good comment
to replace what you wrote in the original, then ;-).

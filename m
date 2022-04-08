Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F9C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 23:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbiDHXmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 19:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiDHXmm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 19:42:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D078427933E
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 16:40:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F0DA18AE57;
        Fri,  8 Apr 2022 19:40:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=mV8Aypnd3F0MZ9ZNzK7cRaGYS7g8Sf4Ugt7PAN4H2ec=; b=f0id
        Hgm8OEqcxSZysTSNpQI6Jhoca5mgH4ImX+VuytMo0Hf+c/9vPgenu8qTFnPx91EB
        Pie/trUFN+228yeG/UQWw4HVzD6aBdodqoRqlgOoR2iPHy3T7pHfZZhL4UfX6u0S
        O7UbeVCwC9cigbAhSnI4SIyMb2cpoPfBNJjPQiw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57EAA18AE56;
        Fri,  8 Apr 2022 19:40:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEF9318AE55;
        Fri,  8 Apr 2022 19:40:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Raphael <raphael@pdev.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty format: fix colors on %+ placeholder newline
References: <e8417ad5-f9f2-c1de-75f6-45be49f0011b@pdev.de>
        <20220405154529.966434-1-raphael@pdev.de> <xmqq8rshx687.fsf@gitster.g>
        <978e7684-2b91-379b-2fdf-bf0453bff30c@pdev.de>
Date:   Fri, 08 Apr 2022 16:40:33 -0700
Message-ID: <xmqqmtgvjg9a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 492C905A-B795-11EC-9E97-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raphael <raphael@pdev.de> writes:

> On 06.04.22 23:16, Junio C Hamano wrote:
>> It is very good to start the proposed log message by describing the
>> current behaviour, highlighting what problem it has.  Because the
>> message is merely _proposing_ to make this change, which may or may
>> not be accepted into the codebase, however, please describe the
>> status quo in the present tense. 
> I understand that for proposing changes this makes sense.

OK

> But if the change would be accepted into the code, wouldn't the text
> become the commit message?

Yes.  Our history records what proposals were made in the past, and
"git log" is the way to learn about them.

> I assumed it is sensible to write the
> message for that case: Using the present tense for the state of the
> code at this commit / after the patch.

I was not saying what you did was unconditionally wrong.  I
understand that you wrote in the past tense with good intentions.
The conventions are different from project and project, and I was
merely telling you what the project convention around here is.

> Using "cat" as a pager produces the correct coloring, but since "less"
> is the default pager I find it useful to follow its conventions:
> Namely that lines are started non-colored and escape sequences must be
> repeated at the beginning of each colored line.

Even if it may be a problem with the pagers, we are OK to help such
pagers if the workaround we need to make is reasonable and does not
involve too much 'bending over backwards' work.  That much we have
already established before seeing this patch in the previous
discussion thread on this, I thought ;-)

But this is a behaviour change, if not limited to the --graph thing,
that probably would affect other usecases negatively.

>> It also is unclear why the new behaviour to save only one "color
>> escape" is sufficient.  For example, if we used
>>      git log --pretty='format:%h%C(green)%C(reverse)%+d test'
>> --graph
>> wouldn't the effects of these two add up?
>
> You are right, I forgot about this case.
> A naive solution would be to concatenate the format escapes and
> clearing the string when the color is reset.

There is vt100/ansi sequence to save/restore attributes, no?  I am
not sure if it passes the "reasonable and not too much" bar if we
have to save all the previous attribute requests ourselves.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F2C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiG0OVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiG0OU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 10:20:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B0DEC4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 07:20:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14D9E1BD83B;
        Wed, 27 Jul 2022 10:20:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=A/6VTFe9IjzYndaxeuTTs970jVlJxkcozulOBKMA8Zo=; b=TNPT
        lDgk9sHv7Lwd4pwbmcfJrLM1z2n4CdCqpTK9vFUUsE7Moem8BabZqoTR4cyLf/Sz
        hlGxzUFKdfijNTCyQvGo+zG8fq6g1cMLdcQUJN1dAFvv7ITMfOpihYpKnuCNa/8o
        sQOO5+ZyZXCYEMyw37Dwz5B6R0WG+OXtjGVyzbg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E4391BD83A;
        Wed, 27 Jul 2022 10:20:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 155791BD837;
        Wed, 27 Jul 2022 10:20:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input
 with `-z`
References: <cover.1658532524.git.me@ttaylorr.com>
        <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
        <xmqq4jz8bdcg.fsf@gitster.g> <Yt8sQ6kPoUUQFjle@nand.local>
Date:   Wed, 27 Jul 2022 07:20:51 -0700
Message-ID: <xmqqo7xatz5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5266C03C-0DB7-11ED-9BBC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Jul 22, 2022 at 10:35:43PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > @@ -14,7 +14,7 @@ SYNOPSIS
>> >  'git cat-file' (-t | -s) [--allow-unknown-type] <object>
>> >  'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
>> >  	     [--buffer] [--follow-symlinks] [--unordered]
>> > -	     [--textconv | --filters]
>> > +	     [--textconv | --filters] [-z]
>>
>> Is "-z" useful with any other option, or is it useful only in
>> combination with one of the three --batch-*?  The above suggests the
>> former.
>
> It only makes sense with `--batch`-related options. But doesn't the
> above suggest the latter, not the former? That synopsis line begins
> with:
>
>     'git cat-file' (--batch | --batch-check | --batch-command) ...
>
> which made me think that this was the invocation for batch-related
> options, and only listed options that made sense with a `--batch` mode
> of one kind or another.

Ah, yes you are absolutely right.  I misread the synopsis.

> I think the helper should probably be something more like:
>
>     echo_with_nul () {
>         echo "$@" | tr '\n' '\0'
>     }

I think you meant

	printf "%s\n" "$@" | tr ..

but then I wonder if

	printf "%s\000" "$@"

would work better?

>> > +	printf "HEAD:newline${LF}embedded" >in &&
>> > +	git cat-file --batch-check -z <in >actual &&
>>
>> As I already said, I suspect that new users who know how our path
>> quoting works would expect c-quoted path would work just fine
>> without using "-z".  It is not a reason to refuse "-z" to exist,
>> though.
>
> Yeah. I think we can do both, if there is a need.

Even though we know it is needed already, it is unfortunately way
too late now X-<, because existing scripts know that paths are not
taken as c-quoted, even though people would naturally expect that
paths are, and satisfying the latter expectation now means breaking
existing scripts.

In any case, as long as "-z" is designed right from the day one, it
would be fine ;-)

Thanks.

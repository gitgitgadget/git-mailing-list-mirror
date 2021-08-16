Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBEC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8EB604DC
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhHPQvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:51:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58601 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPQvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:51:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36BB9F3DDC;
        Mon, 16 Aug 2021 12:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Som3DsWgMvz5U1WfbxNlQV3ijxDVImc+QsPay6
        D/brE=; b=T0UQn7Sjsug0HsTf1mt+bxM8ebLF5PCYqpjAL+NKGOCiZkBgW5Gieh
        nl41hZgokqkc1082WBJQ9eD2FimPFA2iexiXg0LNQcDmSsoDks6SeWOD1oU5CmBF
        FFh3j70YFFnjh4VTtTjBGVcLm/BC/1ox/Gt/vem3mRAhC8kgNC4Kk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C636F3DDB;
        Mon, 16 Aug 2021 12:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B3D1F3DDA;
        Mon, 16 Aug 2021 12:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
        <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
        <20210813180056.ctzivmakj4bj5apa@nitro.local>
        <xmqq35rbtx84.fsf@gitster.g>
        <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
        <YRqQJTyBW6j6b2pW@coredump.intra.peff.net>
Date:   Mon, 16 Aug 2021 09:51:06 -0700
In-Reply-To: <YRqQJTyBW6j6b2pW@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 16 Aug 2021 12:19:49 -0400")
Message-ID: <xmqq4kbps58l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26E8111E-FEB2-11EB-AC95-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 16, 2021 at 09:11:43AM -0400, Konstantin Ryabitsev wrote:
>
>> > I do not think it is feasible to immediately rename the two choices
>> > to SSL/TLS vs StartTLS without transition period, but the first
>> > patch in the three-patch series there to update the documentation
>> > alone may have helped this case.
>> > 
>> > We may also want to error out when seeing an unknown option other
>> > than 'ssl' and 'tls', as the necessary first step to make it
>> > possible to later safely accept StartTLS as a synonym for 'tls' and
>> > 'ssl/tls' as a synonym for 'ssl'.
>> 
>> Is it easier to just add less ambiguous aliases, eventually phasing out old
>> terminology?

There is no issue around ambiguity.  The problem is that the code
does not complain a bogus value in $smtp_encryption---when it is
'ssl', ssmtp gets used, when it is 'tls', StartTLS gets used,
otherwise we do not see any errors.

>> tls -> starttls
>> ssl -> smtps
>> 
>> This way we don't have to change anything, and "smtps" is a valid way to refer
>> to smtp over ssl (e.g. see /etc/services for 465/tcp).
>
> FWIW, those options make quite a bit of sense to me (and I agree the
> transition to them would be easy).

Back when we had the original discussion in April [*], I think we
found one small glitch that we need to solve before we can start
introducing aliases---setting the variable to unknown value (imagine
you set it to 'starttls' and then run a version of Git that does not
know it yet) does not make Git barf but silently ignore.  

And that needs to be changed to die, and versions of Git with such a
change, without any alias added, should be allowed to spread to
eradicate the "silently ignore" version, before we can safely start
adding aliases.

Other than that, the transition is not harder than any other
transition we've done in the past.


[Reference]

* https://lore.kernel.org/git/xmqqtuo9kgo0.fsf@gitster.g/

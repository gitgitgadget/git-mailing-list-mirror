Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B286208DB
	for <e@80x24.org>; Sat, 26 Aug 2017 01:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbdHZBQz (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 21:16:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55850 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754048AbdHZBQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 21:16:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4A5EACF21;
        Fri, 25 Aug 2017 21:16:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qiaJYJM/h29kwAU6+y9NEaH7QxA=; b=dZsd2/
        GNGmViFbExk+rDgmH14LEyTvOWAs7uXBvYKgWLOV+ZGkmAbKkxvKianoHbr2L/g4
        UupRHA+FGj0ncy4vqBjvgNqvqXwPK++7ZdOxmdAAGYjVGCXBotgUb09c9xg9ZA7n
        iPf1Syt5UIn3CVBVekyIAhLsmg1Tm956RJxhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O8lX+Ld6kWB+U/JSPuFDFHjGYkn0IwDF
        zcxCM0aHuO6EVauIITxjZzsAZTC4KO65Q12MGIcEz+ZKCcsGCnhvL6nHpNm25m46
        /nYj9QGoOFOVFvweoCihnEHCTOxcr332AU6PDqauZbxlAjaEhv1sMcbFgXJg2Psw
        EzvGo1xuoFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBDD5ACF20;
        Fri, 25 Aug 2017 21:16:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36CC0ACF1F;
        Fri, 25 Aug 2017 21:16:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: git signed push server-side
References: <22944.38288.91698.811743@chiark.greenend.org.uk>
        <20170826003229.GL13924@aiede.mtv.corp.google.com>
Date:   Fri, 25 Aug 2017 18:16:51 -0700
In-Reply-To: <20170826003229.GL13924@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 25 Aug 2017 17:32:29 -0700")
Message-ID: <xmqqo9r3qgak.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E8E9826-89FC-11E7-82D8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I think respecting gpg.program would be nicer.  Is there a reason not
> to do that?
>
> I suspect receive-pack just forgot to call git_gpg_config.

That would be a good change.

> How is the keyring configured for other commands that use GPG, like
> "git tag -v"?  (Forgive my laziness in not looking it up.)

AFAIR we never do anything special, so you should be able to point
GNUPGHOME to wherever you like to use the desired configuration.

> I also wonder why you say the git configuration system is unsuited to
> keeping secrets.  E.g. passing an include.path setting with -c or
> GIT_CONFIG_PARAMETERS should avoid the kinds of trouble you described.
> Is there a change we could make to make it work better?  That said, I
> think being able to name a file is a good idea.

I also wonder that too.  The configuration file that has the
filename could be made just as secret and unreadable from public as
the new file that stores the seed with the same mechanism, I would
imagine.

>> 5. There are no docs on how to use this feature properly
>>    (Debian #852695, #852688 part 1)
>>
>> Using the signed push feature requires careful programming on the
>> server side.  There should be a doc explaining how to do this.

This was rather deliberately left underspecified, hoping that the
BCP would emerge after people gain experience.  As Ian is looking
into this and hopefully gain real-world experience, we can have a
good BCP description after he is done with his project ;-)

> Yes, that sounds like a very welcome kind of thing to add.

Indeed.

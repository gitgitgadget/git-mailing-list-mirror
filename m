Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4356A1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbcLEWnu (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:43:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56454 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751618AbcLEWnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:43:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6146855832;
        Mon,  5 Dec 2016 17:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9LsDSqqM6MsCp5YceJm6QzcJnfU=; b=KtOMty
        Iq1e9YFMcpSowUWckVQ2sm8bXlMujBw2egbSeecPfWU9GBX9DcsaUcIlYiNbhNgu
        rK/ltoUvSiP2kiRZeCfqsRVf+rhUtReB8KQM2rHZuTVBeUZBKkYyo0oDD4K5C8W6
        bJeCCTwINF1AyUEss2VKB+OMnvPy3ZpqwGVJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pvgNtH4KTod0BnhpgkFjCI0MzY4ePIVo
        b9QWSYf+CW6sg5Nem5kt17ABzKGIdrGBU/MYUmNv13JiP8MYeUM/1y6uV9Rh7g+n
        MBL+jYOH5fuhrEJHChAhOLM/xKKhR/EeOY68WDHUPQPKulKi8qLQ4u9ptPSVZMOp
        hpJs+h9faNA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50D6B55831;
        Mon,  5 Dec 2016 17:43:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD63D55830;
        Mon,  5 Dec 2016 17:43:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jack Bates <bk874k@nottheoilrig.com>, git@vger.kernel.org,
        Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH] diff: fix up SHA-1 abbreviations outside of repository
References: <20161204194747.7100-1-jack@nottheoilrig.com>
        <xmqqr35m6dwt.fsf@gitster.mtv.corp.google.com>
        <20161205072614.zg6yglqnznna65vf@sigill.intra.peff.net>
Date:   Mon, 05 Dec 2016 14:43:46 -0800
In-Reply-To: <20161205072614.zg6yglqnznna65vf@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 5 Dec 2016 02:26:14 -0500")
Message-ID: <xmqqmvga2dzx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48ECCBBA-BB3C-11E6-9D80-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that it may be an accident waiting to happen, though, as soon as
> some buried sub-function needs to care about the distinction.

Yes to that.

>> I wonder if we're better off if we made sure that diff_no_index()
>> works the same way regardless of the value of "have_repository"
>> field?
>
> If you mean adding a diffopt flag like "just abbreviate everything to
> FALLBACK_DEFAULT_ABBREV even if we're in a repository", and then setting
> that in diff_no_index(), I agree that is a lot cleaner.

I am not sure if that is what I meant (I no longer sure what exactly
I meant to say there TBH), but this is probably not limited to the
default abbrev length aka core.abbrev configuration.  Don't we have
other configuration settings we may read from $HOME/.gitconfig (and
possibly per-repository .git/config, if we did discovery but were
explicitly given "--no-index") that want to affect the behaviour of
the command?  

I guess what I wanted, with "the same way", to see happen was that
"have_repository" should be only controling how and from what files
the configuration is read, and the behaviour of the command should
be controlled by the values read from the configuration after that.

Specifically, even if we were running with "--no-index", if we know
we have access to the current repository discovered by setting it up
gently, I do not think it is bad to ask find_unique_abbrev() to come
up with an appropriate abbreviation.  So the fact that patch in
question has to flip the have_repository bit off, if it is done in
order to affect what diff_abbrev_oid() does, smells quite fishy from
that point of view.


Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ACEC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 22:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9C12177B
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 22:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sPiL4jKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgJMWGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 18:06:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52360 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJMWGo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 18:06:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FFA096AEF;
        Tue, 13 Oct 2020 18:06:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oV3Lw9DlTOudl3f9QTV7/vqbrU0=; b=sPiL4j
        Kz+LGw36TCT3nlGGuq4WyKTMeG1wM5j2Owa22fwvm10oCVkMVNEjY0LOW0L37wJF
        dkvajlO9fcpf86B9Mw6UYfMBYarb/62AzgM4iAvWuPWkHutPL9UUuFLXJpRdJqyQ
        94wHNC6pSANAalsLQweMTTl9Hel1wMoBRauZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rkRhiUxskNOO8GGcVkpOwx+NIh37tTjy
        AmRnSQOWReFQkPG+Oh9pNKZFUr0ulCcVLHTTMUGwCPnx6L8LSqkzGyXePi/Qd5q/
        /I5ucnmIWfG7yG2Kiobmg+8XKXiHVSvCRs4uxKrGJRPD0LbZ1YJHkiWPLSR0eAbQ
        Rkgt7cqTnOg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3F7F96AEE;
        Tue, 13 Oct 2020 18:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2800596AED;
        Tue, 13 Oct 2020 18:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
References: <20201012234901.1356948-1-samuel@cavoj.net>
        <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
Date:   Tue, 13 Oct 2020 15:06:40 -0700
In-Reply-To: <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com> (Phillip Wood's
        message of "Tue, 13 Oct 2020 11:02:38 +0100")
Message-ID: <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F6D0A84-0DA0-11EB-B00B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   +test_expect_success 'rebase -r, GPG and merge strategies' '
>> +	git reset --hard merged &&
>> +	git rebase -fr --gpg-sign -s resolve --root &&
>> +	git verify-commit HEAD
>> +'
>
> Unfortunately I've just noticed that the test above runs
>
> 	git config commit.gpgsign true
>
> So this test would pass anyway if merge picks up that config
> setting. The previous test needs to be changed to
>
> 	test_config commit.gpgsign true
>
> so that the config setting is cleared when that test finishes.

Thanks for a review, but I do not think that is a right way to go.

test_config has an inherent assumption that not having the config at
all is somehow the "natural" state, and if that holds true, that
would be OK.  But what is "natural" is subjective X-<.

The way each test is run by calling test_rebase_gpg_sign repeatedly
uses a different and more robust approach to ensure that previous
test does not affect the current one.  Each invocation of test
explicitly sets the configuration to the state the test wants to,
cancelling what the previous test did.

To blend in better with existing tests and match their robustness
expectations, the right fix is for this new test to explicitly use
"git config --set" or "git config --unset" to make the variable into
the desired state, regardless of what the previous tests did.  

If the test quoted at the beginning of this message wants to make
sure that --gpg-sign from the command line takes effect without
commit.gpgsign set, it should unset the variable explicitly.
Another combination worth testing is to ensure that --gpg-sign takes
effect when commit.gpgsign is explicitly set to false (not "left
unset").

Thanks.




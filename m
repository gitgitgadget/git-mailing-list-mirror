Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6624A1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbfFYSSf (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 14:18:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65090 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfFYSSf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 14:18:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4ECF6D5F1;
        Tue, 25 Jun 2019 14:18:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+B0J1a4nlLJb0SuSenkhVumMHKU=; b=KVtrPH
        XKBAMeSSvmdgG8H7w7uoIHmL60pKZSzuFAzYlzSu9A0lPAocVkf6smOg8nQr6ReG
        ehPNGtEuUROf7bGcAvivD2xg9F+DEbki6+5tqUD26N7VvvOCMJZCulo+CT24gth9
        TxA+6jTrtAKjqDj910zyTZ5CCOVE83VPDO6B4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JVlLZFD3JcE9yuCcCcpRMyNxD5n/+9f+
        G06PigZ+GyJyjcqudYKaXNH/ppZe+yCmyEBl3SFos86wJ/AVA2davgrjOPQbVWOX
        9bw15tu6YG6G71audfqBqdF8XFTNMiucXrRKzGX+gd7jNOnneqqVP7oQwioVuMIN
        kzcn/mbKzp8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDFC46D5EF;
        Tue, 25 Jun 2019 14:18:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 23D176D5E6;
        Tue, 25 Jun 2019 14:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Morian Sonnet <moriansonnet@gmail.com>,
        MorianSonnet@googlemail.com,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.us>
Subject: Re: [PATCH] submodule foreach: fix recursion of options
References: <xmqqsgryhmqt.fsf@gitster-ct.c.googlers.com>
        <20190624202653.13810-2-MorianSonnet@googlemail.com>
        <CACsJy8BnpkfYwKJiz2u5=yhoyLQzu5yAcsvmL75bxWop=ZRh0A@mail.gmail.com>
Date:   Tue, 25 Jun 2019 11:18:27 -0700
In-Reply-To: <CACsJy8BnpkfYwKJiz2u5=yhoyLQzu5yAcsvmL75bxWop=ZRh0A@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 25 Jun 2019 18:18:05 +0700")
Message-ID: <xmqqef3hfs0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A24FEC88-9775-11E9-8B0D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jun 25, 2019 at 5:02 AM Morian Sonnet <moriansonnet@gmail.com> wrote:
>>
>> Calling
>>
>>     git submodule foreach --recursive <subcommand> --<option>
>>
>> leads to an error stating that the option --<option> is unknown to
>> submodule--helper. That is of course only, when <option> is not a valid
>> option for git submodule foreach.
>>
>> The reason for this is, that above call is internally translated into a
>> call to submodule--helper:
>>
>>     git submodule--helper foreach --recursive \
>>         -- <subcommand> --<option>
>>
>> This call starts by executing the subcommand with its option inside the
>> first level submodule and continues by calling the next iteration of
>> the submodule foreach call
>>
>>     git --super-prefix <submodulepath> submodule--helper \
>>       foreach --recursive <subcommand> --<option>
>>
>> inside the first level submodule. Note that the double dash in front of
>> the subcommand is missing.
>>
>> This problem starts to arise only recently, as the
>> PARSE_OPT_KEEP_UNKNOWN flag for the argument parsing of git submodule
>> foreach was removed in commit a282f5a906. Hence, the unknown option is
>> complained about now, as the argument parsing is not properly ended by
>> the double dash.
>
> My bad. Last time I checked *.sh but forgot about *.c. I looked around
> this time in *.c. This should be the only submodule--helper invocation
> that needs "--".

Thanks, both.  Will queue.

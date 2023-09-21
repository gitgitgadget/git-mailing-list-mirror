Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28714E7D0B0
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjIUV7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjIUV6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:58:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EDC469BB
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 13:43:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E39D31B2826;
        Thu, 21 Sep 2023 16:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vjkxaoA0E49Q8IQ7wMtQiBwqzr9cSd6G6Kxz1u
        pZyo0=; b=UcgKm+T7cwlWfM6KUJM3gY7nDiIKAc9A08GSkO8XNcrjyqtrhm38Oa
        l6PtLC2T2LHjc/f6ovdu7klNdI2emubS6jJozU1to4hA8zvlswc2JEaHrRisH99Y
        W4IyILn6qzkzSRXFRo76vG7KwMqqDYow243eSY6v/80hPUQ639RwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB7311B2825;
        Thu, 21 Sep 2023 16:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A7D31B2824;
        Thu, 21 Sep 2023 16:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
In-Reply-To: <d6527c54-7dbc-46ee-b73d-49653edda0d9@gmail.com> (Bagas Sanjaya's
        message of "Thu, 21 Sep 2023 14:51:38 +0700")
References: <ZQhI5fMhDE82awpE@debian.me>
        <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
        <ZQknHjKdGZV3vJpV@debian.me>
        <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
        <118975ef-c07f-c397-5288-7698e60516a7@amd.com>
        <ZQrQsa5GJEVhBttT@debian.me> <xmqq7cokc0kj.fsf@gitster.g>
        <d6527c54-7dbc-46ee-b73d-49653edda0d9@gmail.com>
Date:   Thu, 21 Sep 2023 13:42:55 -0700
Message-ID: <xmqq1qer5kc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 719DCB72-58BF-11EE-ADDD-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 20/09/2023 22:43, Junio C Hamano wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>>> Originally, I was intended to report regression on handling multiple
>>> addresses passed in a single --to/--cc/--bcc option.
>> 
>> You refer to v2.40 and v2.41 in the message I am responding to, but
>> do you have a bisection?  There seem to have been five topics around
>> send-email during that timeperiod.
>> 
>>  $ git log --oneline --first-parent v2.40.0..v2.41.0 git-send-email.perl
>>  b04671b638 Merge branch 'jc/send-email-pre-process-fix'
>>  64477d20d7 Merge branch 'mc/send-email-header-cmd'
>>  b6e9521956 Merge branch 'ms/send-email-feed-header-to-validate-hook'
>>  c4c9d5586f Merge branch 'rj/send-email-validate-hook-count-messages'
>>  647a2bb3ff Merge branch 'jc/spell-id-in-both-caps-in-message-id'
>
> I'll make one on the separate report.

Alright.  The next task from your end may be to see if you can
bisect to find which topic broke your expectation.

Thanks.

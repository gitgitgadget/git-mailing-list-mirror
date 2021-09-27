Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732DAC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6298B610A2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhI0U4L convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Sep 2021 16:56:11 -0400
Received: from elephants.elehost.com ([216.66.27.132]:56878 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbhI0Uzz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:55:55 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 18RKs4It017772
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Sep 2021 16:54:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "'The Grey Wolf'" <greywolf@starwolf.com>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net> <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com> <YU49+Y+nRhl1mgof@coredump.intra.peff.net> <xmqqa6k1slxe.fsf@gitster.g> <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net> <xmqqo88eq8um.fsf@gitster.g> <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
In-Reply-To: <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
Subject: RE: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Date:   Mon, 27 Sep 2021 16:53:59 -0400
Message-ID: <00ee01d7b3e1$ceb06840$6c1138c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHNlhe/H9xUBWexP8Y5jg2L0M3l4gJZS/JsALVatmcCOYbmaACH6NfUAkwXmUIDEF/Nx6tzMU2Q
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 27, 2021 4:16 PM, Jeff King wrote:
>Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
>
>On Mon, Sep 27, 2021 at 09:30:41AM -0700, Junio C Hamano wrote:
>
>> >> This asserts what? FOO=" bar"?
>> >
>> > Whoops, that should have been "envIs", asserting that $FOO contains
>> > "bar".
>>
>> Oh, "can we check with a literal with leading whitespace?" was what my
>> question was about ;-)
>
>My assumption was that nobody would really care about doing so. It is true that it's less flexible, though (and is a decision we can't easily
>take back later).
>
>> > As I said, I think it matters more with the infix operators, as:
>> >
>> >   [includeIf "env:FOO == bar"]
>> >
>> > is more readable than:
>> >
>> >   [includeIf "env:FOO==bar"]
>>
>> Sure, but at that point, we'd probably want some quoting mechanism for
>> the literal to be compared, e.g.
>>
>> 	[includeIf "env:PATH ~= \"(:|^)/usr/bin(:|$)\""]
>
>Ick. The extra quoting of the internal double-quotes is pretty horrid to look at. Also, how does one match a double-quote in the value? \\\"?
>
>If it were optional, that would make the common cases easy (no dq, no whitespace), and the hard ones possible.
>
>I think this is getting into a bit of a digression, though. I'm willing to defer to Ævar, who is doing the actual work, and I don't know if he has
>found any of this compelling. ;)

What about something like:

	[includeIf "env:PATH ~= '^(.*😊)/usr/bin(:.*)*$' "]

Using single quotes and a full regex pattern instead of trying to provide a syntax to extract a pattern and then match. One call to regexec() would be easier. Then escaping is regcomp's problem (mostly). Potentially, you could even remove the outer ", but that would be wonky. You could omit the ^ and $ by default assuming a full match.
-Randall


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B035C1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbcH2RRX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:17:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64665 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753510AbcH2RRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:17:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBA5D37DE1;
        Mon, 29 Aug 2016 13:17:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z8ohS0RN9zvQ4NGVMdFkkj+f4tc=; b=ZqcUF1
        90KtoYp4fWAL2Ty95azVVEXbK8P6qbk7ZOl8XDTizCoi7xrit/WJ+exSD9ijKuT8
        uRBLrTgn41rvezMiG7r7miw3aP8nF6CWThFe9dYG70OLipX++Zaw1REQj8j8bACW
        6OluJ4uB94jf80QfyKsci64TbNv0STfmyrOjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nLhZzwMahIBpyhEHaCTcmIacdrSac1OH
        u5r5ztaSB5oZavZqKUkszeZ0htAQO7GFeCGDLHSxGpe1YL94zlXJBiQ6PGVgalRM
        JgoeBYI+Cg8eM9cH/z8MwkPBjX+ZCOQi3QqsbWK2jR6mYAe/YZQN5s5zvMSGvcjc
        xwYVXF5FOJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B297E37DE0;
        Mon, 29 Aug 2016 13:17:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 497B937DDF;
        Mon, 29 Aug 2016 13:17:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v14 08/27] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe69f-6b734e3c-806c-431d-aa52-c96b3783f248-000000@eu-west-1.amazonses.com>
        <xmqqlgzlolwa.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPP2j-+C=J-hiWEiW4wa=Yso27-M-QUABCTyd4WYieeezw@mail.gmail.com>
Date:   Mon, 29 Aug 2016 10:17:19 -0700
In-Reply-To: <CAFZEwPP2j-+C=J-hiWEiW4wa=Yso27-M-QUABCTyd4WYieeezw@mail.gmail.com>
        (Pranit Bauva's message of "Sat, 27 Aug 2016 14:44:04 +0530")
Message-ID: <xmqqfupncx5s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72079926-6E0C-11E6-94BA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Hey Junio,
>
> On Thu, Aug 25, 2016 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>> +static int is_expected_rev(const char *expected_hex)
>>> +{
>>> +     struct strbuf actual_hex = STRBUF_INIT;
>>> +     int res = 0;
>>> +     if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 0) {
>>> +             strbuf_trim(&actual_hex);
>>> +             res = !strcmp(actual_hex.buf, expected_hex);
>>
>> If it is known to have 40-hex:
>>
>>  (1) accepting ">= 0" seems way too lenient.  You only expect a
>>      41-byte file (or 42 if somebody would write CRLF, but I do not
>>      think anybody other than yourself is expected to write into
>>      this file, and you do not write CRLF yourself);
>>
>>  (2) strbuf_trim() is overly loose.  You only want to trim the
>>      terimnating LF and it is an error to have other trailing
>>      whitespaces.
>>
>> I think the latter is not a new problem and it is OK to leave it
>> as-is; limiting (1) to >= 40 may still be a good change, though,
>> because it makes the intention of the code clearer.
>
> I can do the first change. Since this wasn't present in the shell
> code, I will also mention it in the commit message.

There is no need for that, as that was present in the original.  The
original compared the string with something that is known to be
40-hex, so anything shorter than 40 wouldn't have matched.

It is merely a trivial and obvious optimization to do that in C
rewrite.

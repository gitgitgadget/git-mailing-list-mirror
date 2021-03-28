Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F0C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B9C61864
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhC1VnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 17:43:17 -0400
Received: from mx.99rst.org ([52.22.122.190]:50837 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhC1VnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 17:43:16 -0400
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id 201D343C8B;
        Sun, 28 Mar 2021 21:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616967796;
        bh=wJ/645db2d9iN3g+ziiNNj+vFYRNN5+Fs4ufslPe9RU=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=cZkD6YgvmASIFSq34Sizb8s30HryAJfZKLXjPgtRMWuqV5++LTtyg23Efl7Q74EhE
         7c5RLvkjS7wzD8V2extHRQ2+3TNr+Mwhf3GvdX+1DCFl2y2vZGcdJZff+bWLPaiEHl
         tJvgv4sm5kv3YAPUu90bH+m9WoZlLcfDbDncDz+0XQMvTqMWf22adJwTCM8P1CGXF8
         hC4HNwTpvUR+I2oIBe3YV0VOD8v5HcOcMKdAhzjNyauZfYl6QtOmJrARg4Sd5UlnRS
         PZSrqVNuc/tHiaJQ5CRH7FQXgWLeZEo+t2DU/w97tR8wbmvg/Kd8u7Yrcm4Bt9Ohsf
         Nk9ncxVY6Z0Cg==
Received: by mail.kodaksys.org with HTTP;
        Sun, 28 Mar 2021 21:43:16 -0000
Message-ID: <14ebc48b8b7bee23dbcf19942f1f9029.squirrel@mail.kodaksys.org>
In-Reply-To: <xmqqczvkoxzx.fsf@gitster.g>
References: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
    <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
    <xmqqlfaf6nu9.fsf@gitster.g>
    <6f656f62497fb7c9322432b5eb151b86.squirrel@mail.kodaksys.org>
    <xmqqczvkoxzx.fsf@gitster.g>
Date:   Sun, 28 Mar 2021 21:43:16 -0000
Subject: Re: [PATCH v4] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
User-Agent: SquirrelMail
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Georgios Kontaxis" <geko1702+commits@99rst.org> writes:
>
>>> I'll defer to others who are more familiar with gitweb and Perl
>>> ecosystem if this is warranted, but I have a feeling that importing
>>> and using Mail::Address->parse() only because we want to see if a
>>> given "<string>" is an address is a bit overkill and it might be
>>> sufficient to do something as crude as m/^<[^@>]+@[a-z0-9-.]+>$/i
>>> ...
>>>> +	while ($line =~ m/(<[^>]+>)/g) {
>>>> +		my $match = $1;
>>>> +		if (!is_mailaddr($match)) {
>>>> +			next;
>>>> +		}
>>>> +		my $offset = pos $line;
>>>> +		my $head = substr $line, 0, $offset - length($match);
>>>> +		my $redaction = "<redacted>";
>>>> +		my $tail = substr $line, $offset;
>>>> +		$line = $head . $redaction . $tail;
>>>> +		pos $line = length($head) + length($redaction);
>>>
>>> Hmmmm, Perl suggestions from others?  It looks quite strange to see
>>> that s/// operator is not used and replacement is done manually with
>>> byte position in a Perl script.
>>>
>> If there's a more elegant way to do the above we can certain do that
>> instead.
>
> For example, if we do not insist on using overkill Mail::Address->parse(),
> we could do something silly like this:
>
> 	$line =~ s/<[^@>]+@[a-z0-9-.]+>/<redacted@address>/ig;
>
> no?
>
It's not clear if you think it's overkill because we have to depend on an
external module or because we don't need accurate parsing.

The above expression seems to get the job done but it isn't the correct
way to parse an e-mail address.
But if it's good enough for the reviewers I don't feel strongly about it.

If we prefer accurate parsing but don't like depending on Mail::Address,
it's easy to write complete expressions ourselves. (In a separate,
internal, Perl module)

Thoughts?



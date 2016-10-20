Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089261F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbcJTWOg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 18:14:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751722AbcJTWOg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 18:14:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 741BB4803D;
        Thu, 20 Oct 2016 18:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+r7mSfX7jGMSe5ftk/JF8gfMPDk=; b=pYYSOO
        PySoKqc63HLs+JJV2kxsTfemA6uGikIhK1oaAZ3saUyrg9RY+5GK45KkgYGVNHrz
        /t2z2OjEzeQGNztgBlOCIFAGDuXOlQja8MdYDGGFXFvm/Ikv07EOj3uqpdPBfZvA
        slZ6jATCpHkEkNXaIpOPw5/aBiSro4p9wTs3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sv+gnF+2MBfCriThqkwjAjdXweaN5zY9
        EthPl7BrAf8pcCNeSJI4Hbs8DKx+sT6ZlmPufPGSLdPvfWVkFth3Sj8Xe2wZtNCI
        mRKkSQAFX4DaZwLcMGQugUOv0kCw1mrR95dK+zhl+DrvzeBwlNQ9Ke9II8UNSO2q
        Keop7dTvyOw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BCB34803B;
        Thu, 20 Oct 2016 18:14:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA6F848039;
        Thu, 20 Oct 2016 18:14:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476998988.git.jonathantanmy@google.com>
        <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
        <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
Date:   Thu, 20 Oct 2016 15:14:31 -0700
In-Reply-To: <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 20 Oct 2016 15:07:02 -0700")
Message-ID: <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94912B90-9712-11E6-B2E2-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +static int find_separator(const char *line)
>> +{
>> +       const char *c;
>> +       for (c = line; ; c++) {
>> +               if (!*c || *c == '\n')
>> +                       return -1;
>> +               if (*c == '=' || strchr(separators, *c))
>> +                       return c - line;
>> +       }
>
> I was about to suggest this function can be simplified and maybe
> even inlined by the use of strspn or strcspn, but I think manual
> processing of the string is fine, too, as it would not really be shorter.

Hmm, I fear that iterating over a line one-byte-at-a-time and
running strchr(separators, *c) on it for each byte has a performance
implication over running a single call to strcspn(line, separators).

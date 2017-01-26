Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D12C1F794
	for <e@80x24.org>; Thu, 26 Jan 2017 18:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdAZSrH (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:47:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752168AbdAZSrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:47:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7992D63DAC;
        Thu, 26 Jan 2017 13:44:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfUYae9IIeMhQXLM117g2Z4ZBcY=; b=Y1Vxm4
        ImxVW418b1YbInY0KHGrGeJGSoCMipKyHITcfcHLtdjwQHc4YY+rchpfVSgn1OC+
        xBs/sf7D9+/affUJYbHNOjMx0ib4YOWuopIz/RcF+zf0mDpieRS/Zvuu2eqXQrsb
        hzliJUzyrdGjkaMm1oKpYn1nU2Nav6sh0WQro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d+QekjIYwZxMGGmxHVN6NR81iNTlTKVW
        jQGR1Lwk4mI4Isrrru0SptoavB2DFDFoYjiZPYVDAC8imK38i3yl2hlsVSlRCG2a
        RZCRSNl3FmAG0iL9Dmjc6M7N7JDgVL56bilczR0le+oZscJWhTxiYYsKkTv9M0p/
        LT/MPs0TZKY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57D6C63DAB;
        Thu, 26 Jan 2017 13:44:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC5D863DA9;
        Thu, 26 Jan 2017 13:43:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after --exclude
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
        <20170125125054.7422-1-pclouds@gmail.com>
        <20170125125054.7422-5-pclouds@gmail.com>
        <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
        <CACsJy8ATM_kc5SPY0dqprUefRy3vtpKW-4QEyJFK54jw0QgeJA@mail.gmail.com>
Date:   Thu, 26 Jan 2017 10:43:58 -0800
In-Reply-To: <CACsJy8ATM_kc5SPY0dqprUefRy3vtpKW-4QEyJFK54jw0QgeJA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 26 Jan 2017 16:28:17 +0700")
Message-ID: <xmqq8tpx64r5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 667C3D1C-E3F7-11E6-A29D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jan 26, 2017 at 3:57 AM, Jeff King <peff@peff.net> wrote:
>> I don't think it means either. It means to include remotes in the
>> selected revisions, but excluding the entries mentioned by --exclude.
>>
>> IOW:
>>
>>   --exclude=foo --remotes
>>         include all remotes except refs/remotes/foo
>>
>>   --exclude=foo --unrelated --remotes
>>         same
>>
>>   --exclude=foo --decorate-reflog --remotes
>>         decorate reflogs of all remotes except "foo". Do _not_ use them
>>         as traversal tips.
>>
>>   --decorate-reflog --exclude=foo --remotes
>>         same
>>
>> IOW, the ref-selector options build up until a group option is given,
>> which acts on the built-up options (over that group) and then resets the
>> built-up options. Doing "--unrelated" as above is orthogonal (though I
>> think in practice nobody would do that, because it's hard to read).
>
> This is because it makes sense to combine --exclude and
> --decorate-reflog. But what about a new --something that conflicts
> with either --exclude or --decorate-reflog?

I would think that "--exclude=foo --something --remotes" 

 * should be diagnosed as an error if "--something" is not compatible
   with "--exclude";

 * should take effect at the concluding "--remotes" if "--something"
   is similar to "--decorate-reflog" whose effect ends at a
   concluding --remotes/--branches/etc.; and

 * should work independently if "--something" is neither.


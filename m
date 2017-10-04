Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220582036B
	for <e@80x24.org>; Wed,  4 Oct 2017 05:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdJDFUO (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 01:20:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64486 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750909AbdJDFUN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 01:20:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD3AD9608E;
        Wed,  4 Oct 2017 01:20:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=533BBZjLISkI27RWh+2JMvLWKtA=; b=rNdtOS
        b7HhhkSSoi2PkdlE3pK/CfKbYD0lGUxKExLRk2mh43ZWX3P6Kf0uxmHqt5gNFgJu
        oTIRLp/5WxveMLQKWCGIj8fvk9O5bxJdPYrPhN2PCYwg+hj5QazFNJ0mD0BCsY7V
        rd08Rgdx/d8wpIJIexIrepY2YBChs7tkFVkD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=POJe4KXuGL2+ma+i/sbS9+LH8zG4mrp8
        wPUh9oLQxHXtEBHQ5/o+s4hOGPj6a3XZJyM4U/rBGSHWBdNybn6i01zqpltNeIVl
        keHNoxXJ0jBY1IHDIWXKAyNBStwvCl3IdL8TxnGJf8jfUxW5vFZg/y3/KKItmrSp
        9vwG4+MTFfs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C30659608C;
        Wed,  4 Oct 2017 01:20:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 312E69608A;
        Wed,  4 Oct 2017 01:20:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH 2/3] http-push: fix construction of hex value from path
References: <20171003195713.13395-1-t.gummerer@gmail.com>
        <20171003195713.13395-3-t.gummerer@gmail.com>
        <20171003225315.GE19555@aiede.mtv.corp.google.com>
        <20171003233638.fq6lgls2qsucfbn3@sigill.intra.peff.net>
        <xmqqbmlnecxd.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 04 Oct 2017 14:20:05 +0900
In-Reply-To: <xmqqbmlnecxd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 04 Oct 2017 13:48:14 +0900")
Message-ID: <xmqqy3orcwvu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF5AF00A-A8C3-11E7-964A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> Moreover, this is in the webdav-based "dumb http" push code path,
>>> which I do not trust much at all.  I wonder if we could retire it
>>> completely (or at least provide an option to turn it off).
>>
>> I would really like that, too. It has been the cause of a lot of pain
>> when working with the smart code, and I am not at all surprised to find
>> a bug of this magnitude lurking in it. I'd _hoped_ this could show that
>> the system has been unusably broken for years, which would give us
>> confidence to turn it off. :) But per your paragraph above, people could
>> very easily still have been happily using it in the meantime.
>
> Same here.  Perhaps we should deliberately and silently break it and
> see who screams?

Hopefully it should be obvious but just for people with unreasonable
expectations, I should clarify that the above needs a smiley ;-).

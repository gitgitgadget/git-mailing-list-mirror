Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC67C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFEA920715
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WXKa61WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYSKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:10:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63897 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:10:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4F60DDDCB;
        Tue, 25 Aug 2020 14:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T2wUj3b91PD9kHA5yTI9l21jPdI=; b=WXKa61
        WHdlIBBXhtciq8ZlrLYk7Ph7bPbURk6EsMIRWbgNMYUbyzjrxBkAw+uyiSIHTi5t
        OpZ3sMBJkFW6m8x+aaAeB/hfzrWDkL0CYoFWznMnBMPhDDkmzrfvJS8G637PNwbk
        G1A2ZbsNGe8heRjIDcl1wQOG4pU2pJl9V2LVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hEkE/XR7q3tChWz6sUDIopc0Q0h6ibH1
        D7XvswJAN5nrtrpu97msNHHfxsy1flsNQsh73PZcrXmrF8GKaurKkf4sFhLznoes
        d+o+XhYphi0zSg83sDf7ZmHHwJgUL+0L/xjwlc/hqEkabdK5827O2tETx9VpAl+H
        +OKBXDe7cGo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E5E5DDDCA;
        Tue, 25 Aug 2020 14:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC7B2DDDC9;
        Tue, 25 Aug 2020 14:09:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] refs: remove lookup cache for reference-transaction hook
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
        <c1cae6dd19ffe00e4456e4f96ad92277ceeced27.1598349284.git.ps@pks.im>
        <20200825151053.GA1409139@coredump.intra.peff.net>
Date:   Tue, 25 Aug 2020 11:09:54 -0700
In-Reply-To: <20200825151053.GA1409139@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 25 Aug 2020 11:10:53 -0400")
Message-ID: <xmqqd03e1tsd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E2FA706-E6FE-11EA-A5FC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 25, 2020 at 12:35:24PM +0200, Patrick Steinhardt wrote:
>
>> The only change compared to v1 is that I've addressed the unportable
>> `branch-{1..1000}` syntax in favor of `test_seq`. I had to setup refs as
>> part of the setup and change the ordering for "update-ref --stdin" from
>> create/update/delete to update/delete/create, but I don't think that's
>> too bad. At least timings didn't seem to really change because of that.
>
> Another option instead of changing the order in the other tests is to do
> another untimed setup step before the push test. I'm OK either way,
> though.
>
>> +test_perf "nonatomic push" '
>> +	git push ./target-repo.git $(test_seq 1000) &&
>> +	git push --delete ./target-repo.git $(test_seq 1000)
>>  '
>
> This works as far as Git is concerned, but "seq 1000" output with NULs
> is 3893 bytes. I wonder if some platforms might run into command-line
> limits there.

That was my thought when I saw the above as well.  In addition, I do
not think it is a good idea to encourage digit-only refnames.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665D71F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKSB4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:56:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSB4H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:56:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B427980D9;
        Mon, 18 Nov 2019 20:56:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dVDKNs+1VCxPyYNkUGPSuP+yXPk=; b=hzImLt
        0GHPVOWiw4/VlxPj2jE7/EPNk6sdiKcl0L32cDwREPv3H3Exs/0tEUg1ycWxpWaX
        WrW3M94cv7OKTDoh2DN7J11JPJge5roG24b65su0AUm4pIsXasr4aOjd2fIzwudb
        Lgbfd88mCp1D4syxu8eumpSOE7+IwtYx0boBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pwlIIKVX+wxK/HjJ0tCZppkpxq4PbA5L
        HwmnArxFGSA/xmqv3d83WZQ8I7WDjc5j14p4X7F7IEmMvx30S2i3yinPniicpMnx
        UlYNFSmVvZF+Iao6l7/FanOzpzRmfpyYy+mB4MnBjpOh3veqSEi4+SIKo1oX8MH0
        ubt45n/BGQc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23EA3980D8;
        Mon, 18 Nov 2019 20:56:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50395980D7;
        Mon, 18 Nov 2019 20:56:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Erik Chen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Erik Chen <erikchen@chromium.org>
Subject: Re: [PATCH v3 1/1] fetch: add trace2 instrumentation
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
        <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
        <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
        <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
        <944c956e-dd9a-1a12-5cb1-0c263ee7d5bd@gmail.com>
Date:   Tue, 19 Nov 2019 10:55:59 +0900
In-Reply-To: <944c956e-dd9a-1a12-5cb1-0c263ee7d5bd@gmail.com> (Derrick
        Stolee's message of "Mon, 18 Nov 2019 10:46:56 -0500")
Message-ID: <xmqqsgmkzl1s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD65F946-0A6F-11EA-92B1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/7/2019 12:32 AM, Junio C Hamano wrote:
>> So this introduces a single region around the entire function body
>> of mark_complete_and_common_ref(), within which only one subpart is
>> also enclosed in a nested region.  Is that because the parts inside
>> the outer region before and after the inner region are known to
>> consume negligible time?  IOW I would understand
>> 
>>         F () {
>> ...
>>         }
>> 
>> or
>> 
>>         F () {
>>                         trivial code
>>                 <region 1 begin>
>>                         heavy code
>>                 <region 1 end>
>>                         trivial code
>>         }
>> 
>> but this appears to do
>> ...
>> which is somewhat puzzling.
>
> I notice that a v4 was sent that adds more sub-regions without actually
> responding to this request. (It is worth also pointing out that you
> ignored Junio's request you use the cover letter to explain your reasoning
> for changes between versions.)

Thanks for noticing.  I wasn't requesting any change in particular
(at least not yet), but was inquiring the reasoning behind what was
done.  From that point of view, the lack of answers was worse than
yet another patch that does not explain why it was done that other
way this time around.

> There is a real downside to nesting regions like this. Specifically, we
> frequently limit the depth that we report nested regions to avoid
> overwhelming the logs.
>
> In general, these sub-regions should be avoided when possible and instead
> create regions around important sections, such as the second option Junio
> lists above.

Thanks for a clear direction as the area expert of trace2.

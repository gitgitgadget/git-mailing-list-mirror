Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4BBC4332D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207332076C
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 22:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nseAT+CX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCRWlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:41:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60737 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRWlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 18:41:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB5803E6C5;
        Wed, 18 Mar 2020 18:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MIN9hO0m68HWjy+HTii4VFqf8g8=; b=nseAT+
        CXCgiYu2piflsoi/mgu7Zhp2pNHUW7wrNnWY06f27jvUFBTk4DW/oStt2XjjOC3M
        gUo5q7dm8UTY3fft9dj2ndgXI8nM8MhadcjaJavzc3mLQH0rXg4HH4t1yGhrmH6F
        U6W4yFDD/ueddYT9ej4YdqCnz4neIgT4XliZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GjzlawtUW91v5bF5qYbpK9MwTO07Mndt
        3rDPiiYn1U9ovNvbVpvAuRFCvP5fRgIotoVN4UlVeeUhFpUfPtlxz6E9iwKls+TF
        Am6WoumOarzlzhYQh29oIH+Ljx7hNYkIVsGRcYn2mRYUBu5JSGpc7/K+wZRikUrK
        cjs3Zw3+dS0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3C423E6C4;
        Wed, 18 Mar 2020 18:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FEC73E6C3;
        Wed, 18 Mar 2020 18:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        christian.couder@gmail.com, james@jramsay.com.au
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
        <cover.1584477196.git.me@ttaylorr.com>
        <20200318101825.GB1227946@coredump.intra.peff.net>
        <20200318212818.GE31397@syl.local>
Date:   Wed, 18 Mar 2020 15:41:51 -0700
In-Reply-To: <20200318212818.GE31397@syl.local> (Taylor Blau's message of
        "Wed, 18 Mar 2020 15:28:18 -0600")
Message-ID: <xmqq4kulffps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A966F7E8-6969-11EA-AD11-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> We tried equals, like:
>>
>>   uploadpack.filter=blob:none.allow
>>
>> but there's an interesting side effect. Doing:
>>
>>   git -c uploadpack.filter=blob:none.allow=true upload-pack ...
>>
>> doesn't work, because the "-c" parser ends the key at the first "=". As
>> it should, because otherwise we'd get confused by an "=" in a value.
>> This is a failing of the "-c" syntax; it can't represent values with
>> "=". 

s/value/key/ I presume ;-)

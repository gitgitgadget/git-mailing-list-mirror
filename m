Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F88C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C97613C8
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhJUS0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:26:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58877 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhJUS0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:26:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B978EBB11;
        Thu, 21 Oct 2021 14:24:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bFysu0mYb36+
        Jb0Wn5M77sWtp6kc0lsZpacayIwIWck=; b=ggOiqqkQNZD6Typb50TPmWB2NwlE
        ooA/1hC2u/8e429rG0P6goYNJlp6YJk4a2YjIrYrTdk7XcZHnlT+7MHa1pnrL/iW
        EFurxEk1q+rL2dW6RELMT1JySOMPp2uCh65HoNMJIVBTXpuYERSzkX1IFNHQQPWA
        MWHax/+RiujWBX8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5281DEBB0F;
        Thu, 21 Oct 2021 14:24:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4C1DEBB0C;
        Thu, 21 Oct 2021 14:24:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 7/8] Makefile: stop having command-list.h depend on a
 wildcard
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
        <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <patch-7.8-0c6f9b80d3b-20211020T183533Z-avarab@gmail.com>
        <YXF9DQuj0541ULku@coredump.intra.peff.net>
Date:   Thu, 21 Oct 2021 11:24:33 -0700
In-Reply-To: <YXF9DQuj0541ULku@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 21 Oct 2021 10:45:33 -0400")
Message-ID: <xmqq4k9ame1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 244CC15C-329C-11EC-972B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 20, 2021 at 08:39:58PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>>  get_synopsis () {
>> +	head -n 10 "Documentation/$1.txt" |
>>  	sed -n '
>>  		/^NAME/,/'"$1"'/H
>>  		${
>>  			x
>>  			s/.*'"$1"' - \(.*\)/N_("\1")/
>>  			p
>> -		}' "Documentation/$1.txt"
>> +		}'
>>  }
>
> By the way, I'm not sure about the utility of this change. It reduces
> the number of lines that sed looks at, but at the cost of an extra
> process. That's probably a net loss. And if we did want to limit the
> data sed covers, doing "pq" after we matched would be simpler.

Doesn't the above

 - slurp the lines into hold space while we are in the synopsis
   part;
 - otherwise keep reading and discarding;
 - and do the processing at end

So presumably, instead of waiting till the end, can't we immediately
process the thing and exit?

I guess your "'pq' after we matched" is saying the same thing.  I
agree that extra process with an ad-hoc limitation of 10 does leave
a bad taste in my mouth.

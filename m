Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B79D1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbcHaUJn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:09:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58276 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752513AbcHaUJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:09:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29A903BE2F;
        Wed, 31 Aug 2016 16:09:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zsXu5xEv149kWFNbvCHxnQYRcUE=; b=shTdJc
        gqSVyd3Ly6/RSZT7zYH41ZbNwSJYdaDmZyzOPblgWZCl7g9lUS9gRj9DmLPGyRQi
        +EtoZd0LVcU4+sux4JJ3FTenVGt3Bg2NA8T7yFHfVHKfi/QcaimTSYcG2/VNZL9O
        znC1hB2EK1wVoM6QbNWlbf+gCgCblL0sthp4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mlrN+SIfUFF8s5d/SahNM2M9Iw9AFqiM
        HJqVy6XMEoOjwXnxcxjCK06fuZ0iEQcgsWKpu47jv2ZktDofxVsZPa7X9CBWXoLX
        13auzasZLG/XOQitatir27QPz7TIbP93MdZrEudNLhXl+nQNQMRXVBEbLTCeWcUE
        NScEcK2RB28=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 213853BE2E;
        Wed, 31 Aug 2016 16:09:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2EE73BE2B;
        Wed, 31 Aug 2016 16:09:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] git-send-email: Add ability to cc: any "bylines" in the commit message
References: <aa4c9e0b37e70423baa69bc27cc9adda0f152efe.1472669418.git.joe@perches.com>
        <xmqq4m6020nh.fsf@gitster.mtv.corp.google.com>
        <1472672344.4176.32.camel@perches.com>
Date:   Wed, 31 Aug 2016 13:09:38 -0700
In-Reply-To: <1472672344.4176.32.camel@perches.com> (Joe Perches's message of
        "Wed, 31 Aug 2016 12:39:04 -0700")
Message-ID: <xmqqr394zon1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9993684-6FB6-11E6-A9C2-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Wed, 2016-08-31 at 12:34 -0700, Junio C Hamano wrote:
>> Joe Perches <joe@perches.com> writes:
>> > Many commits have various forms of bylines similar to
>> A missing blank line (I can tweak while queuing).
> []
>> > +				next if $suppress_cc{'bylines'} and $what !~ /Signed-off-by/i and $what =~ /by$/i;
>> Having to keep this /by$/i in sync with whatever definition of
>> bylines is will be error prone.  How about doing it in this way?
>> 
>> 	# Now parse the message body
>> +	my $bypat = r/[\w-]+-by/;
>> 	while (<$fh>) {
>>         	...
>>                 if (/^(Signed-off-by|Cc|$bypat): (.*)$/i) {
>>                 	...
>>                         	next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
>> +				next if $suppress_cc{'bylines'} and
>> +					$what !~ /^Signed-off-by/i and
>> +					$what =~ /^$bypat/i;
>> 
>> Other than that, looking good.
>
> Sure, whatever you want, do you want a v3 from me or can
> you fix it up however you want?

This topic is not my itch, so "however I want" would not be a good
instruction to me--The lazy one in me would be tempted to say "ok,
then I'd drop it altogether" ;-)

I am sure the typo "[^\s]+[\w-]by" in the one we just saw was merely
because you rushed it out without double checking.  We are in
pre-release feature freeze so there is no need to rush.  I'd prefer
to see a final version that is carefully proof-read by the author.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C1DC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2A46136F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhHWQQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:16:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58120 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:16:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D898E6DF4;
        Mon, 23 Aug 2021 12:16:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oXhC6Ywx/j+Cu/TNmAED8pmnTkO5KwmSsvQ3ux
        8iepU=; b=UOOBvenqZhyU7hV0kbLoCzEBkw0WJ7npAF1y1r6y9tvBRdB+tjHa/W
        foL/sECWOWFgnEBHOiVUO4sDqvwtXWJZUNYALyCLtiyNKiIgsnRJyv1t1hlExycx
        z3gek/YMtQ2oIzGfA+fwldL2YwgDoTz5YlYFHGTFkQ5I1JuvaUO2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74AD8E6DF3;
        Mon, 23 Aug 2021 12:16:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5218E6DF2;
        Mon, 23 Aug 2021 12:16:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
References: <20210820193504.37044-1-johannes@sipsolutions.net>
        <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
        <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
        <xmqqo89osi0b.fsf@gitster.g>
        <caafaf945ec43ba606b054bf4c4faa42e35a8db1.camel@sipsolutions.net>
        <414ed641-2bd3-1316-8189-ad542988d091@gmail.com>
        <746f574d20c54b5f7d1eaae74f54a624573ad6bc.camel@sipsolutions.net>
Date:   Mon, 23 Aug 2021 09:16:01 -0700
In-Reply-To: <746f574d20c54b5f7d1eaae74f54a624573ad6bc.camel@sipsolutions.net>
        (Johannes Berg's message of "Mon, 23 Aug 2021 15:40:10 +0200")
Message-ID: <xmqqwnocqgqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 695F67B0-042D-11EC-9B72-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2021-08-23 at 09:19 -0400, Derrick Stolee wrote:
>> 
>> We just add subshells this way:
>> 
>> test_expect_success 'test name' '
>> 	prep_step &&
>> 	(
>> 		# now in a subshell
>> 		cd wherever &&
>> 		do things
>> 		# don't need to cd again
>> 	) &&
>> 	continue test
>> '
>
> Sure. I know how to do subshells :)
>
> My point was that inside the subshell you cannot do test_path_is_file
> and similar, because the subshell didn't import the libs.

Everything the call to prep_step, and anything that came before that
call, did to the environment, like setting shell functions and
variables, is visible inside the ( ... subshell ... ).

> I was specifically asking Junio ;-)
>
> But realistically, if this is the requirement you want to impose, then
> you _cannot_ test for the segfault within git's test suite. Your loss.

With that "cannot", I think you are assuming too much.  

Because Git is a fairly long-lived project, we've had our share of
cases where we needed to test for bugs that happen only when outside
a repository.

And we have facility for just that, it's called "nongit" test helper
that comes from test-lib-functions.sh, which is dot-included already
so your subshells get it for free.

t5300-pack-object.sh, for example, wants to make sure that the "git
index-pack --stdin" command invoked in a directory that is not a
repository, but "git index-pack <packfile>" works outside a
repository, and has two tests that uses the nongit helper.

Thanks.

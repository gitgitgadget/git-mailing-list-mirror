Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA64C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288E92077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="phRceGX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgDCTrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:47:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64211 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDCTrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:47:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BED985B232;
        Fri,  3 Apr 2020 15:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jtYkgXVeC5Du
        v9HtOE+ppCSFbwI=; b=phRceGX/suCAvLDHrhdNru5K30syiGj0xxDmdI2K27fd
        hxVyVsgHMJPIFYiarc0isu99dsspqS4aeSltxmyaEGhbsD+OK010f+tFlWUCDoKD
        vzdtzECQXiL71NacRGAIiUZB0OL+jwzKYlO+TIy+jSzN0Fr1Z3bIw2WWxTYB29g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L4VeNp
        jF2hQLZ4FrThe4FucK7XSKzL5MgTvSs/bYhqEkV3i8RjHKBrNzNbq+uRFq+mApX2
        Dp3OgF9kmLrARAf+eDIi3Fjd27YmQBxSKmTGQMVvBTvYBjv3v3N6h7p7o/l7kgZx
        oL2momDIU2ANn8zCAQ1dQXcaXypRJGP76Jp/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6B1B5B231;
        Fri,  3 Apr 2020 15:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FBA75B230;
        Fri,  3 Apr 2020 15:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in 'write --stdin-commits'
References: <20190805080240.30892-1-szeder.dev@gmail.com>
        <20190805080240.30892-4-szeder.dev@gmail.com>
        <20200403183057.GA659224@coredump.intra.peff.net>
        <20200403184933.GA57202@syl.local>
Date:   Fri, 03 Apr 2020 12:47:03 -0700
In-Reply-To: <20200403184933.GA57202@syl.local> (Taylor Blau's message of
        "Fri, 3 Apr 2020 12:49:33 -0600")
Message-ID: <xmqqd08oz70o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E49998DA-75E3-11EA-A1A3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Apr 03, 2020 at 02:30:57PM -0400, Jeff King wrote:
>> On Mon, Aug 05, 2019 at 10:02:40AM +0200, SZEDER G=C3=A1bor wrote:
>>
>> > Check that all input records are indeed valid commit object ids and
>> > return with error otherwise, the same way '--stdin-packs' handles
>> > invalid input; see e103f7276f (commit-graph: return with errors duri=
ng
>> > write, 2019-06-12).
>>
>> Can you explain more why the old behavior is a problem? For reasons (s=
ee
>> below), we want to do something like:
>>
>>   git for-each-ref --format=3D'%(objectname)' |
>>   git commit-graph write --stdin-commits
>> ...
>>  - you're generating an incremental graph update. You know somehow tha=
t
>>    a few refs were updated, and you want to feed those tips to generat=
e
>>    the incremental, but not the rest of the refs (not because it would
>>    be wrong to do so, but in the name of keeping it O(size of change)
>>    and not O(number of refs in the repo).
>> ...
>> Normally I'm in favor of more error checking instead of less, but in
>> this case it feels like it's putting scripted use at a disadvantage
>> versus the internal code (e.g., the auto-write for git-fetch uses the
>> "--reachable" semantics for its internal invocation).

I think the "incremental from the tip of refs" is a valid and useful
use case.  I am not sure if the rationale given in the original to
compare the (stricter) check done here and what e103f7276f did
(which does not seem to get any input, valid or invalid, from the
end users) was a meaningful comparison, and regardless of G=C3=A1bor's
answer to Peff's question, I think we should have an easy way to let
the machinery itself filter non-commit, so "--[no-]check-oids" that
optionally turns the stricter checking off would be an easy way out.
I do not have a strong opinion on which way the default should be
(at least not yet), but given that this was already in two major
releases ago, I'd assume that stricter-by-default-with-escape-hatch
would be the way to go (at least for now).

> For what it's worth, (and in case it wasn't obvious) this came about
> because we feed '--stdin-commits' at GitHub, and observed exactly this
> error case. I wasn't sure what approach would be more palatable, so I
> prepared both in my fork at https://github.com/ttaylorr/git:
>
>   - Branch 'tb/commit-graph-dont-check-oids' drops this checking
>     entirely.
>
>   - Branch 'tb/commit-graph-check-oids-option' adds a
>     '--[no-]check-oids', in case that this is generally desirable
>     behavior, by offering an opt-out of this OID checking.

Thanks.

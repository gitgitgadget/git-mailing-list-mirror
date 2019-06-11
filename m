Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0AA1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 18:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392119AbfFKSvl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 14:51:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58589 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbfFKSvl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 14:51:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E6E714AE51;
        Tue, 11 Jun 2019 14:51:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RwjIoo7Dswlerwnie+S+RRjOHLo=; b=HqX9s1
        a7STrv5vNJFFh/16eXrDf24Atlt1CvDasSu2Ncxf3QL9nVY9exJmxUYIKedUGOod
        v0YXZ7OPU+8c7/ySk85vsgCc5YzsemZfYpAIDOl1jyocr1/LYRScAux7l+XjD9ZE
        7YR5jsRS+bcgua4xa+kQQMd52xZNspLbaLu78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C266Rao5AF0z5yIqqqu6MQi7CAmBxPAa
        phuMnRVIsw/bCiGbr5LKutsB4/WchfaOcHGQqGzdeTV27VdVOTLSWmr2YB0v57Xl
        CblbrcOkNQd1rWDyQ+zJVznk09tjRIWaAZOw5+WSJ+WA93eRU3JzBjoqSKeznacr
        /v0XThFQprE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2480E14AE4E;
        Tue, 11 Jun 2019 14:51:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FA3014AE4D;
        Tue, 11 Jun 2019 14:51:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 06/11] multi-pack-index: implement 'expire' subcommand
References: <pull.261.git.gitgitgadget@gmail.com>
        <8213541052a7d040aad4352ee981c0de01cc6516.1560209720.git.gitgitgadget@gmail.com>
Date:   Tue, 11 Jun 2019 11:51:34 -0700
In-Reply-To: <8213541052a7d040aad4352ee981c0de01cc6516.1560209720.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 10 Jun 2019
        16:35:25 -0700 (PDT)")
Message-ID: <xmqqo934klah.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFC9C792-8C79-11E9-ADFA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The 'git multi-pack-index expire' subcommand looks at the existing
> mult-pack-index, counts the number of objects referenced in each

s/mult/&i/

> pack-file, deletes the pack-fils with no referenced objects, and

s/fils/files/

> rewrites the multi-pack-index to no longer reference those packs.

As we do *not* want to expire a packfile that was created after the
last run of "git multi-pack-index write", "... in each pack-file" in
the above paragraph is a bit tricky.  It cannot literally be "in
each packfile", but a subset of all existing packfiles that are
known to the midx we are looking at.

An obvious alternative is to actually update midx file (so it no
longer "looks at the existing multi-pack-index", but "makes sure we
have up-to-date view of the multi-pack-index that covers all packs).

And I actually suspect that you implemented that alternative here.
IOW, "looks at the existing multi-pack-index" in the first paragraph
is misleading.

I wondered if the error behaviour of add_pack_to_midx() that ignores
a pack that cannot be added to midx for whatever reason can cause
issues, but such a pack would not become part of m->packs[] so it
may not have anything count[]ed from it, but it will not be eligible
for expiration, either.  So we'd be safe there, I think.

> Test that a new pack-file that covers the contents of two other
> pack-files leads to those pack-files being deleted during the
> expire subcommand. Be sure to read the multi-pack-index to ensure
> it no longer references those packs.

I am curious to learn how we guarantee that the midx logic chooses
to record the copy of an object in the new single packfile over the
other copy of the same object in one of the two older and presumably
smaller packfiles for all objects in the latter two packfiles,
because they cannot be expired if even one object were used from
there.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF91C4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994F6603E7
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhHaQao (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:30:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61728 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhHaQan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:30:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AC80ED0CB;
        Tue, 31 Aug 2021 12:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FNe57KJpmMECNuLlYBrt+L/tVNsrOghvO3kFuLJVFBU=; b=FEuL
        8sHPUALFu9hNcIE1CSl8RrFMzXtorTqTmwzIjAFelsnle/COyiQbBfEDwcMQ5LvO
        Y9rCPvnM2PBQeuhezKpTTg/YekEyJFwOduGl8kcESe0QJ443YdvLP75WfOIBM3yW
        YiNOvBRTuGC6NddX61SYzQIUKfULyxwokOoYeY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 911C5ED0CA;
        Tue, 31 Aug 2021 12:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11543ED0C9;
        Tue, 31 Aug 2021 12:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <xmqqy28qlcow.fsf@gitster.g> <YSVuUYFh7lmhNlEy@nand.local>
        <xmqqo89jbf49.fsf@gitster.g> <YSko4OwwPb7MwEMa@nand.local>
        <xmqq4kb797xc.fsf@gitster.g> <YSwhNxqAS8JajA7p@nand.local>
        <xmqqfsur7otx.fsf@gitster.g> <YSwpsp/hQsPFnj+I@nand.local>
        <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
        <xmqqmtoy1s9s.fsf@gitster.g> <YS1croR3etCfMQhR@nand.local>
Date:   Tue, 31 Aug 2021 09:29:46 -0700
Message-ID: <xmqqmtoxwpad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7E6FF24-0A78-11EC-98B0-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Aug 30, 2021 at 03:28:47PM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> > Yeah, this is a possible problem.  You can also see it when using git
>> > index-pack outside of a repository with an incorrect --object-format
>> > option.
>> >
>> > I'm not sure how folks want to deal with that; I'm just fine saying,
>> > "Well, don't do that," but other folks may have different opinions.
>>
>> OK, so if we go back to the original breakage of the test script
>> that triggered this discussion, the right solution would be to make
>> sure both test repositories/object stores are prepared with the
>> algorithm specified with GIT_TEST_DEFAULT_HASH?
>
> Just to make sure do you still see this as a separate issue from running
> the midx builtin outside of a repository?

They are separate issues, but the .midx issue has a small overlap
with the much bigger "do not mix repositories and object stores with
different hashes" issue.

The users of raw object stores (e.g. $GIT_OBJECT_DIRECTORIES,
"--object-dir", there may be others) need to be updated so that the
code paths involved can reliably learn what hash algorithm is used
and other traits that may not be available in the object store alone
(e.g. refs might be relevant if the using code needs to learn which
objects are still reachable) for the latter.  It would need a couple
of things that are fairly isolated to solve, I would imagine:

 (1) convention to either tie a raw object store with its repository
     or declare a raw object store is unusable because "other
     traits" are not found for it.

 (2) given a repository, inspect it and decide if it is "compatible"
     with the current repository.

 (3) update code paths involved in prepare_alt_odb() to use (1) and
     (2) to inspect and reject incompatible object store as
     alternate.

And once we have that, "git multi-pack-index --object-dir=X" can use
(1) and (2) for the same "Is this other object store compatible with
the current repository?" check, no?

The other side of the coin is that midx needs to do equivalents of
(1) and (2) anyway, and the required amount of the work for (3)
smells a lot smaller than work for (1) and (2).  (3) may be just a
matter of "add a call to is_odb_compatible(dir) for the directory
being added as an alt odb", and the same single validation call may
be all it needs on the --object-dir argument on the midx side.

I think it makes sense for the midx command to require being in a
repository to run (to establish what "the current repository" is)
and insist on the other object store given with --object-dir to be
"compatible" with the current repository (i.e. the same hash
algorithm, there may be others).  I am a bit fuzzy why we want it
to be already our alternate.

Thanks.

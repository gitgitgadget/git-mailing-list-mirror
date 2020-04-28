Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F7DC83008
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1E208E0
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GCzpmfof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgD1QuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:50:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55651 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgD1QuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:50:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2409BF880;
        Tue, 28 Apr 2020 12:50:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g8iizoZWGMX5OENDu3ZZP1qt1ZE=; b=GCzpmf
        ofFyCLEFSeS7A5XCu9noXQZtN+x92wYYHuj2rnzxcxNI3e16l4jwfy5StwSgTpfv
        cQGVXLsPQx5syh9amwkHgO8nNEoZrzGTcdrqZAF+8tkZ3Ncz5mIY5CYytvzUBlRJ
        5GEV1PINoQDoCdjNWVP0+9l0McuOy7CYbEwTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PsOnvTFOxN8Z0QtrepY1Xnyr8h44sbzG
        Y2QMJzjXWUcMfLqFemFUeHNrIHHije4/XnyQKYAdNBazb9BzXBopA8BqOe7v53UD
        WO2IVXL8ZIE5jAvLvybopbfsomODfPRhA4PbgJsSvvRcvgP+rKVTiugVCaTdhM8r
        BvxBdGCFc8U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D95C9BF87F;
        Tue, 28 Apr 2020 12:50:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FC4DBF87E;
        Tue, 28 Apr 2020 12:50:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as read-only
References: <cover.1587422630.git.me@ttaylorr.com>
        <cover.1588004647.git.me@ttaylorr.com>
        <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
        <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
        <20200427235935.GA14984@syl.local>
        <20200428033438.GA2369457@coredump.intra.peff.net>
Date:   Tue, 28 Apr 2020 09:50:02 -0700
In-Reply-To: <20200428033438.GA2369457@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 27 Apr 2020 23:34:38 -0400")
Message-ID: <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EDEF574-8970-11EA-81E7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we're just doing this for a single test, perhaps it would be better
> to set the umask in that test (perhaps even in a subshell to avoid
> touching other tests). I guess that's a little awkward here because the
> write and the mode-check happen in separate snippets.

Yes, and we cannot afford to place the writing side under POSIXPERM
prerequisite.

> Or going in the opposite direction: if we think that covering the rest
> of the test suite with a diversity of umasks isn't worthwhile, we could
> just set "umask" in test-lib.sh. That would solve this problem and any
> future ones.

Seen from the point of view of giving us a stable testing
environment, it certainly feels like an easy and simple thing to do.
I do not offhand see any downsides in that approach.

On the other hand, we use and rely on test-specified umask only in a
few tests (t0001, t1301 and t1304).  Perhaps we should discourage
tests outside these to rely too heavily on exact perm bits?

For example, I wonder if we should have used

	test -r commit-graph && ! test -w commit-graph 

to ensure the file is read-only to the user who is testing, instead
of relying on parsing "ls -l" output, which IIRC has bitten us with
xattr and forced us to revise test_modebits helper in 5610e3b0 (Fix
testcase failure when extended attributes are in use, 2008-10-19).
That would make the test require SANITY instead, though.

> I also wondered if it would be simpler to just limit the scope of the
> test, like so:
> ...
> +	# check only user mode bits, as we do not want to rely on
> +	# test environment umask
> +	grep ^-r-- actual
>  '
> ...
> but maybe there's some value in checking the whole thing.

Yeah, I guess we are wondering about the same thing.

Among various approaches on plate, my preference is to use "umask
022" around the place where we prepare the $TRASH_DIRECTORY and do
so only when POSIXPERM is there in the test-lib.sh.  I do not know
if we should do so before or after creating the $TRASH_DIRECTORY;
my gut feeling is that in the ideal world, we should be able to

 - create trash directory

 - use the directory to automatically figure out POSIXPERM

 - if POSIXPERM is set, use umask 022 and chmod og=rx the trash
   directory

Automatically figuring out POSIXPERM the above approach shoots for
is a much larger change, so I am not in a haste to implement it and
it may be OK to only do "umask 022" after we set POSIXPERM for
everybody but MINGW at least as the initial cut, but that would mean
we would run for quite a long time with the testing user's umask
during the setup process, which is unsatisfying.

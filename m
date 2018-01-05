Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07331F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeAETgm (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:36:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65532 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeAETgl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:36:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12AFBC6175;
        Fri,  5 Jan 2018 14:36:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=of3tXB+9dCe+KaoxA1XAKxeR5j4=; b=wRVTDf
        1IxzV9xpXbqZ106fmTWfKap/C2VbyK9LcPZGO3IUhzu295h9De8+A/cb3ba3nLyT
        kCXkQx0R7vbsYaw4PAQXF8FwkmBEo8NY/QKVcIbuw8x+qK1XDQQdsfUTAkKgHCLo
        SpyF3ysqSebgC5EQpM5vt0j5uBiejjiNGKGWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTMG+HLcgHmwI+xDg7VIu09OzaY9oFWW
        xnBWCknu3vOYej/AvTUYROwV+24VGbJi8pRXJ39n1EJRDX++f80XI+ti1s3pN9sp
        M4hYXnbCdP16v4ciQTgpAIk6+mk7UaLYyyBfINLLvIZeGsCjvpsD5rGqKLbH19ri
        zzLY3LAkVVo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A2FCC6174;
        Fri,  5 Jan 2018 14:36:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 812FDC6173;
        Fri,  5 Jan 2018 14:36:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Subject: Re: [PATCH v3] run-command: add hint when a hook is ignored
References: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
        <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
        <xmqqy3ojpr9f.fsf@gitster.mtv.corp.google.com>
        <xmqqmv4ymc7w.fsf@gitster.mtv.corp.google.com>
        <20180103083145.GA7049@sigill.intra.peff.net>
Date:   Fri, 05 Jan 2018 11:36:39 -0800
In-Reply-To: <20180103083145.GA7049@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Jan 2018 03:31:46 -0500")
Message-ID: <xmqqk1wwcd2w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C095B550-F24F-11E7-A2B1-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The problem is that I was bisecting an unrelated change in old code, and
> I built a commit which predates f98f8cbac0 (Ship sample hooks with .sample
> suffix, 2008-06-24). That wrote a bare "update" file into templates/blt
> (without the ".sample" suffix). After that, the cruft is forever in my
> build directory until I "git clean -x".
>
> The t5523 script tries to run "git push --quiet" and make sure that it
> produces no output, but with this setup it produces a round of "hint"
> lines (actually, they come from receive-pack on the remote end but still
> end up on stderr).
>
> So that raises a few interesting questions to me:
>
>   1. Should receive-pack generate these hints? They get propagated by
>      the client, but there's a reasonable chance that the user can't
>      actually fix the situation.

True.  The user could tell the server operator to rename them or
remove them because they are not doing anything useful, but then
as long as everybody knows they are not doing anything, it is OK
to leave that sleeping dog lie, as they are not doing anything
harmful anyway.

That brings us one step further back to question if the hints are
useful in the first place, though ;-).

>   2. Should these hints be suppressed with --quiet? I can see an
>      argument that "--quiet" only applies to non-errors. And while these
>      are not fatal errors, they're outside the realm of the usual
>      chattiness.

I do not think having a non-executable file whose name happens to be
the same as a hook is an error in the first place [*1*], so I do not
think it is unreasonable for --quiet to squelch.

	side note [*1*]: we need to make sure that it is clearly
	documented that such a file is not a hook, of course.

>   3. Should our tests be more careful about not looking at the
>      template hooks? I think test_create_repo already disables the hooks
>      directory manually, but many repos will be created by "git clone"
>      during the tests.

This probably is much deeper issue and templates/hooks--* is merely
a tip of iceberg, I suspect.  In general build artifacts from
different versions of Git in the same build area could interfere the
tests in other ways (e.g. a test for "git help" output could try to
grab a deprecated command left in bin-wrappers/ from previous build
of an ancient version), and could potentially interfere things other
than the tests (e.g. the 'install' target of the Makefile may be
written loosely to install everything in a directory).

In general, I am a bit pessimistic and suspect that the best we
could say is "if you want to absolutely avoid such interference,
'make distclean' before switching to test another revision".

>   4. Should our build system be more clever about dropping non-existent
>      files from templates/blt?

It would be a reasonable mitigation that is specific to templates/,
I suspect.
